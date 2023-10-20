Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6BCDB474
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 07:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376444AbjJTHWL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjJTHWH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 03:22:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430DD73
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:22:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so499423b3a.2
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786524; x=1698391324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3zCDz3wNvDFZIfhQp3mdMMGRfliX9zzX2s9SoD5fk8=;
        b=eWZlqXMTae+4e206soGPMi6RkzcMLXzh8ofE7F7z06HK/UrklYWeHlBX0krBYyDGu8
         N1+7InlbG1xoUhzYLYSEZut5c9x47hgaVeoVXKYwcqkGbDCfeZRvSNQ288wV/tzz4lAY
         jjG5rimOYT78L7XcF/kSbsZyKRIfaOGoiyq9zi1YVxY0JT7VQ4d6xiVArGccQwcSAGru
         JuCa7R9f2bXmti6sovoFiVA4BoF5ZlpOA/9eTX+yf50EeEzU/WHwHIRjs1fa95YdwuWc
         wnsL4lSVed+c8cL5i0bxQCpCRVKDmuNfN8UHJTg0g/0rZQlq9SYaPqido46ndoIwePlu
         sWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786524; x=1698391324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3zCDz3wNvDFZIfhQp3mdMMGRfliX9zzX2s9SoD5fk8=;
        b=Bo42RuhyzNxBNmfP42FHnzyTchxdAOBeupKON0S6Iq9iJEGgnz8INo3Pa6a6hja02G
         ivytDEpngp+b1+gCJ/aW8MmL2u//EH8mOV4xOFTlAFBRY5gzl7fCPupyqYVUA73+9QnH
         PXtd8HCVJFCJi7UyYbb07vLzNOT2NVXetzi31EUxw/VVgFZzlFLjYn+0whU/KUVkdjjp
         oaC+S+fFkMlfIjniP5hC9dmrpyHTgqpuzsPu6eA+0XA6at9psmr6MrXl7+vNFaySgumy
         gRFBbbsZ2B1EavEHiMafkI9xTn7SCrxvp3LOeNt/68kmIn2o6dhHXjzb7wEv4fuFbyQP
         gI1Q==
X-Gm-Message-State: AOJu0YwsNR7HV849PzqoBZGn4JNP026gGOK9Z1CA1qsz/WXvf/JJ9ftu
        TaVSCoo+4nAwbO5RBJMFGBk3mQ==
X-Google-Smtp-Source: AGHT+IG244Unqcch61/RKDkaln/AZV8DtWkK/fAUAz824/pCQp9YvCbi/8qrpjv0yroTiFuFOsikCg==
X-Received: by 2002:aa7:962b:0:b0:690:38b6:b2db with SMTP id r11-20020aa7962b000000b0069038b6b2dbmr951624pfg.6.1697786523600;
        Fri, 20 Oct 2023 00:22:03 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:22:03 -0700 (PDT)
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
Subject: [PATCH v3 3/9] RISC-V: KVM: Allow some SBI extensions to be disabled by default
Date:   Fri, 20 Oct 2023 12:51:34 +0530
Message-Id: <20231020072140.900967-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, all SBI extensions are enabled by default which is
problematic for SBI extensions (such as DBCN) which are forwarded
to the KVM user-space because we might have an older KVM user-space
which is not aware/ready to handle newer SBI extensions. Ideally,
the SBI extensions forwarded to the KVM user-space must be
disabled by default.

To address above, we allow certain SBI extensions to be disabled
by default so that KVM user-space must explicitly enable such
SBI extensions to receive forwarded calls from Guest VCPU.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
 arch/riscv/kvm/vcpu.c                 |  6 +++
 arch/riscv/kvm/vcpu_sbi.c             | 57 +++++++++++++--------------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 8d6d4dce8a5e..c02bda5559d7 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -35,6 +35,9 @@ struct kvm_vcpu_sbi_return {
 struct kvm_vcpu_sbi_extension {
 	unsigned long extid_start;
 	unsigned long extid_end;
+
+	bool default_unavail;
+
 	/**
 	 * SBI extension handler. It can be defined for a given extension or group of
 	 * extension. But it should always return linux error codes rather than SBI
@@ -59,6 +62,7 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 				struct kvm_vcpu *vcpu, unsigned long extid);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
+void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 
 #ifdef CONFIG_RISCV_SBI_V01
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index c061a1c5fe98..e087c809073c 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -141,6 +141,12 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (rc)
 		return rc;
 
+	/*
+	 * Setup SBI extensions
+	 * NOTE: This must be the last thing to be initialized.
+	 */
+	kvm_riscv_vcpu_sbi_init(vcpu);
+
 	/* Reset VCPU */
 	kvm_riscv_reset_vcpu(vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 9cd97091c723..bda8b0b33343 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -155,14 +155,8 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
 	if (!sext)
 		return -ENOENT;
 
-	/*
-	 * We can't set the extension status to available here, since it may
-	 * have a probe() function which needs to confirm availability first,
-	 * but it may be too early to call that here. We can set the status to
-	 * unavailable, though.
-	 */
-	if (!reg_val)
-		scontext->ext_status[sext->ext_idx] =
+	scontext->ext_status[sext->ext_idx] = (reg_val) ?
+			KVM_RISCV_SBI_EXT_AVAILABLE :
 			KVM_RISCV_SBI_EXT_UNAVAILABLE;
 
 	return 0;
@@ -188,16 +182,8 @@ static int riscv_vcpu_get_sbi_ext_single(struct kvm_vcpu *vcpu,
 	if (!sext)
 		return -ENOENT;
 
-	/*
-	 * If the extension status is still uninitialized, then we should probe
-	 * to determine if it's available, but it may be too early to do that
-	 * here. The best we can do is report that the extension has not been
-	 * disabled, i.e. we return 1 when the extension is available and also
-	 * when it only may be available.
-	 */
-	*reg_val = scontext->ext_status[sext->ext_idx] !=
-				KVM_RISCV_SBI_EXT_UNAVAILABLE;
-
+	*reg_val = scontext->ext_status[sext->ext_idx] ==
+				KVM_RISCV_SBI_EXT_AVAILABLE;
 	return 0;
 }
 
@@ -337,18 +323,8 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 			    scontext->ext_status[entry->ext_idx] ==
 						KVM_RISCV_SBI_EXT_AVAILABLE)
 				return ext;
-			if (scontext->ext_status[entry->ext_idx] ==
-						KVM_RISCV_SBI_EXT_UNAVAILABLE)
-				return NULL;
-			if (ext->probe && !ext->probe(vcpu)) {
-				scontext->ext_status[entry->ext_idx] =
-					KVM_RISCV_SBI_EXT_UNAVAILABLE;
-				return NULL;
-			}
 
-			scontext->ext_status[entry->ext_idx] =
-				KVM_RISCV_SBI_EXT_AVAILABLE;
-			return ext;
+			return NULL;
 		}
 	}
 
@@ -419,3 +395,26 @@ int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	return ret;
 }
+
+void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+
+		if (ext->probe && !ext->probe(vcpu)) {
+			scontext->ext_status[entry->ext_idx] =
+				KVM_RISCV_SBI_EXT_UNAVAILABLE;
+			continue;
+		}
+
+		scontext->ext_status[entry->ext_idx] = ext->default_unavail ?
+					KVM_RISCV_SBI_EXT_UNAVAILABLE :
+					KVM_RISCV_SBI_EXT_AVAILABLE;
+	}
+}
-- 
2.34.1

