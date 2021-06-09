Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B1DC48BCF
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE51D613AD
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhFIMk4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233488AbhFIMk4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 08:40:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1AD6139A;
        Wed,  9 Jun 2021 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623242341;
        bh=jYtHpQjLmGyTZrGhKiPMLFg/1ejaPgAby5FBxFuQN/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqiYr1+Q99rzvfeU+9N452qceuc0Z42+bwWDUBVU8BHfb0ernrhh6lJ9hBqD4+ic5
         KNuNsZS2Yc4dZsCJx+t2OS2aw3WT3zSqhMpZi0N/PeWOwZasnRsNSnoQRK9Ey5oP+1
         alIClrYAhGBVNK3ec8MSDBMKT7jqQ/S/GLmAuKh0=
Date:   Wed, 9 Jun 2021 14:38:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/2] serial: stm32: reset dma buffers during probe
Message-ID: <YMC2Y5tVd478wU2B@kroah.com>
References: <20210527091537.8997-1-erwan.leray@foss.st.com>
 <20210527091537.8997-2-erwan.leray@foss.st.com>
 <YK9rDVeg0W9WE+9a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9rDVeg0W9WE+9a@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 27, 2021 at 11:49:01AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 27, 2021 at 11:15:36AM +0200, Erwan Le Ray wrote:
> > Reset Rx and Tx dma buffers during probe to avoid freeing
> > invalid buffer in no dma mode.
> > 
> > Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> > 
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > index c2ae7b392b86..2ac3b30477a7 100644
> > --- a/drivers/tty/serial/stm32-usart.c
> > +++ b/drivers/tty/serial/stm32-usart.c
> > @@ -1168,6 +1168,8 @@ static struct stm32_port *stm32_usart_of_get_port(struct platform_device *pdev)
> >  	stm32_ports[id].cr1_irq = USART_CR1_RXNEIE;
> >  	stm32_ports[id].cr3_irq = 0;
> >  	stm32_ports[id].last_res = RX_BUF_L;
> > +	stm32_ports[id].rx_dma_buf = 0;
> > +	stm32_ports[id].tx_dma_buf = 0;
> >  	return &stm32_ports[id];
> >  }
> >  
> > -- 
> > 2.17.1
> > 
> 
> Is this a bugfix?  if so, what commit does this fix and does it need to
> be backported anywhere?

Due to lack of a response, I've dropped this from my queue.  Please add
the needed information to the patch when you get the chance to resend
this.

thanks,

greg k-h
