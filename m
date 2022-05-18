Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70BFC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiERL7j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiERL7i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 07:59:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52780238
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 04:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E853B81F94
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 11:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7599C385A5;
        Wed, 18 May 2022 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652875174;
        bh=mEtmgf+UaTIDMI+oa6oZfzBTsNO17wYyyBauxAmjdKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP+mDt/ZGioQbfNRfaeLMsTWsYozktZCFEBgvtDyhxggrPRF34VhxuoC2trKYce28
         mmTSP7IVrCoF0o4POQKilMw/6gFxYXbrDuT5CZQDW6e0kgEF55WdeId06ZoYAk0o7i
         sPy3XfWrwi1leqSoxHNnl1obw5MZXoByexrnbrUE=
Date:   Wed, 18 May 2022 13:59:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: custom serial driver node not created
Message-ID: <YoTfou30lNY3tW6l@kroah.com>
References: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv36U1A21pOOnrUyZ6tKm087dAbJ5kjpOQj6L8kHYBZGmvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 18, 2022 at 01:41:18PM +0200, Belisko Marek wrote:
> Hello,
> 
> I'm writing serial tty driver (it's SPI/UART converter) and I get
> inspired by this driver:
> https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/tty/serial/sc16is7xx.c
> 
> I have driver probed and also added port to driver which I see in console:
> [ 2616.826105] spi0.0: ttyTX0 at I/O 0x1 (irq = 0, base_baud = 9375)
> is a test_driver
> 
> so I should see it in /dev/ttyTX0 but it seems node is not created.
> Udev is running on a platform.
> Any ideas what can cause this?

Without seeing the code itself, it's almost impossible to guess.

Also note that udev does not create device nodes (hasn't for over a
decade).  devtmpfs in the kernel does that, udev just helps with
managing the permissions of created nodes if needed.

And why did you pick the ttyTX name?  That's already reserved for that
driver, you should use a new one, right?

And what hardware are you writing this driver for that we don't already
have a driver for it?

thanks,

greg k-h
