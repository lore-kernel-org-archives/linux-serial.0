Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C7127B45
	for <linux-serial@vger.kernel.org>; Wed,  1 May 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565941; cv=none; b=OmGeAvHs/oPtnms6NvPUo42xrLqgIIYit8HGVESYimreneoMjwuDhPjsPBYa7Zdh4eKqNjUTy+Z5It6Gt/ChROhDRMviYuErIOqxfwDK4H0Z1o44Xxs7wJ7BVitrUM7xRTOtbZZ69Nw0ETTAfteCvxyPpbCm2Z9yuDV/d2Xll6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565941; c=relaxed/simple;
	bh=CPhKTM+fujR2wlemEJtEAE/LXnd3DpxMM4jZCEYDYXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LuDhZv+yLMCMKMxcM6jNdDvmkFJuUln8t1/cZUNM/lfRl7suU5oDu0uC3RLbv9JunR9kSMKpEbNwzLJDGTtOGrl0tBqdW2ufGlSpFykXroC/IM6e6QAqit9fsYSiDtwB3in/D/7NmsyFj1ANtl7khaAzjNML7LmCxAg6ckbhblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ep2IluZq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ep2IluZq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c9300c65so57039905ad.0
        for <linux-serial@vger.kernel.org>; Wed, 01 May 2024 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565938; x=1715170738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOIqEzOMfBRaM7n+Lh1Tvfg7gL7m541laQZW313gOHY=;
        b=Ep2IluZqBWfF3BzeFXa/f/A9+iP9LRzreQnDkKcSUEhE1tRgAWDYrb7wpgBpbOf/Ys
         na9nxuIx36POxcd0YlqXg+ws4QHedX2RCHNtDcnn8XSyC0ii8ATVXMIPN0VQoYo2bNvS
         pewZCZdGDLBHsf3zuoAAbNbSuWHr+jhXLkBgaF+uwvDjSpl5n8aLZj5a6bnklsFqyNQQ
         lSrKgb2hZZsrwEv46XN27AFYm3swxqu+/r6812UhBzcQS+8Np/EoRWG1BrSoXV10po+l
         3X4BqNRQXtHqAua97x7ziVE+f/bzTbT3ViSk8beV86OGB34NaLYHnvKPFS1pXlZ/feNv
         Mggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565938; x=1715170738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOIqEzOMfBRaM7n+Lh1Tvfg7gL7m541laQZW313gOHY=;
        b=lOn4xQKbo1phLjvvGLLNZb/7Am/H1c/O5a2TaIIwJtboTYpxYIiwi4SNbk5OhwKZ+h
         mC8SpFZLvQJJne1TIazOk3zKzhNQHPXCZjbojDtCkvJoSLWBtSAo5yToJgT3LM9FJLBW
         svYkf9fU00k7GXudrWIKWldk04yKM9SaAixl5fSfh5SumkpiF8F57dZjqrzerf7pmoIw
         WN5P3oyWZ580CM2jQYEbotO/COavq5JAQyfOYqca3eICmtUmV8bUG3sUxWt5UC20UZj5
         eURZCfyFIo+iQ8XBPfXR3x4z7W1otn4Q/CJfrUI56nLdjSvYE5WKqaXXJnK7H4O3NRxD
         sGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoi7e5bFFqX7GSSw0hjeLLwzDWknUus6ActjpSOoyG79eWYmpH3wNff7y7btpH3A7nVwFbbxhcjFKb8+yiuHxAX6f7UmqH1qL6xulm
X-Gm-Message-State: AOJu0YxrKr/ft7Xh7CeRs60D/LYPZsyXbm+v6nbON1TJxlNRssGOsTea
	Mh9Vlc62qqSmsCn3eVS5D9l2tw9ObwGUnHlcp9kyF6vGKbTB/0WN5UpQznDyELQ=
X-Google-Smtp-Source: AGHT+IGEfdWve8EtzQpflTL0dKP3MQxp+brvZfzYZ/NVGRzicQEMono2Ofsx4PyPFbkYzH1s9yqSdg==
X-Received: by 2002:a17:903:496:b0:1e1:a54:1fe8 with SMTP id jj22-20020a170903049600b001e10a541fe8mr1877916plb.53.1714565938389;
        Wed, 01 May 2024 05:18:58 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Wed,  1 May 2024 17:47:32 +0530
Message-Id: <20240501121742.1215792-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 17ee483c3bf4..6739db258a95 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1190,6 +1190,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 846a4001b5e0..c1a01fd02873 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.40.1

