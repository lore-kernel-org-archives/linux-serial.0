Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7CC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05FF60233
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhDZMYM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233483AbhDZMX5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 299D961175;
        Mon, 26 Apr 2021 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619439794;
        bh=8l8FMIOM/2AmqQe/W20ULO3diao9or5P/lxqzFaH1D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDp2o3LwlZAFrhIW/+K33VSj06yfrflBPXDdOg2PTN4hvF44A8jnrHqg0fhbzPHet
         uBkCofrB3d5Owm2kLeKrpieMs0Th8X4ffJ5cRpBbDqdVAfZjBUStwWgFpTb658FYvK
         hcVxeWzitYuYBqiDU8l+NS/k45ogXz92Qvag/Okc=
Date:   Mon, 26 Apr 2021 14:23:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Message-ID: <YIawr8i62pHfSacm@kroah.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com>
 <YIZ0/vRLASlUph6x@kroah.com>
 <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <YIalMRdbAKZpIJWP@kroah.com>
 <AM0PR04MB49470E50CFAB8C36EABB241192429@AM0PR04MB4947.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB49470E50CFAB8C36EABB241192429@AM0PR04MB4947.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 11:51:39AM +0000, Sherry Sun wrote:
> Hi Greg,
> 
> > > > >  drivers/tty/serial/fsl_lpuart.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > > b/drivers/tty/serial/fsl_lpuart.c index 794035041744..777d54b593f8
> > > > > 100644
> > > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > > @@ -2414,6 +2414,9 @@ lpuart32_console_get_options(struct
> > > > > lpuart_port *sport, int *baud,
> > > > >
> > > > >  	bd = lpuart32_read(&sport->port, UARTBAUD);
> > > > >  	bd &= UARTBAUD_SBR_MASK;
> > > > > +	if (!bd)
> > > > > +		return;
> > > >
> > > > How can this ever happen?
> > > >
> > > > Not to say this is a bad check, but it feels like this can't really
> > > > happen in real life, what code patch could create this result?
> > > >
> > > > And have you tested this on real hardware?
> > > >
> > >
> > > Thanks for the reviewing, yes, I have tested the patchset on the real
> > hardware.
> > >
> > > Seems the coverity check is static scan, so cannot judge if UARTBAUD
> > Register will be zero.
> > > I just found below statement in the uart reference manual: "When SBR is 1
> > - 8191, the baud rate equals "baud clock / ((OSR+1) × SBR)"."
> > > Since I am not familiar with uart, do you mean that the value of UARTBAUD
> > Register will never be zero, so this case will not happen in real word?
> > 
> > Given that this never has happened with hardware for such an old device,
> > perhaps it is impossible.  But it would be good to check.
> > 
> > > If yes, I will drop this patch.
> > 
> > Handling "bad data" from hardware is never a bad idea, so I don't
> > necessarily want to drop this patch, I just want to try to figure out if this is a
> > "incase the hardware is broken/malicious" type of change, vs.
> > a "this bug we are seeing in real hardware" type of change.
> > 
> 
> Yes, you are right, the probability of hardware happen in this case is really low. But we cannot guarantee that it will never happen.
> So will this check here be accepted? Thanks!

Please resubmit it with a better changelog description summarizing the
discussion here to make it more obvious why this change is needed.

thanks,

greg k-h
