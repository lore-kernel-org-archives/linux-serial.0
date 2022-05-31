Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B549C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbiEaMiF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiEaMiE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 08:38:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC63FDA8
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654000680; x=1685536680;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=k2EgNnsBxxXP9wtUzeBA+wpoh8NZLqKoWN7RbDsPcDc=;
  b=Fw9UAJDFwzc4xcpJ8nMGvUrJw2hzOA8XCWnAeL4sZb5ymWlxpili1M5g
   C4Jtil4D3TmmOKySypj96KwDVa9lr3MTZV12ZD+uptarNWG2gP7yZ39If
   f4eJihy+lqs4KlHkbDYNyxqpPCNikxP7DzrqaimCHANYtB3g/DZliT3Bu
   jq+QwDRKJRurV0Vs4m/WLHllaPwTEmEg7Ur2RepxT3iWAHMT4xbOe53S3
   y+iM1hPKLvfIhHhyLcP43AE11LuHpivCK4Iw74db+hu38LaxaLC//I5cO
   sG7IYiWgeXzWQyyyVEVWUGrIMsop/Q4ETANFDnM1VlTO2APzcDP0zsCuM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="262873921"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="262873921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 05:37:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="605653825"
Received: from schiavaz-mobl.ger.corp.intel.com ([10.249.37.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 05:37:57 -0700
Date:   Tue, 31 May 2022 15:37:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiUK=aTDJjPYooQGDbNvdOs+z6AbAj5zU7e_0SJhSk2pz9w@mail.gmail.com>
Message-ID: <857fdbc-acc2-de4-fe2e-229b7a175ad@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com> <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com> <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
 <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com> <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com> <CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com> <269a9a97-dc62-a89-d978-3be8e9d1f7e4@linux.intel.com>
 <CAPmgiUK=aTDJjPYooQGDbNvdOs+z6AbAj5zU7e_0SJhSk2pz9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-940553179-1653990493=:1619"
Content-ID: <2ae579b7-888-bf60-867c-c485a104688@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-940553179-1653990493=:1619
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <32e18fd3-563c-189c-1f3-bffba976c5d3@linux.intel.com>

On Mon, 30 May 2022, cael wrote:

> Thanks, You are right, barrier is needed here. I changed the patch as follows:
> 1) WRITE_ONCE and READ_ONCE is used to access ldata->no_room since
> n_tty_kick_worker  would be called in kworker and reader cpu;
> 2) smp_mb added in chars_in_buffer as this function will be called in
> reader and kworker, accessing commit_head and read_tail; and to make
> sure that read_tail is not read before setting no_room in
> n_tty_receive_buf_common;
> 3) smp_mb added in n_tty_read to make sure that no_room is not read
> before setting read_tail.

Please include proper changelog to all revised patch submissions, not 
just list of changes you've made (and properly version the submissions 
with [PATCH v2] etc. in the subject).

> ---
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index efc72104c840..3327687da0d3 100644
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
>                 WARN_RATELIMIT(tty->port->itty == NULL,
>                                 "scheduling with invalid itty\n");
> @@ -221,6 +221,7 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
>         struct n_tty_data *ldata = tty->disc_data;
>         ssize_t n = 0;
> 
> +       smp_mb();

You should add the reason in comment for any barriers you add.

>         if (!ldata->icanon)
>                 n = ldata->commit_head - ldata->read_tail;
>         else
> @@ -1632,7 +1633,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> const unsigned char *cp,
>                         if (overflow && room < 0)
>                                 ldata->read_head--;
>                         room = overflow;
> -                       ldata->no_room = flow && !room;
> +                       WRITE_ONCE(ldata->no_room, flow && !room);
>                 } else
>                         overflow = 0;
> 
> @@ -1663,6 +1664,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> const unsigned char *cp,
>         } else
>                 n_tty_check_throttle(tty);
> 
> +       if (!chars_in_buffer(tty))
> +               n_tty_kick_worker(tty);
> +

Instead of having the barrier in chars_in_buffer() perhaps it would be 
more obvious what's going on here and also scope down to the cases where 
the barrier might be needed in the first place if you'd do:

	if (ldata->no_room) {
		/* ... */
		smp_mb();
		if (!chars_in_buffer(tty))
			n_tty_kick_worker(tty);
	}


-- 
 i.

>         up_read(&tty->termios_rwsem);
> 
>         return rcvd;
> @@ -2180,8 +2184,10 @@ static ssize_t n_tty_read(struct tty_struct
> *tty, struct file *file,
>                 if (time)
>                         timeout = time;
>         }
> -       if (tail != ldata->read_tail)
> +       if (tail != ldata->read_tail) {
> +               smp_mb();
>                 n_tty_kick_worker(tty);
> +       }
>         up_read(&tty->termios_rwsem);
> 
>         remove_wait_queue(&tty->read_wait, &wait);
> --
> 2.27.0
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 于2022年5月25日周三 19:21写道：
> >
> > On Wed, 25 May 2022, cael wrote:
> >
> > > >Now you switched to an entirely different case, not the one we were
> > > >talking about. ...There is no ldisc->no_room = true race in the case
> > > >you now described.
> > > So, I think we should back to the case ldata->no_room=true as
> > > ldata->no_room=false seems harmless.
> > >
> > > >I'm not worried about the case where both cpus call n_tty_kick_worker but
> > > >the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
> > > >!no_room.
> > >
> > > As ldata->no_room=true is set before checking chars_in_buffer()
> >
> > Please take a brief look at Documentation/memory-barriers.txt and then
> > tell me if you still find this claim to be true.
> >
> > > if producer
> > > finds chars_in_buffer() > 0, then if reader is currently in n_tty_read,
> >
> > ...Then please do a similar analysis for ldata->read_tail. What guarantees
> > its update is seen by the producer cpu when the reader is already past the
> > point you think it still must be in?
> >
> > > when reader quits n_tty_read, n_tty_kick_worker will be called. If reader
> > > has already exited n_tty_read, which means that reader still has data to read,
> > > next time reader will call n_tty_kick_worker inside n_tty_read too.
> >
> > C-level analysis alone is not going to be very useful here given you're
> > dealing with a concurrency challenge here.
> >
> >
> > --
> >  i.
> >
> >
> 
--8323329-940553179-1653990493=:1619--
