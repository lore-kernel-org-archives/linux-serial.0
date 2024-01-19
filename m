Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0E4F1FB
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664120; cv=none; b=iMUvo70sd72XGphvGJEFZFCabMYyajLSUN9HE75BPfh6UdiK+hK7MyZdZrmY3CNxb9/10pqNzLPCHU1WohG+Lo8yx8lM3K3TgaqqT/M3WBT80tO7tyWCG4+ndQwSDm99xNyKiC+mIQqtTH3ZElNliNamqY3lgP+p0l2grdzzrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664120; c=relaxed/simple;
	bh=YBF7A0OJZRzNwOkRz3/ZyND9coOZT6tf8Q+wR8kkdLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkNvSDAEp2gxJkNrNnhWQgISiFgttE1DUxrP/Dhpn2Xgfc74tnOcPjjIbENr0lob3aKl4bsfLA53t/sC+t+F7G5m5di5hFkpKSGPRIxYy67TWUwvT8Cv552nium5/ribtUEFacFRB7hXeI8N1r45ruZAka0qvhQRlDMh9qCiqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nwf1jBRG; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nwf1jBRG"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-361a1f8c675so2203295ab.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664118; x=1706268918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZs1DnoR+BqoPfBEx3sAKhKPyFXu5PFqqMfZZxzp+sc=;
        b=nwf1jBRGcLxyVjLNZ0IrGdI3em3/Dn7Js87UHyqW9OCdgPGYgP325vv0k1keKAAGLz
         8iiSt+3t8A5OiGI84ajlVkhGcyzsvKeeWFqqjLOagRI/HSH5QMeW3jyQycr+HDwxuEr8
         AT5HMRKxvwqUY0pTD/pvGt8y38WYthAcZpwI1yg6tz3L03b5AMsoLUHjX8aZhwZlvwaL
         GaTK8N+2emFK8rT3+4P0pf3U/7g3qdKYQY2NlXbjJcGGMdRWb47TJg2CcZMts2yc+OBZ
         UokWhkwgDAlos8MzLdeRNkjnTD3vtOfvyOCf1SnXmg1IPNo0W64ut+a4aFvK8dMxwiLr
         Px5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664118; x=1706268918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZs1DnoR+BqoPfBEx3sAKhKPyFXu5PFqqMfZZxzp+sc=;
        b=aI1U64wNW1z4lj6CNww3kjF8c3okSXI0hi9DRGWEutMM0OnCpA6gHDok+9gs9GhhNi
         f9VxPI65Z5P3IpDn33o5rxyEzk0Iw3caR6OTjI+zxFMqrJDNqDa5EJTkk+7L3vqjmHFt
         QAYPOmL3rapKPlVFDAQuMzLWDgc1V98zeZQTrD9n8rg0rg/EWn+f0MSLh5CQ44y8jgJs
         6wiXlTUXO1JEmg5Fnkdk/Pi/92O0wuwHYBIRvjp14wFzHTMEX520wqyMBp0okCNZJuuK
         K9DRJDJD2plSHnRW8I/HNRww7vX9UnSaup4k4ldzcqIK1wXmpVJG9fex5n3+BQ648uw5
         sgpg==
X-Gm-Message-State: AOJu0Yx0tbpP17RqHoo1Pc1lRc5ntU3RiLBFd3Mf7Hp4+Tw2mvZ/QkWW
	aZ/bXFhomte1GnWzJxneX/86qVm87MNUjM1NsLxGS49Jk2QSLzHvP+Wy+ENrmHRQvpleNdtAjkQ
	D
X-Google-Smtp-Source: AGHT+IE5xOPzOXRmI0mkKVIo636pZPAAvH16YB5jTX+cVYfv6ns2lQLatq8j8BbSiFb/JfVg9KHVDg==
X-Received: by 2002:a92:bf0a:0:b0:35f:cd02:1dee with SMTP id z10-20020a92bf0a000000b0035fcd021deemr2663290ilh.3.1705664118669;
        Fri, 19 Jan 2024 03:35:18 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:18 -0800 (PST)
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
Subject: [PATCH v6 3/5] tty/serial: Add RISC-V SBI debug console based earlycon
Date: Fri, 19 Jan 2024 17:04:47 +0530
Message-Id: <20240119113449.492152-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
References: <20240119113449.492152-1-apatel@ventanamicro.com>
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8b1f5756002f..ffcf4882b25f 100644
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

