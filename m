Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E2C4320E
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309A36104F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 07:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhHEHuM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:50:12 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38700 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhHEHuL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 03:50:11 -0400
Received: by mail-ed1-f52.google.com with SMTP id y7so7062533eda.5;
        Thu, 05 Aug 2021 00:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9imV97Ad6WYuvPH2ugJvx2YUE8x6OeUHcu+XGnBPGbQ=;
        b=r8s3MRApQfsvCWQi29fqXPwI0mJaxcZ6HaH20OtkTdK1ItJ2V7AGQvJ9S2iqGpDZ/f
         dvw1+j4Q1x21yhtOnzw4RyaogB0BhCX1A8NXSguzTq09qLL2bq/sMo7WYcl943RkC/JF
         pzKodynCHZUzA/xJD47+YRuBpKO5/v2Iuzqx/Xc4lQWSxXFVcqwV71Cl33R9FBr7zr36
         GOkjLw30+E4NFXU5TPOcP39zSOzZIzpmaXN27z/YVXczNGmlTxn5kARbVqR73F9DFkuy
         h4z0jVgJ5jmUhpIPCWk0h6GU5c2xBbBT6njiZvcKBsVE/6xao9dMVAsXB4vYVvhbNrve
         +6rA==
X-Gm-Message-State: AOAM533j30jqx7OPf+fTlW/bL0wq37JnYRaKV5d8HtDK2WRfx9SmszCs
        vytRBBuPAKWT1VKdsDuiJys=
X-Google-Smtp-Source: ABdhPJy5mfk+ekbYHHyshhd4t5KAiMoCWiLkn4OrTESc6Ilms5hyKTlFZ+sW/7yEuB9zubx6zvwdaw==
X-Received: by 2002:a05:6402:270f:: with SMTP id y15mr4835943edd.65.1628149795612;
        Thu, 05 Aug 2021 00:49:55 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.googlemail.com with ESMTPSA id h19sm1934341edt.87.2021.08.05.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:49:54 -0700 (PDT)
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-9-clin@suse.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add an entry for NXP S32G2 boards
Message-ID: <32310c2a-9800-8b04-b6ac-d8ada044c0f8@kernel.org>
Date:   Thu, 5 Aug 2021 09:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-9-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05/08/2021 08:54, Chester Lin wrote:
> Add a new entry for the maintenance of NXP S32G2 DT files.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36aee8517ab0..3c6ba6cefd8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2281,6 +2281,12 @@ F:	arch/arm/boot/dts/nuvoton-wpcm450*
>  F:	arch/arm/mach-npcm/wpcm450.c
>  F:	drivers/*/*wpcm*
>  
> +ARM/NXP S32G2 ARCHITECTURE
> +M:	Chester Lin <clin@suse.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm64/boot/dts/freescale/s32g2*

I support the idea of sub-sub-architecture maintainers but I think idea
of in-file addresses was preferred:
https://lore.kernel.org/lkml/20200830122922.3884-1-shawnguo@kernel.org/


Best regards,
Krzysztof
