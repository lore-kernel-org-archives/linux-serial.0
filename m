Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55896C0032E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 20:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJYUYm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJYUYe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:24:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE718C
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:24:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso126141b3a.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265472; x=1698870272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XsFHpyMSXpsQo/vHxUfuExbd7P0HKVdbzIKlbRfdpg=;
        b=IFtzf0U28RD+GSQFbYyzqFLKa6bFdIIzW112ahFh3jc6XjWupq1EfHGncUr3/acJN2
         xKkmXVXxG7yatZXJkIhLGItwrgVD0Shu6ZTXXUD3qqhwkOdQUdlLTtpvF94vrXozoQ//
         7vYVru2vVcy5/m8p39WgVLXSfjDQTxXvsOry+mE87DCmz6tmOiX2VGR6bUCogS+y03ht
         aDoqwfgMZbvOU9gvHx6lvPJie+sezYV/17tHuqIsG3LsWt1nW3LjOC1fi2ZJGbIytPdX
         Nf49mk5iCdvFgyh9zAOJEnJxrAbxkpp8H3h/bPzVJ1EM9s+nVXXbBH8rkanHNFu/0ibM
         he6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265472; x=1698870272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XsFHpyMSXpsQo/vHxUfuExbd7P0HKVdbzIKlbRfdpg=;
        b=rP14j5Z04NcRSCo2z84rZ6mKED/ToRSU4yCLkjWyaczXKhusMvhpARXahIFhcBUiCL
         Xt5VNbRhbppICgO+0m3GwIUyVDyMuvktI8DOPZXQtWYhc2/7FNWezA9+Ub8C9X9fFXI+
         xHB9MP1hCI/11RwwR8ZEIy6cEDHaM//TcFx0l6uuzCKkmAJAEp/AWqc37lJQho8A41VN
         65nnIPtQxsi5iTauxFXIw66AzwLXudtM+KWHLvtAJyxlfES81Sktkba8V9oOgkMjrRiF
         FQoKDawwfImv6Ni/zsvBrIkpsdfhPUz26DrbnzA3+KbbsvQzOacs3I0zWLiDiZjirmOj
         +sIQ==
X-Gm-Message-State: AOJu0Yz+gzFWyNT3PPLv9rD+b3Xxodjzt94re5Aq6y8ag6o9mt8zHmYj
        tSEuoYItoBoIzFtIyhQmvVP/rA==
X-Google-Smtp-Source: AGHT+IG17/2PVfDmNtmjstcH9/wp6PkDje8IYgLOfv4MBT6NCYwfFeoyShSprXc6RSlzfPVHtacKoA==
X-Received: by 2002:a05:6a00:2d86:b0:68a:59c6:c0a6 with SMTP id fb6-20020a056a002d8600b0068a59c6c0a6mr18973480pfb.24.1698265471729;
        Wed, 25 Oct 2023 13:24:31 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/21] ACPI: irq: Add support for deferred probe in acpi_register_gsi()
Date:   Thu, 26 Oct 2023 01:53:27 +0530
Message-Id: <20231025202344.581132-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The chip which provides the GSI support may not be initialized at the
time of acpi_register_gsi(). Return -EPROBE_DEFER to support deferred
probing similar to acpi_irq_get().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/irq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1687483ff319..c06cfc9725cb 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -51,19 +51,23 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
  * @polarity: polarity of the GSI to be mapped
  *
  * Returns: a valid linux IRQ number on success
+ *          -EPROBE_DEFER if irqdomain is not available.
  *          -EINVAL on failure
  */
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
+	struct irq_domain *domain;
 	struct irq_fwspec fwspec;
 	unsigned int irq;
 
 	fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
-	if (WARN_ON(!fwspec.fwnode)) {
-		pr_warn("GSI: No registered irqchip, giving up\n");
-		return -EINVAL;
-	}
+	if (!fwspec.fwnode)
+		return -EPROBE_DEFER;
+
+	domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
+	if (!domain)
+		return -EPROBE_DEFER;
 
 	fwspec.param[0] = gsi;
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
-- 
2.39.2

