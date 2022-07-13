Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D29C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 13 Jul 2022 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiGMMjc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGMMjb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Jul 2022 08:39:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD92F5D5E
        for <linux-serial@vger.kernel.org>; Wed, 13 Jul 2022 05:39:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so8352065ybi.2
        for <linux-serial@vger.kernel.org>; Wed, 13 Jul 2022 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GlEwVVGZwmExSzZdU5QHRpYeRho/uS6G6Gk9NxHKj+M=;
        b=TKKOqIpzg+qDRzqTWDhgVHUP+0Z/FLyemlhq/cxI6jZlEhtiWxdp7r27jfRMk0GgwM
         ueZKz60Wc8SQJr/kywB/A8TZqbXNK6jJX34N2UbnpW2B6SEs+TBZwfdSwOi1ww1g2vXz
         GwesH64lPhF48vPYHsX8nztKQPjAqRwvrVha2MJP9kH5dHtLcFWqCzS8qYDo2/qHpJe+
         gcic3CGixWEBW8Jt+qUhdNf/jfRSaZDe/koNLCt+6bwfw1xs5ef0UwvF8zWlrTBAAVQp
         6aw56MCd9+hVVCXJU6h/I05kc5bt3pBvhM5Mtp7a6nl2OMVFWecuf594GrNksrFTaJIF
         hPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GlEwVVGZwmExSzZdU5QHRpYeRho/uS6G6Gk9NxHKj+M=;
        b=U0rDlfCdl/VHGda6BAYgIAii7i3jJnTKDn7XThpiUAa4VCM5XpHT/FzJ7DrVN1joUY
         NfvWpKxj4h1knaQ1M9qaiFPOqOnC8z+X/kFY69db8cQqRAMX05CE9qz6z4qcAP8MJfKt
         igUUR9nrVx0iiCEi1IsfrRlerJw71qO+8JkIahyAYhGntBr+P4qkC1j7Mm74OIII7l3k
         +YB4b5bTKLdspqb1sea8yIGk53J1AuPiCKgroLGBMStx4QavRy/6gQK8sJi0xy00aPT7
         bbc0lwQoOqXVWZf3iURa8yxlrLKxQYImyF6RxXZ8RvBSXuLAQBb9bIFAduk6Q7nVmZt9
         nH5Q==
X-Gm-Message-State: AJIora9GObPptRDbCG4iG7scnehO1GkFNTRGsXFBmPJJAbE3e7x1fH72
        1VealqYIfvYjyQRCkdEBNlux5yWEM12jZHY7H+TC
X-Google-Smtp-Source: AGRyM1uA8G/SED3/+nKnJXpMZcYPGNm5LhG0bCzZ/6u2FEPS8x5tQ+nKm+Q1e0N5V5pwyVh7yiI5QkTKFBsDCx94l2yK
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:7356:0:b0:66e:ccb3:54b1 with
 SMTP id o83-20020a257356000000b0066eccb354b1mr3121081ybc.569.1657715969704;
 Wed, 13 Jul 2022 05:39:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:09:22 +0530
Message-Id: <20220713123922.2284522-1-vamshigajjela@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v2] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

With PSLVERR_RESP_EN parameter set to 1, the device generates an error
response when an attempt to read an empty RBR with FIFO enabled.

This happens when LCR writes are ignored when UART is busy.
dw8250_check_lcr() in retries to update LCR, invokes dw8250_force_idle()
to clear and reset FIFO and eventually reads UART_RX causing the error.

Avoid this by not reading RBR/UART_RX when no data is available.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- update as per review comments (re-format comments, xmas tree ordering)

 drivers/tty/serial/8250/8250_dw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..bfba89e6c875 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -82,8 +82,18 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 static void dw8250_force_idle(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int lsr;
 
 	serial8250_clear_and_reinit_fifos(up);
+
+	/*
+	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
+	 * error response when an attempt to read empty RBR with FIFO enabled.
+	 */
+	lsr = p->serial_in(p, UART_LSR);
+	if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
+		return;
+
 	(void)p->serial_in(p, UART_RX);
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

