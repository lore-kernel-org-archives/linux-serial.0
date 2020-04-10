Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4EC2BB55
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075C52087E
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4p/J0Rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJWSb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:31 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36781 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgDJWS2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:28 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so1227250pjb.1
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Xvr0zLScn2nLCI1oJV5OmhbqIZY3/XDOPCMztpMIRU=;
        b=k4p/J0RkQWbVJUKkTEJkmAlkTUHSGfQUMbPY5oEJl0LlPckFTu8/+Cq9PSIYVOTAMF
         Cl7i8VarjWIpiZwgsCIXffNBCRoDzx5zRIs2DL/a1TP/GQCnX0rVVMXb+UubxNRsVGE/
         H02eTDq2K8FVOWnJiLXE/ZsILItbjVpsEFQBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Xvr0zLScn2nLCI1oJV5OmhbqIZY3/XDOPCMztpMIRU=;
        b=bxwA/KFAcaoaroLuIC43EVvhkM6h7GKAMQblKwUhuuEr/p30I8OUaMatQS+xhsz0tr
         UW2ZUtBtHC00k9ZOW+FujqQ1yuxClJlN9X3up5tH77RIsMwDVWPHcCbs1dBGx2uvgOHx
         7Q0z/5hEQSuZ8XGL41tG0s3cSFrX4b3SQzt9fg/EGWVRr/+URVV3vcCgjTNTbryw3op3
         rH0L8J/W8JJyyFRN0bL5bsqkBqxMttJUkeXqV2DEX3GnIdj27IFtN3JvllKvYuVyLuB3
         hU7JUf0N4ODV1ladP58acC7n3oFQXp0HMJXeAh8RBIDpEON6uKyTzgBum+c2c4B5tqTH
         4LhA==
X-Gm-Message-State: AGi0PuYcjaApJFDrZp3Uvy7uaxeYeUixZZ1yP8tWUS2QHvIbbx4gZczG
        mHowOHeUCtPRfOm7vyrzUtWvKQ==
X-Google-Smtp-Source: APiQypKJ94vBioTXZPIp0dI7ctcYkCPzkMjxyO4M1PLccd96ucK1TAvxhGD7obO0jnob1QYfSWfzmw==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr6257430plb.139.1586557107068;
        Fri, 10 Apr 2020 15:18:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] serial: qcom_geni_serial: Support earlycon_kgdboc
Date:   Fri, 10 Apr 2020 15:17:25 -0700
Message-Id: <20200410151632.6.If2deff9679a62c1ce1b8f2558a8635dc837adf8c@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
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

 drivers/tty/serial/qcom_geni_serial.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0bd1684cabb3..e3bb90404ab5 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1084,6 +1084,36 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
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
@@ -1130,6 +1160,8 @@ static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 
 	dev->con->write = qcom_geni_serial_earlycon_write;
 	dev->con->setup = NULL;
+	qcom_geni_serial_enable_early_read(&se, dev->con);
+
 	return 0;
 }
 OF_EARLYCON_DECLARE(qcom_geni, "qcom,geni-debug-uart",
-- 
2.26.0.110.g2183baf09c-goog

