Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F9CD8CAE
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjJJRGP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJJRF5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 13:05:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B3126
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c62d61dc96so36645125ad.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696957541; x=1697562341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qqy4Lq8gbERMmKNa3SsbrCy4B07mso/bpWy+ieX3+w=;
        b=oxsbFfPKApeST8UXfAEZgouvwcN0yMiLW8HE47kN/PIFXkettHGmJnBeY1oMnHLR8w
         1kENylFGJEFUIVCcfqEqA6n8DDOUTUaxXh3m8u0txY6USgdYCbuUKWORgNsT2bLJJqtu
         RER5TjODAkNwXwEzkkKjYX9sxFR6fgaRVNHRZdv26qiP1OkpR7KTI/RBJWAjOTJ72z0O
         Pw86hOoCYQol4hJRIxUQgyMrKW3DTioiDABVibaZ+5DlHg23qRSxeXzVsETs7S+ejsdC
         xqEfLchlgB06beYRu/5LEJPrWZBogDNkhoOy4Mcb4hAYA3oCYsaj7Jl/S1/p10QJ4r84
         O1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957541; x=1697562341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Qqy4Lq8gbERMmKNa3SsbrCy4B07mso/bpWy+ieX3+w=;
        b=Jn4Af460VcAPc0QmzYSjIZ22PIF5O+xQDvPuNXni7pmjsxBQsVU3WlAvtYDjxPKdtv
         TlqE9kWVbC4acAfcgHLkdIs7LKXf8kro9XtrivqidZtAcfz8gi18mMFLW/lv2yje0hxF
         9s3LzPjVW1pUDR83iOKzW3TPv53TR0ae1O+FSwMztHc3FMdEk9xnB1cwvMGiXcKHyf3r
         tP4VWt1lefcKIP9GAnDPDBQHEvl9CHExe5aMMYZFh+KZTCMGfOU999lq5yH06pgiSiAw
         /J6YnxEE89LB10LHER2JCEd3Hk2EsSxK3DjZz+SXDXRph4rr3uMrpG4zprI4AW2ERS7O
         Oe8A==
X-Gm-Message-State: AOJu0YxLK/hutJUhArVvmd3inhEBBT3W5Wp5/bAWZrqTc7PmNF+ZvGFo
        wViqnK3Skw/RFU/gz9Ygr9XmMw==
X-Google-Smtp-Source: AGHT+IERB4pxUt5nWI40xusQqE+9WUh0dFLmx7F6EOp9LBym2k+moLv9bgQcH5zXgP5QADPNDZuBnw==
X-Received: by 2002:a17:902:da89:b0:1c7:3aad:305e with SMTP id j9-20020a170902da8900b001c73aad305emr19217128plx.27.1696957541145;
        Tue, 10 Oct 2023 10:05:41 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001b89536974bsm11979868pll.202.2023.10.10.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:05:40 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 5/6] tty: Add SBI debug console support to HVC SBI driver
Date:   Tue, 10 Oct 2023 22:35:02 +0530
Message-Id: <20231010170503.657189-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010170503.657189-1-apatel@ventanamicro.com>
References: <20231010170503.657189-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Atish Patra <atishp@rivosinc.com>

RISC-V SBI specification supports advanced debug console
support via SBI DBCN extension.

Extend the HVC SBI driver to support it.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/tty/hvc/Kconfig         |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c | 80 ++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 8 deletions(-)

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
index 31f53fa77e4a..be8b7e351840 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -15,6 +15,7 @@
 
 #include "hvc_console.h"
 
+#ifdef CONFIG_RISCV_SBI_V01
 static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
 {
 	int i;
@@ -39,21 +40,86 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static const struct hv_ops hvc_sbi_ops = {
+static const struct hv_ops hvc_sbi_v01_ops = {
 	.get_chars = hvc_sbi_tty_get,
 	.put_chars = hvc_sbi_tty_put,
 };
+#endif
 
-static int __init hvc_sbi_init(void)
+static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
 {
-	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+	phys_addr_t pa;
+	struct sbiret ret;
+
+	if (is_vmalloc_addr(buf))
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+	else
+		pa = __pa(buf);
+
+	ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+#ifdef CONFIG_32BIT
+		  count, pa, (u64)pa >> 32,
+#else
+		  count, pa, 0,
+#endif
+		  0, 0, 0);
+
+	if (ret.error)
+		return 0;
+
+	return count;
 }
-device_initcall(hvc_sbi_init);
 
-static int __init hvc_sbi_console_init(void)
+static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
 {
-	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	phys_addr_t pa;
+	struct sbiret ret;
+
+	if (is_vmalloc_addr(buf))
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+	else
+		pa = __pa(buf);
+
+	ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+#ifdef CONFIG_32BIT
+		  count, pa, (u64)pa >> 32,
+#else
+		  count, pa, 0,
+#endif
+		  0, 0, 0);
+
+	if (ret.error)
+		return 0;
+
+	return ret.value;
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
+	if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
+	    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 16));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
+	} else {
+#ifdef CONFIG_RISCV_SBI_V01
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 16));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+#else
+		return -ENODEV;
+#endif
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1

