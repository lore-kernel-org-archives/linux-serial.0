Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9FCCA473
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbiFAP3K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355551AbiFAP3H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 11:29:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F0A0D0D
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654097341; x=1685633341;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JVETdB9TkIbPk1WGZwErbJeI25SRbUj9sRypXG2evJ8=;
  b=cbfMrkPU6hgwFBdJKajM2aitAgREYze9OfYDwNTGFrOO4eJeBaKp4xbC
   z82yqMUjX2NXx+Njz1zOnOt5tMUCLbsYlcnB+m1olgAYSqVuXMOcA9IKm
   Ijefs3uWqExqV1nRcXbvsq1vJeDMLURTZ9P0/rBS9UlRcFKagh7nb0lS+
   G7v7CJfzUoA/RPknf3wPvZ3gVlhCQFTmq7jXFU9HLi/OGFKKRs+E6rbSU
   M3xVUXMxWOoyAmkgdeo4CbqCZ1Koi7hYW+AED9zOaQvIwVH6KQA05mKy/
   sBXssi+8w/bRNfsincxN+BdvNcbZP0ouIF1RIWG1AMJQVABryBI5bKMIS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="300981758"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="300981758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:29:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="606323583"
Received: from ksulliv1-mobl.ger.corp.intel.com ([10.251.214.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:28:58 -0700
Date:   Wed, 1 Jun 2022 18:28:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
Message-ID: <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com> <YpczhMOT5BvxqL/P@kroah.com> <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-725870110-1654097340=:1728"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-725870110-1654097340=:1728
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jun 2022, cael wrote:

> From: cael <juanfengpy@gmail.com>
> Subject: [PATCH v2] tty: fix a possible hang on tty device
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
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

You should not add Reviewed-by on your own. Only after the person 
himself/herself gives that tag for you, include it.

> 
> ---
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..21241ea7cdb9 100644
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
> @@ -1663,6 +1663,21 @@ n_tty_receive_buf_common(struct tty_struct
> *tty, const unsigned char *cp,
>         } else
>                 n_tty_check_throttle(tty);
> 
> +       if (READ_ONCE(ldata->no_room)) {

Hmm, since this function is only one setting it to non-zero value, perhaps 
the information could be carried over here in a no_room local var (and 
maybe unlikely() would be useful too similar to n_tty_kick_worker). After 
all, this check is just an optimization for the common case where we know 
no_room is definitely zero.

> +               /*
> +                * Reader ensures that read_tail is updated before
> checking no_room,
> +                * make sure that no_room is set before reading read_tail here.



> +                * Now no_room is visible by reader, the race needs to
> be handled is
> +                * that reader has passed checkpoint for no_room and
> reader buffer
> +                * is empty, if so n_tty_kick_worker will not be
> called by reader,
> +                * instead, this function is called here.

This part is hard to parse/understand. Please try to rephrase.


-- 
 i.

--8323329-725870110-1654097340=:1728--
