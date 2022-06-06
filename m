Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5715C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbiFFOn3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiFFOn2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 10:43:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42BC45AF7
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 07:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1063EB819FD
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F1C385A9;
        Mon,  6 Jun 2022 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654526602;
        bh=d6ULalj4EuAINZ/fROXWDyCNJXTlGYQPsEsRdlUvjXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1NEVPthQ8Ymh6puFaAvZDIkwzwh9P62qbkKDXEqe6SKlYmPE34p/u+cTKu5MLF1QQ
         Pjnn0ZyYUpz9E/JhGMgVWwWVjTnspoBESwQLDkNOfVzOnJ4vyyMFaLLUhJOGTYvfAn
         zWcc0cistB1GBiTDqz0HTxKB2A9k2249RRi90dcQ=
Date:   Mon, 6 Jun 2022 16:43:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cael <juanfengpy@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
Message-ID: <Yp4Sh8pMVhwBKUzU@kroah.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <YpczhMOT5BvxqL/P@kroah.com>
 <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
 <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com>
 <CAPmgiUL4XU7qeLvCdTe=G0AWMStKVu78GjmdPMzakLqgEei9yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPmgiUL4XU7qeLvCdTe=G0AWMStKVu78GjmdPMzakLqgEei9yQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 06, 2022 at 09:40:16PM +0800, cael wrote:
> From: cael <juanfengpy@gmail.com>
> Subject:[PATCH v3] tty: fix a possible hang on tty device
> 
> We have met a hang on pty device, the reader was blocking
> at epoll on master side, the writer was sleeping at wait_woken
> inside n_tty_write on slave side, and the write buffer on
> tty_port was full, we found that the reader and writer would
> never be woken again and block forever.
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
> reader consumes all the data on reader buffer and call
> n_tty_kick_worker to check ldata->no_room which is false and
> reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if writer buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> This problem can be solved with a check for read buffer size inside
> n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> is true, a call to n_tty_kick_worker is necessary to keep flushing
> data to reader.
> 
> Signed-off-by: cael <juanfengpy@gmail.com>
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..544f782b9a11 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
>         struct n_tty_data *ldata = tty->disc_data;
> 
>         /* Did the input worker stop? Restart it */
> -       if (unlikely(ldata->no_room)) {
> -               ldata->no_room = 0;
> +       if (unlikely(READ_ONCE(ldata->no_room))) {
> +               WRITE_ONCE(ldata->no_room, 0);
> 
>                 WARN_RATELIMIT(tty->port->itty == NULL,
>                                 "scheduling with invalid itty\n");
> @@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> const unsigned char *cp,
>                         if (overflow && room < 0)
>                                 ldata->read_head--;
>                         room = overflow;
> -                       ldata->no_room = flow && !room;
> +                       WRITE_ONCE(ldata->no_room, flow && !room);
>                 } else
>                         overflow = 0;
> 
> @@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct
> *tty, const unsigned char *cp,
>         } else
>                 n_tty_check_throttle(tty);
> 
> +       if (unlikely(ldata->no_room)) {
> +               /*
> +                * Barrier here is to ensure to read the latest read_tail in
> +                * chars_in_buffer() and to make sure that read_tail
> is not loaded
> +                * before ldata->no_room is set, otherwise, following
> race may occur:
> +                * n_tty_receive_buf_common() |n_tty_read()
> +                * chars_in_buffer() > 0      |
> +                *
> |copy_from_read_buf()->chars_in_buffer()==0
> +                *                            |if (ldata->no_room)
> +                * ldata->no_room = 1         |
> +                * Then both kworker and reader will fail to kick
> n_tty_kick_worker(),
> +                * smp_mb is paired with smp_mb() in n_tty_read().
> +                */
> +               smp_mb();
> +               if (!chars_in_buffer(tty))
> +                       n_tty_kick_worker(tty);
> +       }
> +
>         up_read(&tty->termios_rwsem);
> 
>         return rcvd;
> @@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct
> *tty, struct file *file,
>                 if (time)
>                         timeout = time;
>         }
> -       if (tail != ldata->read_tail)
> +       if (tail != ldata->read_tail) {
> +               /*
> +                * Make sure no_room is not read before setting read_tail,
> +                * otherwise, following race may occur:
> +                * n_tty_read()
> |n_tty_receive_buf_common()
> +                * if(ldata->no_room)->false            |
> +                *                                      |ldata->no_room = 1
> +                *                                      |char_in_buffer() > 0
> +                * ldata->read_tail = ldata->commit_head|
> +                * Then copy_from_read_buf() in reader consumes all the data
> +                * in read buffer, both reader and kworker will fail to kick
> +                * tty_buffer_restart_work().
> +                * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
> +                */
> +               smp_mb();
>                 n_tty_kick_worker(tty);
> +       }
>         up_read(&tty->termios_rwsem);
> 
>         remove_wait_queue(&tty->read_wait, &wait);
> -- 
> 2.27.0


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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

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
