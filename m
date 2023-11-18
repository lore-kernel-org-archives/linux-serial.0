Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FCC47071
	for <linux-serial@archiver.kernel.org>; Sat, 18 Nov 2023 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjKRDkJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 22:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbjKRDj4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8371706
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:49 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b09035b850so43964639f.3
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278789; x=1700883589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwuJDohRQ3aqDyqXIkqqX8SciM39GRJg3jYARQ14u9s=;
        b=aRonvU5ownT5UnSsSA8+v5t8/CtqHPWQKm3q796XR4S5793C2R62EUvHSVvEJYBWzZ
         UHXUnoObMEmMbkeCTEurnSG3mgcaUHS95oOJTicP6z8hJIqXl/HdIAFGFjhlw1CVWgn7
         5wxi0JZjD2sPQ0feNKIWt9laCyCWeq+7d2HIklu23vpSWZ7dUhDJSc1f/VF7jFqRaZnj
         jRt1iB4zDecwtkqk1PFoiz1Kp8LHNGqdfQo525vW62gvENA94YogwLgLZ54QrI+a3kgH
         /3etdgH5a1552oTQq2/SLkXXMsBrFglJVNAaf608u5LnB4JD/IFJZSmIdfdDLbQ3MyPp
         rFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278789; x=1700883589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwuJDohRQ3aqDyqXIkqqX8SciM39GRJg3jYARQ14u9s=;
        b=j8m/yyQAwp4oYqBxAbosAwOWjP0ejLgvVAWMkqjZ4MAVn2sUhJ2gGXkPpLqBH6FOdq
         aHBIBUJOhnHpfJ9s05S+Ij1F7mval6lFDCOq42UkdC1C94ErGD/RbeNOJnRA53xntHsj
         RHGxdw+u2jWui5vmtaQNwr6nFk8v8gOvCYHn6CaNTn4JTllHScv2dF9PdLqoqQ/zPHAM
         PQzs20/0Ks2dd/qAxMs0JPvvCt0385l62GYjFUpo+9f2CC/ne3iAhSnIVhgdCLG9FBtV
         moTk5PrSmDzbR6/DoTqVsoX0G1B5d1Cfipd/ulD1U5SMzy2gcGH3DX3g85fKZqnXOdkR
         Rsjw==
X-Gm-Message-State: AOJu0YzrhvzHlpbZx42gfI6lx4eUhyb6dyip9JkeZVYDQdTcaJU5pw3a
        bVI0FRxTJsHKrlZEq/zGHbMVpA==
X-Google-Smtp-Source: AGHT+IHOlKnIVZ4ksof0LCT4ATUyA4aQHrNLe3GwQ2oPH5iU/GU5vmFy/egl6dy1iF7ul/LCCaVvEg==
X-Received: by 2002:a05:6e02:58f:b0:357:4a63:2ad2 with SMTP id c15-20020a056e02058f00b003574a632ad2mr1554139ils.21.1700278788781;
        Fri, 17 Nov 2023 19:39:48 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:48 -0800 (PST)
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
Subject: [PATCH v4 5/5] RISC-V: Enable SBI based earlycon support
Date:   Sat, 18 Nov 2023 09:08:59 +0530
Message-Id: <20231118033859.726692-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118033859.726692-1-apatel@ventanamicro.com>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Let us enable SBI based earlycon support in defconfigs for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 905881282a7c..eaf34e871e30 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 89b601e253a6..5721af39afd1 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

