From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH 2/3] serial: sh-sci: Fix range check of bit-rate for HSCIF
Date: Mon, 14 Jul 2014 16:09:59 +0900
Message-ID: <1405321800-18114-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1405321800-18114-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60257 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaGNHKT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 03:10:19 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so4681065pdi.23
        for <linux-serial@vger.kernel.org>; Mon, 14 Jul 2014 00:10:18 -0700 (PDT)
In-Reply-To: <1405321800-18114-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, horms+renesas@verge.net.au, magnus.damm@gmail.com, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

If bit-rate calculation result of HSCIF is expect 255 from 0,
driver does not calculate error bit. However, we need to round
the value to calculate error bit in the case of negative value.
This rounds the value of bit-rate using clamp(), and bit-rate is the
case of negative value, it enables the calculation of the error bit.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ce80137..7f571a8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1798,8 +1798,7 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
 			/* integerized formulas from HSCIF documentation */
 			br = DIV_ROUND_CLOSEST(freq, (sr *
 					      (1 << (2 * c + 1)) * bps)) - 1;
-			if (br < 0 || br > 255)
-				continue;
+			br = clamp(br, 0, 255);
 			err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
 					       (1 << (2 * c + 1)) / 1000)) -
 					       1000;
-- 
2.0.0

