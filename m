Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE34C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE49520767
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iES2Z3LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgFVO1q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgFVO1p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB73C061573
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so5753809pls.5
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8XZGlRV/H7ipjUMwZ0R6upcC6zi/GhiQnizl6ayNWQ=;
        b=iES2Z3LS/+1ufp5YulU7Lewvw1bchggk2aWycD2ouwUfDqw/J2BDmhkYLoA5Q8Xi1/
         czE87Id/eTsr/WIJUHU8BJT+s05ule9+LYv0Ido5T4GknU8qZXkBGUNrJUw9Yoc9s4/b
         GbKx6DlF9lfyzRTu+u41x/JFhfpsQDL13xVlQtBdo9b5QcM3gFxunzDEApVgBt2ZCiMC
         fe4kGGgabD666+6T0pGDqHa2rTr0hbLHGBP9dQ91Z9MHTbd+skiPXa44ljD14bUyQwDe
         IqyvhXNM6ncGGDSSPex+2Zmrr3VIqDY+mSqst1UwK3XIJ5tQNVugk+49gE/f2ylISQlv
         Zfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8XZGlRV/H7ipjUMwZ0R6upcC6zi/GhiQnizl6ayNWQ=;
        b=lDJZHEskMkBUqgfWceurRmu1ibsgU9o/05KGpl1QAdiTW+O54PNHUSqj5Of7H9xHIi
         Bl3q2z2jRxHrHcdIqP2V5NjYLFh4VTgNZ3IQ+iPJgmfFZrcp4YuSIBpAHmxzqvtAWwLk
         1JJUP0pW5QJ7f0n0Q9QlQOpnBzhOzU9p8Xn6tHoDlK1q1Rrs2c3DYVBY4e/vGl/MQBR5
         VbRQ582Zw0oy2f1JSwqpGGSyoz8ZTo6GgDcBIWytCHSrHoEOwpmkkT1ei92OfHeUCBaw
         gcNlrseB8uh7Ll57A9MmaKWqIPxh0bhES4uinGFDcvG4SUJBvmy9ZR0P+Qtu5mpOmhGB
         ux4A==
X-Gm-Message-State: AOAM5310oUXXob+x/L4SXLSjfwLfP18RdUadX4kuKdB82ithcJqn4Mca
        2exD/J0aQQsVooBNS21phGsA0g==
X-Google-Smtp-Source: ABdhPJwTKZ4S3rwJvAgQzJ9r2GZApOT49IPaauL4XH7I7OZbzqclPlcDPAUZnlz4ECuEmfHBSCn8JQ==
X-Received: by 2002:a17:90a:36cf:: with SMTP id t73mr19089365pjb.100.1592836065367;
        Mon, 22 Jun 2020 07:27:45 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:44 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 5/7] serial: 8250: Implement poll_get_irq() interface
Date:   Mon, 22 Jun 2020 19:56:22 +0530
Message-Id: <1592835984-28613-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Support kgdb NMI console feature via implementing poll_get_irq()
interface. This will allow usage of RX interrupts to support kgdb entry
while serial device is operating in polling mode.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/8250/8250_port.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f77bf82..1473b1a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2138,6 +2138,21 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	serial8250_rpm_put(up);
 }
 
+static int serial8250_get_poll_irq(struct uart_port *port)
+{
+	unsigned int ier;
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial8250_rpm_get(up);
+
+	ier = serial_port_in(port, UART_IER);
+	ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_port_out(port, UART_IER, ier);
+
+	serial8250_rpm_put(up);
+	return port->irq;
+}
+
 #endif /* CONFIG_CONSOLE_POLL */
 
 int serial8250_do_startup(struct uart_port *port)
@@ -3141,6 +3156,7 @@ static const struct uart_ops serial8250_pops = {
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char = serial8250_get_poll_char,
 	.poll_put_char = serial8250_put_poll_char,
+	.poll_get_irq  = serial8250_get_poll_irq,
 #endif
 };
 
-- 
2.7.4

