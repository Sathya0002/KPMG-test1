
# Create a front-end load balancer
resource "google_compute_backend_service" "web_backend" {
  name             = "web-backend"
  port_name        = "http"
  protocol         = "HTTP"
  timeout_sec      = 10

  
  health_checks = [google_compute_http_health_check.web_health_check.self_link]
}

resource "google_compute_http_health_check" "web_health_check" {
  name               = "web-health-check"
  request_path       = "/health"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
}

resource "google_compute_target_http_proxy" "frontend_proxy" {
  name = "frontend-proxy"

  url_map = google_compute_url_map.web_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "frontend_forwarding_rule" {
  name       = "frontend-forwarding-rule"
  target     = google_compute_target_http_proxy.frontend_proxy.self_link
  port_range = "80"
  ip_address = "10.0.1.10"
}

resource "google_compute_url_map" "web_url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend.self_link

  host_rule {
    hosts = ["my-webapp.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name  = "allpaths"
    default_service = google_compute_backend_service.web_backend.self_link
    path_rule {
      paths = ["/.*"]
      service = google_compute_backend_service.web_backend.self_link
    }
  }
}
