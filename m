Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CFAC28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8912206DD
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588769330;
	bh=8lju/YebT8/gAO7MbDtXVY8kWLavFTz9EYH4r/pKqTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF0YvJWlgJEm3HzC84PqkxMeukWQlWke/xX8uboRabnHpeySRB+qsn/UN1vUyO2CW
	 qeLcPXr+hkZkN2EKsb2sqq4xx7Ve56pS1PB1z0I99rCiwEsYUGAQ+LFZpL/o3akknf
	 Bagpj68oTSzF1FBLDKSd06XNYb1vle4kfgxRY03g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEFMsu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 08:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEFMsu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 08:48:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEE220575;
        Wed,  6 May 2020 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588769330;
        bh=8lju/YebT8/gAO7MbDtXVY8kWLavFTz9EYH4r/pKqTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYoYAb9Ui/evKo5Tl/djpMiomDFz5s8dwq11pxpyMhWN488YEEfHy96Z8ddG6A1xm
         9zKzi8PnXpPDqUf7YWdc6EsO6mcQrYMieIJ8KAO4rwRo8s8bQ5YrboD/b/1bGFVCbm
         TohNxlvLR52dhzysGKi4iIvlgemr1fgwqR/nSLxk=
Date:   Wed, 6 May 2020 13:48:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>,
        akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200506124845.GG8043@willie-the-truck>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120237.GA3047211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506120237.GA3047211@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 02:02:37PM +0200, Greg KH wrote:
> On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> > +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
> > +{
> > +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
> > +	/*
> > +	 * Ensure FIFO write clear goes through before
> > +	 * next iteration.
> > +	 */
> > +	mb();
> 
> Can't you just write the above two lines as:
> 	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
> ?
> 
> Why put a mb() after a _relaxed() call?

writel() usually puts the barrier /before/ the I/O write, since it's
normally used to signal the readiness of a DMA buffer, e.g.:

	ptr = dma_map(...);
	ptr->data = tx_data;
	writel(dev->ctrl_reg, SEND_DATA); // Device must see tx_data

but this driver looks like it only cares about PIO rather than DMA, in which
case there's no need for mb() or writel(); writel_relaxed() should do the
trick because we just need to ensure ordering of the writes hitting the
device. From memory-barriers.txt:

  ... they [relaxed accesses] are still guaranteed to be ordered with
  respect to other accesses from the same CPU thread to the same
  peripheral when operating on __iomem pointers mapped with the default
  I/O attributes.

Will
