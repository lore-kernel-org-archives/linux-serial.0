Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF5C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F60720671
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589464927;
	bh=0WWBlj2qCjQQoOAxY2pmm4mSLAUojSJYM388lf/VHp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OqC5TbcIDaSvMSdAja32aaUKKUuRW7DIKaXG0Za/1/E+It+gRPFrZXeHhBtHeDXm3
	 41ThG4YzywU0nRTd1GAoSl2wnB8EJixrXaR5L2XnkQm4OW87koZlg8VOa5TGNxnSDR
	 7YxyGX3jf20A3glu5OpCY7A70kWNK9ufZwaeT2WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENOCH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 10:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENOCG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 10:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D4D205CB;
        Thu, 14 May 2020 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589464926;
        bh=0WWBlj2qCjQQoOAxY2pmm4mSLAUojSJYM388lf/VHp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPPrYPV4QcoUuy26rkISiwYdMfh5DizO4xO5MjR13XIJSem9hTEf4GQmo4zAw4hiW
         SHFN30Zac5S1UyvyiQ+E0zoIDZM0Ad2wUjApsU5WdnyijJD8CZdmL4/JFLXg9MPHJb
         Vt26+LslWquw3SdUbqmOkBuIXDDkG70YGLKpdX0c=
Date:   Thu, 14 May 2020 16:02:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200514140203.GA2581983@kroah.com>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120532.GB3047211@kroah.com>
 <572765da-6dae-3056-3fc2-188b92291777@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572765da-6dae-3056-3fc2-188b92291777@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 14, 2020 at 07:03:18PM +0530, Mukesh, Savaliya wrote:
> 
> On 5/6/2020 5:35 PM, Greg KH wrote:
> > On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> > > +		/*
> > > +		 * If the WM bit never set, then the Tx state machine is not
> > > +		 * in a valid state, so break, cancel/abort any existing
> > > +		 * command. Unfortunately the current data being written is
> > > +		 * lost.
> > > +		 */
> > > +		while (!msm_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > > +						M_TX_FIFO_WATERMARK_EN, true))
> > > +			break;
> > Am I reading this correctly in that if the bit is set properly, you will
> > just loop for forever?
> > 
> > That feels wrong, are you sure this is correct?
> 
> It seems correct to me. The API returns true if function sees the BIT is set
> else returns false.
> 
> Mostly it's true and returns true, hence it shouldn't loop.

What if it always is false, the loop is now stuck and can never break
out of this.  You need some sort of "timeout" for when the hardware
breaks :)

thanks,

greg k-h
