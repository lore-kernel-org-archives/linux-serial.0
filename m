From: Michael Williamson <michael.williamson@criticallink.com>
Subject: [PATCH 2/2 v1] davinci: mityomapl138 platform: disable MS interrupts on UART1
Date: Wed,  5 Jan 2011 07:26:32 -0500
Message-ID: <1294230392-29564-2-git-send-email-michael.williamson@criticallink.com>
References: <1294230392-29564-1-git-send-email-michael.williamson@criticallink.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58442 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab1AEMYN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Jan 2011 07:24:13 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so6405069vws.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2011 04:24:13 -0800 (PST)
In-Reply-To: <1294230392-29564-1-git-send-email-michael.williamson@criticallink.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, linux-serial@vger.kernel.org, gregkh@suse.de, Michael Williamson <michael.williamson@criticallink.com>

All supported configurations of the MityDSP-l138 and MityARM-1808
SoMs use the pin associated with CTS on UART1 as either an AHCLKX
input or a USB_REFCLKIN input.  Disable modem status interrupts
associated with this pin.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
This is against the linux-davinci tree.

 arch/arm/mach-davinci/board-mityomapl138.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 0bb5f0c..10ea4cb 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -283,7 +283,8 @@ static void __init mityomapl138_setup_nand(void)
 }
 
 static struct davinci_uart_config mityomapl138_uart_config __initdata = {
-	.enabled_uarts = 0x7,
+	.enabled_uarts	= 0x7,
+	.disable_msi	= 0x2,
 };
 
 static const short mityomap_mii_pins[] = {
-- 
1.7.0.4

