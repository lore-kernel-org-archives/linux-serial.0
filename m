Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30AC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 16:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiL2QWt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiL2QWY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 11:22:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7CDCE
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:22:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so16215250pjg.5
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OLkB5mMsHKDwbR+cM0W/wmV6jqAoejRkqxG5WHPUJQ=;
        b=yQiDJFyvnV+prccj0GMjiX10frFzC9Mfv04bocJ0Bh8oX7y+0k1z6Z0xnkfyFjqKTN
         tecrdMMOKsT+GF9HeX5ucR840RKiPVlcQdFksm2EpP7XAJ9W8nteo/euV7HUtU/7XVos
         1gbq8i/EFYMDbJSxlFINjqZCWh0Or2riyQhU8vz0xkkzkh6Xzo+J8F5WBgOl4kH4tth7
         8xSe/BGB6hbIfuiW/binFvc8fGWyKCJQHaCCfH+RS8RzQ2jbZpqI50KJAWYN2ASGpeVk
         C4Ws88CuuQy79JJarYmebhTN4nklASG/JuK2M5upTdnlTHNIhG+lCB/FISII85YP2K5G
         kyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OLkB5mMsHKDwbR+cM0W/wmV6jqAoejRkqxG5WHPUJQ=;
        b=ZtzSVReZWAJ5r60TIRqxeT1r1k+KzcR0GaoaHkPuiBMzdlIq+OinRT3BJWRvktMBJ2
         H7GizgaAoL3Ak/SMDdXv4ZaD2I00GVZu2Elk0ylaQD8p0n1UfH7I6Vlf3HZOQPGNTUHK
         XBQmpf3/t9FjHsHpTe2QPVOe3YPFOYcdHIdwwlyM+U+ENgaEbgFVc/JBQ3SSmS5/AXXJ
         pUzNc8vsixHom32OryC1twr2LnJMD+z5Q/r/B57JXXic043TiB5c82yLt6Ft6skYFOcs
         2xKV6srqUW7yYAFDUZajdNOqtn+XTog8mrurkQTirtk9NLjkcUAfWPG6+fPRN3OcGEXl
         5qgg==
X-Gm-Message-State: AFqh2konEuKeKX8LjYmoOobmuR63VTPphhP9EvAMJcWY8WzjmdTlSfy6
        DIUVRH4Rmfs2lqPlnAyJo+LLQQ==
X-Google-Smtp-Source: AMrXdXvbOxeambP1FNrtoSqupKLHR5ZUV5b4qXQ2GRZNGFk8nmQRfBqHImgd60VPFJ/uowpsCdY3Pg==
X-Received: by 2002:a17:90a:d511:b0:225:dce3:8b9e with SMTP id t17-20020a17090ad51100b00225dce38b9emr19076607pju.5.1672330942227;
        Thu, 29 Dec 2022 08:22:22 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a4fc200b00225d963fbc2sm8493338pjh.34.2022.12.29.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:21 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:21 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:49:50 PST (-0800)
Subject:     Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon semihost driver
In-Reply-To: <20221209150437.795918-1-bmeng@tinylab.org>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux@armlinux.org.uk, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng@tinylab.org
Message-ID: <mhng-93a78d3a-6372-4972-94fe-31607664bb67@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 09 Dec 2022 07:04:34 PST (-0800), bmeng@tinylab.org wrote:
>
> RISC-V semihosting spec [1] is built on top of the existing Arm one;
> we can add RISC-V earlycon semihost driver easily.
>
> This series refactors the existing driver a little bit, to move smh_putc()
> variants in respective arch's semihost.h, then we can implement RISC-V's
> version in the riscv arch directory.
>
> Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]
>
> Changes in v3:
> - add #ifdef in the header to prevent from multiple inclusion
> - add forward-declare struct uart_port
> - add a Link tag in the commit message
>
> Changes in v2:
> - new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"
> - Move the RISC-V implementation to semihost.h
>
> Bin Meng (3):
>   serial: earlycon-arm-semihost: Move smh_putc() variants in respective
>     arch's semihost.h
>   riscv: Implement semihost.h for earlycon semihost driver
>   serial: Rename earlycon semihost driver
>
>  arch/arm/include/asm/semihost.h               | 30 +++++++++++++++++++
>  arch/arm64/include/asm/semihost.h             | 24 +++++++++++++++
>  arch/riscv/include/asm/semihost.h             | 26 ++++++++++++++++
>  drivers/tty/serial/Kconfig                    | 14 ++++-----
>  drivers/tty/serial/Makefile                   |  2 +-
>  ...con-arm-semihost.c => earlycon-semihost.c} | 25 +---------------
>  6 files changed, 89 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm/include/asm/semihost.h
>  create mode 100644 arch/arm64/include/asm/semihost.h
>  create mode 100644 arch/riscv/include/asm/semihost.h
>  rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (57%)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
