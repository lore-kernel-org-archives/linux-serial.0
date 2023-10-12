Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA7CDB46E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 10:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjJLKjx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjJLKjw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 06:39:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289F94
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 03:39:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D0C433C9;
        Thu, 12 Oct 2023 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697107191;
        bh=SsADl0k564/gnage9RYeke7KXr1ZVX1VwQjjnLQwFVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnIRIlGBiG3ScyycJp6/AsUtoARPZcL0MKMElg2G52dXuGq+jk72FrNDSrZNd0UM/
         9IbhjF4FOSKf5hSDi9HMO3dY0ho9RVbu0pzpVbo5D/NHLV0cLIZ1W0EKCDf3EjkFK+
         VdaThnvHoKJXv9tsAkKlwz6IYB5vekHG3/hvhghU=
Date:   Thu, 12 Oct 2023 12:39:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julien MALIK - UNSEENLABS <julien.malik@unseenlabs.fr>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: xilinx_uartps: unset STOPBRK when setting
 STARTBRK
Message-ID: <2023101201-wistful-fresh-567c@gregkh>
References: <20230624210323.88455-1-julien.malik@unseenlabs.fr>
 <3fdb8c7a-6b31-4569-829c-cff84d8b836d@unseenlabs.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fdb8c7a-6b31-4569-829c-cff84d8b836d@unseenlabs.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 12, 2023 at 07:40:16AM +0000, Julien MALIK - UNSEENLABS wrote:
> Le 24/06/2023 à 23:03, Julien Malik a écrit :
> > Zynq UG585 states, in chapter B.33, for XUARTPS_CR_STARTBRK:
> > It can only be set if STPBRK (Stop transmitter break) is not high
> >
> > This fixes tcsendbreak, which otherwise does not actually break.
> >
> > Signed-Off-By: Julien Malik <julien.malik@unseenlabs.fr>
> > ---
> >   drivers/tty/serial/xilinx_uartps.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > index 8e521c69a959..2e69fceaa792 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -657,7 +657,7 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
> >   	status = readl(port->membase + CDNS_UART_CR);
> >   
> >   	if (ctl == -1)
> > -		writel(CDNS_UART_CR_STARTBRK | status,
> > +		writel(CDNS_UART_CR_STARTBRK | (~CDNS_UART_CR_STOPBRK & status),
> >   				port->membase + CDNS_UART_CR);
> >   	else {
> >   		if ((status & CDNS_UART_CR_STOPBRK) == 0)
> 
> 
> Dear reviewers,
> 
> 
> This is a kind ping to attract more attention to this small patch.
> 
> 
> The issue and corresponding fix has already been suggested back in 2016 
> on the xilinx forum [1].
> 
> 
> This is my very first patch submission to the kernel.
> 
> Though I did my best, maybe I did not follow best practices, in which 
> case I'm all ears to suggestions.

Odd, I don't see this in my queue anywhere, nor do I see any responses,
very sorry about that.  I'll try to apply it later today.

thanks,

greg k-h
