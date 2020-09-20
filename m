Return-Path: <SRS0=gJKf=C5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04DC43463
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DC121531
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 12:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgITMrN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Sep 2020 08:47:13 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21468 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbgITMrM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Sep 2020 08:47:12 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468614397"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 14:47:11 +0200
Date:   Sun, 20 Sep 2020 14:47:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] pch_uart: drop double zeroing
In-Reply-To: <20200920121404.GA2830482@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2009201443590.2966@hadrien>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr> <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr> <20200920121404.GA2830482@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Sun, 20 Sep 2020, Greg Kroah-Hartman wrote:

> On Sun, Sep 20, 2020 at 01:26:13PM +0200, Julia Lawall wrote:
> > sg_init_table zeroes its first argument, so the allocation of that argument
> > doesn't have to.
> >
> > the semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @@
> > expression x,n,flags;
> > @@
> >
> > x =
> > - kcalloc
> > + kmalloc_array
> >   (n,sizeof(struct scatterlist),flags)
> > ...
> > sg_init_table(x,n)
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> It inits the first entry in the array, but what about all of the other
> ones?  Is that "safe" to have uninitialized data in them like your
> change causes to happen?

Sorry, I don't follow.  The complete code is:

        priv->sg_tx_p = kcalloc(num, sizeof(struct scatterlist), GFP_ATOMIC);
        if (!priv->sg_tx_p) {
		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
                return 0;
	}

	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */

and the definition of sg_init_table is:

void sg_init_table(struct scatterlist *sgl, unsigned int nents)
{
	memset(sgl, 0, sizeof(*sgl) * nents);
	sg_init_marker(sgl, nents);
}

It looks to me like it zeroes all of the elements?  The same file does
contain a call:

sg_init_table(&priv->sg_rx, 1);

But that's not the one associated with the patch.

julia
