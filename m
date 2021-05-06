Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90158C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 05:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54028613B4
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 05:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEFFsI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 01:48:08 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:46673 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFFsF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 01:48:05 -0400
Received: by mail-wm1-f42.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so2328581wmi.5;
        Wed, 05 May 2021 22:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y1QA9cAFDAy2BxE1Xko90qQI1rWNNvn9lPjQUNAOt+c=;
        b=sNYkc/VwAgRWkO/XNzDY5+6koYDzy5CNgP+h90K7J/k+a9G0DcxZPfPTiSu6iNYeR3
         NjSsyGvIKunjQkeGovmBkHcL7vyxuQnQ4Seef4zXMSlQgJbJgb4gHwaP1JC52FRg6C2j
         Pvnk8OETlR8PSOQ8wGise2PE0PXnIJ3qp6SO5Xu6l5gRw+br8+RWy5P50ZFH1zsnke06
         C84hMwg2lSdQy9qG8Mxl+qtCi2qIzX4v3SxWfKNnhJHb9H7xFoj0hq1BY1ppAInILkPt
         BbuH6lJE9qbaR4VqRf0YgCQgwaP6U3QYIGgOWSScdTkoABUGjJerentrDD3ErCod6cJv
         SprQ==
X-Gm-Message-State: AOAM531SFKplZkVLJn4INDRIX/TqaSVZvt5nf4vBG3uTCXsw477cHnlE
        cR1C2GGm3ZpfJp05fgko6v4=
X-Google-Smtp-Source: ABdhPJxrbxXDJReErRh48gfTbJ/Iw1JL2twaA5hgZy/xYtjviFjRcm8mtmJ5CGHiIoZmvgQglE5Htw==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr2031996wmb.72.1620280026114;
        Wed, 05 May 2021 22:47:06 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k6sm8126504wmi.42.2021.05.05.22.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 22:47:05 -0700 (PDT)
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Henderson <rth@twiddle.net>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-26-jslaby@suse.cz>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 25/35] tty: remove tty_operations::chars_in_buffer for
 non-buffering
Message-ID: <40c8a109-9161-621e-f8cd-c43fdba6dac2@kernel.org>
Date:   Thu, 6 May 2021 07:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210505091928.22010-26-jslaby@suse.cz>
Content-Type:   text/plain; charset=US-ASCII;
        format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05. 05. 21, 11:19, Jiri Slaby wrote:
> The only user of tty_ops::chars_in_buffer is tty_chars_in_buffer. And it
> considers tty_ops::chars_in_buffer optional. In case it's NULL, zero is
> returned. So remove all those chars_in_buffer from tty_ops which return
> zero. (Zero means such driver doesn't buffer.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>


> c: Richard Henderson <rth@twiddle.net>

Uh, "C" is a fugitive. Wanted dead or alive.

So should I send a v2 with:
Cc: Richard Henderson <rth@twiddle.net>
?

> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   arch/alpha/kernel/srmcons.c         |  7 -------
>   arch/parisc/kernel/pdc_cons.c       |  6 ------
>   arch/xtensa/platforms/iss/console.c |  7 -------
>   drivers/s390/char/tty3270.c         | 12 ------------
>   drivers/tty/pty.c                   | 17 -----------------
>   drivers/tty/vt/vt.c                 |  6 ------
>   6 files changed, 55 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index 2110b7e7f988..fc03471a0b0f 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -148,12 +148,6 @@ srmcons_write_room(struct tty_struct *tty)
>   	return 512;
>   }
>   
> -static int
> -srmcons_chars_in_buffer(struct tty_struct *tty)
> -{
> -	return 0;
> -}
> -
>   static int
>   srmcons_open(struct tty_struct *tty, struct file *filp)
>   {
> @@ -200,7 +194,6 @@ static const struct tty_operations srmcons_ops = {
>   	.close		= srmcons_close,
>   	.write		= srmcons_write,
>   	.write_room	= srmcons_write_room,
> -	.chars_in_buffer= srmcons_chars_in_buffer,
>   };
>   
>   static int __init
> diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
> index fe2ed0bbd07e..39ccad063533 100644
> --- a/arch/parisc/kernel/pdc_cons.c
> +++ b/arch/parisc/kernel/pdc_cons.c
> @@ -108,17 +108,11 @@ static unsigned int pdc_console_tty_write_room(struct tty_struct *tty)
>   	return 32768; /* no limit, no buffer used */
>   }
>   
> -static int pdc_console_tty_chars_in_buffer(struct tty_struct *tty)
> -{
> -	return 0; /* no buffer */
> -}
> -
>   static const struct tty_operations pdc_console_tty_ops = {
>   	.open = pdc_console_tty_open,
>   	.close = pdc_console_tty_close,
>   	.write = pdc_console_tty_write,
>   	.write_room = pdc_console_tty_write_room,
> -	.chars_in_buffer = pdc_console_tty_chars_in_buffer,
>   };
>   
>   static void pdc_console_poll(struct timer_list *unused)
> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 98ac3a7fdb0a..21184488c277 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -106,12 +106,6 @@ static unsigned int rs_write_room(struct tty_struct *tty)
>   	return 2 * 1024;
>   }
>   
> -static int rs_chars_in_buffer(struct tty_struct *tty)
> -{
> -	/* the iss doesn't buffer characters */
> -	return 0;
> -}
> -
>   static void rs_hangup(struct tty_struct *tty)
>   {
>   	/* Stub, once again.. */
> @@ -135,7 +129,6 @@ static const struct tty_operations serial_ops = {
>   	.put_char = rs_put_char,
>   	.flush_chars = rs_flush_chars,
>   	.write_room = rs_write_room,
> -	.chars_in_buffer = rs_chars_in_buffer,
>   	.hangup = rs_hangup,
>   	.wait_until_sent = rs_wait_until_sent,
>   	.proc_show = rs_proc_show,
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 82d4c961ed06..ba1fbce63fee 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -1756,17 +1756,6 @@ tty3270_flush_chars(struct tty_struct *tty)
>   	}
>   }
>   
> -/*
> - * Returns the number of characters in the output buffer. This is
> - * used in tty_wait_until_sent to wait until all characters have
> - * appeared on the screen.
> - */
> -static int
> -tty3270_chars_in_buffer(struct tty_struct *tty)
> -{
> -	return 0;
> -}
> -
>   static void
>   tty3270_flush_buffer(struct tty_struct *tty)
>   {
> @@ -1892,7 +1881,6 @@ static const struct tty_operations tty3270_ops = {
>   	.put_char = tty3270_put_char,
>   	.flush_chars = tty3270_flush_chars,
>   	.write_room = tty3270_write_room,
> -	.chars_in_buffer = tty3270_chars_in_buffer,
>   	.flush_buffer = tty3270_flush_buffer,
>   	.throttle = tty3270_throttle,
>   	.unthrottle = tty3270_unthrottle,
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index eb8556b19592..5ada7e9381eb 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -143,19 +143,6 @@ static unsigned int pty_write_room(struct tty_struct *tty)
>   	return tty_buffer_space_avail(tty->link->port);
>   }
>   
> -/**
> - *	pty_chars_in_buffer	-	characters currently in our tx queue
> - *	@tty: our tty
> - *
> - *	Report how much we have in the transmit queue. As everything is
> - *	instantly at the other end this is easy to implement.
> - */
> -
> -static int pty_chars_in_buffer(struct tty_struct *tty)
> -{
> -	return 0;
> -}
> -
>   /* Set the lock flag on a pty */
>   static int pty_set_lock(struct tty_struct *tty, int __user *arg)
>   {
> @@ -525,7 +512,6 @@ static const struct tty_operations master_pty_ops_bsd = {
>   	.write = pty_write,
>   	.write_room = pty_write_room,
>   	.flush_buffer = pty_flush_buffer,
> -	.chars_in_buffer = pty_chars_in_buffer,
>   	.unthrottle = pty_unthrottle,
>   	.ioctl = pty_bsd_ioctl,
>   	.compat_ioctl = pty_bsd_compat_ioctl,
> @@ -541,7 +527,6 @@ static const struct tty_operations slave_pty_ops_bsd = {
>   	.write = pty_write,
>   	.write_room = pty_write_room,
>   	.flush_buffer = pty_flush_buffer,
> -	.chars_in_buffer = pty_chars_in_buffer,
>   	.unthrottle = pty_unthrottle,
>   	.set_termios = pty_set_termios,
>   	.cleanup = pty_cleanup,
> @@ -776,7 +761,6 @@ static const struct tty_operations ptm_unix98_ops = {
>   	.write = pty_write,
>   	.write_room = pty_write_room,
>   	.flush_buffer = pty_flush_buffer,
> -	.chars_in_buffer = pty_chars_in_buffer,
>   	.unthrottle = pty_unthrottle,
>   	.ioctl = pty_unix98_ioctl,
>   	.compat_ioctl = pty_unix98_compat_ioctl,
> @@ -794,7 +778,6 @@ static const struct tty_operations pty_unix98_ops = {
>   	.write = pty_write,
>   	.write_room = pty_write_room,
>   	.flush_buffer = pty_flush_buffer,
> -	.chars_in_buffer = pty_chars_in_buffer,
>   	.unthrottle = pty_unthrottle,
>   	.set_termios = pty_set_termios,
>   	.start = pty_start,
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 96c130714930..b838f656f4cd 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3270,11 +3270,6 @@ static unsigned int con_write_room(struct tty_struct *tty)
>   	return 32768;		/* No limit, really; we're not buffering */
>   }
>   
> -static int con_chars_in_buffer(struct tty_struct *tty)
> -{
> -	return 0;		/* we're not buffering */
> -}
> -
>   /*
>    * con_throttle and con_unthrottle are only used for
>    * paste_selection(), which has to stuff in a large number of
> @@ -3521,7 +3516,6 @@ static const struct tty_operations con_ops = {
>   	.write_room = con_write_room,
>   	.put_char = con_put_char,
>   	.flush_chars = con_flush_chars,
> -	.chars_in_buffer = con_chars_in_buffer,
>   	.ioctl = vt_ioctl,
>   #ifdef CONFIG_COMPAT
>   	.compat_ioctl = vt_compat_ioctl,
> 


-- 
js
suse labs
