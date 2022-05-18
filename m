Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC0C4321E
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 12:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiERMr0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiERMqD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 08:46:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE415FE16
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 05:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD1FB81FB6
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 12:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD6C385A5;
        Wed, 18 May 2022 12:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652877759;
        bh=nJfUymRdTl0emY2fppZD8qGZqSinP3u7StIdHOaWoC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Owov4qxQF3jAG/+b36ICKBZOa8QSUeoHhUGgXBJ9+DTWo8MCrm0i2j4UOI/ZDB0te
         M1AklTnjf9bK7vNCYvHQ2bdzAfkj7nFc+Da9707R8KpBbswUiuu5rbY6LbtT9EveP4
         AHlv1oxEBPC1/F+IR2/dSEitv+r8Ed9dqvcnjk/s=
Date:   Wed, 18 May 2022 14:42:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: custom serial driver node not created
Message-ID: <YoTpu6Oxlx0RzZCU@kroah.com>
References: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
 <YoTfou30lNY3tW6l@kroah.com>
 <CAAfyv35CPtn-WBRPnaEK_PV_XWq0UrZURSsYEtsdAcWFfCW9Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv35CPtn-WBRPnaEK_PV_XWq0UrZURSsYEtsdAcWFfCW9Ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 18, 2022 at 02:24:43PM +0200, Belisko Marek wrote:
> On Wed, May 18, 2022 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 18, 2022 at 01:41:18PM +0200, Belisko Marek wrote:
> > > Hello,
> > >
> > > I'm writing serial tty driver (it's SPI/UART converter) and I get
> > > inspired by this driver:
> > > https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/tty/serial/sc16is7xx.c
> > >
> > > I have driver probed and also added port to driver which I see in console:
> > > [ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
> > > is a test_driver
> > >
> > > so I should see it in /dev/ttyTX0 but it seems node is not created.
> > > Udev is running on a platform.
> > > Any ideas what can cause this?
> >
> > Without seeing the code itself, it's almost impossible to guess.
> >
> > Also note that udev does not create device nodes (hasn't for over a
> > decade).  devtmpfs in the kernel does that, udev just helps with
> > managing the permissions of created nodes if needed.
> OK thanks for clarification.
> >
> > And why did you pick the ttyTX name?  That's already reserved for that
> > driver, you should use a new one, right?
> I've should used also others like ttyTEST but result was same.
> >
> > And what hardware are you writing this driver for that we don't already
> > have a driver for it?
> I'm writing a driver for the following model: Linux CPU is connected
> with SPI with another CPU (Cortex M3) and this other CPU performs UART
> handling based on data which comes over SPI. I would like to expose
> Cortex M3 UARTS on linux as tty ports so it will act as standar serial
> device.
> 
> Code can be found here: https://pastebin.com/6qpUw2Jt

Are you sure that your test_probe() call is really being called?

