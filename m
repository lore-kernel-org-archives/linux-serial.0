Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B07C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 13:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiEXNZ0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiEXNZZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 09:25:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A7994F6
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653398724; x=1684934724;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nQfspCX8oO5ousKoRFyT71OvDK6WUIhKunEDI6ydgcI=;
  b=GduYDUBLhDl0tFMxkB+u0B7/1IAIO33AfHyOGzInB7jYLK5xx/JzM8wJ
   inLnmhxcNCtirI0sI7qM9HaYL3Ak5Be1dj8yAxm3B8xYcxYjs8gqv5ksF
   cIVvswS/39Pl3PsLqsYAiatFxxzsCXzIVvPa574co5X4StTiG32C4XpIX
   vWOYyw5CxT3Rge8ciT0BV3B50JWX71vr0Y6u39tYBdBTXNGDPvkR4LMLu
   k/Mz4yMxTDtdNCkReW4VcKcBfnzn+Hvte5cC+NzV4lo7YlGnh8g/GPcJ5
   PQ1O2lgvgTFbGnGssOnWioQHQcqoEpE1Cg6WLJf7diWh7K4YbFaZBOMRl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="334175078"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="334175078"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:25:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="601301711"
Received: from jzawadzk-mobl2.amr.corp.intel.com ([10.251.212.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:25:22 -0700
Date:   Tue, 24 May 2022 16:25:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com>
Message-ID: <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com> <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com> <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
 <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-345187942-1653398723=:1620"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-345187942-1653398723=:1620
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 24 May 2022, cael wrote:

> if  ldata->no_room is not true, that means kworker has flushed
> at least n characters to break the while loop, so return value of
> n_tty_receive_buf_common is not zero, flush_to_ldisc will
> continue to call this function to flush data to reader if write buffer
> is not empty.

Now you switched to an entirely different case, not the one we were 
talking about. ...There is no ldisc->no_room = true race in the case
you now described.

-- 
 i.

> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 于2022年5月24日周二 19:40写道：
> >
> > On Tue, 24 May 2022, cael wrote:
> >
> > > Thanks for the answer, yes, there exists a race between reader and kworker,
> > > but it's OK. Before checking chars_in_buffer in kworker,
> > > ldata->no_room is set true,
> >
> > Nothing seems to guarantee this.
> >
> > > if reader changes ldata->read_tail in n_tty_read when kworker checks this value
> > > which makes the check fail, then when reader reaches end of n_tty_read,
> > > n_tty_kick_worker will also be called. Besides, kworker and reader may
> > > call n_tty_kick_worker at the same time, this function only queues work
> > > on workqueue, so it's harmless.
> >
> > I'm not worried about the case where both cpus call n_tty_kick_worker but
> > the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
> > !no_room.
> >
> > --
> >  i.
> >
> > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 于2022年5月24日周二 17:11写道：
> > > >
> > > > On Tue, 24 May 2022, cael wrote:
> > > >
> > > > > We have met a hang on pty device, the reader was blocking at
> > > > >  epoll on master side, the writer was sleeping at wait_woken inside
> > > > >  n_tty_write on slave side ,and the write buffer on tty_port was full, we
> > > >
> > > > Space after comma. It would be also useful to tone down usage of "we" in
> > > > the changelog.
> > > >
> > > > >  found that the reader and writer would never be woken again and block
> > > > >  forever.
> > > > >
> > > > > We thought the problem was caused as a race between reader and
> > > > > kworker as follows:
> > > > > n_tty_read(reader)| n_tty_receive_buf_common(kworker)
> > > > >                   |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
> > > > >                   |room <= 0
> > > > > copy_from_read_buf|
> > > > > n_tty_kick_worker |
> > > > >                   |ldata->no_room = true
> > > > >
> > > > > After writing to slave device, writer wakes up kworker to flush
> > > > > data on tty_port to reader, and the kworker finds that reader
> > > > > has no room to store data so room <= 0 is met. At this moment,
> > > > > reader consumes all the data on reader buffer and call
> > > > > n_tty_kick_worker to check ldata->no_room and finds that there
> > > > > is no need to call tty_buffer_restart_work to flush data to reader
> > > > > and reader quits reading. Then kworker sets ldata->no_room=true
> > > > > and quits too.
> > > > >
> > > > > If write buffer is not full, writer will wake kworker to flush data
> > > > > again after following writes, but if writer buffer is full and writer
> > > > > goes to sleep, kworker will never be woken again and tty device is
> > > > > blocked.
> > > > >
> > > > > We think this problem can be solved with a check for read buffer
> > > > > inside function n_tty_receive_buf_common, if read buffer is empty and
> > > > > ldata->no_room is true, this means that kworker has more data to flush
> > > > > to read buffer, so a call to n_tty_kick_worker is necessary.
> > > > >
> > > > > Signed-off-by: cael <juanfengpy@gmail.com>
> > > > > ---
> > > > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > > > index efc72104c840..36c7bc033c78 100644
> > > > > --- a/drivers/tty/n_tty.c
> > > > > +++ b/drivers/tty/n_tty.c
> > > > > @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> > > > > const unsigned char *cp,
> > > > >         } else
> > > > >                 n_tty_check_throttle(tty);
> > > > >
> > > > > +       if (!chars_in_buffer(tty))
> > > > > +               n_tty_kick_worker(tty);
> > > > > +
> > > >
> > > > chars_in_buffer() accesses ldata->read_tail in producer context so this
> > > > probably just moves the race there?



--8323329-345187942-1653398723=:1620--
