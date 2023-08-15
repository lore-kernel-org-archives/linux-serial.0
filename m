Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39364C0015E
	for <linux-serial@archiver.kernel.org>; Tue, 15 Aug 2023 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjHOJEJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjHOJDE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Aug 2023 05:03:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA61BCC
        for <linux-serial@vger.kernel.org>; Tue, 15 Aug 2023 02:02:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68859ba3a93so83977b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 15 Aug 2023 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692090142; x=1692694942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw0ARtvgnK9eBWm0hqqYBsE7PAKIFaPy/RiSwt2xSqk=;
        b=f7XXEf7tFaWgEoGIQtBEemyNQGodu1G427wygI3OnQe/2du59CwHn5caGSfDXLH5iC
         cOEeZqkzJgMyDQQvYaFa8KZ3I5vCZOLMchV9M76pkwkIS5tci1t/N+pztDtHMR9tKZuF
         vrjlz5LjysXbQ0sQ2eW0X4KB2n2kjfPq3Q1TscC02Z8dTZ5T2zTMIxAHrI8nvgwDUHep
         KmoajzSlvnhDZOUaR+/s0fV8URtBwioisXFXE/cv6aRU2ADulIAFmSMANQbL6MYjqqw1
         WKS81hferpTBRkLKUU+UwbonndqOhD1DWXJ59ZxnCXdDgz8bWv8coW/UjU3Io6xaRs3H
         cj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090142; x=1692694942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw0ARtvgnK9eBWm0hqqYBsE7PAKIFaPy/RiSwt2xSqk=;
        b=PhK9sYeVxxRC+ck8SLuPsFVArA3jmnEYANpbUqTMKIzujtTdfL/VP9Kjbznoavice8
         evfqOv6h+yH+EWsiiz6lTLwFWvZ6M4bxShC3mZ9tujM2VVQkSQATXOTqAvI64pVWB/GX
         CsGnB07yXL88vOmd4IGg51YjpP3ONMm8SMPZP9HwaInYKpx25zNFgfa/RAZZplIRqA44
         WykfWCfFqYS6h/dGgTs1A/Uai4gdVKvfA+Pvhqq2YQbhGxN/a/0d3UQ1vL+h75QnG39o
         GAAWjrZqz3OFiu5X7x6l2KvAtHjcQuEgrjIWPIy/0XXHHYv0sWAar1xoKI4O8qI5D6sI
         F9fg==
X-Gm-Message-State: AOJu0YyGeG832jJrSPxrcNGb/cz73yMPeH8rua7hXgMp4p4cT94P5stM
        KZ6JJyfXM0wD+fmY3Rw+iabJsQ==
X-Google-Smtp-Source: AGHT+IENe0tU9RHLk0BkjpQbNw1pxKpJ2/NeGr23TOm4HJozI30zEOhEU5UnWi95cBI6wsaH1tmURg==
X-Received: by 2002:a05:6a00:130d:b0:687:5434:bd14 with SMTP id j13-20020a056a00130d00b006875434bd14mr9078461pfu.11.1692090141951;
        Tue, 15 Aug 2023 02:02:21 -0700 (PDT)
Received: from work.. (1-161-171-111.dynamic-ip.hinet.net. [1.161.171.111])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78c16000000b006826c9e4397sm1264700pfd.48.2023.08.15.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:02:21 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v3] serial: sifive: Add suspend and resume operations
Date:   Tue, 15 Aug 2023 17:02:16 +0800
Message-Id: <20230815090216.2575971-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the Sifive Uart is not used as the wake up source, suspend the uart
before the system enter the suspend state to prevent it woken up by
unexpected uart interrupt. Resume the uart once the system woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---

Changes in v3:
- Fix the conflicts on tty-next branch of tty.git

Changes in v2:
- Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
- Remove the unnecessary check

 drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index e2efc3f84eff..d195c5de52e7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1019,6 +1019,23 @@ static int sifive_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sifive_serial_suspend(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+static int sifive_serial_resume(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+			 sifive_serial_resume);
+
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
 	{ .compatible = "sifive,uart0" },
@@ -1031,6 +1048,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
+		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
 		.of_match_table = sifive_serial_of_match,
 	},
 };
-- 
2.34.1

