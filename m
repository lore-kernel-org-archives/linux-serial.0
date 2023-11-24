Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dz+muue8"
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4E10F4
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:37 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f5d34235dbso746482fac.0
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809836; x=1701414636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQhHGwPmQ4TCzhQ9rEz5VPF8mnM3VrFDuBPe9IkpS1Y=;
        b=dz+muue8lZwwIfj3n9g6aEtHhtaY7QPswJGNa27H0Uh/HKBbKS+oKCRjBi2dsUnlgS
         3ykUbk+nLWEnhXM3MVdP4Uew+4r/qcxA1tLMO40kUNQs08lj2yvlrQJWUtDJIiKI+bIK
         UUE1mZEUJE9p87AVH6aSTTRye0uPzq2z5+v1Fw77a8Lii9JjqhGtOiRhQtJAaJ6InpTq
         ULdKwRYwFJ4TNxJLSLe9VqdJywhHdbZUltymnLgJESpCmWU/Lr8iFcNa2AFbxAGQT3+y
         JwheetW7ksexM+v3ipeD0ISMHeAgs8gwFAcYngfXhU5qL/67xEa78k0y9Y3VLklBA5cF
         xlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809836; x=1701414636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQhHGwPmQ4TCzhQ9rEz5VPF8mnM3VrFDuBPe9IkpS1Y=;
        b=dXOioDi6guaZsQWMApjTrdQIvhOSLycwL5BwqnV07G/rBLWrd6o371txvzK39YLGNm
         xGZJu/8vklgbnMlidXwIvQDHpvaj7jhsV1/wwXbZsZ2+UNkIdo2SOq2xtUz/tpanImID
         7gQ8RegiHTsywILguEsYC6Ho1UfP9Eoi0/Et7UJvzOHIbB1ZJp1sTa2sRqU3OhpI+F9d
         OqcL+0Jc4CWelsCLS2nUUZ22sHvCnruYDlMyeVS64l+cUS5qcrFlSuloGeExelB5USCr
         s35f8uCORmAmNIr8K2AFrxLkAKamPgnEBVfGiABH/lcvikdqSSx19JzV6FWCcgPq6EXd
         l1sA==
X-Gm-Message-State: AOJu0YxZ/A8FJtmmWeOwG9RAUr1Vs7SAzyyyzc12kf2Tt6niP/KqcmG+
	WQxBt08EBssGyk1tQp5SV7sgOw==
X-Google-Smtp-Source: AGHT+IGvJOScqEUs5x/NC1+xkb/+ZzFxNOvJHJDnrqYvAj8EJtKq+m+RbFE9B8BNRcDqThajOtvZdA==
X-Received: by 2002:a05:6870:4729:b0:1f9:d22e:6339 with SMTP id b41-20020a056870472900b001f9d22e6339mr801112oaq.23.1700809836602;
        Thu, 23 Nov 2023 23:10:36 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:36 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 3/5] tty/serial: Add RISC-V SBI debug console based earlycon
Date: Fri, 24 Nov 2023 12:39:03 +0530
Message-Id: <20231124070905.1043092-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We extend the existing RISC-V SBI earlycon support to use the new
RISC-V SBI debug console extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

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
index 27afb0b74ea7..0162155f0c83 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -15,17 +15,38 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
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
+	int ret;
+
+	while (n) {
+		ret = sbi_debug_console_write(s, n);
+		if (ret < 0)
+			break;
+
+		s += ret;
+		n -= ret;
+	}
+}
+
 static int __init early_sbi_setup(struct earlycon_device *device,
 				  const char *opt)
 {
-	device->con->write = sbi_console_write;
+	if (sbi_debug_console_available)
+		device->con->write = sbi_dbcn_console_write;
+	else if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+		device->con->write = sbi_0_1_console_write;
+	else
+		return -ENODEV;
+
 	return 0;
 }
 EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.34.1

