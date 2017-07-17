From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC v2 1/6] mux: include compiler.h from mux/consumer.h
Date: Mon, 17 Jul 2017 17:24:31 +0200
Message-ID: <1500305076-15570-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Required for __must_check.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 include/linux/mux/consumer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 5577e1b..ea96d4c 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -13,6 +13,8 @@
 #ifndef _LINUX_MUX_CONSUMER_H
 #define _LINUX_MUX_CONSUMER_H
 
+#include <linux/compiler.h>
+
 struct device;
 struct mux_control;
 
-- 
2.7.4
