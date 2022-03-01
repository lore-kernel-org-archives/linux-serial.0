Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF00C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 08:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiCAIuh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiCAIug (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 03:50:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954C89332
        for <linux-serial@vger.kernel.org>; Tue,  1 Mar 2022 00:49:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s24so21026933edr.5
        for <linux-serial@vger.kernel.org>; Tue, 01 Mar 2022 00:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=XXHAzHSUKx1FZRpzOVh0FkOoc+KpTYgeqdRYpbFwNrY=;
        b=F+esdrn2u/7IDUUa1QkHWhRVrp8WFnBvGjuqIGJHuagwFCGXLVP7vSZU2U3+wERsQT
         fWvJ+xVv29r9Vrmb9tn5rHED5cU1X8tK2CqfvV6RM7ezsNCdpa2It3cm4FlFR47szVMA
         eCVvAxQXUxdGb0T/KPMTEqz/zILzvrx4TfoVmIeR9sr3xkFKjk0FSai0zNLjIqNh5sn+
         fN7DjLfFSGC311dIGwM3xCmkbA+CJ1cOM9qaZ/yG4C4X3O31AX151x7loCW6uKWMF9W6
         WUL5RqWHhqfJFCCTDtQlIVQP7aw4ks1mo9jMmZArFpwcyWc6pxYrEW01WCNfjPO6TnlG
         /IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=XXHAzHSUKx1FZRpzOVh0FkOoc+KpTYgeqdRYpbFwNrY=;
        b=ROOglUYJBr0tvHbHgp0KFc8LN9dOaEjJopdOmHNCZa8u6HFObD4EjHTeMPIVOJHVZa
         3O+e5lfXlGqDp0ovfaFjOleNj9TGWa1/MswTGLdjGMRy6jz07v8MZsbtWiw4+FQJ9gjT
         gcqEsUwAPtCj/XtFubccFJycC60QOgMMM9gh3Ym0lR3Rk9mrjchudCP/niQTJRG5cCkq
         i82g8aezz+a3szhv5PfQVa1Z0CZv5e+mgW5PLM1UMUZYtQxMLtQ69DXhjT6vHI1kn4w3
         ukJU4VHXQoU4skhtpxNGBriIpx8AEubK0M21xV23Hrh09IEednQnMdwya9zioni9GQMp
         DiTg==
X-Gm-Message-State: AOAM530rK8RjJAydoIqm3SN4nWXrnVZYnD/K3h1ttviUcHFFQKFu5nAh
        dJFBOC5bJuTnlBpHFW/DiI2qIg==
X-Google-Smtp-Source: ABdhPJwwv92nJBUIPZ3wtAe+ZLpDEefHhE/W3cCSrhFs9ZkbcU/booLmLagFYpQio8mA18rbBXJFSQ==
X-Received: by 2002:a05:6402:5207:b0:412:806b:6424 with SMTP id s7-20020a056402520700b00412806b6424mr23434103edd.131.1646124592564;
        Tue, 01 Mar 2022 00:49:52 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id d2-20020a50cf42000000b004135b6eef60sm6931187edk.94.2022.03.01.00.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:49:52 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <1j8rtvxnkv.fsf@starbuckisacylon.baylibre.com>
 <d0da38f1-72c1-d111-2d0d-2bfa2faf1a1d@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Date:   Tue, 01 Mar 2022 09:36:07 +0100
In-reply-to: <d0da38f1-72c1-d111-2d0d-2bfa2faf1a1d@amlogic.com>
Message-ID: <1jilsyvyz9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Tue 01 Mar 2022 at 13:54, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
>
> On 2022/2/28 18:59, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> Using the common Clock code to describe the UART baud rate
>>> clock makes it easier for the UART driver to be compatible
>>> with the baud rate requirements of the UART IP on different
>>> meson chips. Add Meson S4 SoC compatible.
>>>
>>> The test method:
>>> Start the console and run the following commands in turn:
>>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>>>
>>> Since most SoCs are too old, I was able to find all the platforms myself
>>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
>>> G12A and S4.
>> GXL based board are still very common an easy to come by.
>> I'm quite surprised that you are unable to test on this SoC family
> The fact of the matter is that the S4 is our end-2020 chip, the G12A is
> five years old, and the GXL is seven years old. If you must ask for a 
> test, I will report this problem to the leadership to coordinate resources.

The age of the SoC is irrelevant. SoCs don't get deprecated based on age
in mainline. It is not just GXL, same goes for meson8.

These SoCs are actively used. Boards with these SoCs are still sold and
easily available. See the VIM1 or the Libretech boards.

Breaking things for the the users of these SoCs is not acceptable.
So yes, looking at your series, I strongly recommend you do more tests.

>> 
>>>
>>> Yu Tu (6):
>>>    tty: serial: meson: Move request the register region to probe
>>>    tty: serial: meson: Use devm_ioremap_resource to get register mapped
>>>      memory
>>>    tty: serial: meson: Describes the calculation of the UART baud rate
>>>      clock using a clock frame
>>>    tty: serial: meson: Make some bit of the REG5 register writable
>>>    tty: serial: meson: The system stuck when you run the stty command on
>>>      the console to change the baud rate
>>>    tty: serial: meson: Added S4 SOC compatibility
>>>
>>> V6 -> V7: To solve the system stuck when you run the stty command on
>>> the console to change the baud rate.
>>> V5 -> V6: Change error format as discussed in the email.
>>> V4 -> V5: Change error format.
>>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>>> in the email.
>>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
>>> the DTS before it can be deleted
>>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
>>> discussed in the email
>>>
>>> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
>>>
>>>   drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>>>   1 file changed, 154 insertions(+), 67 deletions(-)
>>>
>>>
>>> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8
>> 

