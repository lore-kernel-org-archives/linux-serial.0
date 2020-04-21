Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8727EC54FCC
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686232072D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcJCluHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDUVPd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgDUVPa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5DC0610D5
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f7so1179390pfa.9
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjXLxKYx2J4SfneKVn6eyAIDqxc8kteAmWSGrEv3s1Q=;
        b=CcJCluHY3oWgCqfj8YhfZKPo0NR/BUu6kAlYc9e5Oewk1f5pCuZN7xV0s8bJRPKSaa
         jN+bzjxqRaMU7hrDRd5nNyB2ufRcJdE8b+aIVwOlnZcSoBmTm7+6Ka+Hyjdbn8I/xBdB
         1FpGO292NE9dv3pw6YfLq20gXxSIurqzigZRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjXLxKYx2J4SfneKVn6eyAIDqxc8kteAmWSGrEv3s1Q=;
        b=EnfWTtMfsRHtA1H2sIq6+eGaADZVOL6lZAIHrQvaEEIld/CzLVnfUN8fY6rzZQyCPq
         7zIN6LTsSzzjg4boJXcLHiwsD5+LM5h92gHj80kBOXaCF3RlLe8Sm5prg8rULWEOqGic
         p4KLwYVhSzAiqteqE4YnCuX+BqcLlf0EawMfKGTeVZO3lI7hVoRJOQdiYXOlCxkCWp0p
         ESF00MGzYulrGUDepxCJgxd/IsZRumdsctUBB1fgkqsh1fUXM8JUFaZc8QAHOvIWmPoO
         jeRdqCq2YQKFJHm8WppDpyRkjS/C9/kdf2RmVVx4hU1d+cGUKWIX13Durs9i3jCMGQDJ
         Bhdw==
X-Gm-Message-State: AGi0PuYrsxag9ITHQF29IROG5DTLZlVeS6gojIx/Rtsrokfn64XvtTPG
        nzFP0LKwZlHRGlSyuXYtSHxvJg==
X-Google-Smtp-Source: APiQypKbzNZ3tNv1+91oSCmg1IIaM8GOSYYn0L8dUZkcD300x8Du/f0RDrz/WsZ9Oyq+POo+vU2dNg==
X-Received: by 2002:a63:f14b:: with SMTP id o11mr24165243pgk.429.1587503729162;
        Tue, 21 Apr 2020 14:15:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] serial: qcom_geni_serial: Support earlycon_kgdboc
Date:   Tue, 21 Apr 2020 14:14:46 -0700
Message-Id: <20200421141234.v2.8.If2deff9679a62c1ce1b8f2558a8635dc837adf8c@changeid>
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

 drivers/tty/serial/qcom_geni_serial.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6119090ce045..4563d152b39e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1090,6 +1090,36 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
 	__qcom_geni_serial_console_write(&dev->port, s, n);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int qcom_geni_serial_earlycon_read(struct console *con,
+					  char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	struct uart_port *uport = &dev->port;
+	int num_read = 0;
+	int ch;
+
+	while (num_read < n) {
+		ch = qcom_geni_serial_get_char(uport);
+		if (ch == NO_POLL_CHAR)
+			break;
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+
+static void __init qcom_geni_serial_enable_early_read(struct geni_se *se,
+						      struct console *con)
+{
+	geni_se_setup_s_cmd(se, UART_START_READ, 0);
+	con->read = qcom_geni_serial_earlycon_read;
+}
+#else
+static inline void qcom_geni_serial_enable_early_read(struct geni_se *se,
+						      struct console *con) { ; }
+#endif
+
 static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 								const char *opt)
 {
@@ -1136,6 +1166,8 @@ static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 
 	dev->con->write = qcom_geni_serial_earlycon_write;
 	dev->con->setup = NULL;
+	qcom_geni_serial_enable_early_read(&se, dev->con);
+
 	return 0;
 }
 OF_EARLYCON_DECLARE(qcom_geni, "qcom,geni-debug-uart",
-- 
2.26.1.301.g55bc3eb7cb9-goog

