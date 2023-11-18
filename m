Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D7C54E76
	for <linux-serial@archiver.kernel.org>; Sat, 18 Nov 2023 03:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjKRDjj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 22:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjKRDji (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3CAD79
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28398d6c9f3so1206944a91.0
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278775; x=1700883575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=JB96zYtXcwC6xFXzykj3V+MKnG4qCBTaBH+IWV8wFYK+dc1sfUyf2W5SSK3oVVny9F
         VWQlOetAR8ENiS/FdhGNOib5JBWu5MUNpcYAQbDDPJyRDc3oi67JIFGmZQUIw55qWTvj
         diYd3f6YOpdms8avA8DNQqtu33VHTLeJmXVqLkJTJjRFT5SoDrrGkC1BjqEgOzU7edWy
         WeRGJopCYaraDpmSs/HI2mBoeOWGD3YS0ZNCbaFueMu8TLlPBwFRtpaYlP7ksJV6zhs2
         SmzO1hLRBChDXvwQIzmuo9+USt/t3ZXVXZxEK3FelS2NBUaefga+W9NyG+Fk49A541IZ
         Bvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278775; x=1700883575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=p2DijITZVss4ZqyyToKv02/ozpKVFSCIrtnGiLIe4v//eUJPA4bdlIGOuczO9ymZSy
         LRN77947E9H/EWqGAMeu7JLLsQTlSyM2gghhl1a4zRWbULF9DPBQE/hdIvuNWxYfjl3K
         e69+cQAp1FFNNshO72jLdrKe0BaxedExIOmzTBPi6xjk+fSoyPUD6UfUQkwGGrVhAwZH
         sa8yXuDy649r33CIAx8x6nPFPi7VD+AuleZJQ9BZDSqIoCZqWdTiKvG65WdItx0rbIUb
         hzHmQuYeaOap/69u3yLI20LulipYXQ0GcbziK2htTaGIo9VKfSc7L0mnL249Ip7C2JP7
         1qRA==
X-Gm-Message-State: AOJu0YzF1t905tL3FJ062TGEMMRfAt3Re08TP+0er8qnbgZmSiMPA50k
        foObMhHnkwagfUfNMqiE3gQ52Q==
X-Google-Smtp-Source: AGHT+IFL/vhOEv9SFr5vahVonbYDfe/rMF/KgPJfyv64wzi2WyOjQ+a4xtQ3OlsfO5O9XMpJ2UxSgA==
X-Received: by 2002:a17:90b:3b45:b0:280:29cd:4802 with SMTP id ot5-20020a17090b3b4500b0028029cd4802mr1636773pjb.3.1700278774537;
        Fri, 17 Nov 2023 19:39:34 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:33 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date:   Sat, 18 Nov 2023 09:08:55 +0530
Message-Id: <20231118033859.726692-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118033859.726692-1-apatel@ventanamicro.com>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

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

