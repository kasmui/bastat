package cloud.kasmui.statistikastudio;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Base64;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.JavascriptInterface;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.Toast;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class MainActivity extends Activity {
    private static final int FILE_CHOOSER_REQUEST = 1201;
    private static final int STORAGE_PERMISSION_REQUEST = 1202;

    private WebView webView;
    private ProgressBar progressBar;
    private ValueCallback<Uri[]> filePathCallback;
    private ValueCallback<Uri> legacyFileCallback;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        createUi();
        configureWebView();
        webView.loadUrl("file:///android_asset/index.html");
    }

    private void createUi() {
        FrameLayout root = new FrameLayout(this);
        root.setBackgroundColor(Color.WHITE);

        webView = new WebView(this);
        root.addView(webView, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT));

        progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyleHorizontal);
        progressBar.setMax(100);
        FrameLayout.LayoutParams p = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(3));
        p.gravity = android.view.Gravity.TOP;
        root.addView(progressBar, p);
        setContentView(root);
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    private void configureWebView() {
        WebSettings s = webView.getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        s.setDatabaseEnabled(true);
        s.setAllowFileAccess(true);
        s.setAllowContentAccess(true);
        s.setUseWideViewPort(true);
        s.setLoadWithOverviewMode(false);
        s.setBuiltInZoomControls(false);
        s.setDisplayZoomControls(false);
        s.setTextZoom(100);
        s.setJavaScriptCanOpenWindowsAutomatically(true);
        s.setSupportMultipleWindows(false);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            s.setAllowFileAccessFromFileURLs(true);
            s.setAllowUniversalAccessFromFileURLs(true);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            s.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }

        webView.setBackgroundColor(Color.WHITE);
        webView.addJavascriptInterface(new AndroidBridge(), "Android");

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return handleUrl(request.getUrl());
            }

            @SuppressWarnings("deprecation")
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return handleUrl(Uri.parse(url));
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                progressBar.setVisibility(View.GONE);
                view.evaluateJavascript(
                    "document.documentElement.classList.add('android-app');" +
                    "window.addEventListener('error',function(e){console.log(e.message);});", null);
            }
        });

        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                progressBar.setVisibility(newProgress >= 100 ? View.GONE : View.VISIBLE);
                progressBar.setProgress(newProgress);
            }

            @Override
            public boolean onShowFileChooser(WebView view, ValueCallback<Uri[]> callback,
                                             FileChooserParams params) {
                if (filePathCallback != null) filePathCallback.onReceiveValue(null);
                filePathCallback = callback;
                Intent intent;
                try {
                    intent = params.createIntent();
                } catch (Exception ex) {
                    intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
                    intent.addCategory(Intent.CATEGORY_OPENABLE);
                    intent.setType("*/*");
                }
                try {
                    startActivityForResult(intent, FILE_CHOOSER_REQUEST);
                    return true;
                } catch (Exception ex) {
                    filePathCallback = null;
                    Toast.makeText(MainActivity.this, "Pemilih file tidak tersedia.", Toast.LENGTH_LONG).show();
                    return false;
                }
            }

            @SuppressWarnings("unused")
            public void openFileChooser(ValueCallback<Uri> uploadMsg) {
                openLegacyChooser(uploadMsg, "*/*");
            }

            @SuppressWarnings("unused")
            public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType) {
                openLegacyChooser(uploadMsg, acceptType);
            }

            @SuppressWarnings("unused")
            public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType, String capture) {
                openLegacyChooser(uploadMsg, acceptType);
            }
        });
    }

    private void openLegacyChooser(ValueCallback<Uri> callback, String acceptType) {
        if (legacyFileCallback != null) legacyFileCallback.onReceiveValue(null);
        legacyFileCallback = callback;
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType((acceptType == null || acceptType.trim().isEmpty()) ? "*/*" : acceptType);
        try {
            startActivityForResult(intent, FILE_CHOOSER_REQUEST);
        } catch (Exception ex) {
            legacyFileCallback = null;
            Toast.makeText(this, "Pemilih file tidak tersedia.", Toast.LENGTH_LONG).show();
        }
    }

    private boolean handleUrl(Uri uri) {
        if (uri == null || uri.getScheme() == null) return false;
        String scheme = uri.getScheme();
        if ("file".equalsIgnoreCase(scheme) || "about".equalsIgnoreCase(scheme) ||
                "javascript".equalsIgnoreCase(scheme)) return false;
        try {
            startActivity(new Intent(Intent.ACTION_VIEW, uri));
        } catch (Exception ex) {
            Toast.makeText(this, "Tidak ada aplikasi untuk membuka tautan ini.", Toast.LENGTH_SHORT).show();
        }
        return true;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != FILE_CHOOSER_REQUEST) return;

        if (filePathCallback != null) {
            Uri[] result = null;
            if (resultCode == RESULT_OK && data != null) {
                if (data.getClipData() != null) {
                    int n = data.getClipData().getItemCount();
                    result = new Uri[n];
                    for (int i = 0; i < n; i++) result[i] = data.getClipData().getItemAt(i).getUri();
                } else if (data.getData() != null) {
                    result = new Uri[]{data.getData()};
                }
            }
            filePathCallback.onReceiveValue(result);
            filePathCallback = null;
        }

        if (legacyFileCallback != null) {
            Uri result = (resultCode == RESULT_OK && data != null) ? data.getData() : null;
            legacyFileCallback.onReceiveValue(result);
            legacyFileCallback = null;
        }
    }

    @Override
    public void onBackPressed() {
        if (webView != null && webView.canGoBack()) webView.goBack();
        else super.onBackPressed();
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.removeJavascriptInterface("Android");
            webView.loadUrl("about:blank");
            webView.stopLoading();
            webView.setWebChromeClient(null);
            webView.setWebViewClient(null);
            webView.destroy();
            webView = null;
        }
        super.onDestroy();
    }

    public class AndroidBridge {
        @JavascriptInterface
        public void saveBase64File(String rawName, String dataUrl) {
            if (rawName == null || dataUrl == null) return;
            try {
                String name = sanitizeFileName(rawName);
                int comma = dataUrl.indexOf(',');
                if (comma < 0) throw new IllegalArgumentException("Data file tidak valid");
                String header = dataUrl.substring(0, comma);
                String payload = dataUrl.substring(comma + 1);
                String mime = "application/octet-stream";
                if (header.startsWith("data:")) {
                    int semicolon = header.indexOf(';');
                    if (semicolon > 5) mime = header.substring(5, semicolon);
                }
                byte[] bytes = Base64.decode(payload, Base64.DEFAULT);

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    saveQ(name, mime, bytes);
                } else {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
                            checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                        requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                                STORAGE_PERMISSION_REQUEST);
                        showToast("Izinkan akses penyimpanan, lalu tekan Simpan sekali lagi.");
                        return;
                    }
                    saveLegacy(name, bytes);
                }
                showToast("Tersimpan di Downloads: " + name);
            } catch (Exception ex) {
                showToast("Gagal menyimpan file: " + ex.getMessage());
            }
        }

        @JavascriptInterface
        public void toast(String message) {
            showToast(message == null ? "" : message);
        }
    }

    @TargetApi(Build.VERSION_CODES.Q)
    private void saveQ(String fileName, String mime, byte[] bytes) throws Exception {
        ContentValues values = new ContentValues();
        values.put(MediaStore.Downloads.DISPLAY_NAME, fileName);
        values.put(MediaStore.Downloads.MIME_TYPE, mime);
        values.put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/Statistika Studio");
        values.put(MediaStore.Downloads.IS_PENDING, 1);
        Uri uri = getContentResolver().insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
        if (uri == null) throw new IllegalStateException("Tidak dapat membuat file");
        try (OutputStream out = getContentResolver().openOutputStream(uri)) {
            if (out == null) throw new IllegalStateException("Tidak dapat membuka file");
            out.write(bytes);
        }
        ContentValues done = new ContentValues();
        done.put(MediaStore.Downloads.IS_PENDING, 0);
        getContentResolver().update(uri, done, null, null);
    }

    @SuppressWarnings("deprecation")
    private void saveLegacy(String fileName, byte[] bytes) throws Exception {
        File dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        if (!dir.exists() && !dir.mkdirs()) throw new IllegalStateException("Folder Downloads tidak tersedia");
        File f = uniqueFile(dir, fileName);
        try (FileOutputStream out = new FileOutputStream(f)) {
            out.write(bytes);
        }
        sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(f)));
    }

    private File uniqueFile(File dir, String fileName) {
        File f = new File(dir, fileName);
        if (!f.exists()) return f;
        int dot = fileName.lastIndexOf('.');
        String base = dot > 0 ? fileName.substring(0, dot) : fileName;
        String ext = dot > 0 ? fileName.substring(dot) : "";
        int n = 2;
        while (f.exists()) f = new File(dir, base + " (" + n++ + ")" + ext);
        return f;
    }

    private String sanitizeFileName(String name) {
        String cleaned = name.replaceAll("[\\\\/:*?\"<>|\\r\\n]+", "_").trim();
        return cleaned.isEmpty() ? "statistika_studio_file" : cleaned;
    }

    private void showToast(final String message) {
        runOnUiThread(() ->
                Toast.makeText(MainActivity.this, message, Toast.LENGTH_LONG).show());
    }
}
