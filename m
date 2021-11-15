Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F2C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 00:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668A6619E1
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 00:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbhKPAeE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345108AbhKOT0c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76A766371B;
        Mon, 15 Nov 2021 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637003423;
        bh=5vu5HaAvfYHHkoVBmv9FZtBdmtn8XzLUHZOXPsKguKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhxVQ5QrCFQLfoW10hgALnful7JIwpqNPg5woloYq2obpTp/BxNOA4SV2VBFSmjN0
         lR5o+px44mTMc4GqdU1aayYEeyOkVO1gbMs6zPfoC28yUMbwZJZtXaF2pQGVuD0P6K
         1RDIwGtEN8O+69qD2w8UzV6NKw7xaYfLb5uGlcac=
Date:   Mon, 15 Nov 2021 19:42:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sahil Patidar <sahilpatidar4051@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial:  jsm_tty: fixed a assignment in if condition
Message-ID: <YZKqGGsRQtSbIQrg@kroah.com>
References: <20211115182413.10861-1-sahilpatidar4051@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115182413.10861-1-sahilpatidar4051@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 15, 2021 at 11:54:13PM +0530, Sahil Patidar wrote:
> Fixed assignment in if condition.

What exactly is "fixed"?

And why are there two spaces in your subject line?

> 
> Signed-off-by: Sahil Patidar <sahilpatidar4051@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index d74cbbbf33c6..44507b1ff93a 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -746,10 +746,10 @@ static void jsm_carrier(struct jsm_channel *ch)
>  void jsm_check_queue_flow_control(struct jsm_channel *ch)
>  {
>  	struct board_ops *bd_ops = ch->ch_bd->bd_ops;
> -	int qleft;
> +	int qleft = ch->ch_r_tail - ch->ch_r_head - 1;
>  
>  	/* Store how much space we have left in the queue */
> -	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
> +	if (qleft < 0)

What was wrong with the original code that required this change?

thanks,

greg k-h
