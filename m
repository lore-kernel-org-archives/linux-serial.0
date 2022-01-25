Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C50C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 25 Jan 2022 10:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbiAYKU2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbiAYKRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jan 2022 05:17:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F28C06175A
        for <linux-serial@vger.kernel.org>; Tue, 25 Jan 2022 02:17:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id h133so97279wmh.5
        for <linux-serial@vger.kernel.org>; Tue, 25 Jan 2022 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PxE0IEEXwYbByIBbdhrPsVtZPxKp3eu1XNz2U1gQ29w=;
        b=QAOGxIUPb7iOXKQwl5Etdt4Tq9vpKg0neIg5jkVHEryR2jv1/SH+OUBoOtniql8XLU
         bJRaZem3X138H36NWoe3xTXSqywneJrnLSF/BTgY4lqVlUJGaz49DruRYgYMB+6/EKdW
         oNJIPR8ZEVeS8rPqM2R/XFudP+XqHmn4Dq/TdZ4Uya+7n2koQOrF7dUaaK3CGfRDA54i
         QZZ8TLgBuv38nKZrbi9MkWwEutlG1vM6XC8xUIBiqCLLNDCQCxVjDCvOAD3woouK//jc
         wcqmTBbZXluxRq/N7govb4xBVJDSj67l60eYWdeAiqymGA5+XMa6RWuJUYhIfh7JDGY2
         QhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PxE0IEEXwYbByIBbdhrPsVtZPxKp3eu1XNz2U1gQ29w=;
        b=ttPgyjM2crG3qYBYRF8R/9QS+uDoFEC9y+VZevVtKOXpPIkkHFbLC0i3MFUrVWsJP1
         BaUpFvISna4Rs3XYFbBdPHazmNjSweMAK3Bj+97714mEzMOmVFsCUyxORcths9f9LsGv
         XxfH4RFPuhf5uAx+dE15cP+fqtRcKtClSCdjc/PGVmc2t6+arJCbSpox3O9nMyVPj2s6
         K7/L7a5S5bHRzIeff2dcNPHJMzCsFiS+gPQQykSMKSJ4dn25LjeOuGqRp28s0U85ve7V
         BSp5l8pN2JCG7XmI1TY5cugxWxf3k+KPFu80lZBtMWNz+4Xw1V0D7wT2zk18TlkCBFyh
         hjXg==
X-Gm-Message-State: AOAM533URo7BqBUXd7xkwECZCN/ALSB3nWz/uYyUsKLcuVFI4C8rCxCU
        GyfqDSgL+0zOo8CXYF9/c6U=
X-Google-Smtp-Source: ABdhPJz5QgmhC9tWOZfy0I941uQ+DZCNoiI1Et9xLp7NbZgWgZVWGZyl5Id19vDGhfAKDErUU1jl1w==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr2201479wmc.89.1643105859392;
        Tue, 25 Jan 2022 02:17:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id l10sm6913984wry.67.2022.01.25.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 02:17:38 -0800 (PST)
Message-ID: <7b341732-d8ce-6ccd-34d3-3d706ba0faf3@gmail.com>
Date:   Tue, 25 Jan 2022 11:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
Content-Language: fr-FR
To:     Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
 <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
 <CAJ+vNU27VQR6Bwp_KtYLubr_CBd30Ewgm6xxZtPiVXOFw8sEqg@mail.gmail.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <CAJ+vNU27VQR6Bwp_KtYLubr_CBd30Ewgm6xxZtPiVXOFw8sEqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org




Le 25/01/2022 à 00:56, Tim Harvey a écrit :
> On Thu, Jan 13, 2022 at 10:19 PM Tomasz Moń <tomasz.mon@camlingroup.com> wrote:
>>
>> On 14.01.2022 04:08, Tim Harvey wrote:
>>> So I believe in order to support using gpios for rts/cts in the imx
>>> uart driver I must find the right place to call imx_uart_rts_active
>>> and imx_uart_rts_inactive when the FIFO is not full and full
>>> respectively. I'm not that familiar with the Linux uart driver
>>> framework - am I on the right track and if so any ideas where this is
>>> best done?
>>
>> It is not really the driver (and thus FIFO level), but rather the amount
>> of free space in tty buffer (checked by Line Discipline workqueue) that
>> determines when to throttle (set RTS inactive). This mostly works fine,
>> but fails [1] when the RX interrupt frequency is too high [2].
>>
>> The throttle/unthrottle request, when termios CRTSCTS is set, is seen by
>> the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_RTS
>> bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() only
>> controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.
>>
>> To support your case you would most likely have to add the gpio handling
>> in imx_uart_set_mctrl(). However, I am unaware what other issues you
>> might encounter (i.e. if it is not done there yet simply because nobody
>> had that use case or if there is some deeper problem).
>>
>> [1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd250478313@camlingroup.com/
>> [2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.mon@camlingroup.com/
>>
>> Best Regards,
>> Tomasz Mon
>>
> 
> Tomasz,
> 
> Thanks for the info. Currently imx_uart_set_mctrl calls mctrl_gpio_set
> which does toggle the rts-gpio per mctrl & TIOCM_RTS.
> 
> Also, there's something in
> Documentation/devicetree/bindings/serial/serial.yaml that puzzles me:
> 
> if:
>    required:
>      - uart-has-rtscts
> then:
>    properties:
>      cts-gpios: false
>      rts-gpios: false
> 
> That would seem to indicate to me that if you define 'uart-has-rtscts'
> you should not be defining 'cts-gpios' or 'rts-gpios' but I found that
> when I omitted 'uart-has-rtscts' I could no longer enable hardware
> flow control. Is my understanding of the yaml wrong or is this just
> not accurate?
Yes, it seems that you're right
cf older textual description :
https://elixir.bootlin.com/linux/v4.20.17/source/Documentation/devicetree/bindings/serial/serial.txt

Regards,
Richard
