From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 34/47] ARM: shmobile: r7s72100: Don't set plat_sci_port scbrr_algo_id field
Date: Fri,  6 Dec 2013 10:59:41 +0100
Message-ID: <1386323994-12850-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33748 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab3LFKAe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 05:00:34 -0500
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r7s72100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 81b995b..9c0b3a9 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -33,7 +33,6 @@ static const struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= PORT_SCIF,					\
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= SCBRR_ALGO_2,					\
 	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
 			  SCSCR_REIE,					\
 };									\
-- 
1.8.3.2

