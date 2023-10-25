Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F411C25B6E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJYUZ0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjJYUZC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:25:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475FE1A2
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so132188b3a.2
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265495; x=1698870295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=HmX0WIx5ZKR8Cg3REtV8WvU+4A28I3jLrhYLezQY+rp0mQhBER7xMb/ToHKODSjlj7
         9aLYkV02gUF/2XnEVo1AwnEOt58O6rZquL0s3P53ziGLqlbYyPbjdycjDYoUW1stjWvr
         rKgGnj5V3bcFCfmCjdxyPLXDN0xB2fxplJUE3DqCkdHc3mzjVEKH0kXwgsDTy4hYAqP9
         P/WBTpzN7E0ZoKTHRR2UA05tUxCkaAIkx+j19OSo9SBppQIUcY9JUwadvgwhh3sG76gl
         R7B0oJcJMu5lOEj+1NQvmnD88vwGK+ehl5SxiF0Ecwg7iRYw96TElPdqUlCsZbN/v6ch
         4ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265495; x=1698870295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=R8WtXhcBjrx/A7DlfZWRpiEfrq+aWH4m9We7t/9qpExregSkW4xa2EPmvFAU2w91E6
         zlI2w6n4B9Clwx2fRteenjBG9FWZxhGDZvoFk7f4yPIagx7xI3vG/dCo/Q2/C/N1YyEe
         kBlOoJ4FL07IfKCfEhrkKyY/fHpPGKuJBzlCtlIfv/fiZDFq5+LfCfgVVB2CmyDOOMYT
         ct93bSLnEOl/S0GX4mNSiMamaZo4hChUMyarsEhKVzpZ5pB79YMa9vjkJjEZZBp2kYiu
         o8m248DJutDkLhyuoS6K0KAkD2KXW+b8OOZE/h+n+2ACuAi2v8nsbLxpDqncOfzQhVM+
         OrAA==
X-Gm-Message-State: AOJu0Yyg/vDFIUHr4WIMEER08zSQ1B7//dnjZqhe+3KJNiv+OVwRyvn+
        B1UEOkVOnuhtwq9MFH0efHTksw==
X-Google-Smtp-Source: AGHT+IGOtWmx7Z9hH5AFpr5sZFQnzIJZNuxwJNKWTB6+enKWMWr67WgjO7Vy6dwjrSM8D50mINvLmA==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr19185035pfe.10.1698265495348;
        Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/21] ACPI: pci_irq: Avoid warning for deferred probe in acpi_pci_irq_enable()
Date:   Thu, 26 Oct 2023 01:53:31 +0530
Message-Id: <20231025202344.581132-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When the architecture like RISC-V supports deferred GSI interrupt
controller probe,  acpi_register_gsi() can return -EPROBE_DEFER which is
a valid use case to delay the dependent driver probe. So, avoid printing
the warning for the deferred probe case.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_irq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..f7d0822da08f 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -452,8 +452,11 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 
 	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
 	if (rc < 0) {
-		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
-			 pin_name(pin));
+		if (rc != -EPROBE_DEFER) {
+			dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
+				 pin_name(pin));
+		}
+
 		kfree(entry);
 		return rc;
 	}
-- 
2.39.2

