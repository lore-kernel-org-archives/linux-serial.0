Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Apr 2022 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351071AbiD1SlI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1SlH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Apr 2022 14:41:07 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E6BE9CF
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 11:37:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E1CF5C00C7;
        Thu, 28 Apr 2022 14:37:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Apr 2022 14:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651171068; x=
        1651257468; bh=NADRAsN6WYkSpiNZmErD6zcr0wH1EebowVVk/AcMF6c=; b=T
        Rp3KrrHx7zR4XWskew7c2GUqxZaZbd0HqXogepT/NiSJBmUnFBUdcQCKZNCYVh37
        FR5Ld9+moLniV6AfLM6FVLXNfb0qZhL/tjevi3sDEfoccr5PjAhj13r1nBSOTcIm
        Ea4gZPd3srMteFO4i1BqtXgisp90pEPyG8Qhw6exQDfCAy24swbsFkNDCGMGoJkB
        vrtybetWTZ4sqmpadp/fMnMaFgFHxKfV0nxCZq8mxRAYBrHUlf37OPSZ4LhVowoA
        ybVsl0eEfnTPiwBhpN0M2CtmRgdmxhLQTrnPW0sSh7yvJTW8vUhuQX5YLW5zaSwG
        bYXAnL+RctRO89uQUBbpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651171068; x=1651257468; bh=NADRAsN6WYkSp
        iNZmErD6zcr0wH1EebowVVk/AcMF6c=; b=sJWLwAJNKdoil9UWEhrbYpiRcADRJ
        VKxabPJmy48JJ5fzXb8Jgek/6FSIzaoqOTOkA9yaY++kl2BjZOs5+ZGlmnCuTmag
        UJd7EXAddFpcBuGYXsSPxcwCeWInzY63H8eMGqMc0zbk3G/tJo+7YHMex7JgD2fy
        yIdbIC/xqK7QScSFioKtlk89MzJVRj3rAuRLSpLOxtUcSegV2XaJCAds4+s26k/J
        czHVlVcOHOoW/DP6XtiBpTp7T5sqy8uHLwH6GrppNcNU3HrPA09IoxDxRvsmBmwJ
        M5HDdlHeScFKd0lLD9mTUSwakqUY7In2vOPyee7vuzVkaPlpNHhU9oP6Q==
X-ME-Sender: <xms:-95qYmQl1leT7AMD-iV0dm4ZouTd-qI2ncPW9TtZFoh5yUN8-F9Hiw>
    <xme:-95qYrzf60OTmr1fjUhw5Anpp_l5JtbNC8HJRFtD4yRBvdXnjsA6nHl2PK_uKrPuF
    Qn2yxIukUTK3A>
X-ME-Received: <xmr:-95qYj2DIReM5_xiIYliIgsf1OEUxvJrGwmGGvWoDtLPXp6xCcgI347jVIcUg-4mUa8Oab4mXfcrlqkgpJBI0rjrm-0zsPbx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:-95qYiAbTRxj734ArrO6vbpDAfa01yGcL8FclxYmGGLbJvOOGp82hg>
    <xmx:-95qYvgQ91DMAG_ASTDc5y2YLM-NaNt74lNsGcD-OUMUpdQ0VBXrFQ>
    <xmx:-95qYuql96fBpPYXqKyB9RNUQj-VBIDoWeC5UY1SvMHtUtx_wAGKpg>
    <xmx:_N5qYvcdZo0TRPSysTBeE6WXuEr3xKprAtToXzs9IELhu3TmGBA10g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Apr 2022 14:37:47 -0400 (EDT)
Date:   Thu, 28 Apr 2022 20:37:45 +0200
From:   Greg KH <greg@kroah.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Nuno =?iso-8859-1?Q?Gon=E7alves?= <nunojpg@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RFC PATCH] serial: Don't assume uart_ops .throttle is always set
Message-ID: <Ymre+Y5NhQIuVpdd@kroah.com>
References: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 28, 2022 at 08:11:56PM +0300, Ilpo Järvinen wrote:
> uart_throttle() assumes that a driver provides a throttle function in
> uart_ops. But not all drivers do and there seems to nothing in
> serial_core that would set it either. Thus, check it before calling.
> 
> Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
>  drivers/tty/serial/serial_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6a8963caf954..18c9d46e0b85 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -697,7 +697,8 @@ static void uart_throttle(struct tty_struct *tty)
>  		mask |= UPSTAT_AUTORTS;
>  
>  	if (port->status & mask) {
> -		port->ops->throttle(port);
> +		if (port->ops->throttle)
> +			port->ops->throttle(port);
>  		mask &= ~port->status;
>  	}
>  
> 

What commit id does this "fix"?

thanks,

greg k-h
