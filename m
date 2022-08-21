Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A4C00140
	for <linux-serial@archiver.kernel.org>; Sun, 21 Aug 2022 10:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiHUKHr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Aug 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHUKHq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Aug 2022 06:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204E26AF3;
        Sun, 21 Aug 2022 03:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF21C60DEF;
        Sun, 21 Aug 2022 10:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4990AC433C1;
        Sun, 21 Aug 2022 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661076464;
        bh=OswnZdvDgD55twhUiC3jfLmaXEs8tbfXHaC261uOFEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rc2SkzienB0g8AoK+ZkpUsz6WwhvQ3G5h22vrGmMT4RUkhP69GRvfQoyyNeMbkkb5
         hTuWeyq2ZgoJfs9z50zuAOIfcXPm//KFLCFWh5z++9kLAO4sFhR9Yn06M+kIlIACpj
         Yne4FutbNvxI68mWLdnSq4bd8cQUCW9D1CeVC7CA=
Date:   Sun, 21 Aug 2022 12:07:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Message-ID: <YwID+aTN+wptFdKa@kroah.com>
References: <20220804070420.32186-1-sherry.sun@nxp.com>
 <YwHvAsOmMaa6rmm0@kroah.com>
 <DB9PR04MB84110E4B09CC05573584724F926E9@DB9PR04MB8411.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84110E4B09CC05573584724F926E9@DB9PR04MB8411.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 21, 2022 at 10:01:45AM +0000, Sherry Sun wrote:
> > On Thu, Aug 04, 2022 at 03:04:20PM +0800, Sherry Sun wrote:
> > > When the user initializes the uart port, and waits for the transmit
> > > engine to complete in lpuart32_set_termios(), if the UART TX fifo has
> > > dirty data and the UARTMODIR enable the flow control, the TX fifo may
> > > never be empty. So here we should disable the flow control first to
> > > make sure the transmit engin can complete.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > > Changes in V2:
> > > 1. Rephrase the commit log as suggested by Jiri.
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index fc7d235a1e27..f0fccd2ff7ac
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port,
> > struct ktermios *termios,
> > >  	uart_update_timeout(port, termios->c_cflag, baud);
> > >
> > >  	/* wait transmit engin complete */
> > > +	lpuart32_write(&sport->port, 0, UARTMODIR);
> > >  	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
> > >
> > >  	/* disable transmit and receive */
> > > --
> > > 2.17.1
> > 
> > What commit id does this fix?  Should it be backported to older stable kernels?
> 
> This issue existed when the lpuart32_set_termios() was introduced. So the Fixes tag should be:
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support"), and I believe it can be backported to the older stable kernels.
> 
> Should I send a V2 patch to add the Fixes tag?

Yes please.
