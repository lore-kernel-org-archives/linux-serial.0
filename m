Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20CAC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jun 2022 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiFKHcc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jun 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFKHcc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jun 2022 03:32:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E03A736
        for <linux-serial@vger.kernel.org>; Sat, 11 Jun 2022 00:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB8A5B836C0
        for <linux-serial@vger.kernel.org>; Sat, 11 Jun 2022 07:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC286C34116;
        Sat, 11 Jun 2022 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654932746;
        bh=fnwET/gjBl/grWYuvbexNHt+zdbR/7V7Xz2Jrs9hV5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miaMbcyzVkWOXDXR5iQFEPo8lx1IA+AGMIj2m96V/RSr48XwhmhHXUceX+p2GADhm
         Plmo6XhiLkkwBZ17WjZdnUQSh8cZWjWAIOFly8XrAUnw7nOU3PmWS9x6UFWRpgBqjP
         zsg4GwiHKD9f/TXxflAyW/D+PUWvA+Tqr9U692Xc=
Date:   Sat, 11 Jun 2022 09:32:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cael <juanfengpy@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
Message-ID: <YqRFBMXz7/9SkL5F@kroah.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <YpczhMOT5BvxqL/P@kroah.com>
 <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
 <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com>
 <CAPmgiUL4XU7qeLvCdTe=G0AWMStKVu78GjmdPMzakLqgEei9yQ@mail.gmail.com>
 <Yp4Sh8pMVhwBKUzU@kroah.com>
 <CAPmgiUJzTg7YMuVp=wmZnoDKAjcig7Uw2O-qRxtWc7RU2mP+YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPmgiUJzTg7YMuVp=wmZnoDKAjcig7Uw2O-qRxtWc7RU2mP+YA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 11, 2022 at 02:50:54PM +0800, cael wrote:
> From: cael <juanfengpy@gmail.com>
> Subject: [PATCH] [PATCH v3] tty: fix a possible hang on tty device
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

Is there any specific reason you ignored all of the recommendations from
my previous email as to what needs to be changed in order for this patch
to be accepted?  It doesn't make any sense for me to just keep sending
the same information again :(

thanks,

greg k-h
