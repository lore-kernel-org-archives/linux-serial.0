Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C8C38A2A
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C1215A4
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k06JzvMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgEGUJQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728658AbgEGUJP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 16:09:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420FC05BD09
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 13:09:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so3136537pjh.2
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDitJmCYI6w8zpra4JuK0k+hw0gGmgK6hNM/TsrDerA=;
        b=k06JzvMvr6IYLZzGXi5MfjXYuByqlDZ5Ov7mPhaAbBAYC2WDtJlBDj/9PSIX63fckv
         yvcOSjPw7/Q1Vr8lprU6X2yuu+hUFrZgmNJmmkEF8/JQfVgtWlgprpvoRq5+dHn2sEWv
         beDgToAgENRUasSAvNZUqtFk/E56syR3ia0zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDitJmCYI6w8zpra4JuK0k+hw0gGmgK6hNM/TsrDerA=;
        b=Lj/ZuQXAvEsX5BMTWv7XmsYFLu2PW4nFDLCY9MrleG6qnxSLvYQgOou2mLIdyR5i8t
         LVn80yK8SlQPazeK2caEyesdKKKWujBMVzrSKDg/BsmFWIE6s632+O7KbBjWooccvbxL
         vBbHC/FJDBjfkl3CUBxiYq7UHnfDZc51fx5YMUwop5Q5bHc5E24HGV2xDhDc4Zrm+WGR
         9K0QyyU+Ml8jSIoUoJuIUdCkYvbQTd1ux+A/mRDc3bNeX3p54tWfVdHGFoM2JztORDpw
         71jABwWBPg5G2c/p5rwN360uYB4pyfnGII04pmK0vKQ0Iw0oEFSwu7zg5oCGiwiz8ACp
         8BjA==
X-Gm-Message-State: AGi0PuYb4PfUBfzxbj2xvJT5BFqawFU1ky8p/vm8vQ9ja7VuNNr/95HN
        SB46zhxJw+4FOy8sYWDBgpo9mg==
X-Google-Smtp-Source: APiQypJ7eLBdCYVxkzItvTQhjgPKMPikSZLf+2fArLtn+DXLDcEsLN3jFlCfrxAqCJRgj8wo2lxu1w==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr15341546pll.62.1588882153625;
        Thu, 07 May 2020 13:09:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] serial: qcom_geni_serial: Support kgdboc_earlycon
Date:   Thu,  7 May 2020 13:08:48 -0700
Message-Id: <20200507130644.v4.10.If2deff9679a62c1ce1b8f2558a8635dc837adf8c@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
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
---

Changes in v4: None
Changes in v3:
- Renamed earlycon_kgdboc to kgdboc_earlycon.
- { ; } ==> { }

Changes in v2: None

 drivers/tty/serial/qcom_geni_serial.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6119090ce045..6bace1c6bb09 100644
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
+						      struct console *con) { }
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
2.26.2.645.ge9eca65c58-goog

