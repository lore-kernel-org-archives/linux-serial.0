From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 11/11] MAINTAINERS: add fblog entry
Date: Sun,  8 Jul 2012 23:56:54 +0200
Message-ID: <1341784614-2797-12-git-send-email-dh.herrmann@googlemail.com>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org, David Herrmann <dh.herrmann@googlemail.com>
List-Id: linux-serial@vger.kernel.org

Add myself as maintainer for the fblog driver to the MAINTAINERS file.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae8fe46..249b02a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2854,6 +2854,12 @@ F:	drivers/video/
 F:	include/video/
 F:	include/linux/fb.h
 
+FRAMEBUFFER LOG DRIVER
+M:	David Herrmann <dh.herrmann@googlemail.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/video/console/fblog.c
+
 FREESCALE DMA DRIVER
 M:	Li Yang <leoli@freescale.com>
 M:	Zhang Wei <zw@zh-kernel.org>
-- 
1.7.11.1
