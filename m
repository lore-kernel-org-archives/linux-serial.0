From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2] ASoC: CX20442: simplify codec controller usage
Date: Thu, 6 Aug 2009 12:25:00 +0200
Message-ID: <200908061225.00856.jkrzyszt@tis.icnet.pl>
References: <200908061141.38695.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:58371 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbZHFKZW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Aug 2009 06:25:22 -0400
In-Reply-To: <200908061141.38695.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, e3-hacking@earth.li

This patch is a workaround for the problem of several subsequent control 
statements not being applied correctly to the codec controller (modem).

In order to follow the hook switch state change from handset to handsfree 
while 
in full duplex mode, two consecutive +VLS control commands were sent to the 
modem. The first one was M1 (microphone only), the seconds one was M1S1 (both 
microphone and speaker). As there was no real modem handshaking procedure 
implemented, neither in the codec nor in the machine driver part of the line 
discipline, the modem was having the second command missed.

Since a possibility to switch to microphone only mode (and speaker only mode 
as well) seams of no value, I have modified the code to issue single M1S1 
command only for any of those cases.

Tested on my Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- linux-2.6.31-rc5/sound/soc/codecs/cx20442.c.orig	2009-08-04 
23:41:03.000000000 +0200
+++ linux-2.6.31-rc5/sound/soc/codecs/cx20442.c	2009-08-05 00:56:30.000000000 
+0200
@@ -138,9 +138,7 @@ static int cx20442_pm_to_v253_vls(u8 val
 	case 0:
 		return V253_VLS_T;
 	case (1 << CX20442_SPKOUT):
-		return V253_VLS_S1;
 	case (1 << CX20442_MIC):
-		return V253_VLS_M1;
 	case (1 << CX20442_SPKOUT) | (1 << CX20442_MIC):
 		return V253_VLS_M1S1;
 	case (1 << CX20442_TELOUT):
