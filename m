Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8124C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 11:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiEXLkx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiEXLkt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 07:40:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC28D69A
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653392421; x=1684928421;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=prPeln2w5G2uynzJ+vtNdvoDt3g/8MBpi4nxVUW4SRo=;
  b=iRVv69Iggfs1zsZkrZGJvNWISuQa6tS+t6mamWhwPQDg+LOP73N2g0qd
   G9EZ1hpZzP4jNBT9gUOwZJKSyoOPdYdD2qKOmCm2a6MwG86DiESJqwD1x
   GPbNAx1mbi72JpAsT4TbXL019aowRPzcEqJJtb0hrrbbkyxBXe/XIvyIK
   Tx1MmPkKaba6ULsVmnPYjobQUzq2q6S6tBC2qtdvg0PeeLP2N87TJ9DMG
   EFm6aK8GMfy/kgnMNlX6BWdrnUlMekDWay6N/GsXquN5bPbe8LQ7CwhFb
   q0gfx2HPpGyu6/r/UjH0gR8L1KMgQBRzJyPzfgx1+2Dj431j/nhoRNd2z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273618096"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273618096"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:40:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="572588238"
Received: from jzawadzk-mobl2.amr.corp.intel.com ([10.251.212.72])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:40:18 -0700
Date:   Tue, 24 May 2022 14:40:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com>
Message-ID: <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com> <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-406394293-1653392420=:1620"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-406394293-1653392420=:1620
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 24 May 2022, cael wrote:

> Thanks for the answer, yes, there exists a race between reader and kworker,
> but it's OK. Before checking chars_in_buffer in kworker,
> ldata->no_room is set true,

Nothing seems to guarantee this.

> if reader changes ldata->read_tail in n_tty_read when kworker checks this value
> which makes the check fail, then when reader reaches end of n_tty_read,
> n_tty_kick_worker will also be called. Besides, kworker and reader may
> call n_tty_kick_worker at the same time, this function only queues work
> on workqueue, so it's harmless.

I'm not worried about the case where both cpus call n_tty_kick_worker but 
the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
!no_room.

-- 
 i.

> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 于2022年5月24日周二 17:11写道：
> >
> > On Tue, 24 May 2022, cael wrote:
> >
> > > We have met a hang on pty device, the reader was blocking at
> > >  epoll on master side, the writer was sleeping at wait_woken inside
> > >  n_tty_write on slave side ,and the write buffer on tty_port was full, we
> >
> > Space after comma. It would be also useful to tone down usage of "we" in
> > the changelog.
> >
> > >  found that the reader and writer would never be woken again and block
> > >  forever.
> > >
> > > We thought the problem was caused as a race between reader and
> > > kworker as follows:
> > > n_tty_read(reader)| n_tty_receive_buf_common(kworker)
> > >                   |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
> > >                   |room <= 0
> > > copy_from_read_buf|
> > > n_tty_kick_worker |
> > >                   |ldata->no_room = true
> > >
> > > After writing to slave device, writer wakes up kworker to flush
> > > data on tty_port to reader, and the kworker finds that reader
> > > has no room to store data so room <= 0 is met. At this moment,
> > > reader consumes all the data on reader buffer and call
> > > n_tty_kick_worker to check ldata->no_room and finds that there
> > > is no need to call tty_buffer_restart_work to flush data to reader
> > > and reader quits reading. Then kworker sets ldata->no_room=true
> > > and quits too.
> > >
> > > If write buffer is not full, writer will wake kworker to flush data
> > > again after following writes, but if writer buffer is full and writer
> > > goes to sleep, kworker will never be woken again and tty device is
> > > blocked.
> > >
> > > We think this problem can be solved with a check for read buffer
> > > inside function n_tty_receive_buf_common, if read buffer is empty and
> > > ldata->no_room is true, this means that kworker has more data to flush
> > > to read buffer, so a call to n_tty_kick_worker is necessary.
> > >
> > > Signed-off-by: cael <juanfengpy@gmail.com>
> > > ---
> > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > index efc72104c840..36c7bc033c78 100644
> > > --- a/drivers/tty/n_tty.c
> > > +++ b/drivers/tty/n_tty.c
> > > @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> > > const unsigned char *cp,
> > >         } else
> > >                 n_tty_check_throttle(tty);
> > >
> > > +       if (!chars_in_buffer(tty))
> > > +               n_tty_kick_worker(tty);
> > > +
> >
> > chars_in_buffer() accesses ldata->read_tail in producer context so this
> > probably just moves the race there?
> >
> >
> > --
> >  i.
> >
> 

--8323329-406394293-1653392420=:1620--
