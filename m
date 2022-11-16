Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4DCC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 16 Nov 2022 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiKPOtm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiKPOth (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:37 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98003F051;
        Wed, 16 Nov 2022 06:49:28 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d8so8516338qki.13;
        Wed, 16 Nov 2022 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21klUdbfGDRjcluKPkIVpLANgI2deNdmI4jgyQps/O0=;
        b=EYgqspdiucuTWsvjn5S6eUubn/RonJlGGr6XQH9udQo5oPwaxVDlPnph7Uqr9uT43c
         jnddqrU9VZOGOAvSZCyhXOjg0QLntF8hRsx5fPxddi2x3KtN0sXQJi6ephoD/4pBAjQJ
         R13YdcKGMhbNobLjaC6zy7shjKf7dNtCVNfcDhopeGbavJ+HgFHOHpJhtQNe2Ko+/HEu
         rINoCnFKpAjrZ3Ns3uEcRh1RdJ0Ymm3JWkqNHhsPhmxdNahffUIYzkRkf81MWH0IImOW
         FtHKeabx8H3RisP0G/FMgfj+3rqCq6P3JL+RpTMeKzjPR6/D3Y26xOfNZ8FoOn92epsS
         a1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21klUdbfGDRjcluKPkIVpLANgI2deNdmI4jgyQps/O0=;
        b=xfN/h+t9kz2QwqNC/JM3g9XYNG0rRbEvJyy+1n/2lM7PmbvCx3+iPhhqOsj7ku7zHf
         fn/caGdddmbdLA8QjFSTnx3r8T7N8ggMXhLF/t58DqaqWbczhXL7A2Oved8XIcmF6lDU
         6McgvC4MhWxXTWZ7/sBzlGRP115m1PL/9kGDjU8DTPAvsIP6Aibmq5ZZrM4fhQ6HcTPP
         dN3atEznWZ1oDFyW4hekQJULXLABjLLOJ7p9jil/w0vqjiFU4BSemF5UAHmFScExTvnq
         DE0o0bndVB4lhaZsVXVpl57Wwl64WuImHY+TwvYFOrIzPiAKDCkYPkVny1OAURAhCG6s
         1wgw==
X-Gm-Message-State: ANoB5plTejUeEQ7IrRCvqmNuFFuSu9cAkH7Vl+JSr6kCuypQ7NVQWOfS
        WKxyAHBLJ43oP+zL+VtXvqdiQiO+E21Qdg==
X-Google-Smtp-Source: AA0mqf7jEQ6KqNUud3f9kU3ikIi1jHJPAI4w9x+VlydXU0a3WgHtXg2UsUW2AEaxGj7kcNNmv7xRmw==
X-Received: by 2002:a37:a9c6:0:b0:6fa:752a:496 with SMTP id s189-20020a37a9c6000000b006fa752a0496mr19217958qke.428.1668610167537;
        Wed, 16 Nov 2022 06:49:27 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:27 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 11/14] serial: liteuart: move function definitions
Date:   Wed, 16 Nov 2022 09:49:05 -0500
Message-Id: <20221116144908.234154-12-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move definitions for liteuart_[stop|start]_tx(), liteuart_stop_rx(),
and liteuart_putchar() to a more convenient location in preparation
for adding IRQ support. This patch contains no functional changes.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 76f8a09b82cd..8a6e176be08e 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -68,6 +68,47 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
+static void liteuart_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, ch);
+}
+
+static void liteuart_stop_tx(struct uart_port *port)
+{
+}
+
+static void liteuart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned char ch;
+
+	if (unlikely(port->x_char)) {
+		litex_write8(port->membase + OFF_RXTX, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+	} else if (!uart_circ_empty(xmit)) {
+		while (xmit->head != xmit->tail) {
+			ch = xmit->buf[xmit->tail];
+			uart_xmit_advance(port, 1);
+			liteuart_putchar(port, ch);
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void liteuart_stop_rx(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* just delete timer */
+	del_timer(&uart->timer);
+}
+
 static void liteuart_rx_chars(struct uart_port *port)
 {
 	unsigned char __iomem *membase = port->membase;
@@ -98,14 +139,6 @@ static void liteuart_timer(struct timer_list *t)
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-static void liteuart_putchar(struct uart_port *port, unsigned char ch)
-{
-	while (litex_read8(port->membase + OFF_TXFULL))
-		cpu_relax();
-
-	litex_write8(port->membase + OFF_RXTX, ch);
-}
-
 static unsigned int liteuart_tx_empty(struct uart_port *port)
 {
 	/* not really tx empty, just checking if tx is not full */
@@ -125,39 +158,6 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 }
 
-static void liteuart_stop_tx(struct uart_port *port)
-{
-}
-
-static void liteuart_start_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned char ch;
-
-	if (unlikely(port->x_char)) {
-		litex_write8(port->membase + OFF_RXTX, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-	} else if (!uart_circ_empty(xmit)) {
-		while (xmit->head != xmit->tail) {
-			ch = xmit->buf[xmit->tail];
-			uart_xmit_advance(port, 1);
-			liteuart_putchar(port, ch);
-		}
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-}
-
-static void liteuart_stop_rx(struct uart_port *port)
-{
-	struct liteuart_port *uart = to_liteuart_port(port);
-
-	/* just delete timer */
-	del_timer(&uart->timer);
-}
-
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
-- 
2.38.1

