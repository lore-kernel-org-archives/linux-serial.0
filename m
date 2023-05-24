Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC92C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjEXNpS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjEXNpR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 09:45:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790793
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 06:45:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso949819e87.3
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684935914; x=1687527914;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vNTBDNCFxlyOPIHK7N6QjslY8lXFcmfSu2CofEg0/g=;
        b=E/t6lRm27zPyOAY8hPIZhDPCMxxoMQdzRMhIxmGTfO7SMmilUoon0Y6yyyZAJZNV4r
         AmIkEDQat94l8OcFbsFK32uJDBh6rnlzXivcQxzwZxhGZGIPIJvxR6p9g8VwKQcnjDUC
         1C82077409HcABjTreZ4nv88cC/8SvRRrHesKNgd6zem3RtTzfPeq3ZqVArh/NZxomx4
         kFZmurxVcCMueAXR8kSHgTxhxurc3M9H6FgTjN6OmFrQgAAo7wzHIJHgxwFMPGnbJKCz
         MWdyEm2LkEywaalVJynBdt7ZGLuddZSPRZNTDk7hmep6s4FwgRicxsIIGrq4B15N+ZdN
         lLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684935914; x=1687527914;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vNTBDNCFxlyOPIHK7N6QjslY8lXFcmfSu2CofEg0/g=;
        b=FNWP+XN9XDBI8lbSyb0oslWYK45CQSjFCfcOgNhI7vw82949JKhdag+E1pI5J8FJDF
         WJtHGPr3ijiwM+DZlajMCC3KEDzzE+5jORpjofzg7k0wwfR/aIrk0IVYtJwxr2Lpfyyb
         visGIKClg5iXW1Q1XvC/oOH/By7pQ7GhOiaJXULw1xKFZ6VyxzyQrq2EARMDDqh0LSVP
         yc7tFTGM2FaSC6cH31SkFdZO+vwfm0dAs1li6X7DnSA1o7K615ost9lvJ6UvRspG6Sl5
         GQLHh4YuFD8JlVziFbHpTFtplq9BEegocs+J5FgJMTYxqSm/Cvvhs5arg5G12hnCN0sb
         I3UQ==
X-Gm-Message-State: AC+VfDyXVSKetbtuYvcFYdme/RzE9mWD4u4RFk3szsGHjwOSmFfIWcyQ
        brvb6w9I5i9jXWFjMyvpBRI=
X-Google-Smtp-Source: ACHHUZ5L+LyhyYXUgzNzp/B+19/VRhu9Ie1LpX9uE3Lr8bLRJoO6U89ChQIyEmZWXnd7vqjP/ZuBzw==
X-Received: by 2002:ac2:5581:0:b0:4f3:aaf0:f672 with SMTP id v1-20020ac25581000000b004f3aaf0f672mr6675180lfg.45.1684935912363;
        Wed, 24 May 2023 06:45:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e26-20020a2e8eda000000b002adadd0c8c8sm2087167ljl.33.2023.05.24.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 06:45:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
        <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
        <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
        <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
        <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
        <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
        <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
        <87mt3ynsa7.fsf@osv.gnss.ru>
        <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
        <87sfcy8ncu.fsf@osv.gnss.ru>
        <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
        <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
        <87ttw2vnn0.fsf@osv.gnss.ru>
        <80207a43-6047-4493-da5d-8bd87ef74551@leemhuis.info>
Date:   Wed, 24 May 2023 16:45:10 +0300
In-Reply-To: <80207a43-6047-4493-da5d-8bd87ef74551@leemhuis.info> (Thorsten
        Leemhuis's message of "Wed, 24 May 2023 12:48:51 +0200")
Message-ID: <87a5xtyhax.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 23.05.23 21:44, Sergey Organov wrote:
>> "Linux regression tracking (Thorsten Leemhuis)"
>> <regressions@leemhuis.info> writes:
>> 
>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>> for once, to make this easily accessible to everyone.
>>>
>>> Stefan, was this regression ever solved? It doesn't look like it, but
>>> maybe I'm missing something.
>>>
>>> If it wasn't solved: what needs to be done to get this rolling again?
>> 
>> Not Stefan,
>
> Thx to both you and Stefan for the update.
>
>> but as far as I can tell, the problem is that on Stefan's
>> build the kernel has rather large periods of interrupts being disabled,
>> so any attempt to decrease IRQs frequency from UART by raising FIFO IRQ
>> threshold causes "regression" that manifests itself as missing
>> characters on receive. I'm not sure if it's tuning FIFO level that is in
>> fact a regression in this case.
>
> Not totally sure, but I guess Linus stance in this case would be along
> the lines of "commit 7a637784d517 made an existing issue worse; either
> the people involved in it fix it, or we revert that commit[1], as it's
> causing a regression". At least we *iirc* had situations he handled like
> that.

From Stefan's investigations it follows that the kernel has interrupts
disabled for about 2.5 milliseconds! If that's an acceptable value for
Linux kernel, then the commit in question is a regression. If not, and
in my opinion that's too high a number, then it's not a regression at
all, but rather a manifestation of a problem (bug?) elsewhere.

>
> [1] of course unless a revert would cause regressions for others --
> which i guess might be the case here, as that was added in 5.18 already.
> So let's not bring Linus in.
>
>> Solving this would need to identify the cause of interrupts being
>> disabled for prolonged times, and nobody volunteered to investigate this
>> further. 
>
> Well, Stefan kind of did to do so in his spare time, but asked for
> "clear instructions to investigate this further". Could you maybe
> provide those? If not: who could?

There should be somebody who is familiar with methods to isolate the
victim of abnormal interrupts latencies, but I'm not the one, sorry.

Thanks,
-- Sergey Organov
