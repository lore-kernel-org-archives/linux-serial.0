Return-Path: <SRS0=VIcj=AF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70FC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Jun 2020 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E270E20874
	for <linux-serial@archiver.kernel.org>; Wed, 24 Jun 2020 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592991250;
	bh=sICbUBxqvnNymzIHTAoebMoDGJFpflFpDIcZ1Z6LF88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YGcfFahQETsdUNkqEdAMiNVvHidTeb5WMSVVmZoL4aw6ghzOedAOXtJ470JOf4L7v
	 AfhS3XS6aAztqeBT2Oc6H9vPjX7nXZKrUINyXBNj9Ip9PGtKKKDPEs7sLkzrJoVZDP
	 xuSvIHryHDBJm+u3/Q++M0FbJfYbn86mUz52jC+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgFXJeJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387495AbgFXJeJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Jun 2020 05:34:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF1220767;
        Wed, 24 Jun 2020 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592991248;
        bh=sICbUBxqvnNymzIHTAoebMoDGJFpflFpDIcZ1Z6LF88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xuve8tMyf3HRgy/Eo1NRgKSXn6+cAf7mU467oGgsAVQxcZsJNvqiJHfPVwVI2xUY8
         hiAfozChkvoklpLt75moy7IyTOm7LbDKR89jESY1Ihn57+LROZJRGcC8zukJFAKVyV
         iEPG2ik34c0NwttLdXBfltgAnADHjss+rVU8AVAo=
Date:   Wed, 24 Jun 2020 11:34:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] tty: serial_core: Fix uart_state refcnt leak when the
 port startup
Message-ID: <20200624093407.GB1751086@kroah.com>
References: <1592052738-95202-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592052738-95202-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 13, 2020 at 08:52:18PM +0800, Xiyu Yang wrote:
> uart_port_startup() invokes uart_port_lock(), which returns a reference
> of the uart_port object if increases the refcount of the uart_state
> object successfully or returns NULL if fails.
> 
> However, uart_port_startup() don't take the return value of
> uart_port_lock() as the new uart_port object to "uport" and use the old
> "uport" instead to balance refcount in uart_port_unlock(), which may
> cause a redundant decrement of refcount occurred when the new "uport"
> equals to NULL and then cause a potential memory leak.
> 
> Fix this issue by update the "uport" object to the return value of
> uart_port_lock() when invoking uart_port_lock().
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57840cf90388..968fd619aec0 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -205,7 +205,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  	if (!page)
>  		return -ENOMEM;
>  
> -	uart_port_lock(state, flags);
> +	uport = uart_port_lock(state, flags);

How is this a different pointer than you originally had?

And if it is a different pointer, shouldn't you be calling this function
and using the pointer much earlier in the function instead of just here?

Can you trigger a problem that this patch solves?  If so, how?

thanks,

greg k-h
