From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/10] fblog: add framebuffer helpers
Date: Sun, 17 Jun 2012 00:04:21 +0200
Message-ID: <1339884266-9201-6-git-send-email-dh.herrmann@googlemail.com>
References: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Herrmann <dh.herrmann@googlemail.com>
List-Id: linux-serial@vger.kernel.org

These helpers scan the system for all available framebuffers and register
or unregister them. This is needed during startup and stopping fblog so we
are aware of all connected displays.

The third helper handles mode changes by rescanning the mode and adjusting
the buffer size.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/video/console/fblog.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/video/console/fblog.c b/drivers/video/console/fblog.c
index e790971..7d4032e 100644
--- a/drivers/video/console/fblog.c
+++ b/drivers/video/console/fblog.c
@@ -399,6 +399,35 @@ static void fblog_unregister(struct fblog_fb *fb)
 	kfree(fb);
 }
 
+static void fblog_register_all(void)
+{
+	int i;
+
+	for (i = 0; i < FB_MAX; ++i)
+		fblog_register(registered_fb[i]);
+}
+
+static void fblog_unregister_all(void)
+{
+	int i;
+
+	for (i = 0; i < FB_MAX; ++i)
+		fblog_unregister(fblog_info2fb(registered_fb[i]));
+}
+
+static void fblog_refresh(struct fblog_fb *fb)
+{
+	unsigned int width, height;
+
+	if (!fb || !fb->font)
+		return;
+
+	width = fb->info->var.xres / fb->font->width;
+	height = fb->info->var.yres / fb->font->height;
+	fblog_buf_resize(&fb->buf, width, height);
+	fblog_redraw(fb);
+}
+
 static int __init fblog_init(void)
 {
 	return 0;
-- 
1.7.10.4
