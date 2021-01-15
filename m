Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB214C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6B8235F9
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 06:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbhAOG34 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbhAOG3z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 01:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E82A23A05;
        Fri, 15 Jan 2021 06:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610692155;
        bh=jjD1kHhVU15jHOAfM0IgbJZHMD1xn6W95UIHnKhxq9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqqVThpGxs5hqhE0aAbkfyNfMIKhZmtc25Q7iN9F/CR27dn0UeuNtd5gPMGX5MtJF
         Mhfi86FnnvC63qAL8hOGMms//TsWfzYHB+ajIJmDI5Jc1zrRpEgnqXbZKccYBHgQKD
         GvSY9Eli6se6tLBsENHrpDwlVJ4mwxTJpY6+IkRc=
Date:   Fri, 15 Jan 2021 07:29:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao <zhangqiumiao1@huawei.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: [PATCH v3] tty: make pl011 serial port driver support 485 mode
Message-ID: <YAE2OCd0WCXTHQp2@kroah.com>
References: <BEEC2888CE24964AA5C6EAB9EA9DA122272F78@dggemi529-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEEC2888CE24964AA5C6EAB9EA9DA122272F78@dggemi529-mbs.china.huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 15, 2021 at 02:32:39AM +0000, zhangqiumiao wrote:
> On Thu, Jan 14, 2021 at 08:28:30PM +0800, zhangqiumiao1@huawei.com wrote:
> > From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> > 
> > make pl011 serial port support 485 mode full duplex communication
> > 
> > Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> > ---
> > Changes in v3:
> >   -Fix busy loop forever in pl011_tx_empty
> >   -Move the definition of cr into uart_amba_port
> >   -run checkpatch with no error or warning
> > 
> > Changes in v2:
> >   -Fix two compilation errors
> > 
> >  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c 
> > b/drivers/tty/serial/amba-pl011.c index c255476..9da10a4 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -44,6 +44,7 @@
> > 
> >  #include "amba-pl011.h"
> > 
> > +#define ISEMPTY			1
> >  #define UART_NR			14
> > 
> >  #define SERIAL_AMBA_MAJOR	204
> > @@ -264,6 +265,7 @@ struct uart_amba_port {
> >  	unsigned int		fifosize;	/* vendor-specific */
> >  	unsigned int		old_cr;		/* state during shutdown */
> >  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
> > +	unsigned int		cr;
> >  	char			type[12];
> >  #ifdef CONFIG_DMA_ENGINE
> >  	/* DMA stuff */
> > @@ -1284,6 +1286,8 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
> >  #define pl011_dma_flush_buffer	NULL
> >  #endif
> > 
> > +static unsigned int pl011_tx_empty(struct uart_port *port);
> > +
> >  static void pl011_stop_tx(struct uart_port *port)  {
> >  	struct uart_amba_port *uap =
> > @@ -1292,6 +1296,17 @@ static void pl011_stop_tx(struct uart_port *port)
> >  	uap->im &= ~UART011_TXIM;
> >  	pl011_write(uap->im, uap, REG_IMSC);
> >  	pl011_dma_tx_stop(uap);
> > +	if (port->rs485.flags & SER_RS485_ENABLED) {
> > +		while(pl011_tx_empty(port) != ISEMPTY) ;
> 
> I intend to change this to:
>         while(pl011_tx_empty(port) != ISEMPTY)
> 			cpu_relax();
> Is this ok?

See other comments on this same list (linux-serial) for a patch for a
different driver a few days ago about why doing that would not be a good
idea.  Did you not review that change when it was submitted?

> > +
> > +		uap->cr = pl011_read(uap, REG_CR);
> > +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) {
> > +			uap->cr |= UART011_CR_RTS;
> > +		} else {
> > +			uap->cr &= ~UART011_CR_RTS;
> > +		}
> 
> Checkpatch doesn't find the problem here. Please tell me what's wrong here?

No braces should be needed, have you read the coding style rules?

thanks,

greg k-h
