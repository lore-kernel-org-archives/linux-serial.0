Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4909BC28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1527E206DD
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588769948;
	bh=VZ5wfbpaa65fQBz24+L9yq+Pz+Arql7THjHEU0/HkRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XnCCqa1NTOriyV8kwCTFIoom65RLUeAejE4mN2PCJp/O0hoE3GSNp9f2WjCTMEYie
	 Yy9fYP8O+e7tBq2DlU0RwLVrWM51hcMl1//+zK1sLBb52GzEVibvgZgamEx2qbVItW
	 mAaMccUYwH6OgqticdtbwZ8HeaGBrOOEHa2uKQtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgEFM7H (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 08:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFM7H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 08:59:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FE2206DB;
        Wed,  6 May 2020 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588769946;
        bh=VZ5wfbpaa65fQBz24+L9yq+Pz+Arql7THjHEU0/HkRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwPwoVwjo9aOtcg7CV3VMyFiXMl7UWvFnxdzl547INGsVtcJxF7jWZGEe8C0n4SRe
         I6RNJsdiavAoQatx03dZ3Q2ffuvxB2H1AopxnOXL3ZvcigD0gyTBaVue3CQ2obaNot
         eGNaPDSUkk1wb00exmC63kx91Y3VOVy+UbyKFnIQ=
Date:   Wed, 6 May 2020 14:59:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>,
        akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200506125904.GA3159967@kroah.com>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120237.GA3047211@kroah.com>
 <20200506124845.GG8043@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506124845.GG8043@willie-the-truck>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 01:48:45PM +0100, Will Deacon wrote:
> On Wed, May 06, 2020 at 02:02:37PM +0200, Greg KH wrote:
> > On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> > > +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
> > > +{
> > > +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
> > > +	/*
> > > +	 * Ensure FIFO write clear goes through before
> > > +	 * next iteration.
> > > +	 */
> > > +	mb();
> > 
> > Can't you just write the above two lines as:
> > 	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
> > ?
> > 
> > Why put a mb() after a _relaxed() call?
> 
> writel() usually puts the barrier /before/ the I/O write, since it's
> normally used to signal the readiness of a DMA buffer, e.g.:
> 
> 	ptr = dma_map(...);
> 	ptr->data = tx_data;
> 	writel(dev->ctrl_reg, SEND_DATA); // Device must see tx_data
> 
> but this driver looks like it only cares about PIO rather than DMA, in which
> case there's no need for mb() or writel(); writel_relaxed() should do the
> trick because we just need to ensure ordering of the writes hitting the
> device. From memory-barriers.txt:
> 
>   ... they [relaxed accesses] are still guaranteed to be ordered with
>   respect to other accesses from the same CPU thread to the same
>   peripheral when operating on __iomem pointers mapped with the default
>   I/O attributes.

Ok, that makes more sense, many thanks.

So, as writes are ordered here, Savaliya, I think all of the calls to
mb() can be dropped from this driver, right?

thanks,

greg k-h
