Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3EC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 07:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiFOHlN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbiFOHlM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 03:41:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1148E57
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 00:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D741B81C6E
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 07:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8053EC3411C;
        Wed, 15 Jun 2022 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655278867;
        bh=vIoH+XUzMII5fXhja9LAL5OgMI0tz4TMdat2ur7qBnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls4XulGwu6pyv45jUCOZs7CGKbg5mI/SMtVyV5hbkCKb4S8ynsjxemGrPilMbKjmI
         EAdFUbcPNIWKL/ogZOuIeG01Zn+mXsjuvtoYxzKla5EFPdV3KAb/7OWN5cH1se04Tn
         YxSaxNdtT1USJ2ZMoNcmwn8HsvyefCw764hsFCeg=
Date:   Wed, 15 Jun 2022 07:00:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cael <juanfengpy@gmail.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        benbjiang@tencent.com, robinlai@tencent.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] tty: fix hang on tty device with no_room set
Message-ID: <YqlnVBY6IBSQnTFC@kroah.com>
References: <Yqdx0W8HhvT5qZlP@kroah.com>
 <1655264710-26055-1-git-send-email-juanfengpy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655264710-26055-1-git-send-email-juanfengpy@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 15, 2022 at 11:45:10AM +0800, cael wrote:
> We have met a hang on pty device, the reader was blocking
> at epoll on master side, the writer was sleeping at wait_woken
> inside n_tty_write on slave side, and the write buffer on
> tty_port was full, we found that the reader and writer would
> never be woken again and blocked forever.
> 
> The problem was caused by a race between reader and kworker:
> n_tty_read(reader):  n_tty_receive_buf_common(kworker):
>                     |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
>                     |room <= 0
> copy_from_read_buf()|
> n_tty_kick_worker() |
>                     |ldata->no_room = true
> 
> After writing to slave device, writer wakes up kworker to flush
> data on tty_port to reader, and the kworker finds that reader
> has no room to store data so room <= 0 is met. At this moment,
> reader consumes all the data on reader buffer and calls
> n_tty_kick_worker to check ldata->no_room which is false and
> reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if write buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> This problem can be solved with a check for read buffer size inside
> n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> is true, a call to n_tty_kick_worker is necessary to keep flushing
> data to reader.
> 
> Signed-off-by: cael <juanfengpy@gmail.com>
> ---
> Patch changelogs between v1 and v2:
> 	-add barrier inside n_tty_read and n_tty_receive_buf_common;
> 	-comment why barrier is needed;
> 	-access to ldata->no_room is changed with READ_ONCE and WRITE_ONCE;
> Patch changelogs between v2 and v3:
> 	-in function n_tty_receive_buf_common, add unlikely to check
> 	 ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
> 	 is removed here to get locality;
> 	-change comment for barrier to show the race condition to make
> 	 comment easier to understand;
> Patch changelogs between v3 and v4:
> 	-change subject from 'tty: fix a possible hang on tty device' to
> 	 'tty: fix hang on tty device with no_room set' to make subject 
> 	 more obvious.
> 
>  drivers/tty/n_tty.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..544f782b9a11 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
>  	struct n_tty_data *ldata = tty->disc_data;
>  
>  	/* Did the input worker stop? Restart it */
> -	if (unlikely(ldata->no_room)) {
> -		ldata->no_room = 0;
> +	if (unlikely(READ_ONCE(ldata->no_room))) {
> +		WRITE_ONCE(ldata->no_room, 0);
>  
>  		WARN_RATELIMIT(tty->port->itty == NULL,
>  				"scheduling with invalid itty\n");
> @@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  			if (overflow && room < 0)
>  				ldata->read_head--;
>  			room = overflow;
> -			ldata->no_room = flow && !room;
> +			WRITE_ONCE(ldata->no_room, flow && !room);
>  		} else
>  			overflow = 0;
>  
> @@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  	} else
>  		n_tty_check_throttle(tty);
>  
> +	if (unlikely(ldata->no_room)) {
> +		/*
> +		 * Barrier here is to ensure to read the latest read_tail in
> +		 * chars_in_buffer() and to make sure that read_tail is not loaded
> +		 * before ldata->no_room is set, otherwise, following race may occur:
> +		 * n_tty_receive_buf_common() |n_tty_read()
> +		 * chars_in_buffer() > 0      |
> +		 *                            |copy_from_read_buf()->chars_in_buffer()==0
> +		 *                            |if (ldata->no_room)
> +		 * ldata->no_room = 1         |
> +		 * Then both kworker and reader will fail to kick n_tty_kick_worker(),
> +		 * smp_mb is paired with smp_mb() in n_tty_read().
> +		 */
> +		smp_mb();
> +		if (!chars_in_buffer(tty))
> +			n_tty_kick_worker(tty);
> +	}
> +
>  	up_read(&tty->termios_rwsem);
>  
>  	return rcvd;
> @@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
>  		if (time)
>  			timeout = time;
>  	}
> -	if (tail != ldata->read_tail)
> +	if (tail != ldata->read_tail) {
> +		/*
> +		 * Make sure no_room is not read before setting read_tail,
> +		 * otherwise, following race may occur:
> +		 * n_tty_read()		                |n_tty_receive_buf_common()
> +		 * if(ldata->no_room)->false            |
> +		 *			                |ldata->no_room = 1
> +		 *                                      |char_in_buffer() > 0
> +		 * ldata->read_tail = ldata->commit_head|
> +		 * Then copy_from_read_buf() in reader consumes all the data
> +		 * in read buffer, both reader and kworker will fail to kick
> +		 * tty_buffer_restart_work().
> +		 * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
> +		 */
> +		smp_mb();
>  		n_tty_kick_worker(tty);
> +	}
>  	up_read(&tty->termios_rwsem);
>  
>  	remove_wait_queue(&tty->read_wait, &wait);
> -- 
> 2.27.0
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
