Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB20ECDB47E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 07:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376544AbjJTHXE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376545AbjJTHWk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 03:22:40 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DF10EA
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:22:27 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e58a522e41so348746fac.2
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786546; x=1698391346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRerAerNbb8Gix3xbbzThpKCfwsEd5HQVNj+VzWX/14=;
        b=KjrGLpp1+Qq+ISGZ+ROuA4avDxaRmJJ9isYoVfubxNd2s7bolIn8sB3stP11bEJa60
         sOi3bmbF9mc/MSwqa7WqW57bIy9iYUr3nuUtQcKOxjNatzUNi8i+XCWQbcvvUm2jmmU7
         dXK/TA/ZkvNsjDurFfIPb89jCO6/roRHvkXco/uRPbAcbLQy01E9x/TbJLqu4o8jpJtS
         EjNybfDZCbhhJxnQLnH/q7kx23A1NLxjAR/RaFs2Fs0JOy62oawxhXkyA1EcU6ooZPqf
         kqSAKIWUIwaoanzV1/wYTVK9N1D6Oq4UjnZS95RjiH88kgMvhIJcCSDoUKSG1V7OGHOD
         M8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786546; x=1698391346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRerAerNbb8Gix3xbbzThpKCfwsEd5HQVNj+VzWX/14=;
        b=XAKj7k/l6xQFyargbSxMTt/DbsdKwU/M5lk7sOjcu+N9sRryMjxDMf+LdFmrNRG5b1
         Th1v1XBD5WgISw1HOFFdvq7hskay8nvPmM584qfYNlmgpMrNyqzT+oWjPdCgsp26InaN
         tY3xm470Xy3wpMDbAvqEm/1gDg0NYkirwKJXUz/EbqDQ1KBCJ7RFSmdAMbtOtz7v6AN8
         8MVRC8fXI6wT1oKtfg1ayMZOMezV5yiBa4mwWIh6KfGDkulx4DYxDgyNbbwb+QU4fpxs
         lUp8va+6hOutTSqCqXfGLTbfshtrgbm2dFdBw09dHgGuj1GITaVoxYJKXneoKEGHm+1u
         E5sw==
X-Gm-Message-State: AOJu0YzP/qMX+TD/5J/7fQ6SafXnyrZc9Gz4uuzXwLnpeOETPB2zlh6A
        iJDoEuKO5+u3tMFR7idTPb1Avw==
X-Google-Smtp-Source: AGHT+IGbj7Rt6bShDAUFanmC108dgduwjhSl0KgUP8g8u39xhZmpikUXzy5ZBRKEXuN+qk48Le7mXg==
X-Received: by 2002:a05:6871:5225:b0:1ea:2ed0:2978 with SMTP id ht37-20020a056871522500b001ea2ed02978mr1202977oac.22.1697786546202;
        Fri, 20 Oct 2023 00:22:26 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:22:25 -0700 (PDT)
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
Subject: [PATCH v3 8/9] tty: Add SBI debug console support to HVC SBI driver
Date:   Fri, 20 Oct 2023 12:51:39 +0530
Message-Id: <20231020072140.900967-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
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
 drivers/tty/hvc/hvc_riscv_sbi.c | 82 ++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 8 deletions(-)

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
index 31f53fa77e4a..56da1a4b5aca 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -39,21 +39,89 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static const struct hv_ops hvc_sbi_ops = {
+static const struct hv_ops hvc_sbi_v01_ops = {
 	.get_chars = hvc_sbi_tty_get,
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int __init hvc_sbi_init(void)
+static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
 {
-	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+	phys_addr_t pa;
+	struct sbiret ret;
+
+	if (is_vmalloc_addr(buf)) {
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+		if (PAGE_SIZE < (offset_in_page(buf) + count))
+			count = PAGE_SIZE - offset_in_page(buf);
+	} else {
+		pa = __pa(buf);
+	}
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				count, lower_32_bits(pa), upper_32_bits(pa),
+				0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				count, pa, 0, 0, 0, 0);
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
+	if (is_vmalloc_addr(buf)) {
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+		if (PAGE_SIZE < (offset_in_page(buf) + count))
+			count = PAGE_SIZE - offset_in_page(buf);
+	} else {
+		pa = __pa(buf);
+	}
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				count, lower_32_bits(pa), upper_32_bits(pa),
+				0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				count, pa, 0, 0, 0, 0);
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
+		if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
+			err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 16));
+			if (err)
+				return err;
+			hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+		} else {
+			return -ENODEV;
+		}
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1

