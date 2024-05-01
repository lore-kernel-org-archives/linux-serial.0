Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E11272D9
	for <linux-serial@vger.kernel.org>; Wed,  1 May 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565932; cv=none; b=TZGarf1HNmCbAuKk7fap17zZYSwo6l6v26uXNcyfbf2a4WhfZ27Zlmp9A0cXIA+JVxyMgu5NPzxCf1br+tTc6rc1ctdSk07nPU91Zbmic1PuELaaWXlz2er0kgxTmdVgP+VH7fcsSS/lt7AIfkk3meb3uqT9BJqmey4KW3bjeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565932; c=relaxed/simple;
	bh=p3PlpHNinxzAsGkdtYqlBifL18TCbYSIHjqjLs8QrEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzYtvxqfdwdMsZUdM3bzzMGkxvxX0pL645E/e4mG8stLYKv+6YKTXX9nGchLN9NSAP7sllpAJf10g225953iohzdSecq609WV6vJ+P7bZHtoX/LD1oAH2wxq7EoWao8Hi52KgdfEJoc2iowV5L8lSRe3xyeWpOoQP6yy7oc7C6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Z9lae5WB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Z9lae5WB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eab699fcddso52718035ad.0
        for <linux-serial@vger.kernel.org>; Wed, 01 May 2024 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565931; x=1715170731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJK7HUkOtgooa4XBRIgNv++I9VXVR1Nc/x5AlB9DEr4=;
        b=Z9lae5WB3xIDPGD4UJhZYx7Qa/W0uxMoyHxCTitfqGzsHl2aJUGf3YvceYTTv2YjG4
         kY8HlmtlOO+jywWivI8kbB3H/WJxg6LqKzl/YRzxE6+V9B4lz1alJyBwdlosPiEPr7o+
         i7U3BW8h8CeKjERd2hVcY8imTPpFNzLftu1faBTkTEjlXLWX2ULgDa9jtmXCS8h8A0ON
         Tzyvl9P7NHf/0F0ASvNoODm84DCosmG1pkbS+WYB2qzw1jhLhjmeEFdClKKrXwDnsJGP
         F9Vqy46FGobUcgLQK4QffJB4mqIABnx6LUU04HtMJBJj7zPF1dalE44NApU2CXV6Dp6O
         uZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565931; x=1715170731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJK7HUkOtgooa4XBRIgNv++I9VXVR1Nc/x5AlB9DEr4=;
        b=iSmyzvzDhjk39tg/mh4twG7OaFRxxgFz4M1KYJNzK171y3UynJVpnH1zG9LUhrEFGO
         CKb6e5Hg0/Sj/cdZciVmrnaTeN78PMmGchniU2hyKrfyhAjROdRqZ+gm/+xxviGn+1Lh
         ImJPqgEZCxMB27Fbul81EGTA4sPsC/6t6KYhdQSttICMGiomQR6Kdp5yrpNhNvgAWQ1Q
         g7mDEQ1S1g6LNO/y2JaDsBKRtamCjqreePIkCz4P4sLI/8S0LUBXEw4CQ63XqHG+rjgm
         bEh0B/so6hxdRNmwCUIQ1exgGm95YAps6LWmfAKfMRYCSdzeCRDYUPCHbL6tB0PvBN71
         0ZIw==
X-Forwarded-Encrypted: i=1; AJvYcCX9UU5gdgIuzAL46wuhH9o8dPm8amKE+WhSllS1ma4T8y5NsX/HNz1ilT2BGcxxK1JSg50+vJzZLsKshdB1z170fgenqxdR54pmyYFD
X-Gm-Message-State: AOJu0YycY4BxMP9zB0Z6/rw0UyOYjDmOrfCZGhDG069JoXs0sCJL4APK
	VHeAj+mSX3+/c7oFIu+K2fLxz/KksCRmCL0FAn/BqVl7iYhFxuB8k0Hk42PPpTOL8DslSUQCRrs
	9Cs4=
X-Google-Smtp-Source: AGHT+IHqQHwdtyucv9ZMhP/dVbiOcapAJDdX24SUfAiXrmEd3YjBfB6sjT+VYhoitv18fuYmxMjC0Q==
X-Received: by 2002:a17:902:eb4a:b0:1e9:470:87e6 with SMTP id i10-20020a170902eb4a00b001e9047087e6mr2178199pli.23.1714565930746;
        Wed, 01 May 2024 05:18:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:50 -0700 (PDT)
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
Subject: [PATCH v5 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Wed,  1 May 2024 17:47:31 +0530
Message-Id: <20240501121742.1215792-7-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index beded069cb0a..3eeb4ce39fcc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2068,11 +2068,22 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 	return count;
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 28a9b87c23fa..5fba4075d764 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1

