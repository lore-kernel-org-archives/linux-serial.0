Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE32C83004
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1620E2087E
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lC/o9/g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgD1VOd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbgD1VOd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6761C03C1AD
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so161192pjw.0
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oGO5v8y9nak8k9DrQPglFtrPLstpeIPrguWZ4LmKLk=;
        b=lC/o9/g0QvPZPmlrzukJy8za454JFvMQ6cfQQiPCvEmJqP5U7RtcGoNEEmRqQ2yyve
         +ZhWGOuIAj/7XknaXTCzgBgpD/pS6Zwjx/MibXjHKLZBX/Sl5fdjL9PZrqow6aRDfNPH
         OUPD0gdA3c10zoXT8G662DiHJbzogg3+7fv+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oGO5v8y9nak8k9DrQPglFtrPLstpeIPrguWZ4LmKLk=;
        b=A1j2ZIc7lCcjFj9uvxJeNj2sAUbne9r9pi7Qs3m+999qDJrAeTLuT/8HbE7/iZJyB9
         D664Le8bWGMCLS3nnEwGyxdB2aR/6TTrWrGNdsfQeim5YwR3uPm3/booVMUq4S0T0CwJ
         0BisDkgb5v6YFPFK2XwncEOy/OyIkoCDGYv/5/CV7TETjqCkcLc79qWXtICEPTjkl3f1
         eCld6UTwLv6Z4yYDw0zCe06NQD7CnQUoZm2yMuTUK3xPlGghDARqdkgvqTR4B9TeEJ9K
         JTZHd9BPX5+o4DccF8rR1Y1scpVSyKiuKFw+t3Z9R3xToO18U261wLyvNRQyFaN7p+M1
         2QsQ==
X-Gm-Message-State: AGi0PuYEwWbCefPnu07scIOSkQ1Z4t36p5Kdt0W+Pn+Vtx3GQ2aeQyMl
        kJTwfgEtVxRgPRh0H//MG5aSKQ==
X-Google-Smtp-Source: APiQypKmcFNHvVmZs0bdmlo52tOJ+MEJoSuTxzLb+JRrva27+RdyqI9eP6g8PWVNuKP/HyPbfr2aUA==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr30329731pln.191.1588108472393;
        Tue, 28 Apr 2020 14:14:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] serial: 8250_early: Support kgdboc_earlycon
Date:   Tue, 28 Apr 2020 14:13:50 -0700
Message-Id: <20200428141218.v3.10.I8f668556c244776523320a95b09373a86eda11b7@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Implement the read() function in the early console driver.  With
recent kgdb patches this allows you to use kgdb to debug fairly early
into the system boot.

We only bother implementing this if polling is enabled since kgdb
can't be enabled without that.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v3:
- Renamed earlycon_kgdboc to kgdboc_earlycon.

Changes in v2: None

 drivers/tty/serial/8250/8250_early.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..70d7826788f5 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -109,6 +109,28 @@ static void early_serial8250_write(struct console *console,
 	uart_console_write(port, s, count, serial_putc);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int early_serial8250_read(struct console *console,
+				 char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+	unsigned int status;
+	int num_read = 0;
+
+	while (num_read < count) {
+		status = serial8250_early_in(port, UART_LSR);
+		if (!(status & UART_LSR_DR))
+			break;
+		s[num_read++] = serial8250_early_in(port, UART_RX);
+	}
+
+	return num_read;
+}
+#else
+#define early_serial8250_read NULL
+#endif
+
 static void __init init_port(struct earlycon_device *device)
 {
 	struct uart_port *port = &device->port;
@@ -149,6 +171,7 @@ int __init early_serial8250_setup(struct earlycon_device *device,
 		init_port(device);
 
 	device->con->write = early_serial8250_write;
+	device->con->read = early_serial8250_read;
 	return 0;
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
-- 
2.26.2.303.gf8c07b1a785-goog

