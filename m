Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA02C001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHDOR2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjHDOR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 10:17:27 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252EA1BF6;
        Fri,  4 Aug 2023 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3BmCy3FfAFJVmkULUEo0LPODBrgu2376z1QX3mxEv68=; b=zQjLY8z0pJ5Vw2FxP6AK7cJK3g
        5iyOQZ2KhJjz9vLYcJNwZeFHktEkmk/Lu95i/C+s2yaYOklOl5iXHrZ29HTTV93sWb9YeL9KYZmTI
        8f3KkUjjC2iOkoITYu3p3PzH9rB8MZXsyqD98WC7KTv/kMNI5T3y3bCy4yE6xhSzgFCQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42044 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRvcI-0007In-J2; Fri, 04 Aug 2023 10:17:23 -0400
Date:   Fri, 4 Aug 2023 10:17:22 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20230804101722.7e437a81b2639ccab408d6ba@hugovil.com>
In-Reply-To: <2023080417-surname-sizzling-591e@gregkh>
References: <20230803140551.970141-1-hugo@hugovil.com>
        <2023080417-surname-sizzling-591e@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH] serial: max310x: add comments for membase address
 workaround
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 4 Aug 2023 15:07:50 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Aug 03, 2023 at 10:05:51AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add comments about workaround used to configure membase address. This
> > follows suggestions made during review of a sc16is7xx driver patch to
> > add the same workaround.
> > 
> > Link: https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com
> > Link: https://lore.kernel.org/lkml/20230801131655.80bd8f97f018dda6155d65f6@hugovil.com/
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/max310x.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > index 416d553b73a7..5903dd033fd0 100644
> > --- a/drivers/tty/serial/max310x.c
> > +++ b/drivers/tty/serial/max310x.c
> > @@ -1369,6 +1369,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
> >  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> >  		s->p[i].port.iotype	= UPIO_PORT;
> >  		s->p[i].port.iobase	= i;
> > +		/*
> > +		 * Use all ones as membase to make sure uart_configure_port() in
> > +		 * serial_core.c does not abort for SPI/I2C devices where the
> > +		 * membase address is not applicable.
> > +		 */
> >  		s->p[i].port.membase	= (void __iomem *)~0;
> >  		s->p[i].port.uartclk	= uartclk;
> >  		s->p[i].port.rs485_config = max310x_rs485_config;
> > 
> > base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
> > -- 
> > 2.30.2
> > 
> 
> Meta-comment, your email system is not correct and is not able to be
> verified as I get the following when attempting to apply your patch:
> 
> ---
>   ✗ [PATCH] serial: max310x: add comments for membase address workaround
>   ---
>   ✗ BADSIG: DKIM/hugovil.com
> 
> Please fix up for future submissions.
> 
> thanks,
> 
> greg k-h

Hi Greg,
I will look into it. Thank you.

Hugo.
