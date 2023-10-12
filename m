Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E95CDB47E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 05:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbjJLFP2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjJLFP0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 01:15:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA92CA
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso523175b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697087723; x=1697692523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8bTrDTugOefVQ1gZ31VUL3xKHXyC/9v3hCQTi2FF0M=;
        b=PNA01VWNv5rr7c5hvYy72qP2gSfhJBWYL7GkWB8vh2i5whAT7kBzB6WDQw4dcv8hNn
         R62hI6nuQIewYkRRvBc9uLH1pmZvirjGJOV6fTkSKOBSJJo80ejAsm+bEIjp+SDfaWmj
         R1A+1kX6zyq8OguCZyQccqWG5F9KLoA0fAHhkCS6jpnI7+Iw3QCptJqgv+4qne2Z0uNn
         evtQPvTolgsxS1q4C3Hc+NR+UtS1AKAES3JOnK490mxa5mhhq1frmc9v6QnPJP9pJmCg
         nEEyk0D1eZlKfJyA8rLtDAoaSL4a4m/RPzZ2HCkencgQEDdyCVFarfChRgA6ECwVKpNi
         T77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697087723; x=1697692523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8bTrDTugOefVQ1gZ31VUL3xKHXyC/9v3hCQTi2FF0M=;
        b=nvC7F39pck2o62K/IbVjyQSy+9zNRKx+7xvGn+bh7n4zdQ1wRKcy4biDlTIKilePAB
         EIjy7kcNygLJ9lE2RNwz3Xu7jetXFzE9q0ln+m9sqWCqZx6oY8jWwuOnY4/QJgUGUeKh
         WcYcxRBQwdkSfPfgRoRc4WlHP4gtu1c2xwGJVVIkCRS2GYODLF0l+Cu/F8t1HWENHWab
         r8iQ9zgR+XIWX9ZJKHaYtUrnMsR8v3oZdPB8XFxl79nwLnKNtOa0a7D8dcRVtNXGokRh
         WhwJemFNthMaDCn5URRuzDm+NPXxlHI4dQuNuCsKKAhhcRmZvcuAI1MX/NyZww37Fj2N
         OUPg==
X-Gm-Message-State: AOJu0YxAfilyj62uwf6GEsACG9m5x9Zw0LJStvy6oygR8DcCRL6ex0MX
        6Gl9M+bDgzHdhMajSxH7S7XCKQ==
X-Google-Smtp-Source: AGHT+IF5O37nt3kva1oplLeK9oTh/UptqKIJMOtFRGHJUvOY3IKhqZJUhVs0shUGm9K4PlGiYUf6Xg==
X-Received: by 2002:a05:6a20:1609:b0:153:7515:9919 with SMTP id l9-20020a056a20160900b0015375159919mr27813886pzj.21.1697087723486;
        Wed, 11 Oct 2023 22:15:23 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001b9d95945afsm851309plc.155.2023.10.11.22.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:15:23 -0700 (PDT)
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
Subject: [PATCH v2 1/8] RISC-V: Add defines for SBI debug console extension
Date:   Thu, 12 Oct 2023 10:45:02 +0530
Message-Id: <20231012051509.738750-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012051509.738750-1-apatel@ventanamicro.com>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
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

