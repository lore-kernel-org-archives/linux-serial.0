Return-Path: <SRS0=5qHh=DE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBE0C4346E
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 12:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF3C23718
	for <linux-serial@archiver.kernel.org>; Sun, 27 Sep 2020 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601208691;
	bh=segKEbXbLQKoyPsw1zVmBiTvE2bpOdGaSwUbj//kNpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e38QvoTnVa1mztr3jnBK1vERq6yVEnz0muuWrO8y6vaxmD/PLj/DrF3kxBKxxjWA+
	 7R/ZUqVhcmtHZ8zQTisJ7ECBfnvZlC8GDhdOZPzTtigvBnFkaA8F45DmNTzvjKFAso
	 vJJHJ00gQIOlPnLt7jXhbE++YVq2m/GvFhDE//4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0ML1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Sep 2020 08:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0ML0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 08:11:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD572389F;
        Sun, 27 Sep 2020 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601208686;
        bh=segKEbXbLQKoyPsw1zVmBiTvE2bpOdGaSwUbj//kNpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TR4snYG+LeCHuPJnPeV/NE3sixMtY3veYQsu9oJ1po1GZvDF4zwVJC+EyzmPrWOLx
         hVMTpzuQdkfkrOxdIfZb4gluYxR9AzFIu9IGMC7gegQiSyQcXMwdJa0PgsZcci49G0
         SNfkzWwkZ+bfzvRrqmxPGErhABqNauV3FLYSEi4I=
Date:   Sun, 27 Sep 2020 14:11:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] pch_uart: drop double zeroing
Message-ID: <20200927121136.GA164938@kroah.com>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr>
 <20200920121404.GA2830482@kroah.com>
 <alpine.DEB.2.22.394.2009201443590.2966@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2009201443590.2966@hadrien>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 20, 2020 at 02:47:11PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 20 Sep 2020, Greg Kroah-Hartman wrote:
> 
> > On Sun, Sep 20, 2020 at 01:26:13PM +0200, Julia Lawall wrote:
> > > sg_init_table zeroes its first argument, so the allocation of that argument
> > > doesn't have to.
> > >
> > > the semantic patch that makes this change is as follows:
> > > (http://coccinelle.lip6.fr/)
> > >
> > > // <smpl>
> > > @@
> > > expression x,n,flags;
> > > @@
> > >
> > > x =
> > > - kcalloc
> > > + kmalloc_array
> > >   (n,sizeof(struct scatterlist),flags)
> > > ...
> > > sg_init_table(x,n)
> > > // </smpl>
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > It inits the first entry in the array, but what about all of the other
> > ones?  Is that "safe" to have uninitialized data in them like your
> > change causes to happen?
> 
> Sorry, I don't follow.  The complete code is:
> 
>         priv->sg_tx_p = kcalloc(num, sizeof(struct scatterlist), GFP_ATOMIC);
>         if (!priv->sg_tx_p) {
> 		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
>                 return 0;
> 	}
> 
> 	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */
> 
> and the definition of sg_init_table is:
> 
> void sg_init_table(struct scatterlist *sgl, unsigned int nents)
> {
> 	memset(sgl, 0, sizeof(*sgl) * nents);
> 	sg_init_marker(sgl, nents);
> }

Ah, missed the "* nents" thing there, sorry, my fault.

greg k-h
