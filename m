Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA1C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70B861181
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhKHNzV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235081AbhKHNzU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 08:55:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 137E96124D;
        Mon,  8 Nov 2021 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636379556;
        bh=kbc0rwSm5a8mYAz5zctvLsZ3j+RGrQGOjUVOM0UCaMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkm9CgPcOC6OWlVj4ziTMMbGV0b8C5rmTiUZwsEE27dWHxmmshgCLbILiCYfo0YRp
         pi0kK0NFg971R7qYtnn+L15Q15L4dd5oDk0+4wFYIDwH4lZjhCHSfJm+ncRIJBzems
         CiiklddKWEMQ0CLXEauD7KekhZO/sXvsRpIrEtYg=
Date:   Mon, 8 Nov 2021 14:52:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        kernel@esmil.dk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        johan@kernel.org
Subject: Re: [PATCH v5] vt: keyboard: suppress warnings in vt_do_kdgkb_ioctl
Message-ID: <YYkroa2v1ruwPRBN@kroah.com>
References: <20211108134901.7449-1-ajaygargnsit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108134901.7449-1-ajaygargnsit@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 08, 2021 at 07:19:01PM +0530, Ajay Garg wrote:
> smatch-kchecker gives the following warnings when run on keyboard.c :
> 
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
> 
> i)
> The 'kbs" warning was introduced by "07edff926520" :
> ("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")
> 
> * 
> prior 07edff926520, the scope of kbs (allocation/deallocation) was
> external to switch-cases.
> 
> *
> post 07edff926520, kbs is allocated internally for each case, however the
> deallocation remains external.
> 
> Thus, as the "fix", the scope of kbs deallocation is now made internal
> to each switch case.
> 
> ii)
> The 'ret' warning is the result of "4e1404a5cd04" :
> ("vt: keyboard, extract and simplify vt_kdskbsent")
> 
> where the "ret = 0" (right at the end) was accidentally removed.
> 
> Bringing back the above in a slightly different way, by initializing ret
> to 0 at the start.
> 
> Many thanks to the following for review of previous versions :
> 
> 	* Pavel Skripkin <paskripkin@gmail.com> 
> 	* Andy Shevchenko <andy.shevchenko@gmail.com> 
> 	* Johan Hovold <johan@kernel.org>
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
> 
> There were discussions previously, and the current patch is the 
> result.
> 
> v1 :
> https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t
> 
> v2 :
> https://lore.kernel.org/linux-serial/CAHP4M8Vdj4Eb8q773BeHvsW9n6t=3n1WznuXAR4fZCNi1J6rOg@mail.gmail.com/T/#m18f45676feaba6b1f01ddd5fe607997b190ef4b9
> 
> v3 :
> https://lore.kernel.org/linux-serial/20211106220315.392842-1-ajaygargnsit@gmail.com/T/#u
> 
> v4 :
> https://lore.kernel.org/linux-serial/YYjw2mRIhy1SoIb+@hovoldconsulting.com/T/#mf25ca00a93e278bbb8f0382a4f7752dc35f4aa8b
> 
> Changes in v2 :
> 
>         * Changes as required by scripts/checkpatch.pl
> 
>         * Checking whether kbs is not NULL before kfree is not required,
>           as kfree(NULL) is safe. So, dropped the check.
> 
> Changes in v3 :
> 
>         * Using default-switch case, and setting the variables 
>           when there is no matching cmd.
> 
> Changes in v4 :
> 
>         * Removed braces for the default switch-case.
> 
> Changes in v5 :
> 
>         * Incorporating changes as suggested by Johan Hovold
>  	  (please see v4 link).
> 
>  drivers/tty/vt/keyboard.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..ea19671d5d0c 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2050,7 +2050,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  	unsigned char kb_func;
>  	unsigned long flags;
>  	char *kbs;
> -	int ret;
> +	int ret = 0;
>  
>  	if (get_user(kb_func, &user_kdgkb->kb_func))
>  		return -EFAULT;
> @@ -2073,6 +2073,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>  			-EFAULT : 0;
>  
> +		kfree(kbs);
>  		break;
>  	}
>  	case KDSKBSENT:
> @@ -2088,11 +2089,11 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  		kbs = vt_kdskbsent(kbs, kb_func);
>  		spin_unlock_irqrestore(&func_buf_lock, flags);
>  
> +		kfree(kbs);
>  		ret = 0;
>  		break;
>  	}
>  
> -	kfree(kbs);
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
