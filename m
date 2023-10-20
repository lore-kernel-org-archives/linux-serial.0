Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C3CDB474
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 07:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjJTHWH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376409AbjJTHWC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 03:22:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0FD55
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:21:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b26a3163acso454815b3a.2
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786519; x=1698391319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeCDV01Cfgp2ua0LgBWyAWr2dv9+xpkaYGG6VewjHJM=;
        b=YIVl7jqh/mVMZvM7LpYq+nOKqOw0HllLkePgMOp26Pw8rv5lL+UhDis0N0Qmb0/L4k
         h3k7vJWIfx5rhbj7o6BRaYriDzP/v4SI69KzKks9Tyjz1vcxR080XMEY0okHcBeaOqJF
         80AERFZoJrWib+yAsXj1tjtRNFYxBDFjo/CGtSnl3SQzIMwcQM2tzYuPnGsuMiMk9p+z
         Kl/HcD0bCY6Wb19ctXbpTL4RGQBKriySV8Fv2dZkr9z2kWMZbf0GezNra/rlJlHDKo62
         CsIkxPfChxBzGj9utFNEufUNYGGUqz9J7js2r4Tlo1DBhdnVyLLJ8hQLVG1oDymfSWSI
         Yjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786519; x=1698391319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeCDV01Cfgp2ua0LgBWyAWr2dv9+xpkaYGG6VewjHJM=;
        b=smmbpAXtYY/shBPTs0+6DHO7u6cNSplrfaU7p9h708giWUd+0ned8HmPZeZxzf72Dk
         OPmhnbc04+i4i3NTqEovbnZehThboz0MH99SFGiiW1ZcKec/GmwFAeEabg2AwIADLxpG
         i/txCyZ8taEzwe3x4+mdt0F+aK142/mHx9+6xlxbZsCuL/3quFWobFbNiVcoMiKNk8/5
         VmAz6if/MZPwl7zCGxSW/LWVQd9iAS2Jocfm5vr/5v2oormeuSWKZYvtqW0nUEMxDYRB
         FsY1N+zAYH/+mYPZd/HanapKG0yEQvYaJC6wQ9xj3ggJMs4kGm2YI/eR9yvJiAP5iA9t
         5C6w==
X-Gm-Message-State: AOJu0Yy0EP7jqlUolXlpv5XzLzIKKRHmLyQwECRrVHgvXRySkekwY/Rv
        kGf0FQ13LIUROvpVwP4mZ8oqTg==
X-Google-Smtp-Source: AGHT+IHW872RFsEW0M8OTGxKAzWnTo/8F6Le59a6yN6WSYq8GfyXYOW1jHmUi8NhTnVPlD9i+6DmJA==
X-Received: by 2002:a05:6a00:b8e:b0:6be:4789:97ba with SMTP id g14-20020a056a000b8e00b006be478997bamr1029478pfj.3.1697786518893;
        Fri, 20 Oct 2023 00:21:58 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:21:58 -0700 (PDT)
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
Subject: [PATCH v3 2/9] RISC-V: KVM: Change the SBI specification version to v2.0
Date:   Fri, 20 Oct 2023 12:51:33 +0530
Message-Id: <20231020072140.900967-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We will be implementing SBI DBCN extension for KVM RISC-V so let
us change the KVM RISC-V SBI specification version to v2.0.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index cdcf0ff07be7..8d6d4dce8a5e 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -11,7 +11,7 @@
 
 #define KVM_SBI_IMPID 3
 
-#define KVM_SBI_VERSION_MAJOR 1
+#define KVM_SBI_VERSION_MAJOR 2
 #define KVM_SBI_VERSION_MINOR 0
 
 enum kvm_riscv_sbi_ext_status {
-- 
2.34.1

