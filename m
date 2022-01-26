Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54619C3526D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiAZOLl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiAZOLj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 09:11:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F16C06161C
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 06:11:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r25so9323458wrc.12
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 06:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0LjfliPV2lqniJ1GWy/KM8l8B0S0kAr864IiuW9ac4=;
        b=JYOgK6Rt2GZ7TG1tOBJFZLRGb66DJLQmU4Oau5w5tWL9ucaWvtLb2/W+NpMpP2JpoF
         APNFcmirysrGCHBgyzh1Loz/4dQ8K16r4WyADyFEdC5Lg2pcFPQLOtoxe5GT2T6pTqgo
         QjYwhmiPDjtRujBad/6/dfC+TlpGRHE1n/NQHI+tSZMObg1y6wY7LD/JQbv5toShlAIr
         mWjveGDxSPIo/RmeczKB9+ALF2CkU31jYhYEw70pQPo8TJREucNToLRnq8civou2B0+R
         LVwH2bUZU7EIw3MJcPVKx7h9Y6X7Y0AFQyWf5+BuJU8u/D+A4Y4dCWZLozn5DOBXy884
         47+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0LjfliPV2lqniJ1GWy/KM8l8B0S0kAr864IiuW9ac4=;
        b=k7w9Sye3jH/7fCXijZwW/HvCA0lmTbbhjQFM8FRFJrhK6qJ/MqgjdH90qRNI/YYocS
         Y0tNLzk2szV0iZnVmiDLC0yLdnOlcqGGRFYhYgFQJoHluzu63vb3GWX9HA50SEUnk0VP
         FMtBwbSjFllV2MTyQ64comhCWoZTsbFNUeAwxDume5cJOy7CGp3y+GMxkelYk+wUVtZv
         VthAzRgqS08fdB0fdh2tn79MWSbi/QNaFyDwW2mExGWqpPDXcDGSpFO16zuSexn0ZEOl
         ADNEROOlduhplI9xZKkVNPYyWmgfsU2k7OHFlIvpfK1c/4aUxIoxaRZCjlr8IteRop6f
         aRlg==
X-Gm-Message-State: AOAM530VvKqhMuD4exwjJW0QooR7wMcys8YVR3Z8TGOJkPbmADSf5M/X
        u7UlXFlC9VJxAFh/UXuHCSjeiA==
X-Google-Smtp-Source: ABdhPJyJ5cXGvopPOp06Iko/KXy0KjBLBCkkfJjcsEyHGfEEQ8tTDBOwCnjsWsfiaVSTy9+Z8R2zhw==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr22141657wrz.635.1643206297012;
        Wed, 26 Jan 2022 06:11:37 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id o12sm3967150wmq.41.2022.01.26.06.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:11:36 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] serial: 8250: Fix ...console_fifo_write on BCM283x
Date:   Wed, 26 Jan 2022 14:11:24 +0000
Message-Id: <20220126141124.4086065-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The mini-UART on BCM283x is doubly crippled - it has 8-byte FIFOs and
the THRE bit indicates that the TX FIFO is not-full rather than empty.

The optimisation to enable the use of the FIFO assumes that it is safe
to write fifosize bytes whenever THRE is set, but the BCM283x quirk
(indicated by the presence of UART_CAP_MINI) makes it necessary to
check the FIFO state after each byte.

See: https://github.com/raspberrypi/linux/issues/4849

Fixes: 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2abb3de11a48..8a2b462d363c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3357,6 +3357,13 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				serial_out(up, UART_TX, *s++);
 				cr_sent = false;
 			}
+			/*
+			 * The BCM2835 MINI UART THRE bit is really a not-full
+			 * bit, so be prepared to bail out early.
+			 */
+			if ((up->capabilities & UART_CAP_MINI) &&
+			    !(serial_in(up, UART_LSR) & UART_LSR_THRE))
+				break;
 		}
 	}
 }
-- 
2.25.1

