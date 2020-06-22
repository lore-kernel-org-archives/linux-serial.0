Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B6C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EBD20768
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcYOxIUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFVO1w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgFVO1v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F854C061795
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k6so7641502pll.9
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9KwMzs626zZhBtIoTQs5efdkplmNJ79hSzl8cSVNjw=;
        b=fcYOxIUyQqvxk/LMxj5k2PcHWbKksWlVM0RADhm7nGAokdEUmwV3EEiZC6qY8FZN+u
         MXoiD9Bl8uV3mE4dflId5Ysj9kk2DyS+ixwUWTwMxgQNlEF/UXTDXHxh7aeIfq/mou+U
         eOEgNlbrFUBNwfhMfJmEyGzg5fmJfkUD5+UTEteGBQmEZK7I1tsSoxz7idIIF4PWOgEv
         3wQpxAZvdSHhEhomUs3Z4VP2UfDdFTNS9ukNUxnLQOoybV0TbZMI9blZV8rUJ1CsWUdM
         EJwzGZlCgI6Rtzeeiy5wd0ZheSlc3cyB8kuXh84pgLq/xOC7zPeMMPf0jJb4+LZ6QsuT
         hT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9KwMzs626zZhBtIoTQs5efdkplmNJ79hSzl8cSVNjw=;
        b=O9sJcF0mPghMqch6Bto2p1tJrxVlp3XYU96nw2LeMDfcb6Hn8/d+nP9JguHnh4Gm+f
         R5P7eAvh7YtWgFLtVYQqTsa0ay3ybMuz6sHPdj+CUo5GLQgtdG9G9wMxyktO8PWdIraz
         V+dDDXQICs5mcd+LDjtbdz4PLVJ/ESI47BZ/9lNeJ8YFg2mXdmhZS4nwGPtLBKSJs8o8
         57c4z75QrY7fwlEYbW0ZIrRrWj1vUpWt7ey+4IxXFj4S5YjvOdLgce/5iq+Hbim/NQ7e
         N/gmwtIkApXTkE6cbYxF1AUtN/h4vd0NUWgb6Yo45u3ZKyAorO1q2p6hIYGr9d7lLUEE
         Tg7g==
X-Gm-Message-State: AOAM531c3PgR52XFv4PDYFLF9U7E3Zo9LHNW4jNy4p/J6P8l8gsTsVd4
        +1o+/tsKAEYpqxsntHqz+aHCpQ==
X-Google-Smtp-Source: ABdhPJxdk4/xczBSB9mmZ7kd/CjrWcQEW1E+5kTeVyzPqHBNPaFgJntiHv8R1qUiKMAh8yK0vGiMnA==
X-Received: by 2002:a17:902:d903:: with SMTP id c3mr18839486plz.229.1592836070328;
        Mon, 22 Jun 2020 07:27:50 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:49 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 6/7] serial: amba-pl011: Implement poll_get_irq() interface
Date:   Mon, 22 Jun 2020 19:56:23 +0530
Message-Id: <1592835984-28613-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support kgdb NMI console feature via implementing poll_get_irq()
interface. This will allow usage of RX interrupts to support kgdb entry
while serial device is operating in polling mode.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c010f63..d620d12 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1637,6 +1637,16 @@ static void pl011_put_poll_char(struct uart_port *port,
 	pl011_write(ch, uap, REG_DR);
 }
 
+static int pl011_get_poll_irq(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+
+	pl011_write(UART011_RTIM | UART011_RXIM, uap, REG_IMSC);
+
+	return uap->port.irq;
+}
+
 #endif /* CONFIG_CONSOLE_POLL */
 
 static int pl011_hwinit(struct uart_port *port)
@@ -2145,6 +2155,7 @@ static const struct uart_ops amba_pl011_pops = {
 	.poll_init     = pl011_hwinit,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
+	.poll_get_irq  = pl011_get_poll_irq,
 #endif
 };
 
@@ -2176,6 +2187,7 @@ static const struct uart_ops sbsa_uart_pops = {
 	.poll_init     = pl011_hwinit,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
+	.poll_get_irq  = pl011_get_poll_irq,
 #endif
 };
 
-- 
2.7.4

