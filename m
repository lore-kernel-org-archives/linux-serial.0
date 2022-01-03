Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30213C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jan 2022 13:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiACN5f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jan 2022 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiACN5f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jan 2022 08:57:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335AC061784
        for <linux-serial@vger.kernel.org>; Mon,  3 Jan 2022 05:57:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i22so70026403wrb.13
        for <linux-serial@vger.kernel.org>; Mon, 03 Jan 2022 05:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=s9ejwD9yhPYnVOGboXQSQzo2YN5XrVTHlsEd+M9MQHE=;
        b=wzBKbDAT5VRzexaEy8OyRR1b3uAcZJPFyF8c9jqe454LDDm16miT7mQScfNP/UTBQC
         xSztPVKdpGBwu5n0POlroE2LQFgpKKDQthfVRs1mlndwVnRGSSI8Zk/5zYPAw4ZwDwAC
         XZdSZzlOpk2vFwKj7e64oMMshnR99514Zn1b/vpmfDUx7nCkLcHICbZw+jfvPp86Vhd0
         hlnyoTlf8XjK41Lz5gXhvt4ogbsajxty3MlX2gOY6VKIeMStwKLOCQ4Vcd3zrBMrVEo6
         Q4NepwRPLWsoiu/F+c/jlSMJFRPW/yGNF67FchApLOQw4O22ad4NvW5LdL2N8YNjNIkx
         sNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=s9ejwD9yhPYnVOGboXQSQzo2YN5XrVTHlsEd+M9MQHE=;
        b=xcosgNle9VXqo92s38i7c+Jn6EeZOLSm+oij8C/Nv+6tAYbWM+F9Cap8/ENtf07zdQ
         PvZj6ndRJmD8ALI9Iml9AcfSaYUUHFEPIbOBthdpn+df1CgmYW/OZKBCXMc8PmmK2+mV
         aolInu7ZwBDgRHt3Y9w1GbhJtQ8+5CawwQgUvN4GgmKXDwIb5ylJLTDEtdtqmzRLxjdY
         0CSBzCZhPAXMLZ7yc9edqjcHb/Ey+hrzLm/gqfHWh6KOLPtYeQtek23MHiwwzZ3C1gXt
         iajR6foOYsHRP7Uu8aYRVAX5nCk2M/77HexeUcElOlerH3Ar2/RM17KsgTa/2S6psm3r
         K+oQ==
X-Gm-Message-State: AOAM533U46rA9Sm0N7tJ/PHlgX9mGmnYKZR3sKfJc9+r3JnKpKX1lW1E
        h6cHg/IFNzf6LDeLJp9gtouZFw==
X-Google-Smtp-Source: ABdhPJxghNu6jAsWSh6bWzVfWgWaf7nRMDXoUZYnhoeOqlJPnOE8PWM88b7d69tpC9s+zfplC2ZXqg==
X-Received: by 2002:adf:97c2:: with SMTP id t2mr39143444wrb.577.1641218253101;
        Mon, 03 Jan 2022 05:57:33 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y8sm38527606wrd.10.2022.01.03.05.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:57:32 -0800 (PST)
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com>
 <CAFBinCCL-QaeSRCLzfyNXcRQZ7YC1D85rP2y4OGkAjCmQEqGgQ@mail.gmail.com>
 <3e1e40aa-7865-0f7a-5772-e2ad96c8141d@amlogic.com>
 <CAFBinCB2nF0TwRE1uJ4UTB_avcqRBfOHR1CDSe29dB1o-YjEHQ@mail.gmail.com>
 <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate
 calculation is described using the common clock code. Also added S4 chip
 uart Compatible.
Date:   Mon, 03 Jan 2022 14:50:06 +0100
In-reply-to: <7278bace-a2b9-0cfc-55b3-c19311e3352e@amlogic.com>
Message-ID: <1jbl0s9b1w.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Sat 01 Jan 2022 at 21:30, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Martin,
>     Thank you very much for your reply.
>
> On 2021/12/31 23:32, Martin Blumenstingl wrote:
>> [ EXTERNAL EMAIL ]
>> On Fri, Dec 31, 2021 at 12:24 PM Yu Tu <yu.tu@amlogic.com> wrote:
>> [...]
>>>>>    static int meson_uart_request_port(struct uart_port *port)
>>>>>    {
>>>>> +       struct meson_uart_data *private_data =3D port->private_data;
>>>>> +       int ret;
>>>>> +
>>>>> +       ret =3D clk_prepare_enable(private_data->pclk);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       ret =3D clk_prepare_enable(private_data->baud_clk);
>>>>> +       if (ret) {
>>>>> +               clk_disable_unprepare(private_data->pclk);
>>>>> +               return ret;
>>>>> +       }
>>>> This code is from my original suggestion - and I had a doubt there
>>>> which I forgot to add as a comment originally:
>>>> Can you confirm that accessing the UART controller registers works
>>>> even when "pclk" is turned off?
>>>> I am asking this because the common clock framework can access the
>>>> clocks at any time.
>>>> And I have seen SoCs which would hang when trying to access a module's
>>>> registers while the module's pclk is turned off.
>>> On all meson platforms, the default pclk for all UART is turned on
>>> during the u-boot phase. When registering uart pclk in the kernel phase,
>>> the CLK_IGNORE_UNUSED flag is added. So the real shutdown is when the
>>> standby goes down, the parent clk shuts down.
>> Interesting, thanks for sharing that u-boot turns these clocks on.
>> Let's say someone wanted to make u-boot save power and turn off all
>> UART clocks except the one for uart_AO (where we typically connect the
>> serial console).
>> In that case the pclk of uart_C (just to choose an example here) is
>> turned off. Would there be a problem then accessing the registers of
>> uart_C before clk_prepare_enable is called?
> The way you describe it, it does hang. This would not be recommended on
> actual projects.
>
> At present, AmLogic chips are older than S4 Soc, and we have no way to de=
al
> with this problem. We have to tell customers not to use it in this way=E3=
=80=82
> Customers rarely use it in real projects.On the S4 SOC we will use a clock
> like the UART pclk to control the shutdown using two registers, one safe
> (need to operate in EL3) and one normal (EL1). It will only be closed if
> both registers are closed. This mainly prevents misoperation.
>
> With your experience, I'd like to know how you deal with this kind of
> problem.

Relying on the CLK_IGNORE_UNUSED and the boot loader is unsafe.
As Martin is suggesting, the driver must ensure pclk is on before
touching any register.

This was done in the probe before in probe before your change which
seems safe but maybe not optimal.

Again, If you wish to optimize that, please do so in another dedicated
change so we can discuss it and make sure it is still safe

>> [...]
>>>>>           port->fifosize =3D 64;
>>>> commit 27d44e05d7b85d ("tty: serial: meson: retrieve port FIFO size
>>>> from DT") [0] from May 2021 has changed this line to:
>>>>     port->fifosize =3D fifosize;
>>>> So your patch currently does not apply to linux-next (or even Linus'
>>>> mainline tree).
>>>>
>>> So do I need to wait for [0] patch merged before I can continue to make
>>> changes ?
>> These changes are already merged.
>>=20
>>> What can I do before?
>> You should base your changes on top of the tty.git/tty-next branch [1]
>> where Greg (the maintainer of this tree) will pick up the patches once
>> they are good (got enough Acked-by/Reviewed-by, etc.).
>> I suspect that you based your changes on an older or stable kernel
>> version (let's say 5.10). New functionality should always get into the
>> -next tree where various auto-build robots will compile-test the
>> changes and we even have Kernel CI where changes are tested on real
>> hardware (BayLibre even maintains Amlogic boards in their Kernel CI
>> labs). Let's say Amlogic updates to Linux 5.17 next year then the
>> patches are already included in that kernel version - instead of being
>> only available in Linux 5.10.
>>=20
> I'm sorry, I did branch confirm there was a mistake, I have corrected.
>> Best regards,
>> Martin
>>=20
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?=
h=3Dtty-next
>>=20

