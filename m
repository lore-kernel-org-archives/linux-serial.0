Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C49C0032E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJYU1E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJYU0b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 16:26:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2DD7A
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so188727a12.0
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265548; x=1698870348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=cZDdqT/gtqqI0oRq7UCAkp68DsV0s5Wqf+YVZ1of5fXPaZ95fQ1mwqXd5CoOeff3Pn
         cWT82Cg/EhuvcFsKVQTjTH4THO35VgzBwMguia2vgolJ9+0ZyEwWwJ1cOkjg20y8VuZY
         sLOhrr7oUewiG4Rhb2YweEwgUxxUhYD1lb8Rymo1TEkjYyO0NmbW6HUsmHjuOP75O+Nh
         ZFPnpmAU1Z7lbL8uugrDLcXdMyQtMUhSFFvt6+WJAS91FdwgYZQbquE1TJ5hBPh1po5a
         +c4wrcjBMG7B/TuKcikOoUPZC8GpKJ3/8NHrgBSMFJjQpR9Vkl7OB/9FHz7/+XqTg6e7
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265548; x=1698870348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=R8f8LJuEtXlFt29HzH0mtmbOY3hCuHXCKYRF7zVUDLM4zhqQKA+gpLRW2tM4vyVJHp
         ywQJEn+Ebrg1G7orvIhNRtRYHCW+xZuPnohtUOJWEi6xHvWq9yMfJImT8EIHIjCrvWdT
         Gk5870k/2mIKP9riwAqSFX/VAD4V/m5i/2hhfwVualSgoJhNouxpBYzWzXADn0oJvjfa
         ixVYttn1a5VN/umCl+rcoOTXFu4xPLjfm9pKPh3IY4iA+MHz39HhsJsoN7Tm1bsM2Fzr
         wGxMjWwmEgDQGOeJD9N3pqweHLQ0w3hJQETeN8HOXQVXRLYIJhT2p1l1EZt5k9EBk517
         IwKQ==
X-Gm-Message-State: AOJu0Yw14ZBDhgIju6senqDByOtOrtXEAHgM71k8HFiwxg5t7I0InAbv
        qseVI1YwSLGzhVtHXzO4OgFT7g==
X-Google-Smtp-Source: AGHT+IEhemy4634FjVGt90Fqrc/7Er8LwdUnaKYZ7F/EhXxC4jPWbW3jfNiUW2TVJUJPoCyPB2P5Hw==
X-Received: by 2002:a05:6a21:78a3:b0:17a:eddb:acc2 with SMTP id bf35-20020a056a2178a300b0017aeddbacc2mr8715766pzc.46.1698265547753;
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/21] ACPI: bus: Add RINTC IRQ model for RISC-V
Date:   Thu, 26 Oct 2023 01:53:40 +0530
Message-Id: <20231025202344.581132-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4aa53b7e2bb..9eace6c7042e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1158,6 +1158,9 @@ static int __init acpi_bus_init_irq(void)
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
index 4ad256a0039c..19c3dda9c2ed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -95,6 +95,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.39.2

