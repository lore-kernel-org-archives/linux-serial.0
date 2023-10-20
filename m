Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE64CDB47E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 07:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjJTHV7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376404AbjJTHV6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 03:21:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966FE1BF
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:21:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2e22f1937so319987b6e.1
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786514; x=1698391314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFjlFx01Ut+IIk7lMz+iwDuvVBUbWHCR3u/gBbk/FU0=;
        b=cb8kwDbfcMYKuSbeSM4vmK4dk5HzH6+UGU9Z4Cm9buYLbisAywChN7kMLnISn5KVCX
         4iEg08DokJN7xvb1BkDT73ttxPDnbStGLtP/6xk0fZaF1syrUmO1QYmkRXv8jbLIqPGI
         7g8Fv5F/gIwBBHj59qwC3zPpZC5m9kKpl6dNSQpenDmKNCFPLr0RMNrcAX4wXpCNBrvW
         eqk79GYyEO9VH4V8sC52dBFkZr60OL+mAUu7j9ytcxNFJF7NHpm9yIMJO7aiWPZwAHkv
         q45YENrxvOIK0hLlEQSOwLCkrqjqbKDiBokIL35OGLchAHkXvgTwUgqFi5BI9UU6NkIV
         74UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786514; x=1698391314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFjlFx01Ut+IIk7lMz+iwDuvVBUbWHCR3u/gBbk/FU0=;
        b=p2fbCJgAE2fdbGdhGDl2BJ1gBatgxC+MDsVQe2vvfmVQGcEYnCavm+o25luqmKss8d
         tm5hOBynHufVCTpJQHf4ZQtzYpB6bh1T+oiUbZpLe4T5PZUQA6wWU8jiKF20AtoVBYS6
         bwH/1JSwjBkyBIKpdjeIHpztSDtA5ETgFaM2fxSI7EtcuU+j8tL2LIkp3iAdTdn7uE88
         hV/PCXhPiVEOajacAqoKYQ8uOJrBN8Kr/28eEi67hzq+WOiKhQwpG2yxBVMjmdxc/HGk
         G+wsn5Ma/NtC391ghP7K1SPOpaLyUDHGq75zPpqgPdQ18yytHixuaWQr1RlC+h2BCt7H
         XTTg==
X-Gm-Message-State: AOJu0Yy5AZNFVi/sRRWqENPQCpRhH9d+OjeCdr3vOdXmoQfXzYjJmeIN
        +W/SaFvypStz0sJvQw7jCOe2SA==
X-Google-Smtp-Source: AGHT+IHCf4SRFvcjUaBZbUoLW1qmUD5qW9WnhX5EFjNLnYxx3oBY2eRFWdyPRUuwwRReyZ05UhdEZg==
X-Received: by 2002:a05:6808:15a3:b0:3ad:ffa4:dfee with SMTP id t35-20020a05680815a300b003adffa4dfeemr1187937oiw.51.1697786514419;
        Fri, 20 Oct 2023 00:21:54 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:21:54 -0700 (PDT)
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
Subject: [PATCH v3 1/9] RISC-V: Add defines for SBI debug console extension
Date:   Fri, 20 Oct 2023 12:51:32 +0530
Message-Id: <20231020072140.900967-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We add SBI debug console extension related defines/enum to the
asm/sbi.h header.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

