Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F216C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbiFAJi1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiFAJiW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 05:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2823B3CA
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 02:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297106153F
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 09:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC44C385A5;
        Wed,  1 Jun 2022 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654076299;
        bh=tIcsqYS/8A1wly7mtuIXSxxHzHpyNQE0R+y+Vref6jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxNDU+Pz86UKSLVS6mtEc/7z3oDeQw/w6AKo6ICZlWJQv/0V3CeH6Q4nVJalU32sJ
         7js/koX9GCTg4m+NctONzRmpIEDGfPmlphYJjmT0C4ah7OcZs6KV+za9kh5vk4wzsF
         tHjhzUt0K/A1cMIal2zFevZ3mgRrhgfR9BwAawTk=
Date:   Wed, 1 Jun 2022 11:38:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cael <juanfengpy@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: tty: fix a possible hang on tty device
Message-ID: <YpczhMOT5BvxqL/P@kroah.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 24, 2022 at 10:21:04AM +0800, cael wrote:
> We have met a hang on pty device, the reader was blocking at
>  epoll on master side, the writer was sleeping at wait_woken inside
>  n_tty_write on slave side ,and the write buffer on tty_port was full, we
>  found that the reader and writer would never be woken again and block
>  forever.
> 
> We thought the problem was caused as a race between reader and
> kworker as follows:
> n_tty_read(reader)| n_tty_receive_buf_common(kworker)
>                   |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
>                   |room <= 0
> copy_from_read_buf|
> n_tty_kick_worker |
>                   |ldata->no_room = true
> 
> After writing to slave device, writer wakes up kworker to flush
> data on tty_port to reader, and the kworker finds that reader
> has no room to store data so room <= 0 is met. At this moment,
> reader consumes all the data on reader buffer and call
> n_tty_kick_worker to check ldata->no_room and finds that there
> is no need to call tty_buffer_restart_work to flush data to reader
> and reader quits reading. Then kworker sets ldata->no_room=true
> and quits too.
> 
> If write buffer is not full, writer will wake kworker to flush data
> again after following writes, but if writer buffer is full and writer
> goes to sleep, kworker will never be woken again and tty device is
> blocked.
> 
> We think this problem can be solved with a check for read buffer
> inside function n_tty_receive_buf_common, if read buffer is empty and
> ldata->no_room is true, this means that kworker has more data to flush
> to read buffer, so a call to n_tty_kick_worker is necessary.
> 
> Signed-off-by: cael <juanfengpy@gmail.com>
> ---
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..36c7bc033c78 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> const unsigned char *cp,
>         } else
>                 n_tty_check_throttle(tty);
> 
> +       if (!chars_in_buffer(tty))
> +               n_tty_kick_worker(tty);
> +
>         up_read(&tty->termios_rwsem);
> 
>         return rcvd;
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
