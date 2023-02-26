Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A72C64ED6
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 13:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBZNpT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZNpS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 08:45:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79827CDC9
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 05:45:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b10so3847254ljr.0
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JN7moP2awsjlsG1DRZ34+/W1vrYY2zM9tlCpMsaWKeA=;
        b=brGfVlit8D6j28/QIfydBqY4yGkKBcfq666wdtlD0IhIGF0TRAkkJInXK6qGpG+X0I
         ikapS+Kqu4Svh0W2swiiioqnSs7oiv20aXvC2ZbaxWXm9TtCdkAa/UUi3afx0O1lLCMi
         Mdek/HWFhaVUkrmHGCLvsg6K12HddmvDqTv8d7W1tBTB+akukNCifApX3U0glED76Fcj
         Bt04vkNVJ3kW/faEa2eXJ/QdePJ97btxzNxUuAkguTaHgpH2M9qzc0SQLM+uPnrc01jZ
         YiAhrNeIwXgcyD+Hlv8LZT3aN/TSdR7yEGdDeGjUvrD6oR6jMidPfn+eQGCbjIwi9gLR
         7N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN7moP2awsjlsG1DRZ34+/W1vrYY2zM9tlCpMsaWKeA=;
        b=hsCopkTwniI2dqcJJJzBQVEuWdeKY9SJCrXL64UD9VlODhm8nRGI2c3M74JcdxLtYR
         q9gddmWOk3DkuERvImAb3oQ7qufiDHFYsgYMOT4L2u7G45b3eUTjKNdVaPxDNA3gtw61
         LpPfJxbECPySH/3d4/CBBtkTm/IBgYTUmo9sDJrXn9KvfizuLzwgV5wU32vyzRR94sIU
         VPFDUiEQQO1GvDPZGyOZaxLuAMnvov8ugy7llpiq0xCMbfE0kzarkvEAe7LY39i7WMp4
         gxcbjua65gdEDGVt5m4P4EIPunIka9YTu3xelZftpUaGE89YpGUmsXso0Fz/2jKg0A+O
         NkbA==
X-Gm-Message-State: AO0yUKXsKrAMBnxUgMyLrAgDHsSOUXSYTN6XQ76/tPMSjAENTGJkuUm/
        5ipHVO6ZX83QsXbzzDGVL8Q=
X-Google-Smtp-Source: AK7set/t/0K5QEwIP/T3c/ZbbeXNoZLsXoMg7aLC7Q1QAzA596qEZUK+p7wXS95ZdD6UPNM9vPwUlA==
X-Received: by 2002:a2e:700e:0:b0:283:4310:da75 with SMTP id l14-20020a2e700e000000b002834310da75mr7315085ljc.39.1677419115522;
        Sun, 26 Feb 2023 05:45:15 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea44b000000b002935632b3f8sm416208ljn.14.2023.02.26.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 05:45:14 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Gerz Burak LCPF-CH <Burak.Gerz@mt.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Manuel Traut <manut@mecka.net>,
        Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Subject: Re: UART RX losing bytes
References: <DB3PR0302MB8966B89FA30528D5C0643259E7AE9@DB3PR0302MB8966.eurprd03.prod.outlook.com>
Date:   Sun, 26 Feb 2023 16:45:13 +0300
In-Reply-To: <DB3PR0302MB8966B89FA30528D5C0643259E7AE9@DB3PR0302MB8966.eurprd03.prod.outlook.com>
        (Gerz Burak's message of "Sun, 26 Feb 2023 10:47:35 +0000")
Message-ID: <87h6v8levq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

It reminds me about this:

https://marc.info/?l=linux-serial&m=166479501704202&w=2

HTH,
-- Sergey

Gerz Burak LCPF-CH <Burak.Gerz@mt.com> writes:

> Hello,
>
> v6.1.14 on a Phytec phyBoard Segin i.MX 6ULL based board [0] is losing bytes on UART RX.
> imx_v6_v7_defconfig was used.
>
> Minimalistic test to reproduce the issue:
>
> 1) Connect imx6ull UART with another machine
> 2) imx6ull$ stty -F /dev/ttymxc0 115200 raw; cat /dev/ttymcx0
> 3) othermachine$ stty -F /dev/USB0 115200 raw; 
>     echo "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/&" > /dev/ttyUSB0
>
> Expected result:
> imx6ull: 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/&
>
> Seen result (Many times, not always):
> imx6ull: 1234567890abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/&
> or
> imx6ull: 1234567890abcdefghijklmnopqrstuvBCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/&
> or
> ...
>
> Setting scaling_governor to performance seems to be a workaround for this problem - but:
> We are normally using the PREMPT_RT patch [1], and with this workaround bytes will still be lost
>
> Any hints how to track this down further?
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts?h=v6.1.14 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v6.1.12-rt7
