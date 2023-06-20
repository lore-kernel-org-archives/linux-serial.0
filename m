Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3AAEB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjFTPeY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFTPeX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 11:34:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919099
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 08:34:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b474dac685so39306311fa.3
        for <linux-serial@vger.kernel.org>; Tue, 20 Jun 2023 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275258; x=1689867258;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/KBk4MEJMYZgClXUS8ICwIAOz/V2ZoCxcaeujLubZ8=;
        b=XEwC7+ND5zwQ2LAeNDFA9tSf473qVu4kRiNFkwTSZ78Z8fi7a1MitrGcUHVA7piiFJ
         ZK0YdpO1D0qIWmJBUKd+C0TPiCIk1ZDxUqRUGt/ZSReinozj0faLE4L9lagNQKsaLE0h
         9B47vMvqJ7KjpV8BLDdIX3Y+8Nc2KbqAqraX+1/EZyVvLqh7P8lt2z9v34HIr3+096Ft
         fyAO9Nj3ZZxIRQaPIlL0WgOw17fxrBYoOLSxO/+nlrAxLbwniupaaPZujv2eMkhlNsVW
         vzxBD+nRreoMR1SrH0YqON/VYhT4yFHXSpFxfaNLxdZnRNAsSf/SJj9J9/gNRlQ5f6Bj
         b2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275258; x=1689867258;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/KBk4MEJMYZgClXUS8ICwIAOz/V2ZoCxcaeujLubZ8=;
        b=PdLSWW2tgXZD/ftIT1whpH3cUP8mfuDoxvVdO0FDWfg8Kkv/omdjUJl2HR3gAG0dc3
         m0uoHpJIgGUQuE9tdpwYbd2fS246W2vFGANV1Gr+zpeMeiMqHmIiT1ItIzmFGVJOFW5l
         C3E4UzhgnfXnf8L2PXKu0OvlL6UmdkSDw7eY5d0PWYdEq7BHcUu7mp+dj9+uI8Nb8QF2
         fIgKlF0K3McDqhiyTFgaTmD9F+uepvNuasInzGrrBYlN6BLTAM5X/kqazc9HVVhdrj+l
         2vpDUP4JoDvkQHV9gqo6JrrXBGgOq4zmNC811bFiaS0jg/zl57hW7PA+zyJYWrv0m6ri
         dKqg==
X-Gm-Message-State: AC+VfDx05072MCUXLEzLWTrxo2JssneZGhhqxj/hXp1FyhIkvD0Ju+xy
        +X1ulNQ0l3S+jNP4CdPSKRI=
X-Google-Smtp-Source: ACHHUZ7yts7ERKqH2CeYz0vMGC3lU/Ml5zeYPU3j2KIJz+Ew7NtmPYqSfUlZqMiOxe87w/iN5TICjw==
X-Received: by 2002:a2e:9648:0:b0:2b5:7ecc:bb0d with SMTP id z8-20020a2e9648000000b002b57eccbb0dmr1506671ljh.47.1687275257882;
        Tue, 20 Jun 2023 08:34:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h9-20020a2e9009000000b002b326e7e76csm453125ljg.64.2023.06.20.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:34:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
References: <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
        <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
        <87mt3ynsa7.fsf@osv.gnss.ru>
        <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
        <87sfcy8ncu.fsf@osv.gnss.ru>
        <534ac8db-ae8f-1ea3-9aa9-2105db7f7a52@i2se.com>
        <203ce87f-2898-eb10-2f8c-f237859d75e6@leemhuis.info>
        <87ttw2vnn0.fsf@osv.gnss.ru>
        <d1b6209d-a174-406a-cc81-86b391940c0c@i2se.com>
        <3853881c-976f-dadc-b64b-4ffd8cc88cf0@leemhuis.info>
        <2023062046-jersey-facecloth-7a5d@gregkh>
Date:   Tue, 20 Jun 2023 18:34:16 +0300
In-Reply-To: <2023062046-jersey-facecloth-7a5d@gregkh> (Greg Kroah-Hartman's
        message of "Tue, 20 Jun 2023 16:59:18 +0200")
Message-ID: <87r0q6407b.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jun 20, 2023 at 04:47:10PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 24.05.23 15:07, Stefan Wahren wrote:
>> > 
>> > Am 23.05.23 um 21:44 schrieb Sergey Organov:
>> >> "Linux regression tracking (Thorsten Leemhuis)"
>> >> <regressions@leemhuis.info> writes:
>> >>
>> >> Solving this would need to identify the cause of interrupts being
>> >> disabled for prolonged times, and nobody volunteered to investigate this
>> >> further. One suspect, the Linux serial console, has been likely excluded
>> >> already though, as not actually being in use for printk() output.
>> >>
>> > 
>> > I don't think that we can exclude the serial console as a whole, i never
>> > made such a observation. But at least we can exclude kernel logging on
>> > the debug UART.
>> 
>> Stefan, just wondering: was this ever addressed upstream? I assume it's
>> not, just wanted to be sure.
>> 
>> I'm a bit unsure what to do with this and consider asking Greg for
>> advice, as he applied the patch. On one hand it's *IMHO* clearly a
>> regression (but for the record,  some people involved in the discussion
>> claim it's not). OTOH the culprit was applied more than a year ago now,
>> so reverting it might cause more trouble than it's worth at this point,
>> as that could lead to regressions for other users.
>
> I'll be glad to revert this, but for some reason I thought that someone
> was working on a "real fix" here.  Stefan, is that not the case?

As far as I understand, the "real fix" is to be where interrupts are
being disabled for prolonged times in given specific kernel build, and
nobody is looking for that place.

In other words, I'm one who thinks the commit in question is not a
regression per se, so I'm not sure it should be reverted.

Thanks,
Sergey Organov
