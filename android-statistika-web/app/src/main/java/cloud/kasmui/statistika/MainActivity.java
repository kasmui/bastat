package cloud.kasmui.statistika;

import android.Manifest;
import android.app.Activity;
import android.app.DownloadManager;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.Uri;
import android.net.http.SslError;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.CookieManager;
import android.webkit.DownloadListener;
import android.webkit.SslErrorHandler;
import android.webkit.URLUtil;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    private static final String HOME_URL = "https://kasmui.cloud/statistika/";
    private static final String ALLOWED_HOST = "kasmui.cloud";
    private static final int FILE_CHOOSER_REQUEST = 4101;
    private static final int STORAGE_PERMISSION_REQUEST = 4102;

    private WebView webView;
    private ProgressBar progressBar;
    private LinearLayout errorPanel;
    private TextView errorTitle;
    private TextView errorMessage;
    private ValueCallback<Uri[]> fileChooserCallback;

    private String pendingDownloadUrl;
    private String pendingUserAgent;
    private String pendingContentDisposition;
    private String pendingMimeType;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        buildUi();
        configureWebView();
        loadHome();
    }

    private void buildUi() {
        FrameLayout root = new FrameLayout(this);
        root.setBackgroundColor(Color.WHITE);

        webView = new WebView(this);
        root.addView(webView, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT));

        progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyleHorizontal);
        progressBar.setMax(100);
        FrameLayout.LayoutParams progressParams = new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(3));
        progressParams.gravity = Gravity.TOP;
        root.addView(progressBar, progressParams);

        errorPanel = new LinearLayout(this);
        errorPanel.setOrientation(LinearLayout.VERTICAL);
        errorPanel.setGravity(Gravity.CENTER);
        errorPanel.setPadding(dp(26), dp(26), dp(26), dp(26));
        errorPanel.setBackgroundColor(Color.rgb(238, 244, 255));
        errorPanel.setVisibility(View.GONE);

        LinearLayout card = new LinearLayout(this);
        card.setOrientation(LinearLayout.VERTICAL);
        card.setGravity(Gravity.CENTER);
        card.setPadding(dp(24), dp(24), dp(24), dp(24));
        card.setBackgroundColor(Color.WHITE);

        errorTitle = new TextView(this);
        errorTitle.setTextSize(24);
        errorTitle.setTextColor(Color.rgb(15, 63, 133));
        errorTitle.setGravity(Gravity.CENTER);
        errorTitle.setText("Tidak ada koneksi internet");
        card.addView(errorTitle, matchWrap());

        errorMessage = new TextView(this);
        errorMessage.setTextSize(16);
        errorMessage.setTextColor(Color.rgb(71, 85, 105));
        errorMessage.setGravity(Gravity.CENTER);
        errorMessage.setPadding(0, dp(12), 0, dp(18));
        errorMessage.setText("Statistika Studio membutuhkan internet. Aktifkan Wi-Fi atau data seluler lalu tekan Coba Lagi.");
        card.addView(errorMessage, matchWrap());

        Button retry = new Button(this);
        retry.setText("Coba Lagi");
        retry.setAllCaps(false);
        retry.setOnClickListener(v -> loadHome());
        card.addView(retry, buttonParams());

        Button settingsButton = new Button(this);
        settingsButton.setText("Pengaturan Internet");
        settingsButton.setAllCaps(false);
        settingsButton.setOnClickListener(v -> openInternetSettings());
        LinearLayout.LayoutParams sbp = buttonParams();
        sbp.topMargin = dp(8);
        card.addView(settingsButton, sbp);

        TextView url = new TextView(this);
        url.setText(HOME_URL);
        url.setTextSize(12);
        url.setTextColor(Color.rgb(100, 116, 139));
        url.setGravity(Gravity.CENTER);
        url.setPadding(0, dp(16), 0, 0);
        card.addView(url, matchWrap());

        LinearLayout.LayoutParams cardParams = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        cardParams.leftMargin = dp(10);
        cardParams.rightMargin = dp(10);
        errorPanel.addView(card, cardParams);

        root.addView(errorPanel, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT));

        setContentView(root);
    }

    private LinearLayout.LayoutParams matchWrap() {
        return new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    private LinearLayout.LayoutParams buttonParams() {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        p.leftMargin = dp(12);
        p.rightMargin = dp(12);
        return p;
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }

    private void configureWebView() {
        WebSettings s = webView.getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        s.setDatabaseEnabled(true);
        s.setAllowContentAccess(true);
        s.setAllowFileAccess(true);
        s.setUseWideViewPort(true);
        s.setLoadWithOverviewMode(false);
        s.setBuiltInZoomControls(true);
        s.setDisplayZoomControls(false);
        s.setSupportZoom(true);
        s.setJavaScriptCanOpenWindowsAutomatically(true);
        s.setMediaPlaybackRequiresUserGesture(false);
        s.setCacheMode(WebSettings.LOAD_DEFAULT);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            s.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }

        String ua = s.getUserAgentString();
        s.setUserAgentString(ua + " StatistikaStudioAndroid/1.0");

        CookieManager cm = CookieManager.getInstance();
        cm.setAcceptCookie(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            cm.setAcceptThirdPartyCookies(webView, true);
        }

        webView.setBackgroundColor(Color.WHITE);

        webView.setWebViewClient(new StatistikaWebViewClient());

        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                progressBar.setProgress(newProgress);
                progressBar.setVisibility(newProgress >= 100 ? View.GONE : View.VISIBLE);
            }

            @Override
            public boolean onShowFileChooser(
                    WebView webView,
                    ValueCallback<Uri[]> callback,
                    FileChooserParams fileChooserParams) {

                if (fileChooserCallback != null) {
                    fileChooserCallback.onReceiveValue(null);
                }
                fileChooserCallback = callback;

                Intent intent;
                try {
                    intent = fileChooserParams.createIntent();
                } catch (Exception e) {
                    intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
                    intent.addCategory(Intent.CATEGORY_OPENABLE);
                    intent.setType("*/*");
                }

                try {
                    startActivityForResult(intent, FILE_CHOOSER_REQUEST);
                    return true;
                } catch (ActivityNotFoundException e) {
                    fileChooserCallback = null;
                    Toast.makeText(MainActivity.this,
                            "Pemilih file tidak tersedia di perangkat ini.",
                            Toast.LENGTH_LONG).show();
                    return false;
                }
            }
        });

        webView.setDownloadListener(new DownloadListener() {
            @Override
            public void onDownloadStart(String url, String userAgent,
                                        String contentDisposition, String mimetype,
                                        long contentLength) {
                startDownload(url, userAgent, contentDisposition, mimetype);
            }
        });
    }

    private void loadHome() {
        hideError();
        if (!hasInternetConnection()) {
            showError("Tidak ada koneksi internet",
                    "Statistika Studio membutuhkan internet. Aktifkan Wi-Fi atau data seluler lalu tekan Coba Lagi.");
            return;
        }
        progressBar.setVisibility(View.VISIBLE);
        webView.loadUrl(HOME_URL);
    }

    private boolean hasInternetConnection() {
        ConnectivityManager cm =
                (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        if (cm == null) return false;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Network network = cm.getActiveNetwork();
            if (network == null) return false;
            NetworkCapabilities caps = cm.getNetworkCapabilities(network);
            return caps != null &&
                    caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET);
        }

        @SuppressWarnings("deprecation")
        android.net.NetworkInfo info = cm.getActiveNetworkInfo();
        return info != null && info.isConnected();
    }

    private void showError(String title, String message) {
        progressBar.setVisibility(View.GONE);
        errorTitle.setText(title);
        errorMessage.setText(message);
        errorPanel.setVisibility(View.VISIBLE);
        webView.setVisibility(View.GONE);
    }

    private void hideError() {
        errorPanel.setVisibility(View.GONE);
        webView.setVisibility(View.VISIBLE);
    }

    private void openInternetSettings() {
        try {
            startActivity(new Intent(Settings.ACTION_WIRELESS_SETTINGS));
        } catch (Exception e) {
            startActivity(new Intent(Settings.ACTION_SETTINGS));
        }
    }

    private boolean isAllowedInWebView(Uri uri) {
        if (uri == null) return false;
        String scheme = uri.getScheme();
        if (scheme == null) return false;

        if ("about".equalsIgnoreCase(scheme) ||
                "javascript".equalsIgnoreCase(scheme) ||
                "blob".equalsIgnoreCase(scheme) ||
                "data".equalsIgnoreCase(scheme)) {
            return true;
        }

        if (!"http".equalsIgnoreCase(scheme) && !"https".equalsIgnoreCase(scheme)) {
            return false;
        }

        String host = uri.getHost();
        return host != null &&
                (host.equalsIgnoreCase(ALLOWED_HOST) ||
                 host.toLowerCase().endsWith("." + ALLOWED_HOST));
    }

    private void openExternal(Uri uri) {
        try {
            startActivity(new Intent(Intent.ACTION_VIEW, uri));
        } catch (Exception e) {
            Toast.makeText(this,
                    "Tidak ada aplikasi untuk membuka tautan ini.",
                    Toast.LENGTH_SHORT).show();
        }
    }

    private class StatistikaWebViewClient extends WebViewClient {

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
            Uri uri = request.getUrl();
            if (isAllowedInWebView(uri)) return false;
            openExternal(uri);
            return true;
        }

        @SuppressWarnings("deprecation")
        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            Uri uri = Uri.parse(url);
            if (isAllowedInWebView(uri)) return false;
            openExternal(uri);
            return true;
        }

        @Override
        public void onPageStarted(WebView view, String url, android.graphics.Bitmap favicon) {
            hideError();
            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        public void onPageFinished(WebView view, String url) {
            progressBar.setVisibility(View.GONE);
            hideError();
        }

        @Override
        public void onReceivedError(WebView view, WebResourceRequest request,
                                    WebResourceError error) {
            if (request.isForMainFrame()) {
                showError("Halaman tidak dapat dimuat",
                        "Periksa koneksi internet dan coba lagi.");
            }
        }

        @SuppressWarnings("deprecation")
        @Override
        public void onReceivedError(WebView view, int errorCode,
                                    String description, String failingUrl) {
            showError("Halaman tidak dapat dimuat",
                    "Periksa koneksi internet dan coba lagi.");
        }

        @Override
        public void onReceivedHttpError(WebView view, WebResourceRequest request,
                                        WebResourceResponse errorResponse) {
            if (request.isForMainFrame() && errorResponse != null &&
                    errorResponse.getStatusCode() >= 400) {
                showError("Server mengembalikan kesalahan",
                        "Statistika Studio belum dapat dibuka. Silakan tekan Coba Lagi.");
            }
        }

        @Override
        public void onReceivedSslError(WebView view, SslErrorHandler handler,
                                       SslError error) {
            handler.cancel();
            showError("Sertifikat HTTPS bermasalah",
                    "Sambungan aman ke kasmui.cloud tidak dapat diverifikasi oleh perangkat ini. Halaman dibatalkan demi keamanan.");
        }
    }

    private void startDownload(String url, String userAgent,
                               String contentDisposition, String mimeType) {
        pendingDownloadUrl = url;
        pendingUserAgent = userAgent;
        pendingContentDisposition = contentDisposition;
        pendingMimeType = mimeType;

        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.P &&
                checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                        != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(
                    new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    STORAGE_PERMISSION_REQUEST);
            return;
        }

        enqueueDownload();
    }

    private void enqueueDownload() {
        if (pendingDownloadUrl == null) return;

        try {
            String fileName = URLUtil.guessFileName(
                    pendingDownloadUrl,
                    pendingContentDisposition,
                    pendingMimeType);

            DownloadManager.Request request =
                    new DownloadManager.Request(Uri.parse(pendingDownloadUrl));
            request.setTitle(fileName);
            request.setDescription("Mengunduh file Statistika Studio");
            request.setNotificationVisibility(
                    DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);

            if (pendingMimeType != null && !pendingMimeType.trim().isEmpty()) {
                request.setMimeType(pendingMimeType);
            }
            if (pendingUserAgent != null) {
                request.addRequestHeader("User-Agent", pendingUserAgent);
            }

            String cookies = CookieManager.getInstance().getCookie(pendingDownloadUrl);
            if (cookies != null) {
                request.addRequestHeader("Cookie", cookies);
            }

            request.setDestinationInExternalPublicDir(
                    Environment.DIRECTORY_DOWNLOADS, fileName);

            DownloadManager dm =
                    (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
            if (dm == null) throw new IllegalStateException("DownloadManager tidak tersedia");
            dm.enqueue(request);

            Toast.makeText(this,
                    "Unduhan dimulai. Periksa folder Download.",
                    Toast.LENGTH_LONG).show();
        } catch (Exception e) {
            Toast.makeText(this,
                    "Unduhan gagal dimulai: " + e.getMessage(),
                    Toast.LENGTH_LONG).show();
        } finally {
            pendingDownloadUrl = null;
            pendingUserAgent = null;
            pendingContentDisposition = null;
            pendingMimeType = null;
        }
    }

    @Override
    public void onRequestPermissionsResult(
            int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == STORAGE_PERMISSION_REQUEST) {
            if (grantResults.length > 0 &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                enqueueDownload();
            } else {
                Toast.makeText(this,
                        "Izin penyimpanan diperlukan untuk mengunduh file.",
                        Toast.LENGTH_LONG).show();
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == FILE_CHOOSER_REQUEST) {
            Uri[] results = null;
            if (resultCode == RESULT_OK && data != null) {
                if (data.getClipData() != null) {
                    int count = data.getClipData().getItemCount();
                    results = new Uri[count];
                    for (int i = 0; i < count; i++) {
                        results[i] = data.getClipData().getItemAt(i).getUri();
                    }
                } else if (data.getData() != null) {
                    results = new Uri[]{data.getData()};
                }
            }

            if (fileChooserCallback != null) {
                fileChooserCallback.onReceiveValue(results);
                fileChooserCallback = null;
            }
        }
    }

    @Override
    public void onBackPressed() {
        if (errorPanel.getVisibility() == View.VISIBLE) {
            loadHome();
        } else if (webView.canGoBack()) {
            webView.goBack();
        } else {
            super.onBackPressed();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (errorPanel != null && errorPanel.getVisibility() == View.VISIBLE &&
                hasInternetConnection()) {
            loadHome();
        }
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.stopLoading();
            webView.setDownloadListener(null);
            webView.setWebChromeClient(null);
            webView.setWebViewClient(null);
            webView.loadUrl("about:blank");
            webView.clearHistory();
            webView.removeAllViews();
            webView.destroy();
        }
        super.onDestroy();
    }
}
