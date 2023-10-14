Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB07CDB482
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNSNm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjJNSNm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 14:13:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD7A1
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 11:13:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so2585337276.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697307219; x=1697912019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rKyrhxaGZv0nPLnMXbvJXkiVEGuU/Lq6wP9rgM/Alfg=;
        b=u/yYNOojuWmJosMmEwVDzzax7C8pIpjeMNn6ObQ2JFgunKX5fe3pJvQUIhHaq3wXfx
         muDTEoWT32bmlJ0SmlSdQjj4DayGooJQ6F1X/SZv0NLDdmcbCb1lyRWbVsEyOz1RWE1Z
         /5e83rH3pztsq+OrAwowSsXxvfydaRQOUAKDex/lwj2iwlzODSKDhM1myiOOlt0XTzBt
         gR/qxsCJCPcbObAYBnc3ECzKuxca/dwcoUcoOENHJOoXOSZtHhsKaGZIDVFX0alEXYx5
         3FI5Omjd7jEhF/5ukmATWtr67wQgkI/sd3bcLNm+C5xKMwdcqcA5lAodoPOYzxswrBKL
         ASCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307219; x=1697912019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKyrhxaGZv0nPLnMXbvJXkiVEGuU/Lq6wP9rgM/Alfg=;
        b=IIyuBjyvLxbHWgcHCSFnvzSqOqUsuwDW1rMdBEjyMMtggqILkKFvUF7SUKYkbSdx0O
         friGXBXweGe+mX9S6Z3aYFCX5dPVtCySEoxFv3YAUwhn9jl0JlB0mFfRTdskpC1P60wv
         9qqzh18YNfpRCeQEy41HHhnDRyjx2L5BXHRIpzwWM1ecZPdjykLlumcIXZHK+Ih/867/
         Y98DPRHdo/YkdvWmxo93N4ilIP9STRqoO/PBMHnvCy7iyZCL7fbZI8JWjbEE5It6bdpw
         weOYiGB1mmFnsdtXYvfJuCQwOykzJlfL4xoLnnEmwx+YgMk5SaCO+3tHEFiTnawcoL1e
         DxaQ==
X-Gm-Message-State: AOJu0YyKBDdx6zuptp8KjpkBFfJi+MSEILJrvijmpQ6EsD4i003/o9H3
        mgDnAzJ8Djcf2jifMipRPogw0lX3GZAfbTxdj2Kr
X-Google-Smtp-Source: AGHT+IH0MJExwfauji0fzv9X3e2ja5LOFD5TgaDDRwSxh/LV1XA12gw16CrCrlDxSl0RHLgxPKVAr43tr6sACN2TaXH5
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:d748:0:b0:d89:cd65:c2b0 with
 SMTP id o69-20020a25d748000000b00d89cd65c2b0mr95600ybg.6.1697307219523; Sat,
 14 Oct 2023 11:13:39 -0700 (PDT)
Date:   Sat, 14 Oct 2023 23:43:33 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014181333.2579530-1-vamshigajjela@google.com>
Subject: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

uart_update_timeout() sets a u64 value to an unsigned int frame_time.
While it can be cast to u32 before assignment, there's a specific case
where frame_time is cast to u64. Since frame_time consistently
participates in u64 arithmetic, its data type is converted to u64 to
eliminate the need for explicit casting.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- use DIV64_U64_ROUND_UP with frame_time

 drivers/tty/serial/8250/8250_port.c | 2 +-
 include/linux/serial_core.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 141627370aab..d1bf794498c4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 			 * rather than after it is fully sent.
 			 * Roughly estimate 1 extra bit here with / 7.
 			 */
-			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
+			stop_delay = p->port.frame_time + DIV64_U64_ROUND_UP(p->port.frame_time, 7);
 		}
 
 		__stop_tx_rs485(p, stop_delay);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..b128513b009a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -558,7 +558,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
-	unsigned int		frame_time;		/* frame timing in ns */
+	unsigned long		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
 	const struct uart_ops	*ops;
 	unsigned int		custom_divisor;
@@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
  */
 static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 {
-	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
 
 	/* Add .02 seconds of slop */
 	fifo_timeout += 20 * NSEC_PER_MSEC;
-- 
2.42.0.655.g421f12c284-goog

