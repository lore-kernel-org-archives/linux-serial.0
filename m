Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514FCD8CAC
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjJJRFW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjJJRFW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 13:05:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAEB94
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9b95943beso5620685ad.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696957519; x=1697562319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8bTrDTugOefVQ1gZ31VUL3xKHXyC/9v3hCQTi2FF0M=;
        b=jU5kqW5+yNfWXyrCBivpJvC6WFn8kuATscsBROojMz/mRH5v2/fAXFwz8y12CccoWJ
         Jf9kUJVveLhhjTZIhIGmzhi2PIHmqcU0yey+PIzlutgigyxExtvao35qm2vVKBHlj0M5
         80OItPZNkpj1AOWEtJNrhHi2/IOld306mc2QXADitvQQij7EcYmrVMsuTKiWy8/IwyRF
         +jF/FpsrO6boZuWHZ4Hp2HIcoT2fU1RGd8mLrl/mxlF6M7G52GTSCS7MxQtYzWhmSq2r
         g4rsQxODxOtVoFgX8GNihTrb/BCzJDZqzSMVUarbirZT5uVPB2+gZabqxBaiLqhYtD8J
         3ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957519; x=1697562319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8bTrDTugOefVQ1gZ31VUL3xKHXyC/9v3hCQTi2FF0M=;
        b=YPzPtjtBkXUbGAv9HsczqJSFGf0DXQ888hVeD6sn03kZG4GF7xwRTx/AetCaH+9jAF
         5/MU8hnd3e7Ejrp4527kdF2rAfe4QLwnXmOPV7XqaEX/LNXaTC/7sHa/GZJJaaVRJVgq
         vi8ZLjYcgJHDnkiI6e/ITTVFncQ/kNeCiRMxPheqwkejeEFxEkBmJ5reOnTV7OG0BcBz
         jdmR0gDvD10vxOFF5WbpljyJFNXeY52zP7p8h2TNiuNXNYrW4FNgX9tSWYR1+jxKO55W
         9YOQ3qooGjXM3UHdW76ialcDBXhy7WOiISHC1e5gC1/odV3GZknjhRdhfBr9qvl4VFtw
         o4+Q==
X-Gm-Message-State: AOJu0YxdLR87e1RxgIOTNYgREztbjxIhniv/ZElzFm9ca7dKniJlHI6c
        7rL2F/W34l2unpAEsAJwyKoc2w==
X-Google-Smtp-Source: AGHT+IFL7+0d+NQPD7h5kg3nJxB/J3VP1OkPOJXtOKdl/WfOH7Q9zbTJf6UkIcSLTxobmxIUYWGImA==
X-Received: by 2002:a17:902:ea0a:b0:1bb:598a:14e5 with SMTP id s10-20020a170902ea0a00b001bb598a14e5mr24227444plg.43.1696957519183;
        Tue, 10 Oct 2023 10:05:19 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001b89536974bsm11979868pll.202.2023.10.10.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:05:18 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/6] RISC-V: Add defines for SBI debug console extension
Date:   Tue, 10 Oct 2023 22:34:58 +0530
Message-Id: <20231010170503.657189-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010170503.657189-1-apatel@ventanamicro.com>
References: <20231010170503.657189-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We add SBI debug console extension related defines/enum to the
asm/sbi.h header.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..12dfda6bb924 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -30,6 +30,7 @@ enum sbi_ext_id {
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
+	SBI_EXT_DBCN = 0x4442434E,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -236,6 +237,12 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+enum sbi_ext_dbcn_fid {
+	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
+	SBI_EXT_DBCN_CONSOLE_READ = 1,
+	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.34.1

