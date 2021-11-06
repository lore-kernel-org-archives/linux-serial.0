Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4FC433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA446108B
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhKFJoj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 05:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhKFJoj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 05:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98BEA6112D;
        Sat,  6 Nov 2021 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636191718;
        bh=sSl9L01mAckz72bCozkyppermy/9l5Izyr9s6eoUk60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmt4ooBgwB3y4FRQHRHG7gvR7nr2fMKxXql+EUM3zck5eAcnDc2kX/NaSC8pA+JQo
         MfjH1nil41Uq3GdRmjs0M7ba3A5sRospbYYGUX1DJwFfNGGTXlecTT0PnB64v6uCX8
         qoSJ2mtlwg7sSNyWrUhTYLb8lbAg+oZN1hntMduk=
Date:   Sat, 6 Nov 2021 10:41:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: keyboard: Free dynamic-memory only if
 kmalloc'ed.
Message-ID: <YYZN30qfaKMskVwE@kroah.com>
References: <20211106093202.44518-1-ajaygargnsit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106093202.44518-1-ajaygargnsit@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Nov 06, 2021 at 03:02:02PM +0530, Ajay Garg wrote:
> In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of
> KDGKBSENT or KDGSKBSENT.
> 
> If cmd is none of the above, no kbs is kmalloced, and thus,
> kbs must only be kfreed if it is really kmalloced.
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index dfef7de8a057..95839987c79c 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2049,7 +2049,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  {
>  	unsigned char kb_func;
>  	unsigned long flags;
> -	char *kbs;
> +	char *kbs = NULL;
>  	int ret;
>  
>  	if (get_user(kb_func, &user_kdgkb->kb_func))
> @@ -2092,7 +2092,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  		break;
>  	}
>  
> -	kfree(kbs);
> +        if(kbs)
> +            kfree(kbs);
>  
>  	return ret;
>  }
> -- 
> 2.30.2
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
