Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CC4F5FF
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664126; cv=none; b=hWtRGvSyFDCf+cOP+HQ6Imc5N9EZ8jnx667YrVonAl/OQP/7puUo5wBSWpLaoxxh59pJoT64OMlr/JblCd7pXi1xkM6jHjQ5u4BWYJS9vlHepMtUj7tHn1NpcRQSvzqKsZv5HLBj0J8G/NTK+hvGGHA0rBjAIsbQTSJv2TDS+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664126; c=relaxed/simple;
	bh=biGuQPZKz9nJLpyogO7APhYUhiA6YmM02cSM8cnfGYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwDqBwLtFQZHO95diPe8YjM/V8lNoFubJ/23jiW7d56hH5RZ1lQxYfIcoscVAL7HvQNE6/CXBOBLpsKCZrobVO+zBcAmCWxgVb4hs1ELOZrGs3Jj7Z4pTILJhIIZDCsTfWOtuUYdnWug8xeOL9we4QkRBkF4mJ+YjyC6lnRPonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aCxx5Jw2; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aCxx5Jw2"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3608bd50cbeso3161075ab.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 03:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664124; x=1706268924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB3Vj18FKp8kzrC7fP7ko88EXDexTWBrSVK1Kjp8q3Q=;
        b=aCxx5Jw2ZsPnT9/JWPztaq1jvm+ltsjOZXTZOA+2aNOefrgPd0Y2rOQN2DLDedONfS
         xT3k6BNLJ2aoGd13Yaf8wvr938DZXXxE6lkq1um5983mSWY7kxzB+tgXWhgK7heFvvTH
         rbxkVPw8xc/Gf+xDPVOrPZcUHKtwi8DApbmlzfyg9Z3qnRDOz0dVDqd/PAlkY57J1ZZU
         2wQdkrPfvcP2TUDAIVvoSI37k7UI9yhC1RMVm+zgiAc6v+Hs10IBucdK4TApbsxLzwq5
         /YzUJVa6vA4c58SqnbqY2GAHI9z2eSizUKcMvy9GLyvClOc5X3obdP1uEwaF5/VEa7JH
         ++LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664124; x=1706268924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB3Vj18FKp8kzrC7fP7ko88EXDexTWBrSVK1Kjp8q3Q=;
        b=hUCt5RuqsDkvwpVKM9904Gr1/JvHT6454ZoXmxCfBRgHDlLjqfQk8iEvOs1Wmynm0B
         XJxZvXgghvrGuq6ekD8FhheEIXk1hwnBt2QuApm581hjJ/ObI8at2ijRA0b1tkmUI+an
         aKll3OnOTmnyQ3WytVErR7DGGmRIp0pFLPr2ZcNQoxDleHQqL9xiLE1QxUdt/LA2Ge9W
         W4FldP8tdXKU9t9KWGQrWROgGADbzOdv5IR62/EZjdOm9UhNXV8wVQK3jiBQ+eYXXQmH
         qPTLL5PvZlRecQMnGyWEyuOw36l3JGZJvPtgCXIvsRGYPdicWRDGTJEp9pkOnNnbbz8s
         G83g==
X-Gm-Message-State: AOJu0Yzxq2llr0mnQnSZUBftGSoKLbu2TiBLg5dLCFtlY1cq1CZT50dF
	A6kmu+UuZo26G8zR6H8Bj6rehkRdOXGqI24KZMhPgwGm2LoI96Omr2n9UG/oaqA=
X-Google-Smtp-Source: AGHT+IGd1T1w9ctzUQVdgV1cwoeDle40sUshSYKn5r2via60aXBN96+yVuKGmlEjCGjfQyn1G3wsRg==
X-Received: by 2002:a92:2908:0:b0:361:99a3:5bc4 with SMTP id l8-20020a922908000000b0036199a35bc4mr2763048ilg.12.1705664124322;
        Fri, 19 Jan 2024 03:35:24 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:23 -0800 (PST)
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
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 4/5] tty: Add SBI debug console support to HVC SBI driver
Date: Fri, 19 Jan 2024 17:04:48 +0530
Message-Id: <20240119113449.492152-5-apatel@ventanamicro.com>
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

From: Atish Patra <atishp@rivosinc.com>

RISC-V SBI specification supports advanced debug console
support via SBI DBCN extension.

Extend the HVC SBI driver to support it.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/hvc/Kconfig         |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4f9264d005c0..6e05c5c7bca1 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -108,7 +108,7 @@ config HVC_DCC_SERIALIZE_SMP
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV_SBI_V01
+	depends on RISCV_SBI
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index a72591279f86..cede8a572594 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -40,21 +40,44 @@ static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 	return i;
 }
 
-static const struct hv_ops hvc_sbi_ops = {
+static const struct hv_ops hvc_sbi_v01_ops = {
 	.get_chars = hvc_sbi_tty_get,
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int __init hvc_sbi_init(void)
+static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
-	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+	return sbi_debug_console_write(buf, count);
 }
-device_initcall(hvc_sbi_init);
 
-static int __init hvc_sbi_console_init(void)
+static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
-	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	return sbi_debug_console_read(buf, count);
+}
+
+static const struct hv_ops hvc_sbi_dbcn_ops = {
+	.put_chars = hvc_sbi_dbcn_tty_put,
+	.get_chars = hvc_sbi_dbcn_tty_get,
+};
+
+static int __init hvc_sbi_init(void)
+{
+	int err;
+
+	if (sbi_debug_console_available) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+	} else {
+		return -ENODEV;
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1

