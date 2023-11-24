Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MshE5NZu"
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0710D0
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:33 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2cf67be2so831128a34.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809833; x=1701414633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9VElKh7WOuKh8RiW2R0mJxQw2Lx4DpptCzfBSkBTAk=;
        b=MshE5NZupX6tdgp7UvUUg5AwswL+pvl/9JEIvslAJUuMxbpu/Z4Cy6UW141hPOR8B+
         cdMwbJ00xo760zAtXOVl9TaRcHLP4k5w25xPxhBNxdTOaOt2dogUhKTBdSAXlbN+JyuD
         yT9kwnbVFvd87zcKd2/73OeSbRwujydtzDpgNl265S0BNB6FQnrxdU7zqf2pEKSXDXg5
         cekVnEHBHDkQLGLVYi2NZhcCw09cH5SncgEW9DQ0ynq3jSTj03EcZqes3jjQjsuBrSZz
         FMh/gjySDsDTKwem96BTtE3k4UHGdnH4V1e+OFIiOHHEbXx7rmxutHdZRCBjX8hDR739
         bhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809833; x=1701414633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9VElKh7WOuKh8RiW2R0mJxQw2Lx4DpptCzfBSkBTAk=;
        b=QwHRXhi5Zr72w5HtK35/bKOxy6yMXyWdXYM9ziz/zzTKOHd6Q0U52ho4Ks3oHw7VyP
         TUIvAVqEd6+JZXktJ3HZZGGND4kxx8gnmcTth4UyiJ4rpFR/VpglxFRYbMTr+5Nx3t2Q
         y9Z0pPPhM6UzRH9lG9rQcWczENxuW7m60v1o3LMfjcvL20i5YamCiq54TtZw03MVJumv
         sbZwxDdsiW3rjO1+fxI0/SNUN2Mm8pt2Y7geP9S/TEf8rX2cq0wVIJ/jVUXYD0n/i8z5
         hhUlyUtqXSTrbhvgzrtAcAanR38DRD7E5gsRmiMCZdYnq3ZS/PEHEFHwI7E3ofjekas8
         qpmg==
X-Gm-Message-State: AOJu0Yw294EtIBNferZuu6gDUI6KkljXKT7bRef5aUcFMXp318EM6M4b
	DJ2pExnhqO23ghFU/rVsKjPQkA==
X-Google-Smtp-Source: AGHT+IEG2s4ycd1mkqU7FpTGI5rAcibI7RkN0EhH6e4T2RQdhaX7LpOD9UkrqUiowsChg6UsME1p9w==
X-Received: by 2002:a05:6830:88:b0:6d3:1d04:54e with SMTP id a8-20020a056830008800b006d31d04054emr2059407oto.10.1700809832783;
        Thu, 23 Nov 2023 23:10:32 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:32 -0800 (PST)
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
Subject: [PATCH v5 2/5] RISC-V: Add SBI debug console helper routines
Date: Fri, 24 Nov 2023 12:39:02 +0530
Message-Id: <20231124070905.1043092-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
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
index 66f3933c14f6..9eef25308d53 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 }
 
 int sbi_err_map_linux_errno(int err);
+
+extern bool sbi_debug_console_available;
+int sbi_debug_console_write(const char *bytes, unsigned int num_bytes);
+int sbi_debug_console_read(char *bytes, unsigned int num_bytes);
+
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
 static inline void sbi_init(void) {}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5a62ed1da453..e66e0999a800 100644
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
+int sbi_debug_console_write(const char *bytes, unsigned int num_bytes)
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
+int sbi_debug_console_read(char *bytes, unsigned int num_bytes)
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

