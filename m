Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3343DC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BC960FDC
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhDZLez (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhDZLez (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 07:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B935560FEF;
        Mon, 26 Apr 2021 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619436852;
        bh=W3vHHW3L5Jp7qhyyytzPq8R1EAEE0x9hepv5yOVGiRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzJLN44f1mr5WcC7jeAPhpk/RlAA/VxnIP5hH63DuQeJo4pNvVQGNVefB9rfBqJxn
         +MwmWvHS5yMRvz9j2A/WaASB86j1Msz9XErlBhhRRX1VOpEyX62xbfehJMca8q5/9A
         Tie1CVBm9NweI4Q7M0p6AFVvtQn16HW5TUply6Ck=
Date:   Mon, 26 Apr 2021 13:34:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Message-ID: <YIalMRdbAKZpIJWP@kroah.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com>
 <YIZ0/vRLASlUph6x@kroah.com>
 <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 11:30:47AM +0000, Sherry Sun wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 2021年4月26日 16:09
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of division
> > or modulo by zero
> > 
> > On Mon, Apr 26, 2021 at 03:49:34PM +0800, Sherry Sun wrote:
> > > This issue is reported by Coverity Check.
> > > In lpuart32_console_get_options, division or modulo by zero may
> > > results in undefined behavior.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 794035041744..777d54b593f8
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -2414,6 +2414,9 @@ lpuart32_console_get_options(struct lpuart_port
> > > *sport, int *baud,
> > >
> > >  	bd = lpuart32_read(&sport->port, UARTBAUD);
> > >  	bd &= UARTBAUD_SBR_MASK;
> > > +	if (!bd)
> > > +		return;
> > 
> > How can this ever happen?
> > 
> > Not to say this is a bad check, but it feels like this can't really happen in real
> > life, what code patch could create this result?
> > 
> > And have you tested this on real hardware?
> > 
> 
> Thanks for the reviewing, yes, I have tested the patchset on the real hardware.
> 
> Seems the coverity check is static scan, so cannot judge if UARTBAUD Register will be zero.
> I just found below statement in the uart reference manual: "When SBR is 1 - 8191, the baud rate equals "baud clock / ((OSR+1) × SBR)"."
> Since I am not familiar with uart, do you mean that the value of UARTBAUD Register will never be zero, so this case will not happen in real word?

Given that this never has happened with hardware for such an old device,
perhaps it is impossible.  But it would be good to check.

> If yes, I will drop this patch.

Handling "bad data" from hardware is never a bad idea, so I don't
necessarily want to drop this patch, I just want to try to figure out if
this is a "incase the hardware is broken/malicious" type of change, vs.
a "this bug we are seeing in real hardware" type of change.

thanks,

greg k-h
