From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 05/16] ARM: shmobile: sh7372: Don't set plat_sci_port scbrr_algo_id field
Date: Thu, 28 Nov 2013 22:43:19 +0100
Message-ID: <1385675010-26904-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 798f8ac..2730127 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -91,7 +91,6 @@ void __init sh7372_pinmux_init(void)
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
 	.flags		= UPF_BOOT_AUTOCONF,			\
-	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= SCSCR_RE | SCSCR_TE,			\
 };								\
 								\
-- 
1.8.3.2

