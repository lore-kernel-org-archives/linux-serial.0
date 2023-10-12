Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50FCDB482
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 05:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377523AbjJLFQP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJLFPz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 01:15:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5288C185
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso510777b3a.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697087741; x=1697692541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRORRt3s6hvFf4qGGIikwZfB3q5mq8SDYLLtJc1fkNQ=;
        b=V94Wj3U/8ri8qOnuiAfwzl/+3mX/XBsscxf8tNI0Hms+fw5wJy9OjICgNeHgx7CUzm
         lT4CMLvtxci7RU1cvI86pEOZRBOWqybo1tNkXEWqe/OLTjE1cKaR1rM8ir6LnUCYSEWi
         pQcgVlqgGyTmixozzZ3j0cPfYtKoryovslksLot74oNUsZDHs1L1SQkpf4yN+v+FU82r
         MGFc9ljUpBrrdBHGvoMPdVGtve8hTYR+wg9/nUgmaWNXk5J9KRsbJJMSEnQxq1BY2pf8
         1G5ff1mCo6EiHQafHJPojpXLHVz2EYASo8KKP034drr+mn0au9iyxQoQU+IxXkXWiSSt
         Ui7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697087741; x=1697692541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRORRt3s6hvFf4qGGIikwZfB3q5mq8SDYLLtJc1fkNQ=;
        b=Tf6PMsVxNVrgl+TdTgMwPjigp9fPo2w6ndukVlGp9ysLl7IqppoLJBMdLDt5R6UIpK
         QBN68L6yfBnzRgjvABMi5FjuXTXT/xjGW+S9EO9cE8YV8AyqQIV9rAqhbRNhp/hy80w6
         a6o8lJiBnRqOTnrqV5VeZkRPTIdyodXJCVjq99ItNAbfD/RGrGdVnncRqgRA6IKLr46f
         YVQk6smQBDLOyrk8lSG3RKNbHGCS/WRNZ2v4PcbadiTfXFZhUBfdZYxDcJP1plizfPn6
         WX8VdY9GP798cNGfe87DU6tBKeTaRpIXwzXJSAPEo0TGrf8SgXwfc5y5m9mzOZYZ4rQJ
         YpLA==
X-Gm-Message-State: AOJu0YwG2j6QRTirTsOkccXbU7VweqhJncw0c2OQGr3sl9uNh8ni/C2k
        7H+ajvxcpZT5hcjs9Eu7zbBz9Q==
X-Google-Smtp-Source: AGHT+IEHQA7g0wr5kBdA1+VUq03jI8s5X+zTK5oLbVixutxk664ESGEsqt+140ZFSE0KLFXmweQiJg==
X-Received: by 2002:a05:6a20:1586:b0:173:e36c:6d03 with SMTP id h6-20020a056a20158600b00173e36c6d03mr3716883pzj.22.1697087741089;
        Wed, 11 Oct 2023 22:15:41 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001b9d95945afsm851309plc.155.2023.10.11.22.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:15:40 -0700 (PDT)
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
Subject: [PATCH v2 5/8] RISC-V: Add inline version of sbi_console_putchar/getchar() functions
Date:   Thu, 12 Oct 2023 10:45:06 +0530
Message-Id: <20231012051509.738750-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012051509.738750-1-apatel@ventanamicro.com>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
inline version of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 12dfda6bb924..cbcefa344417 100644
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
+static inline int sbi_console_getchar(void) { return -1; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1

