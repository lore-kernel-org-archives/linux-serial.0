Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RoALgjWn"
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73CD4A
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:29 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d7e794f5d3so1017045a34.0
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809829; x=1701414629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=RoALgjWnemxxjmtlqT5DvnrTTgrLgOFwI5HLeHeeAIVVWAflUwcIjaxs52WR1GmaIp
         TnAMIpePdF6OisIV869E0SRSwj+9o02T8gUCYCP95UcOXOG415pScOy1ADdF+g+J7K/7
         N8rDXO5drpGbBzpJPJkQCWnEL3cpsOohih4cebzkF7/BtJaMJGwoYH8IHtxt8wPK8tot
         jqSsMNqSF9zIvyNufldP/BRztJ+o2e2eKKSBXd2NeKiVqn4jKsOSJ5lXCi8bgdGrYVjy
         rcxf4XHUGaDSCwE/gj607oToozYwVevud+OIZXJ1RJR6AZMEfVHWqXHrFlbchS59SlqR
         a3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809829; x=1701414629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=Di/cQ30/orBki4tTVXLUbtuuz4Dzx63Egfsoi3cpkYcJ2MHJo3Q+iJtQ0M4MnGu+Ax
         Gk94eviRZOE7ecv8s7XIsVJuy+qMg8mjG6YcTWS8Azw5ehnHA30VcCssIGETMiEMMDg7
         nm9TEkSsRrTQXmWRl3BbOWqn5LSKErUvIB6qFZCdZWFyABZi3BitCKZkZ0DtaA15IUEC
         IAVZhX84d6Z0MyBv/MuXtjZagwxYNXQSGkLPN72NndaoCA2EMvXJn+PZzwSMs8PAAZSQ
         cFkKmEqjpA6wZh8UKJbiMstxXpKTbSvKuHai9mTPCHUSwELlZ+2YTps5wP87b+FEGxHq
         zhtw==
X-Gm-Message-State: AOJu0YyR4O1PqAsc0ckjJrWK64amzByJJck7tGSXZ1wTSsIIdgNOim3a
	eSHKcTE5eNkLARkH37s/zHk9JA==
X-Google-Smtp-Source: AGHT+IFcPdJe1/+ZUHL4jSznxzi4QTW1Nct7Qxw/93cKKbEqCPdbOrdVTAgRyzDakbY8JJUSxK2OJg==
X-Received: by 2002:a05:6870:d8cb:b0:1e1:3ac9:bc14 with SMTP id of11-20020a056870d8cb00b001e13ac9bc14mr2262118oac.30.1700809828736;
        Thu, 23 Nov 2023 23:10:28 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:28 -0800 (PST)
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
Subject: [PATCH v5 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date: Fri, 24 Nov 2023 12:39:01 +0530
Message-Id: <20231124070905.1043092-2-apatel@ventanamicro.com>
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

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
stub of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..66f3933c14f6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+#ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
+#else
+static inline void sbi_console_putchar(int ch) { }
+static inline int sbi_console_getchar(void) { return -ENOENT; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1

