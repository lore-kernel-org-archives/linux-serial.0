Return-Path: <SRS0=D0ei=4Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D1C10F00
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 04:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21409206D7
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 04:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="O08IJSgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCGE2j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 23:28:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43962 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCGE2j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 23:28:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id f8so1685234plt.10
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2020 20:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=JqEEYRC8D7J1sqL+MKbRyD3O12DI0rJhBdywb3r67aQ=;
        b=O08IJSgT9RRdq5UtU96pn7QHniy1dRZmoBOegNea4qVsuG7GW4BGZ1kf24iIzptTXj
         n12w1q4o+KIEoHoIhFfdSgeBm5XuRuIxmHbXtULepqatTSsPw78lALhRAEgTBpyoIaHB
         nKnb2PU1MabuA19gEBBI+cXC5+ri0TUQ6n+QlxLtFShaTABIHCgHCBS0koOv2cBd551h
         7E/h3zaZ7x00dpfRzG59m56yMOrtuzyBH9W0rCYcafyls/igaqSl60l+KpdzA5ekQb1a
         7SqiRqL31fJkJpkzGf5bPIhMM5x3CpqPoNM+XfOofd6TdIi/mvsLGTn5wTGO/L8rpIJ1
         IjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=JqEEYRC8D7J1sqL+MKbRyD3O12DI0rJhBdywb3r67aQ=;
        b=Zvv18ayAI/3nYrkWrEPKWZeXNo4IcGDVt27ig6jytwmU413wsAD/f9yKukF8anxmKR
         9NolOTHj3aNG+m0sVo9rDOfnW09jLQ8hT68tLtVsCpqVGOiSdRBYLlPoBbaq5TYMX2yT
         6crzgQqlzd3AnpKNf55tV2iHwJpgJ2txWUFfMZBGmCuiETMQ9BYjRCdnZe12FgSyS3eD
         dfq/WTNP3ndU4fH83IubCAS3qgBDl0qXSihTBqn82RQlzrNNhQQqgXCRzb3pRhZXjfLa
         cZCmh9pmm2DJt2ylSiW6pKK5FmTQfPcTy+prtVlgE6n7g5R7dzcTZJFYVElR7g1AIM5L
         8eWg==
X-Gm-Message-State: ANhLgQ0Q42825YOFmgY3rciVI5FjxK3FGgyHydLSjoidv2/VMF7PET/5
        kJ33ci3UzIMKnisw8LEtQjv0QA==
X-Google-Smtp-Source: ADFU+vsXktTJfbSIn4OTidMPzYwPYVCPRU5N0l5d8ObjtGHmgqRiAVuDkF3RXOj+/nOfBuMLYLNPAg==
X-Received: by 2002:a17:90a:20b:: with SMTP id c11mr6965847pjc.53.1583555317388;
        Fri, 06 Mar 2020 20:28:37 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id h4sm32082934pgq.20.2020.03.06.20.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 20:28:36 -0800 (PST)
Subject: [PATCH] tty: sifive: Finish transmission before changing the clock
Date:   Fri,  6 Mar 2020 20:26:38 -0800
Message-Id: <20200307042637.83728-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

SiFive's UART has a software controller clock divider that produces the
final baud rate clock.  Whenever the clock that drives the UART is
changed this divider must be updated accordingly, and given that these
two events are controlled by software they cannot be done atomically.
During the period between updating the UART's driving clock and internal
divider the UART will transmit a different baud rate than what the user
has configured, which will probably result in a corrupted transmission
stream.

The SiFive UART has a FIFO, but due to an issue with the programming
interface there is no way to directly determine when the UART has
finished transmitting.  We're essentially restricted to dead reckoning
in order to figure that out: we can use the FIFO's TX busy register to
figure out when the last frame has begun transmission and just delay for
a long enough that the last frame is guaranteed to get out.

As far as the actual implementation goes: I've modified the existing
existing clock notifier function to drain both the FIFO and the shift
register in on PRE_RATE_CHANGE.  As far as I know there is no hardware
flow control in this UART, so there's no good way to ask the other end
to stop transmission while we can't receive (inserting software flow
control messages seems like a bad idea here).

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
I have not tested this, as I don't have any hardware.  I'm also not even
remotely familiar with the serial subsystem, so I don't know if there's a
better way of going about this.  I'm specifically worried about a udelay() that
could be quite long.  Maybe some sort of "delay for short times, sleep for long
times" approach would be better?

I don't know if this manifests in practice on existing hardware when running
real workloads, but I'd be willing to bet that it would be possible to trigger
the bug on purpose as by my calculations there's about a 10k cycle window in
which the clock can't change.  IIRC there's a lot of instability when changing
the clock frequency on the HiFive Unleashed so I doubt people are going to
stumble across the issue regularly in practice.

 drivers/tty/serial/sifive.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d5f81b98e4d7..d34031e842d0 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -618,10 +618,10 @@ static void sifive_serial_shutdown(struct uart_port *port)
  *
  * On the V0 SoC, the UART IP block is derived from the CPU clock source
  * after a synchronous divide-by-two divider, so any CPU clock rate change
- * requires the UART baud rate to be updated.  This presumably could corrupt any
- * serial word currently being transmitted or received.  It would probably
- * be better to stop receives and transmits, then complete the baud rate
- * change, then re-enable them.
+ * requires the UART baud rate to be updated.  This presumably corrupts any
+ * serial word currently being transmitted or received.  In order to avoid
+ * corrupting the output data stream, we drain the transmit queue before
+ * allowing the clock's rate to be changed.
  */
 static int sifive_serial_clk_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
@@ -629,6 +629,26 @@ static int sifive_serial_clk_notifier(struct notifier_block *nb,
 	struct clk_notifier_data *cnd = data;
 	struct sifive_serial_port *ssp = notifier_to_sifive_serial_port(nb);
 
+	if (event == PRE_RATE_CHANGE) {
+		/*
+		 * The TX watermark is always set to 1 by this driver, which
+		 * means that the TX busy bit will lower when there are 0 bytes
+		 * left in the TX queue -- in other words, when the TX FIFO is
+		 * empty.
+		 */
+		__ssp_wait_for_xmitr(ssp);
+		/*
+		 * On the cycle the TX FIFO goes empty there is still a full
+		 * UART frame left to be transmitted in the shift register.
+		 * The UART provides no way for software to directly determine
+		 * when that last frame has been transmitted, so we just sleep
+		 * here instead.  As we're not tracking the number of stop bits
+		 * they're just worst cased here.  The rest of the serial
+		 * framing parameters aren't configurable by software.
+		 */
+		udelay(DIV_ROUND_UP(12 * 1000 * 1000, ssp->baud_rate));
+	}
+
 	if (event == POST_RATE_CHANGE && ssp->clkin_rate != cnd->new_rate) {
 		ssp->clkin_rate = cnd->new_rate;
 		__ssp_update_div(ssp);
-- 
2.25.1.481.gfbce0eb801-goog

