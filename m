Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E14C55185
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A682072D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fi7GhO/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDUVPe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgDUVPb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A5C0610D6
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so7184353pfc.12
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to0u/Jn7Js4VPZOuXqA43IyX5Na3y9BiQIqtXkvA+lM=;
        b=Fi7GhO/HIQuePgWWr4CAwtD3Nm2BO9549F2xy6Ify+xWUhksu4HNmc2cI7/51GU+Ch
         L/n5ai+tI4jzrDDdPfty2/gS+I7isrdFl83WaL/FlfxsVbFv0gdgZJthH5iQcYAQHTC5
         QDlYrK8x4Xkir0fVq0MFu0g741PDRv9AznrbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to0u/Jn7Js4VPZOuXqA43IyX5Na3y9BiQIqtXkvA+lM=;
        b=Ep/133T9mqYgMQAowpt8tPFrm6H6sxKx9AuJ6Q79GeE3mhRE27hIjMk7NNPvmtulez
         Uuq6G2Hn+BxRTssjwjPwudTyRxnMwnEGhvDVjSsAZPKnyJjnwMGs1daYAo7FMR4N0Gtu
         gR2vta3EXmnicQvabZ9IlMVdV47+PSv0D49EU/dYayD547jxc2x7ZEfl+ZvqKFrOP7Gu
         iOjppW4OCPWBRe/snuOMjkO/CCWH6FWuhwgSLgaWrCM8XFObFGWPf/B2ATONXq6jtiTN
         iJ55N0daqxemeRjqSqjSwb1sUekzZDCMw5YWMDeRFbdY4wr5Yte0ROWm0VnndxYbsirj
         Vy+g==
X-Gm-Message-State: AGi0PuZJnmi6gDdEVlthfaGWKfGFhKMgjBEQTXei/Hzzpm/vWm06QUOK
        oXl4k2ZlrmaiWbMbmylB3y9XBA==
X-Google-Smtp-Source: APiQypJ7dM3c1Vl/KOkONz1GC46IExu+/RPzPNDHW1csvMJmR81uQd7VsO5+P57/5ygsNzFb3hkAUw==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr8602658pgi.23.1587503730684;
        Tue, 21 Apr 2020 14:15:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] serial: 8250_early: Support earlycon_kgdboc
Date:   Tue, 21 Apr 2020 14:14:47 -0700
Message-Id: <20200421141234.v2.9.I8f668556c244776523320a95b09373a86eda11b7@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
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
---

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
2.26.1.301.g55bc3eb7cb9-goog

