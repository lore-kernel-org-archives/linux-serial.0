Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75CC25B6E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 20:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbjJYU1R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJYU0i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:26:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704E1BE9
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so130425b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265553; x=1698870353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=gni9otB/RxqkdQcBtDhkGtxYXI1WhO6/nBa5LuP10/nNencAljOkoEGMmIzHInY/ky
         oDlR4aIa6BOWPeVwvMeutGJ5V6ffVJCjq9yAVxUgQJ2NWKDBS7IHFKiQ+l6fFBvSh15A
         mZC/WjARqRxm2wTMlRiEvP5OHITXIqMDoeYIdAubOwiSoJbWpW6qqgDG3R3ijHPWgG3l
         RZ7TnvwKTmJTwhe02+58gFnl2LR1WgjHj440rGe69OikbaJsYYesrFvKharIMMus1Hog
         QqV5S9f6vTbimWXy/i5vLDf/0GQKcbKhCidzew7Kz1qBK6XcaGk99AbAHyc/PlHte0Xp
         EzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265553; x=1698870353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=GCtCptaPLZr5n39V400GzbQac2zqDD/lj+m+EBBWr3gtm0RN8mVpaUhy30eK6CdFEw
         8rZVidrbPoGvJhEJ22orfVgkicc+HFkT+GrwEy181jj3FEhbJyAHn5xqWZXQf504rA1E
         8Kq2j8PD9jk8XjCYHSYHb1ioAh/swDMb/pfPo0Ax7Lmy2SprEQqwSwIaGLOTmiXHHbJd
         wFLvTqcZjAQQ5JajP+NLLF8GGuOeLKtgQztC0lWpy+Tz72VNcXso5rSSsne6381Jpbgq
         NqcaYQpC7hYv1xMQ/5kyjVvSEn4eCOLSASw5P9RQlC8lTs4Hone546WKAWdEWvMFvP5X
         RJ/g==
X-Gm-Message-State: AOJu0Yz7P2douPhGKxkWHx7Z6GOxh4gZKFrLJKoZMwCMpYllpNDglQ8x
        Yov/fWR8KgbMhi4S6IlFTKqGYQ==
X-Google-Smtp-Source: AGHT+IHkn2z1G+Hl0DvKFF4S04ijeypy9mwQD0HYMK+syY66BONzs/0zW1LpSVQhK3aml5xBfnLnBg==
X-Received: by 2002:a05:6a00:17a1:b0:6be:265:1bf6 with SMTP id s33-20020a056a0017a100b006be02651bf6mr14834736pfg.32.1698265553494;
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/21] irqchip: riscv-intc: Set ACPI irqmodel
Date:   Thu, 26 Oct 2023 01:53:41 +0530
Message-Id: <20231025202344.581132-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

INTC being the root interrupt controller, set the ACPI irqmodel with
callback function to get the GSI domain id.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f3aaecde12dd..627723d72b01 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -273,6 +273,17 @@ int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
 	return 0;
 }
 
+static struct fwnode_handle *riscv_get_gsi_domain_id(u32 gsi)
+{
+	struct fwnode_handle *gsi_fwnode = NULL;
+
+	gsi_fwnode = aplic_get_gsi_domain_id(gsi);
+	if (!gsi_fwnode)
+		gsi_fwnode = plic_get_gsi_domain_id(gsi);
+
+	return gsi_fwnode;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
@@ -318,6 +329,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	 * unsupported. Once IMSIC is probed, MSI support will be set.
 	 */
 	pci_no_msi();
+	acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_get_gsi_domain_id);
 	return 0;
 }
 
-- 
2.39.2

