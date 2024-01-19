Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5054F1FA
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664115; cv=none; b=cECFnP1uXddWwr2tN68xjt9vqoRLgrB9RvKpEZPU5r9Bgtnm6UWmGK7v+uth1cuFRRFIvh9bCm/XkucJTeyflNx5Wg3t6tHSDDo1feZrN7WNWQHgnyRIuN8GwaTdF+4olFQUzBMCc1OnXDYeEIvEgYYmYhp5nhZ9YEXHdX0ig9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664115; c=relaxed/simple;
	bh=bVlmxLWw388qCP8JHmo3ylKuzf2WF3OCLmtCeHD9r3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FETY1qpxMuI0bemle8fGPaZ2+ienTzGgOfHPcO+Syj/ODKN7/R8W0lIoe1nceuGZb9SwPCDWXjbgNeQUYqtk4lYsdQ78r2KcQFrNQYrNgM74G3UVnS54ceqh5IJOnWyKFh6OEKy4MKN9IY2Znix6QEI2ZnIsZ1V2QXkleCfHBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KQZxILTF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KQZxILTF"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36082f3cb05so2795225ab.0
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 03:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664112; x=1706268912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HakN1bFuSJrmH5vBdRWtx03jEjEl7JQWSWUtuZHUeu4=;
        b=KQZxILTF612OomhefVTDW7powU5mbyItKRK1SH75WUGsBwkUoiEQVDiSc2Dwbi3m+Y
         /dN/2tKpHR8dm1HkfTPpv1Unwe3XuX8OsAj9Ik4h+tu0b8OHhCBP8Ouede02QV9d4mrp
         2vvyjeCjzQzpxJ1zxjznDpgYn61y1LayxbGMs+N/H2aUQDbg17b4T7ez3dDMvpnxykuf
         qg83qqe4+hE/2hrd1SBl6Wa2F6WY/bWfBfvZ7zndyYxQvSvb56S4HVx96vsrADLa5xfb
         rKPQfjpTlgve9ZV+U6ylsb7Cu9n5Hy/HR9lyFvGPbKHOg6xPl4GSjtUQPTBTMQNZbyR1
         l9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664112; x=1706268912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HakN1bFuSJrmH5vBdRWtx03jEjEl7JQWSWUtuZHUeu4=;
        b=qNSNN4Q4p6R+oFy5RzEJj5Z9c0jFV9XxW+CqU3+x0fqiFLZ8sQ4wNJ8RunR1lhAYLA
         JTsyqMoIciC7m1tjJkQKT+GXupEBhSR3vDp2h0vH1BWg+Ma0lcXjOda6qDmYTPQdSUXu
         KNA/cRqTYrjAvO+ajwbmJVM9Y5Zttih0rRoTtMTkROR1EcK0WGUPuagsqvkFYwBmz1FI
         dz9NFMgR/QRkXfyWtHmocSuXmi89ns3r/RHaFKdznFEvF1VWBaUMdp6zhOphWo234Baj
         5x5iIdvxr7jWGp2Qmgh70xZuqlpnj73cxKgO8IxYMvNHtfesGtuvHzNqYVUPBeukN+gF
         0s+Q==
X-Gm-Message-State: AOJu0YygQ2jGTihXwwS6dkNDw7GEzHtX3RCPIfKU5cnE3oaFGqWPJKer
	efh0O9kVHC1FO/agHqi4JOPFfZD/JNlGO5BPywlW+/8OR1bn/tnzFyVR2mhxYyg=
X-Google-Smtp-Source: AGHT+IGFtjL8Em7K93L47SjMB1nw+F+/vUPksVOq3vIFdZf79/+q2KL2eT42Exg7xGjUxULzusxfHA==
X-Received: by 2002:a92:d643:0:b0:361:8f10:1a01 with SMTP id x3-20020a92d643000000b003618f101a01mr2827672ilp.18.1705664112618;
        Fri, 19 Jan 2024 03:35:12 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:12 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 2/5] RISC-V: Add SBI debug console helper routines
Date: Fri, 19 Jan 2024 17:04:46 +0530
Message-Id: <20240119113449.492152-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
References: <20240119113449.492152-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us provide SBI debug console helper routines which can be
shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h |  5 +++
 arch/riscv/kernel/sbi.c      | 66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index e0a8eca32ba5..13594efb24bd 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -351,6 +351,11 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 }
 
 int sbi_err_map_linux_errno(int err);
+
+extern bool sbi_debug_console_available;
+ssize_t sbi_debug_console_write(const u8 *bytes, size_t num_bytes);
+ssize_t sbi_debug_console_read(u8 *bytes, size_t num_bytes);
+
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
 static inline void sbi_init(void) {}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5a62ed1da453..b06ad29f54b5 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
 #include <asm/sbi.h>
@@ -571,6 +572,66 @@ long sbi_get_mimpid(void)
 }
 EXPORT_SYMBOL_GPL(sbi_get_mimpid);
 
+bool sbi_debug_console_available;
+
+ssize_t sbi_debug_console_write(const u8 *bytes, size_t num_bytes)
+{
+	phys_addr_t base_addr;
+	struct sbiret ret;
+
+	if (!sbi_debug_console_available)
+		return -EOPNOTSUPP;
+
+	if (is_vmalloc_addr(bytes))
+		base_addr = page_to_phys(vmalloc_to_page(bytes)) +
+			    offset_in_page(bytes);
+	else
+		base_addr = __pa(bytes);
+	if (PAGE_SIZE < (offset_in_page(bytes) + num_bytes))
+		num_bytes = PAGE_SIZE - offset_in_page(bytes);
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				num_bytes, lower_32_bits(base_addr),
+				upper_32_bits(base_addr), 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				num_bytes, base_addr, 0, 0, 0, 0);
+
+	if (ret.error == SBI_ERR_FAILURE)
+		return -EIO;
+	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
+}
+
+ssize_t sbi_debug_console_read(u8 *bytes, size_t num_bytes)
+{
+	phys_addr_t base_addr;
+	struct sbiret ret;
+
+	if (!sbi_debug_console_available)
+		return -EOPNOTSUPP;
+
+	if (is_vmalloc_addr(bytes))
+		base_addr = page_to_phys(vmalloc_to_page(bytes)) +
+			    offset_in_page(bytes);
+	else
+		base_addr = __pa(bytes);
+	if (PAGE_SIZE < (offset_in_page(bytes) + num_bytes))
+		num_bytes = PAGE_SIZE - offset_in_page(bytes);
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				num_bytes, lower_32_bits(base_addr),
+				upper_32_bits(base_addr), 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				num_bytes, base_addr, 0, 0, 0, 0);
+
+	if (ret.error == SBI_ERR_FAILURE)
+		return -EIO;
+	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
+}
+
 void __init sbi_init(void)
 {
 	int ret;
@@ -612,6 +673,11 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
+		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
+		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+			pr_info("SBI DBCN extension detected\n");
+			sbi_debug_console_available = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.34.1

