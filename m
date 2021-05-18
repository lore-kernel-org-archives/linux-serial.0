Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D3C433ED
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75777611BD
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 06:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhERGja (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 02:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhERGj2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 02:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62CD9611B0;
        Tue, 18 May 2021 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621319890;
        bh=A/cflykcOTYV4DtVK9ADdAYseWeD5YVtDHXFY/y2UVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=on/bfYxol0bSNMXWXbOrxdMvGc2OTG+ePP/gS1AvrvWNTnzMwI0G53tjQ8emREgZr
         KfYSWtnrkbk2MQVjeuAb3c2pZJGWbHdBJRVwYRzDleDGVfJr9pkuoZeD3fSUwrG3kF
         mieEvmVd9DhafQ1WIAFdy44feYWFiNqyrNpOQUA0=
Date:   Tue, 18 May 2021 08:38:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, Ryan Chen <ryan_chen@aspeedtech.com>,
        Milton Miller II <miltonm@us.ibm.com>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH] tty: 8250: Add UART_BUG_TXRACE workaround for Aspeed
 VUART
Message-ID: <YKNgziMXms4zWRoY@kroah.com>
References: <20210517124105.3565860-1-andrew@aj.id.au>
 <YKJ6aP/xqAe1hW6A@kroah.com>
 <d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 18, 2021 at 11:00:39AM +0930, Andrew Jeffery wrote:
> 
> 
> On Mon, 17 May 2021, at 23:45, Greg KH wrote:
> > On Mon, May 17, 2021 at 10:11:05PM +0930, Andrew Jeffery wrote:
> > > Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
> > > LPC bus to the UART interface on the BMC's internal APB. As such there's
> > > no RS-232 signalling involved - the UART interfaces on each bus are
> > > directly connected as the producers and consumers of the one set of
> > > FIFOs.
> > > 
> > > The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
> > > at 33MHz. The difference in clock speeds exposes a race in the VUART
> > > design where a Tx data burst on the APB interface can result in a byte
> > > lost on the LPC interface. The symptom is LSR[DR] remains clear on the
> > > LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
> > > remains clear on the APB interface as the host has not consumed the data
> > > the BMC has transmitted. In this state, the UART has stalled and no
> > > further data can be transmitted without manual intervention (e.g.
> > > resetting the FIFOs, resulting in loss of data).
> > > 
> > > The recommended work-around is to insert a read cycle on the APB
> > > interface between writes to THR.
> > > 
> > > Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/tty/serial/8250/8250.h              | 1 +
> > >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
> > >  drivers/tty/serial/8250/8250_port.c         | 2 ++
> > >  3 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > > index 52bb21205bb6..4d6f5e0ecd4c 100644
> > > --- a/drivers/tty/serial/8250/8250.h
> > > +++ b/drivers/tty/serial/8250/8250.h
> > > @@ -88,6 +88,7 @@ struct serial8250_config {
> > >  #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
> > >  #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
> > >  #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> > > +#define UART_BUG_TXRACE (1 << 5)	/* UART Tx fails to set remote DR */
> > 
> > BUG()?
> 
> Can you please expand on what you mean here? I don't follow.
> 
> At least, I think there might be a formatting issue (spaces vs tabs).

Ick, my fault, I meant "BIT()"?  To perhaps use that macro instead of the <<
symbol.

And yes, tabs would be good as well :)

thanks,

greg k-h


