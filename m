Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBAC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8FC61417
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVMwm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVMwl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 08:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A373F613FB;
        Thu, 22 Apr 2021 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619095926;
        bh=wEoT3jO7UtucRwy84ajbIOsrnCqay9RurD5+DQogCG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVC5ePKKD0aujwWblA2ntnpXUKuFtkikz339I3cH2Qht8T6thqnRDvqE80Ouch6LR
         GprUS3wq56xbWKHzAGhsTLqYVEzWOPWHSMcd70Nyr+cj3QIV/MbN0XBbFdq8Tj2PVk
         D2zOPubRbL/594hxQ+0NyHmFIIbusZ1SR61ENlp5msOni1PGwgP7mad0x2iZj78tqM
         Tk+nSFNZ3JZd5XXJhuTshwSXxRDlXDimVQt7MsGS38uOc6DKxVG3aoIYbnHReM9RUu
         fllz7R+sreRiRrPH6LSJ9kqRxd5iucIBpChbXK3n8BA5hZ1U1+p3iHwORnooUoxF2v
         FQomY+MfS1llQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZYoW-0008L8-B9; Thu, 22 Apr 2021 14:52:12 +0200
Date:   Thu, 22 Apr 2021 14:52:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: serial: jsm: remove redundant assignments of
 several variables
Message-ID: <YIFxfH4MXc1ekn4f@hovoldconsulting.com>
References: <20210422121115.246625-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422121115.246625-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 01:11:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Several variables are being assigned with values that are never
> read and being updated later with a new value. The initializations
> are redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/tty/serial/jsm/jsm_cls.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> index b507a2cec926..b58ea4344aaf 100644
> --- a/drivers/tty/serial/jsm/jsm_cls.c
> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> @@ -349,8 +349,8 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
>  
>  static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  {
> -	int qleft = 0;
> -	u8 linestatus = 0;
> +	int qleft;
> +	u8 linestatus;
>  	u8 error_mask = 0;
>  	u16 head;
>  	u16 tail;
> @@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  	head = ch->ch_r_head & RQUEUEMASK;
>  	tail = ch->ch_r_tail & RQUEUEMASK;
>  
> -	/* Get our cached LSR */
> -	linestatus = ch->ch_cached_lsr;
>  	ch->ch_cached_lsr = 0;

Why leave this assignment in? Looks like this was all copy-pasta, but
this assignment makes even less sense now that you remove the comment
and load.

Johan
