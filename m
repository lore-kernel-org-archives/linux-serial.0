Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F75CC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1199661244
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhKHJoe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236838AbhKHJod (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 04:44:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5B1961242;
        Mon,  8 Nov 2021 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636364509;
        bh=KubNRzNxhXVYig4fprNmbCEDI0o1MB2KC5bqwRxBdsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXiQvIp/aMZhEW+2/cYq+GecvOAMtof+uzLEZJPzHvylPVEA2Uqq9CHCHwGfWhi1k
         Yk4NhLWGUbGlb/4uIrYpDtMsfdAqnfQedlb/bcfOIlIocFZFsG0RaY+ugq/FeMFVJm
         EqsjmdFwO65Hw9kiSdYj6L+uutw+CNzd9ljGNT5J7n7BCY9waoQUPYzDwVH9robrpy
         AcOnHMDijykttGdwyiSpR3R9fXGTINCP3fiyXr8fWPFY2YLCVyAe8rvLP0Hare3nlc
         TAN+qUOflI3jZsILRsr0hIrJuYm91tQZwnpNfmQf9blfIzVBSDR2bCLgvzfW7wW/Rh
         0KzhQAQDa72GA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mk19u-0003VH-7U; Mon, 08 Nov 2021 10:41:46 +0100
Date:   Mon, 8 Nov 2021 10:41:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
Message-ID: <YYjw2mRIhy1SoIb+@hovoldconsulting.com>
References: <20211107031721.4734-1-ajaygargnsit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211107031721.4734-1-ajaygargnsit@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

First, please fix your patch Subject which is way too verbose. You
should aim at less than 72 chars including prefix. Something like

	"vt: keyboard: suppress smatch warning in vt_do_kdgkb_ioctl"

should do.

On Sun, Nov 07, 2021 at 08:47:21AM +0530, Ajay Garg wrote:
> smatch-kchecker gives the following warnings when run on keyboard.c :
> 
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
> vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.
> 
> This usually happens when switch has no default case and static 
> analyzers and even sometimes compilers can’t prove that all possible 
> values are covered.
>
> Thus, the default switch-case has been added, which sets the values 
> for the two variables :
> 
>         * kbs as NULL, which also nicely fits in with kfree.
> 
>         * ret as -ENOIOCTLCMD (on same lines if there is no cmd
>                                match in "vt_do_kdskled" method).

Not sure how far we want to take the suppression of false-positive
warnings but at least this isn't the right way to do it.

> Many thanks to the following for review of previous versions :
> 
> 	* Pavel Skripkin <paskripkin@gmail.com> 
> 	* Andy Shevchenko <andy.shevchenko@gmail.com> 
> 
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
> 
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
> 
>  drivers/tty/vt/keyboard.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..f66c32fe7ef1 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2090,6 +2090,10 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  
>  		ret = 0;
>  		break;
> +	default:
> +		kbs = NULL;
> +		ret = -ENOIOCTLCMD;
> +		break;
>  	}
>  
>  	kfree(kbs);

Instead, move the kfree() into the two cases blocks and initialise ret
to 0 as is done in several other vt helpers in case a driver bug ever
causes them to be called for the wrong cmds (e.g. instead of sprinkling
WARN_ON(1) in all those functions).

You may want to mention that the kfree warning was introduced by 

	07edff926520 ("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")

which moved the shared allocation into the switch statement, and perhaps
also mention

	4e1404a5cd04 ("vt: keyboard, extract and simplify vt_kdskbsent")

for the ret warning.

Johan
