Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C801C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  2 Mar 2022 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiCBKUl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiCBKUl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Mar 2022 05:20:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576690FF3
        for <linux-serial@vger.kernel.org>; Wed,  2 Mar 2022 02:19:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x27-20020aa79a5b000000b004f3f7c2981eso1037708pfj.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Mar 2022 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Yq89WbWr/nKtI2RVDgbrgWiRqIUUvQxU4ZRP/u39Tc4=;
        b=lm4zJUzyhqzs2nvdFpXSR0vlIVib2Ri38tWVjvsqeYEdwiEB/dxkr1OjSZBdKRIhWP
         mOqCavmFBymWwOrD0rp4KYZUr0Ol+p86D4yAkeZDMOBUmioLtRyAM0Y1Re2kFojye2S9
         /6G7U6K078XM38L9pSWDyY9HW4BfENWa5utIpmtqViWK+Ug7VhxoX0G30P6Y/VM7NA3s
         8b6NdWbCkU5JymN+ENB5BeIRq7YDKcgcMbdIW4IuZbqJ1MlPQtNZSq9tFLPP/uvLtCWz
         rPBhwC6kcAIriegH5SODZ3BROXUxIylYmljIiX+77sNZvgtnxxVDyiMyoxqUfQzcmhKN
         yNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Yq89WbWr/nKtI2RVDgbrgWiRqIUUvQxU4ZRP/u39Tc4=;
        b=vAkUjJ6FRdIh4ZO99vubRyilhkoJhMax9rOO3icAP418a3X7mnOvRbB+3nIdox3v8J
         gmaJUXad0k7l32TCCWBAvC5suoBJkdZ1Gsfv0p5zXH0L6ibQLQjI4laq0IYqmp+HrDqx
         6TVltdcHupNGIY3bHzVimEX1xJ/NQD5xqYRARCTfezkvYnGXlPppNjT+bLqoEZ6nXuHr
         0XCkiqQvtkM3KaLElpGbKZvcFIbtw86otyI/aT7JpUb9gwNlLzHv7Jpd294tCbwHzCYR
         l+IYcYpDO/4c4rwHbiHqZu91VoanewY8XijZtxSHcNdiXEael5aD2aQAK8iKRWCpYJNJ
         N6Bg==
X-Gm-Message-State: AOAM531chfzrFVjaUreqRqbbsKHrlIivKagsdus4/QcYrZRg+uG8hk4R
        YxVzq5fbmpIepAOlcdcjrIAlXo1SzrKa9Q==
X-Google-Smtp-Source: ABdhPJzEXQNhD0xqT2s2x//pYYtesl+TerhASD0Ziddn/5GiSvMBYaO6FAMA2Ou6p+she/JPNCFbtFSgjrrJtQ==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:3ddc:5127:fcb7:1fad])
 (user=woodylin job=sendgmr) by 2002:a17:903:2285:b0:151:4b38:298e with SMTP
 id b5-20020a170903228500b001514b38298emr20044336plh.36.1646216397851; Wed, 02
 Mar 2022 02:19:57 -0800 (PST)
Date:   Wed,  2 Mar 2022 18:19:25 +0800
Message-Id: <20220302101925.210810-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] serial: samsung: Add samsung_early_read to support early kgdboc
From:   Woody Lin <woodylin@google.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, woodylin@google.com,
        markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'kgdboc_earlycon_init' looks for boot console that has both .read
and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
console to support kgdboc.

Signed-off-by: Woody Lin <woodylin@google.com>
---
 drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..eeb30d016ff1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
 
 struct samsung_early_console_data {
 	u32 txfull_mask;
+	u32 rxfifo_mask;
 };
 
 static void samsung_early_busyuart(struct uart_port *port)
@@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, samsung_early_putc);
 }
 
+static int samsung_early_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	struct samsung_early_console_data *data = dev->port.private_data;
+	int ch, ufstat, num_read = 0;
+
+	while (num_read < n) {
+		ufstat = rd_regl(&dev->port, S3C2410_UFSTAT);
+		if (!(ufstat & data->rxfifo_mask))
+			break;
+		ch = rd_reg(&dev->port, S3C2410_URXH);
+		if (ch == NO_POLL_CHAR)
+			break;
+
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+
 static int __init samsung_early_console_setup(struct earlycon_device *device,
 					      const char *opt)
 {
@@ -2990,12 +3011,14 @@ static int __init samsung_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = samsung_early_write;
+	device->con->read = samsung_early_read;
 	return 0;
 }
 
 /* S3C2410 */
 static struct samsung_early_console_data s3c2410_early_console_data = {
 	.txfull_mask = S3C2410_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2410_UFSTAT_RXFULL | S3C2410_UFSTAT_RXMASK,
 };
 
 static int __init s3c2410_early_console_setup(struct earlycon_device *device,
@@ -3011,6 +3034,7 @@ OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 /* S3C2412, S3C2440, S3C64xx */
 static struct samsung_early_console_data s3c2440_early_console_data = {
 	.txfull_mask = S3C2440_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2440_UFSTAT_RXFULL | S3C2440_UFSTAT_RXMASK,
 };
 
 static int __init s3c2440_early_console_setup(struct earlycon_device *device,
@@ -3030,6 +3054,7 @@ OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 /* S5PV210, Exynos */
 static struct samsung_early_console_data s5pv210_early_console_data = {
 	.txfull_mask = S5PV210_UFSTAT_TXFULL,
+	.rxfifo_mask = S5PV210_UFSTAT_RXFULL | S5PV210_UFSTAT_RXMASK,
 };
 
 static int __init s5pv210_early_console_setup(struct earlycon_device *device,
-- 
2.35.1.574.g5d30c73bfb-goog

