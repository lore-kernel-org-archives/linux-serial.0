Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B80C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 12:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiERMsj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbiERMrb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 08:47:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97014ECFD
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 05:47:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q8so2450714oif.13
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6SEi9Ez+z5VtbUYDDVMLwcEedUg7a3Q6tKfoBAQUSk=;
        b=gNYs5HdAVPPYYwqnybmrf3yWTYCuOoFzXsy+KN2Ccz9cLlPhZ+cCWkOLPBHXI74Chx
         MRK/hgceClPRizKswwO5U9ZjRIBR6o1CNPHyDN9ICcv7A9+ZOkw8XUQbcPljIHGfSRj3
         ZABzxYX83iTxf9+5sXK49xGWf2R0t3NggH1RTi0mo4LoCxg+UokrvEvBXY/d/X7kiJnA
         Xv7S+GUkzs/XD/wMWSUxtW4wu1QEWJhKSLzD+O0I1JiMFH9bO20W00RCj+3GROF6iBnm
         iNgB8ZsfNFfUTxcqOctBnjwshuTuJheYguL7NlrnRQ2eYVT8GD2KwPYC9LIfPG8lE1UJ
         eW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6SEi9Ez+z5VtbUYDDVMLwcEedUg7a3Q6tKfoBAQUSk=;
        b=iBw+kEDj2Igqd8Q8rhwG/dcUTFJiogqrqZ8coJX9b6dekLBfBpTrViO5nM+G+opXax
         qx2AB82ogCfGkzRemk0hiyFflc+DieLpe1AM1PvHZjyA48ihGXCGk1z0ECuDjRJSVCix
         vp5zCkFEPuPu/qtZpKQ7op21HBtMCIxfhzusks1oe4lz9sKUb+NHSPj2WoVBA+YxcMOv
         zL4hOWvkr81mjR9OBtsRmQ61r8y3e8MKjpxtj+xoMIHy0DEoovaJyxbYJRvZvjRsOyGH
         AJb6qBdD1G1QVOD6wPRxXEf8A0Qev5UsBz2vGpBv6hXjcXY53v4lW2+UCD4Wss5rdglZ
         VbEQ==
X-Gm-Message-State: AOAM532recvAmf9NcQ3UUTiuBY9b3dL8aEz2DStoPc7cgjpJs1sU1gZy
        nO+qUuCBjdnYWudAmwbJOrXGwXTDGAKual7KEHS3H3T4p18=
X-Google-Smtp-Source: ABdhPJx5YQlr7nNJMphcKYqzq1+EhcehY8fzgrOW+DV96Nl08P1w5bdc5ppiRd9ChP1c1HanS/1YJJXE6qqJ7/MAO0o=
X-Received: by 2002:a05:6808:e8d:b0:322:4fbe:8c5f with SMTP id
 k13-20020a0568080e8d00b003224fbe8c5fmr18583350oil.284.1652878044025; Wed, 18
 May 2022 05:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
 <YoTfou30lNY3tW6l@kroah.com> <CAAfyv35CPtn-WBRPnaEK_PV_XWq0UrZURSsYEtsdAcWFfCW9Ag@mail.gmail.com>
 <YoTpu6Oxlx0RzZCU@kroah.com>
In-Reply-To: <YoTpu6Oxlx0RzZCU@kroah.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 18 May 2022 14:47:12 +0200
Message-ID: <CAAfyv36tbxZb8V0oppPpFaRhxjNHvgUfOXqeEbZjXUd8otf28w@mail.gmail.com>
Subject: Re: custom serial driver node not created
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 18, 2022 at 2:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 18, 2022 at 02:24:43PM +0200, Belisko Marek wrote:
> > On Wed, May 18, 2022 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, May 18, 2022 at 01:41:18PM +0200, Belisko Marek wrote:
> > > > Hello,
> > > >
> > > > I'm writing serial tty driver (it's SPI/UART converter) and I get
> > > > inspired by this driver:
> > > > https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/tty/serial/sc16is7xx.c
> > > >
> > > > I have driver probed and also added port to driver which I see in console:
> > > > [ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
> > > > is a test_driver
> > > >
> > > > so I should see it in /dev/ttyTX0 but it seems node is not created.
> > > > Udev is running on a platform.
> > > > Any ideas what can cause this?
> > >
> > > Without seeing the code itself, it's almost impossible to guess.
> > >
> > > Also note that udev does not create device nodes (hasn't for over a
> > > decade).  devtmpfs in the kernel does that, udev just helps with
> > > managing the permissions of created nodes if needed.
> > OK thanks for clarification.
> > >
> > > And why did you pick the ttyTX name?  That's already reserved for that
> > > driver, you should use a new one, right?
> > I've should used also others like ttyTEST but result was same.
> > >
> > > And what hardware are you writing this driver for that we don't already
> > > have a driver for it?
> > I'm writing a driver for the following model: Linux CPU is connected
> > with SPI with another CPU (Cortex M3) and this other CPU performs UART
> > handling based on data which comes over SPI. I would like to expose
> > Cortex M3 UARTS on linux as tty ports so it will act as standar serial
> > device.
> >
> > Code can be found here: https://pastebin.com/6qpUw2Jt
>
> Are you sure that your test_probe() call is really being called?
Of course I've added tons of debugging to the driver and it is probed.
As I mentioned in first topic I see this printout:
[ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
is a test_driver

which came from uart_report_port() foom serial_core.c
>

marek
-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
