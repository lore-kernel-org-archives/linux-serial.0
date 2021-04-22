Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF19C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0EC613FB
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhDVM4v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVM4u (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 08:56:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97E7161421;
        Thu, 22 Apr 2021 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619096175;
        bh=67Q2cT7gJwqbkeudvADA/kgYbXlrl1Bc7sxBlveRglY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ3uZ70WTSsPlJIscCBN/Us3AzLMfZKRzx77q4k0/mk3B6Wz+Tdoy+blJ764BI65G
         L4qcgWfHw5LtwIrl5Veg1AYRV2AMHu1/WHTRfy/nLXZVIu3L74vRmGVRbdlcOyws1F
         u5XDMrKoKj6h9gzKPNS/wPvQKOZQ1rkzf6b+gFKFBlkuxQ5l8AfsaEZTbBDj+kPAQ9
         SWJbAl5k04l1GUKb4W+jhf3zhoIhL2AttNPBOyI0OoSAQw2dOa3UWPOHVZUq7jJs36
         2aQjCrI5wqT7mLT0O9ItbOEQfwamTgxrjm6emY/nQWatktmydLHrTm+CG6KS+2yvK0
         DIwjWc99AO6yA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZYsX-0008M1-9M; Thu, 22 Apr 2021 14:56:21 +0200
Date:   Thu, 22 Apr 2021 14:56:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: serial: jsm: remove redundant assignments of
 several variables
Message-ID: <YIFydeoE/WRfPcvA@hovoldconsulting.com>
References: <20210422121115.246625-1-colin.king@canonical.com>
 <YIFxfH4MXc1ekn4f@hovoldconsulting.com>
 <c9497e47-cdfb-7be0-ad35-648ea5d68268@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9497e47-cdfb-7be0-ad35-648ea5d68268@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 01:53:03PM +0100, Colin Ian King wrote:
> On 22/04/2021 13:52, Johan Hovold wrote:
> > On Thu, Apr 22, 2021 at 01:11:15PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Several variables are being assigned with values that are never
> >> read and being updated later with a new value. The initializations
> >> are redundant and can be removed.
> >>
> >> Addresses-Coverity: ("Unused value")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/tty/serial/jsm/jsm_cls.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> >> index b507a2cec926..b58ea4344aaf 100644
> >> --- a/drivers/tty/serial/jsm/jsm_cls.c
> >> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> >> @@ -349,8 +349,8 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
> >>  
> >>  static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
> >>  {
> >> -	int qleft = 0;
> >> -	u8 linestatus = 0;
> >> +	int qleft;
> >> +	u8 linestatus;
> >>  	u8 error_mask = 0;
> >>  	u16 head;
> >>  	u16 tail;
> >> @@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
> >>  	head = ch->ch_r_head & RQUEUEMASK;
> >>  	tail = ch->ch_r_tail & RQUEUEMASK;
> >>  
> >> -	/* Get our cached LSR */
> >> -	linestatus = ch->ch_cached_lsr;
> >>  	ch->ch_cached_lsr = 0;
> > 
> > Why leave this assignment in? Looks like this was all copy-pasta, but
> > this assignment makes even less sense now that you remove the comment
> > and load.
> 
> Which assignment are you referring to?

The one just above my comment: 

	ch->ch_cached_lsr = 0;

Johan
