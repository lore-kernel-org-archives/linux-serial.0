Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C44EB4C
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664109; cv=none; b=FEiekBAQgjhXfkOZlY11yN6e+pNbdyAzcr74iNGTyMIduANoh4AalbqWbHn1uey9c+JzKpSzt4N450WLk90ws7n4KU2swhI9I/uIJ1LnHImjZyz1T6lCUYF9nzFCfDIRF4dJ3ZBCh0wZsRjpAagEKGYPjl7Iki3MRYXEDyxTd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664109; c=relaxed/simple;
	bh=C5iRWOaVPvgyoKC+hI5XbA0WdGNDbqEUa5o2YyeO7Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud+A6NAlC9xeCjqtnffd/4j0LRFrw0Gd5yEgOcF8A1+zlyOIFV7xq01lHewF98L0OQCLOk7V0X7EjRRK7xHRxXrxCRQt+6204ciMzHpt/n0TsZKUpb81k/xYOv7LxCxt4VLND///s6KayGydeyKBYyZpsIf94JfIumj+Qi607Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CZxqI0Bd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CZxqI0Bd"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bf2c826a5aso31756939f.0
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664107; x=1706268907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k38gzzXnRwc1LG01yYkdNKX2/4JudjETsypjyCoA1oc=;
        b=CZxqI0BdDTcoozSkR/a28LpSgR1gpMw5CRIoktrw+Zto+znxGyybJXV/utBlAoWCT1
         00oUQIfDtL4AGaXcmUa7Npz7nEo2fXU9KxToFA1bSnRvoRhp0XUmlTqfk3u2alw6ho9G
         u1wzteojoyKQEQlaO+QeoftlHWXAD2Q6xAeNNXlDQlH6CG/HCHs+8AOmR/b5y+GWouoG
         Vat48JJ5CYA/AHtJM7M63K+QRf463r9pRwjOzUFQGamAe/+bN9P9/M2xgF5SeEYWwBwf
         r1ZQo+cgXsD9C8Xfmiuo8VFlbchkS6xjWyzUr/ITUbYqn1EboaumF4nkQqPgZV3wCNjF
         5qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664107; x=1706268907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k38gzzXnRwc1LG01yYkdNKX2/4JudjETsypjyCoA1oc=;
        b=OvdgUumxVpTAQDzMbT75VGE1LLA5leqzl+ztiW+X1jTOHt1yk9Kp51OdYT9hOQmvUE
         84JHX8TlJ/KAOPMQEoht1uCFg00XN8GsgmyfGhfnEXPganUgJCoF+GBMMOEGVLLxrJCG
         hM0dsWNugeHGG+P5c/+NyAr4oV3Mxk2/CquBjIs7Dd0FkYdHX3sbI4RL604tZTXYbT8A
         SJx0OP1eL1GI1VpbE/urAhPJCN0VXQV3/WJKmg4YYnh82JxeXx/A86l2CAlozA2N7FFK
         De0IlPuspzMwNrc7xVSx/Q66Wpd6m642zxRU1iy6Q9ONUWqXi1u1k2Whys8bPpskJx31
         lUXQ==
X-Gm-Message-State: AOJu0Yz3cRb7Rbfqnwfl5atv43euxVbJSQZ4SXXnmB9SMrvGD+Evhr+j
	FgrFbdP9EeVrNz4ZDYYBnv3Yhghl23C31nmZ82jTenUCCW/SxowoVMwbX7r16PPGwdASos3dMMq
	W
X-Google-Smtp-Source: AGHT+IEFgxqp4c4BSC1SH5cF+VnXZrlQYZRwfL7NLGJ+2lwsht4p33YhmsPE8cnHExWItmf7lq/Yhg==
X-Received: by 2002:a05:6e02:80a:b0:361:981f:5b32 with SMTP id u10-20020a056e02080a00b00361981f5b32mr2364278ilm.123.1705664107212;
        Fri, 19 Jan 2024 03:35:07 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:06 -0800 (PST)
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
Subject: [PATCH v6 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date: Fri, 19 Jan 2024 17:04:45 +0530
Message-Id: <20240119113449.492152-2-apatel@ventanamicro.com>
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

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
stub of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b6f898c56940..e0a8eca32ba5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -288,8 +288,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+#ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
+#else
+static inline void sbi_console_putchar(int ch) { }
+static inline int sbi_console_getchar(void) { return -ENOENT; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1

