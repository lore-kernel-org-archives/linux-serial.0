Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AYsLJoeK"
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED4D6E
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6cd0963c61cso886117a34.0
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809824; x=1701414624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O91wfSpN9ObCdaEwiURAAaoPifbKQnuX2UDqzMk/9EE=;
        b=AYsLJoeKp/VeCaPKIAsqEeGRNi1EXuiCRdE4pVMDxJ6B/TXmQou42eJ+FTRMhNpdnd
         sFuKbaeEReP4bKRRo6CyvkVoKprhlpDx2zx70YKSZLMqK/pM8YdLoYy7vVPx55si3cwd
         +BHk+GRqfjWiA/CiWu5xVNTwzv4UofcWvYHv4DLGksU9dgA8m6ZA86W3C2kBPstgYvGq
         C3HDN5hJhfWEydJcE+A4lEzpyxI8bEjX2zZFta1QC9sLiRa+tfnCdcUmlV9gkqgAPn4V
         36L5/VNZt4XjaErD9yP/duGhGFEOksXfIfMZHsHB0ZL+/5LP0yX+iUAuDGXBm8KY1qrI
         9eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809824; x=1701414624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O91wfSpN9ObCdaEwiURAAaoPifbKQnuX2UDqzMk/9EE=;
        b=LMAP/hYCaAyYij3fPU4pXLlmklw9NyuQFbswo2SalyrloiA57K7x6J8cjTOmciCLm+
         h+EKVkvda0qcKCBbC+m2tpr+kGD2X/E/jdbzabmyfmemFBneMWzZdEgvQ8eTZsIoJ8Oy
         tmCOtc9eokjt++ZSyTXVlsxuHWkSyVa8fBYAQ2B1Y26nOa1hVQrWngglwtXDpi2Kq7PF
         z2uQgTTs1B9nZudve/TVfNyY319wIzpgwY20KKnhfhbpAVfX6xyDLzHg4VAK8JBg88b7
         bDV7WW58G0axHadfLA7IytHDWuoEkEVXqY27Xd6muKsInGkZpkJ1kCNmmSL23bQy3S7G
         HCnA==
X-Gm-Message-State: AOJu0YxZaUcMZY6FmJ444iu2YLUkTumtg7vhHLsIHKsacXAnMa6tu+U+
	d/KKbg43hY7q7kT87aN00BMiBw==
X-Google-Smtp-Source: AGHT+IHoAk7libxxmoEnwyG+ICVQkzzI6uc6joEaMVEQl0m28dbDgLSf9VQd9ACWrQm5vBhlWCIngw==
X-Received: by 2002:a05:6830:603:b0:6d7:f66d:b0ae with SMTP id w3-20020a056830060300b006d7f66db0aemr1910766oti.5.1700809824530;
        Thu, 23 Nov 2023 23:10:24 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:24 -0800 (PST)
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
Subject: [PATCH v5 0/5] RISC-V SBI debug console extension support
Date: Fri, 24 Nov 2023 12:39:00 +0530
Message-Id: <20231124070905.1043092-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
functions sbi_console_putchar() and sbi_console_getchar().
(Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)

This series adds support for SBI debug console (DBCN) extension in
Linux RISC-V.

To try these patches with KVM RISC-V, use KVMTOOL from the
riscv_zbx_zicntr_smstateen_condops_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_sbi_dbcn_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Rebased on Linux-6.7-rc2
 - Addressed Drew's comments in PATCH2
 - Improved sbi_debug_console_write/read() to directly take virtual
   address of data so that virtual address to physical address
   conversion can be shared between tty/serial/earlycon-riscv-sbi.c
   and tty/hvc/hvc_riscv_sbi.c
 - Addressed Samuel's comments in PATCH3 and PATCH4

Changes since v3:
 - Rebased on Linux-6.7-rc1
 - Dropped PATCH1 to PATCH5 of v3 series since these were merged through
   KVM RISC-V tree for Linux-6.7
 - Used proper error code in PATCH1
 - Added new PATCH2 which add common SBI debug console helper functions
 - Updated PATCH3 and PATCH4 to use SBI debug console helper functions

Changes since v2:
 - Rebased on Linux-6.6-rc5
 - Handled page-crossing in PATCH7 of v2 series
 - Addressed Drew's comment in PATCH3 of v2 series
 - Added new PATCH5 to make get-reg-list test aware of SBI DBCN extension

Changes since v1:
 - Remove use of #ifdef from PATCH4 and PATCH5 of the v1 series
 - Improved commit description of PATCH3 in v1 series
 - Introduced new PATCH3 in this series to allow some SBI extensions
   (such as SBI DBCN) do to disabled by default so that older KVM user space
   work fine and newer KVM user space have to explicitly opt-in for emulating
   SBI DBCN.
 - Introduced new PATCH5 in this series which adds inline version of
   sbi_console_getchar() and sbi_console_putchar() for the case where
   CONFIG_RISCV_SBI_V01 is disabled.

Anup Patel (4):
  RISC-V: Add stubs for sbi_console_putchar/getchar()
  RISC-V: Add SBI debug console helper routines
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/include/asm/sbi.h            | 10 ++++
 arch/riscv/kernel/sbi.c                 | 66 +++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 37 +++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++--
 7 files changed, 133 insertions(+), 12 deletions(-)

-- 
2.34.1

