Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F3C001B0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjHPOoh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbjHPOoL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 10:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2B26BD
        for <linux-serial@vger.kernel.org>; Wed, 16 Aug 2023 07:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB43D669E8
        for <linux-serial@vger.kernel.org>; Wed, 16 Aug 2023 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DC6C433C7;
        Wed, 16 Aug 2023 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692197032;
        bh=j1MVj+OpwEGVwZT9tlmdxhCZhNYqO+NIpG+UeJfImsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTDmov8wtPASUCPQvAcZKF+cboT9w36KkERu5NFintbPcZwwddixsx2MizgP5v77z
         dk4k3oLI8zN5DD0QIMK3Gf1Oaix08idQm9G2qBbA/7vpAyopSn9qPeYU9uakiCFryc
         nz9HUeP1UIsU+gFTi66DPH2P4zojxEIG7TYxqaUk=
Date:   Wed, 16 Aug 2023 16:43:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     jirislaby@kernel.org, jannh@google.com,
        linux-serial@vger.kernel.org, guozihua@huawei.com
Subject: Re: [PATCH V3 RESEND] tty: tty_jobctrl: fix pid memleak in
 disassociate_ctty()
Message-ID: <2023081639-ambitious-seventeen-9537@gregkh>
References: <20230816025700.179769-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816025700.179769-1-yiyang13@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 16, 2023 at 10:57:00AM +0800, Yi Yang wrote:
> There is a pid leakage:
> ------------------------------
> unreferenced object 0xffff88810c181940 (size 224):
>   comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
>     ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
>   backtrace:
>     [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
>     [<ffffffff81177342>] alloc_pid+0x72/0x570
>     [<ffffffff81140ac4>] copy_process+0x1374/0x2470
>     [<ffffffff81141d77>] kernel_clone+0xb7/0x900
>     [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
>     [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
>     [<ffffffff83965a72>] do_syscall_64+0x32/0x80
>     [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> It turns out that there is a race condition between disassociate_ctty() and
> tty_signal_session_leader(), which caused this leakage.
> 
> The pid memleak is triggered by the following race:
> task[sshd]                     task[bash]
> -----------------------        -----------------------
>                                disassociate_ctty();
>                                spin_lock_irq(&current->sighand->siglock);
>                                put_pid(current->signal->tty_old_pgrp);
>                                current->signal->tty_old_pgrp = NULL;
>                                tty = tty_kref_get(current->signal->tty);
>                                spin_unlock_irq(&current->sighand->siglock);
> tty_vhangup();
> tty_lock(tty);
> ...
> tty_signal_session_leader();
> spin_lock_irq(&p->sighand->siglock);
> ...
> if (tty->ctrl.pgrp) //tty->ctrl.pgrp is not NULL
> p->signal->tty_old_pgrp = get_pid(tty->ctrl.pgrp); //An extra get
> spin_unlock_irq(&p->sighand->siglock);
> ...
> tty_unlock(tty);
>                                if (tty) {
>                                    tty_lock(tty);
>                                    ...
>                                    put_pid(tty->ctrl.pgrp);
>                                    tty->ctrl.pgrp = NULL; //It's too late
>                                    ...
>                                    tty_unlock(tty);
>                                }
> 
> The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
> Fix ->session locking") who moves the unlock of siglock in
> disassociate_ctty() above "if (tty)", making a small window allowing
> tty_signal_session_leader() to kick in. It can be easily reproduced by
> adding a delay before "if (tty)" and at the entrance of
> tty_signal_session_leader().
> 
> To fix this issue, we move "put_pid(current->signal->tty_old_pgrp)" after
> "tty->ctrl.pgrp = NULL".
> 
> Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> Co-developed-by: GUO Zihua <guozihua@huawei.com>
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  drivers/tty/tty_jobctrl.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> index 0d04287da098..ef8741c3e662 100644
> --- a/drivers/tty/tty_jobctrl.c
> +++ b/drivers/tty/tty_jobctrl.c
> @@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
>  		return;
>  	}
>  
> -	spin_lock_irq(&current->sighand->siglock);
> -	put_pid(current->signal->tty_old_pgrp);
> -	current->signal->tty_old_pgrp = NULL;
> -	tty = tty_kref_get(current->signal->tty);
> -	spin_unlock_irq(&current->sighand->siglock);
> -
> +	tty = get_current_tty();
>  	if (tty) {
>  		unsigned long flags;
>  
> @@ -320,6 +315,16 @@ void disassociate_ctty(int on_exit)
>  		tty_kref_put(tty);
>  	}
>  
> +	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
> +	 * current->signal->tty_old_pgrp in a race condition, and
> +	 * cause pid memleak. Release current->signal->tty_old_pgrp
> +	 * after tty->ctrl.pgrp set to NULL.
> +	 */
> +	spin_lock_irq(&current->sighand->siglock);
> +	put_pid(current->signal->tty_old_pgrp);
> +	current->signal->tty_old_pgrp = NULL;
> +	spin_unlock_irq(&current->sighand->siglock);
> +
>  	/* Now clear signal->tty under the lock */
>  	read_lock(&tasklist_lock);
>  	session_clear_tty(task_session(current));
> -- 
> 2.17.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
