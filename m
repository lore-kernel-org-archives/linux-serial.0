Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE88C47071
	for <linux-serial@archiver.kernel.org>; Sat, 18 Nov 2023 03:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjKRDjx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 22:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbjKRDjt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03877173A
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so2200889a91.2
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278782; x=1700883582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii/r8hzimL/XtavRWrcGkJgKEnLeFuQkfTAUm70Wb2A=;
        b=L7tk3XsPAJfBJui+7mljsx5jHduoziR5VxXsq4WSWgLyVhrKSG2R6kpLmbGgZLDnNB
         wqftKeb/NTcH74tLHPrV09IVx1PWAzvf8VDD4/9eQxKPe5DTpT4gqczLHCpkIUIFsxhw
         dQIKqTmDJK5dWM+uzcmcdnD7gB2FBY3Qu5mYbVoniYAqV0/DYD6syD+9naE1EE7gzz+I
         ZnYSZy7HvptS1saW9ulyRYdjhZiw58NDKM/oDZxJ3U5/JQqgFWGJOwOuelcuS18t5qoT
         E92fLTMkKAwAc7mCF8/bsREFCPb0kYIWAzR3b6pkAChA4yr5Msvd9uzTuKf7R9qFPLAt
         DNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278782; x=1700883582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii/r8hzimL/XtavRWrcGkJgKEnLeFuQkfTAUm70Wb2A=;
        b=q0Mfo32sT52g7j1APb2a0AtSCp1XtM9+8z5Pnxl5tqiYLSmymHlznhxvFpoM/26OPI
         LHwT0goF3uL/IaP1LUTCeVum4Vhpxob7TUTJIgx5kuggONsw0xsZ17WJkaNc0lMAaPEy
         UVybpZvH/Nnuli0Mn/xJo0OFIS+xTBWL1enui/LZiea66cGVX5kq+CpSwZpdARyXRUSs
         SpndYwAfz2+U/vzurLCSaBWutZtuXA7o9AVTMU+YKhSFs9bmCYGs/1T8nnMET5W/4jY0
         9OrY6DqnZcOMFdLvmVQ2yqYrVjdJmIGAWppwntOtb6N3vMMPZf7749jFS8hpvEBQ+qBR
         aMSw==
X-Gm-Message-State: AOJu0Yzgl4wSyLBH9NmaW0UpwNjgEhFACdqJthJbd4pgY4/RhE5mK/Yc
        lZE8xcTKNZh1urcvr+SGmMGmXQ==
X-Google-Smtp-Source: AGHT+IEnlmvKg48AWLtRJlHz9Rg/Q27+8No7s5ojWvtL/WdnvFdbsfi5N3eU9MggG7ZhT0nUoF/4cA==
X-Received: by 2002:a17:90b:38cb:b0:27d:1376:3ae1 with SMTP id nn11-20020a17090b38cb00b0027d13763ae1mr1378816pjb.0.1700278781572;
        Fri, 17 Nov 2023 19:39:41 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:41 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 3/5] tty/serial: Add RISC-V SBI debug console based earlycon
Date:   Sat, 18 Nov 2023 09:08:57 +0530
Message-Id: <20231118033859.726692-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118033859.726692-1-apatel@ventanamicro.com>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We extend the existing RISC-V SBI earlycon support to use the new
RISC-V SBI debug console extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..1f2594b8ab9d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
-	depends on RISCV_SBI_V01
+	depends on RISCV_SBI
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index 27afb0b74ea7..5351e1e31f45 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -15,17 +15,33 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
 	sbi_console_putchar(c);
 }
 
-static void sbi_console_write(struct console *con,
-			      const char *s, unsigned n)
+static void sbi_0_1_console_write(struct console *con,
+				  const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 	uart_console_write(&dev->port, s, n, sbi_putc);
 }
 
+static void sbi_dbcn_console_write(struct console *con,
+				   const char *s, unsigned int n)
+{
+	sbi_debug_console_write(n, __pa(s));
+}
+
 static int __init early_sbi_setup(struct earlycon_device *device,
 				  const char *opt)
 {
-	device->con->write = sbi_console_write;
-	return 0;
+	int ret = 0;
+
+	if (sbi_debug_console_available) {
+		device->con->write = sbi_dbcn_console_write;
+	} else {
+		if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+			device->con->write = sbi_0_1_console_write;
+		else
+			ret = -ENODEV;
+	}
+
+	return ret;
 }
 EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.34.1

