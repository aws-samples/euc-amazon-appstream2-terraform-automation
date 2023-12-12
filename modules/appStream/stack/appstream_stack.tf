resource "aws_appstream_stack" "app_stack" {
  name         = "${var.name_prefix}appstream_stack"
  description  = "AppStream 2.0 application Stack"
  display_name = "${var.name_prefix}appstream_stack"
  # feedback_url = "http://your-domain/feedback"
  # redirect_url = "http://your-domain/redirect"

  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }

  # user_settings {
  #   action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
  #   permission = "ENABLED"
  # }
  # user_settings {
  #   action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
  #   permission = "ENABLED"
  # }
  # user_settings {
  #   action     = "FILE_UPLOAD"
  #   permission = "ENABLED"
  # }
  # user_settings {
  #   action     = "FILE_DOWNLOAD"
  #   permission = "ENABLED"
  # }

  application_settings {
    enabled        = true
    settings_group = "SettingsGroup"
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}appstream_stack"
  })
}