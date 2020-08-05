Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6FC433E0
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 20:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB742076E
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596657905;
	bh=SmzHEjXJKI0Ah3FCpKvLcMIvLkMQABYGGHX0eTpxkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zB5g+m7IFNZ02VDxuGjkotL6g5ZC9I6HYFubgMRumVO+FCI0Pr/H6omSbjM1EeMcA
	 MKh+Lk4sJgYnF2xIZ8jkFtYhmfkIXd8Me+O+dZDkd7928QuGeVGTMJzheTFYUrEQ3Q
	 W6bmQ7CH9w36qVQ2Vl0prbNmzlTkD/usGoFXZGTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHEUE4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgHEQgh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Aug 2020 12:36:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E9121744;
        Wed,  5 Aug 2020 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596632170;
        bh=SmzHEjXJKI0Ah3FCpKvLcMIvLkMQABYGGHX0eTpxkp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCxIQJw4GOQ+h1x3tpCiOUo/92RnUW5K44Ue5g2BDrgjVKDIeXDdMTLRnPjibu+3M
         Lc+TzYJggQfzEAXArbpTLmfrvfB/Y9EwDdCS/TJ+h1PFBtf+fU8o3bsVmUfKp1RiqO
         ox5N7Y2xXe+uqcPy6x6U6/8b6T9WvZmByeDlqzew=
Date:   Wed, 5 Aug 2020 14:56:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
Cc:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift
 operation
Message-ID: <20200805125627.GA1822283@kroah.com>
References: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu>
 <20200729160333.GA3652767@kroah.com>
 <VI1PR04MB480018F32A080BC5CC76E3C7F34B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB480018F32A080BC5CC76E3C7F34B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 05, 2020 at 12:09:34PM +0000, Vabhav Sharma (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Wednesday, July 29, 2020 9:34 PM
> > To: B K Karthik <bkkarthik@pesu.pes.edu>
> > Cc: Jiri Slaby <jirislaby@kernel.org>; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Vabhav Sharma (OSS)
> > <vabhav.sharma@oss.nxp.com>; bhuvanchandra.dv@toradex.com
> > Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift operation
> > 
> > On Tue, Jul 21, 2020 at 11:12:29PM +0530, B K Karthik wrote:
> > > prevent a bad shift operation by verifying that the argument to fls is
> > > non zero.
> > >
> > > Reported-by: "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
> > > Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > ---
> > > v1 -> v2:
> > > 	added Reported-by tag
> > >
> > >  drivers/tty/serial/fsl_lpuart.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 7ca642249224..0cc64279cd2d
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct
> > lpuart_port *sport)
> > >  	 * 10ms at any baud rate.
> > >  	 */
> > >  	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits /
> > 1000) * 2;
> > > -	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len)
> > - 1));
> > > +	if (sport->rx_dma_rng_buf_len != 0)
> > 
> > How can this variable become 0?
> Condition x, taking false branch
> Explicitly returning zero 
> 
> static __always_inline int fls(unsigned int x)
> {
> 	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
> }

What false branch?

I don't see how this can ever be an issue in "the real world", can you
explain how it could ever be a problem?

thanks,

greg k-h
