Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB90C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiERMZA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiERMY7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 08:24:59 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BFB41E8
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 05:24:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so1188310otr.9
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sb7bg/s9/N5CWFYTGhhWzwAaU+Kt6rFIVSTuHr1wPxg=;
        b=ciAanlZP7Dm2swICrwVKobgfunmFm+V99Lej7bRS2lrIQYxaDVlbraYorj0Yx7e81a
         utKHIkhDWguI7C5klBnFYkmZDfin2+M9LjytKVtngsNZd+Oh5887J4slQSS/dJMOSP4j
         KZnEOKrjPA4EPIz0nRYvt+NR+xfd1W7ho6/tZG6cSnp/uZjcbGsaITwvlbLe6herW6w8
         dwWulwRlZYfk/TZx8BaqhFwSglZWoM+p6A3Uurtd9r1ui+kLR7L7sSXFNem0Hwx7H7QC
         UzsYLc5QS78DDTfhxpkl81s29YyKqx26GO8gkZG1lXmXw/WqVT3h2UdWzv41zRpaL/PS
         FNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb7bg/s9/N5CWFYTGhhWzwAaU+Kt6rFIVSTuHr1wPxg=;
        b=r82a8/VMVJU5tDkANAsBcGfPQZTP6Li82lhbI4iNtH8VtEFDeRmh9NEmnQE73DJB9U
         pE2hzxM4nxzZVWVfmxdal5Ipl876Zv9RygEtONBBclFXt4mfXxjlIvZFBfgAKizmijLR
         Tjhvr+4ntAm7grmcFQFLkULIgLKCWu4HDbkrEIBRtRyBa6zIDzREaTmEsEgtdwV3j6xi
         E4/0ifov9za82T/JNBDwuvp3PQXNJZNnP2daMPxYil4Nv7MpI+q7YJCXJ3FWq9cTZAoh
         S2Z4DrgA01PqV+5AV/3Ax3OuznTmfdM15+QPLA6lvZkj2pqrBJB95I/bG9twqDn1gZf+
         lSIQ==
X-Gm-Message-State: AOAM533c6rZ9AJbFm1mOYd+SJ7opkI3yNGEjz91L1aM9U7qCcUlCp/6V
        QrOIRmDNtCHIt6h8N4RF069loo+KYgYOvDNgeG3rQYLDrFc=
X-Google-Smtp-Source: ABdhPJzJ/A7zgOpn2XXpVuQQo9rDwf46W+CZiyG5Y9wCmQ1ApB4zIQnTkGwIOvSNmUUeKDc44kHKaLya2BBBMjDtqJg=
X-Received: by 2002:a9d:f0a:0:b0:606:1e5e:8bc7 with SMTP id
 10-20020a9d0f0a000000b006061e5e8bc7mr9911131ott.258.1652876695219; Wed, 18
 May 2022 05:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
 <YoTfou30lNY3tW6l@kroah.com>
In-Reply-To: <YoTfou30lNY3tW6l@kroah.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 18 May 2022 14:24:43 +0200
Message-ID: <CAAfyv35CPtn-WBRPnaEK_PV_XWq0UrZURSsYEtsdAcWFfCW9Ag@mail.gmail.com>
Subject: Re: custom serial driver node not created
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 18, 2022 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 18, 2022 at 01:41:18PM +0200, Belisko Marek wrote:
> > Hello,
> >
> > I'm writing serial tty driver (it's SPI/UART converter) and I get
> > inspired by this driver:
> > https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/tty/serial/sc16is7xx.c
> >
> > I have driver probed and also added port to driver which I see in console:
> > [ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
> > is a test_driver
> >
> > so I should see it in /dev/ttyTX0 but it seems node is not created.
> > Udev is running on a platform.
> > Any ideas what can cause this?
>
> Without seeing the code itself, it's almost impossible to guess.
>
> Also note that udev does not create device nodes (hasn't for over a
> decade).  devtmpfs in the kernel does that, udev just helps with
> managing the permissions of created nodes if needed.
OK thanks for clarification.
>
> And why did you pick the ttyTX name?  That's already reserved for that
> driver, you should use a new one, right?
I've should used also others like ttyTEST but result was same.
>
> And what hardware are you writing this driver for that we don't already
> have a driver for it?
I'm writing a driver for the following model: Linux CPU is connected
with SPI with another CPU (Cortex M3) and this other CPU performs UART
handling based on data which comes over SPI. I would like to expose
Cortex M3 UARTS on linux as tty ports so it will act as standar serial
device.

Code can be found here: https://pastebin.com/6qpUw2Jt


Thanks,

marek
>
> thanks,
>
> greg k-h
