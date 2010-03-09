From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 11/13] serial: bfin_sport_uart: pull in bfin_sport.h for SPORT defines
Date: Tue,  9 Mar 2010 12:25:38 -0500
Message-ID: <1268155540-8241-12-git-send-email-vapier@gentoo.org>
References: <1268155540-8241-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54729 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347Ab0CIRWf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Mar 2010 12:22:35 -0500
In-Reply-To: <1268155540-8241-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

Now that the SPORT MMR defines have been unified, switch over to it.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_sport_uart.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_sport_uart.c
index 9d777e4..840faf5 100644
--- a/drivers/serial/bfin_sport_uart.c
+++ b/drivers/serial/bfin_sport_uart.c
@@ -33,6 +33,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 
+#include <asm/bfin_sport.h>
 #include <asm/delay.h>
 #include <asm/portmux.h>
 
-- 
1.7.0.2

