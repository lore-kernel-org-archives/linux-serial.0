Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0920CDB47E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 05:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjJLFPb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377075AbjJLFP3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 01:15:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E9BA
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69101d33315so480227b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697087728; x=1697692528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3lhlJZP7U6sfVX0rlDY0S8d2x8DhhVnWXy5WEJL0wg=;
        b=bO+joST4fnerVfNdvxbD3G3EoUdUyb/IiYMN7kJDot/319BBpvmqIEXizqDQpzw4fo
         Zr71ov/sReYoJpVlsLm+EYW8Y0K0WOwapk0LVesTMBkXNfV4GShQfOza4eChN6syVvUn
         GnGch/9x0NYKMJnJN7NWWdonUf5rTM90CKKcOU0mJGwc62UI5u4dSrOValXKOmSFap/b
         alTHuwF8ML7KvPL0/HQITD035UCzdTBp+7YnJOhRdaq5oDZtarz3pdVCDdJK6lZEjaTP
         V//DM5DKE0DsYP+ErdQZiOrK8UcJOb9mLLl9CYmCW/sXMYZ1pJcXiJuqUAKlon7wYXC9
         9LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697087728; x=1697692528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3lhlJZP7U6sfVX0rlDY0S8d2x8DhhVnWXy5WEJL0wg=;
        b=siEQH0DyP5A4/wsJRtHfmjBU7P+NgrpTtb64RXY6EAz6w7xvg+AuoB6+J6X2BTfaOA
         yRunmwDlORQRtrqnarXVHXIpPhpRyxSR7A0ECsGTo/2N6mIR5cM8kPyA5UFpSZalsD6d
         UI1GJwvSaSN2FSjHEDDvMegn77QCHnK+/yBIepyj7ImnCVQ5whSdsIuDJqBOfPpkHtNA
         B+yxOc06qxQeOjsgg5Xy9zxLW3Mco9oZ4RuxuonNrdPWuH/oS8aR1U36bXfARQExGDaq
         Jy36lzFLSptqf/QrEOYRdbOkVIFTob31FU5RiE9g1l3GwAhOkKwkXhKipD5JsmddlYPk
         y6pA==
X-Gm-Message-State: AOJu0YzOeEUZhFC3kWTYfFXwUmXjfnESH5aA1aK3hfvUIY2uEEcMIMGK
        ZzEVPyhY3SzlQFeqVzqWz8X/xw==
X-Google-Smtp-Source: AGHT+IEYTYmKd3tYlh3LiHGeR+Se06zPGfuu6PsLv0v0PYM+oZ1DNY/YAR7he8NCW/RMMx46gl3FeQ==
X-Received: by 2002:a05:6a21:7784:b0:173:318:b1ec with SMTP id bd4-20020a056a21778400b001730318b1ecmr5209664pzc.35.1697087727987;
        Wed, 11 Oct 2023 22:15:27 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001b9d95945afsm851309plc.155.2023.10.11.22.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:15:27 -0700 (PDT)
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
Subject: [PATCH v2 2/8] RISC-V: KVM: Change the SBI specification version to v2.0
Date:   Thu, 12 Oct 2023 10:45:03 +0530
Message-Id: <20231012051509.738750-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012051509.738750-1-apatel@ventanamicro.com>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We will be implementing SBI DBCN extension for KVM RISC-V so let
us change the KVM RISC-V SBI specification version to v2.0.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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

