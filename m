Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F2C25B6E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJYUZe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjJYUZK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:25:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B510C3
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859d13f73dso168844a12.1
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265501; x=1698870301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTitWHvbkwllUIYzM7TBpB/hreitIS32ztyb9Cf5EZw=;
        b=D4SzcIRpEAoSD2gyJoIcTnEFFf04Mx+Q2l/0KvosZJ+xD5NZqpKoeWIC00Ga/ET5mR
         XzouaS+YX2WSYqspovVJ39D8YRYcVLoZmxvWK7FY8ie+mj8CqUjn3y0FtiqM5S44KKJ/
         dPSs87lGFRQ3HzhUYV1v2Ot/J3bTveLemiD+zQdMM6OAQNhLUSehw41nmX3ExU858j07
         cxnFTuknGDvi6F6cb+xHfRvRs7wZGoDt082OQwrmtJpULryJakb7wwV62wjmhFaUtPKr
         zmXN/X1sRC26AjtzYihpKXdyp6uMRdGz6xWntJchH71/9cInvwIZtV5Htn2VNNkaK60V
         9s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265501; x=1698870301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTitWHvbkwllUIYzM7TBpB/hreitIS32ztyb9Cf5EZw=;
        b=IKECwRSXuli5cx5Xc0bdUeNYNAo/hreGhu6X/At4UQAglf1VkzhDw3K2+rc5A7y+tV
         Gdxtxzr5R0hkJIQusEUsjsaKn8pVfiAgczTB2M0cFcTsgoKWuU6waalc74qL6wfwx0pp
         DAG7CK/WJTWP2DPu4V3Xgv/WzezTgukfFugtVWOiDDdeNYI01+KbAmowR4xZ9063ZwUC
         0PEplcY8kvXu+Xc9TjsNlwirmaaKWULZyVr5Dyrcn3Y6HCczqqBdHiWSfCvv0Z3Kjf5X
         UPycw5aS/Z8qUH6Eqa17R/bJHsuRr0Z3zLdP4e2D9mB+odrf6JYMOK0YHJm5EonX9sqK
         P7rA==
X-Gm-Message-State: AOJu0YzhccKG8VCQj+fjMttsKVXEHXijsThlWHc9vlLicJjOww2R8FNR
        E/eDweCtbI9R+VFYzvEzqP1qNw==
X-Google-Smtp-Source: AGHT+IFxa1VnMrjTGhwV07IKwl5LjRCiwN2wledHcfI6/uXGW7IWW0Iy/XFASuJINb+BuyvT7MzlLA==
X-Received: by 2002:a05:6a20:244d:b0:17a:d560:5d13 with SMTP id t13-20020a056a20244d00b0017ad5605d13mr7578124pzc.22.1698265501053;
        Wed, 25 Oct 2023 13:25:01 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:00 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 09/21] ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP probe
Date:   Thu, 26 Oct 2023 01:53:32 +0530
Message-Id: <20231025202344.581132-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the driver Makefile is not a good idea. So,
usually it is worked around by mandating only root interrupt controller
probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
probed via cascade mechanism.

However, this is also not a clean solution because if there are multiple
root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
probed first, then the cascade will happen for every root controller.
So, introduce a architecture specific weak function to order the probing
of the interrupt controllers which can be implemented by different
architectures as per their interrupt controller hierarchy.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c  | 3 +++
 include/linux/acpi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..87f4baebd497 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2685,6 +2685,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2693,6 +2695,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..4ad256a0039c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1338,6 +1338,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.39.2

