From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 11/11] MAINTAINERS: add fblog entry
Date: Sun, 12 Aug 2012 16:53:25 +0200
Message-ID: <1344783205-2384-12-git-send-email-dh.herrmann@googlemail.com>
References: <1344783205-2384-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344783205-2384-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, David Herrmann <dh.herrmann@googlemail.com>
List-Id: linux-serial@vger.kernel.org

Add myself as maintainer for the fblog driver to the MAINTAINERS file.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 375b1fd..40a10b54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2895,6 +2895,12 @@ F:	drivers/video/
 F:	include/video/
 F:	include/linux/fb.h
 
+FRAMEBUFFER LOG DRIVER
+M:	David Herrmann <dh.herrmann@googlemail.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/console/fblog.c
+
 FREESCALE DMA DRIVER
 M:	Li Yang <leoli@freescale.com>
 M:	Zhang Wei <zw@zh-kernel.org>
-- 
1.7.11.4
