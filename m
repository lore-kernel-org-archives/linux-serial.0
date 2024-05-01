Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3A85920
	for <linux-serial@vger.kernel.org>; Wed,  1 May 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565956; cv=none; b=SfUIrSW5JWI+8FVQ+m1miRIGxqtMjUJG0ZgiyicDdb92/AaTjeePkz2TNWw95KpgOQePlvnqvQFCH/0uPHqg33WpyRlbpFbKTKetVoaeM4wLwE82XiQHhmgzDXItBQbqdl6WXMRIcZLrL9n7blcVfQNxd7GAmRxb+4x4lxm2DgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565956; c=relaxed/simple;
	bh=cL7Je5RYE4qBGSwgVsumxbhFwtVnDhVheuCzr81f6SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6Z3+fbhiVxw2cggjMXv3HlbdZeG0d+N39fm3nFDLGNrY3V9l+HPRDCvHuQue6YrEbs1bJd3U41FHGabfqJxU3odKNO+//2FShqydSZRCzNJieVP/c5snW/RF6o2w1uAYPa1MS9lLmxTRFZjAmSo3w70SxZQfsd/Vp1bEV5kSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YznQalVy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YznQalVy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec5387aed9so13696095ad.3
        for <linux-serial@vger.kernel.org>; Wed, 01 May 2024 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565954; x=1715170754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycPsvBm29e5SjcL+mnP2CfCAXKwmh5unfT08m5gLAm0=;
        b=YznQalVy0FKQq+MPsBAIVV8bpistELZgB8fC1TL1AeU046p3yMlGF8MxxF43KuthM6
         BJZL2B+T5vrlTpj1lx21GjV2UvjfBJvm1i8HqLSz16Nn516/qZ844UIEBuD0o/D8t8MM
         sCWfyZdysdWyRMv0M602QV+8IiU5YA3Zhhrzwsqbb5VGM8Hav63i8iAfd8ihAR12tHQV
         5/nZtEU4f0sjJZxD9mkWzCXcwxE63IaeINZONg0dV3NvBt0c9C6eTtmQck+CeV8S0uBc
         BE/0kYLPjGyLvSqyjBU3O0fsZyry3jsdILYmZ3NIdmiDEx98eWiOS1jRaj79i6LthH0C
         bd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565954; x=1715170754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycPsvBm29e5SjcL+mnP2CfCAXKwmh5unfT08m5gLAm0=;
        b=IsV2joEbqAF5Jk6m5+id7LETunmkzZcL8C1so0H7fyWEKkcjcRnV8DMgscytyUN2Qa
         uUH4old/Zr22g3dhIyal0k3gLJXUsdfmoCvBttfj0SE2xCPjhqJG5zqRheCet1soHUbZ
         fiZRxPO/CB+ACoLWOXincOMXz4GBSwHVeD92h9YcAunQz5Yk+Ry61Wyb7mS5DTGiekqh
         oA+IVZwYzQQxzXX2OZwShr8wlfUCb4xd3LE0JjYk675I1XwviLCCrjf7jtWlgtp6b2ez
         aww1Ei+9CgCRYXIqJUV3DVcWvnFgRNJYRp4CEvLnN/wdz3VkfVduEKU5wtF2TdO5qDVj
         ayXw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XAn+SLZG96dQq2DnMcvH8RLAXAx1zOnU10x/XJHc4OeWYCc6DE6vp7lxyYAitXpDEMKdgQbgs/janTRLcs0UMudGZWjRrAygOaIA
X-Gm-Message-State: AOJu0YwXPqf/ewJjyAAQ1qbo5+5piH7RIeflrXRzMvxZFFgwR0akUx7w
	MXk6R9zMGRUxaOPop/knvas3tpYi0R9qo1Hqa7PqJFUmU8GxiINgvFUOQV032gk=
X-Google-Smtp-Source: AGHT+IEDg6A+K3iip7ZStHi7uQnpL11UU8DLGuIplAfF1OsmX8JbUJctZLyYRcjpa+LuwJ/5zvxvdQ==
X-Received: by 2002:a17:902:864a:b0:1ea:5ac0:ce46 with SMTP id y10-20020a170902864a00b001ea5ac0ce46mr1772335plt.66.1714565953984;
        Wed, 01 May 2024 05:19:13 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:13 -0700 (PDT)
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
Subject: [PATCH v5 09/17] ACPI: RISC-V: Implement PCI related functionality
Date: Wed,  1 May 2024 17:47:34 +0530
Message-Id: <20240501121742.1215792-10-sunilvl@ventanamicro.com>
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

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 31 ++++++++++++++-----------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f7a36d79ff1a..09a86256ddfa 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
@@ -176,6 +177,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..41aa77c8484b 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -306,29 +306,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 #ifdef CONFIG_PCI
 
 /*
- * These interfaces are defined just to enable building ACPI core.
- * TODO: Update it with actual implementation when external interrupt
- * controller support is added in RISC-V ACPI.
+ * raw_pci_read/write - Platform-specific PCI config space access.
  */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val)
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		 unsigned int devfn, int reg, int len, u32 *val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return -1;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
+
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e8d84fa435da..b5892d0fa68c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1521,7 +1521,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.40.1

