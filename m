Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72075C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 24 May 2022 12:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiEXMsF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 May 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiEXMsF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 May 2022 08:48:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388AC579AA
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 05:48:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id l82so10216661qke.3
        for <linux-serial@vger.kernel.org>; Tue, 24 May 2022 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jlVcJpHEDj+eUIsCoD6gyMNEhL/pFoxUXZ5io3iGX8=;
        b=Q3VzMGz+ZBXo/+wEXleb2+54IK1mzmVMd4yX+aRN1CkV30cvJL8q4tL3O1XWStl5HK
         ih8CpPD20iWCTSC9LP+OCpgZB87jqdXWcoXh57Q2G5yoaIrD3zpzJUbFvJJ3bSWSixRZ
         ypxCIBN+iBXPLHgW5kKuH9q2L7dbuH25YtqpLS6v0N0eWuHuecUeR+/d1qkpyI609apL
         lk7ygv3VpzZvUYmQMqt3cVycEmpliP5s//JSsSn/Me+1LSoLSZkKm1ZThVSUIA0zIca1
         nxWILad90iqcDaMshFI3OGZ9bmooI4ctk/twpPH/ma+9R2kZjXv4Ua2aRE+0jmdqO5Gt
         M88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jlVcJpHEDj+eUIsCoD6gyMNEhL/pFoxUXZ5io3iGX8=;
        b=49QxAPyLxKDylHRtoD5gGqjJc9CV190ZAPOXI9n53tKp7uZCVPQjvGO90Cj+a3xhsM
         ZqqehADLe+I6Zq6Pn+A7kb8MYNWyYlnVMMYxG3Lx4htGjSGp12MixHV7igVnnY6Vkuzd
         pMvJRk18rlB2EXQhK/6UBoxps21bsr78xRgNpriwxD4gwlf42JRo2H7dxUUz88eRWiXs
         /OeGxIeDgDG+5mi1zJS4BEm9BWSZmD7KfMCw8Ndra1GpN2xuANCYLLOZR+HvIsecmmJb
         +pn1EY2EGRHbNzIkXFgyuX1SDSa59XC483H7qtH+2Bg4ivi6cdG+oQ685LJjHmYEacJK
         Qmhg==
X-Gm-Message-State: AOAM5325QQEyaiMY3K4ZjPJV1ewQvQ0EM8x0PG+SRuXvkP8BNzZgYpWf
        2J9+tWP78wWvbbT6Ma6h4Q7+O0kod/J+EBZuTDyE9gRjiG4=
X-Google-Smtp-Source: ABdhPJyKv9diAufXALCRX7BrwmRgXjfMPerskb+O841LOgiu6acuVCxWQLL/hob6HG6qmMvR9nXZiQ4/LYnR+lzmYKw=
X-Received: by 2002:a05:620a:22a7:b0:6a5:823d:652d with SMTP id
 p7-20020a05620a22a700b006a5823d652dmr182354qkh.127.1653396483389; Tue, 24 May
 2022 05:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com>
 <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
In-Reply-To: <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
From:   cael <juanfengpy@gmail.com>
Date:   Tue, 24 May 2022 20:47:52 +0800
Message-ID: <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com>
Subject: Re: tty: fix a possible hang on tty device
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

if  ldata->no_room is not true, that means kworker has flushed
at least n characters to break the while loop, so return value of
n_tty_receive_buf_common is not zero, flush_to_ldisc will
continue to call this function to flush data to reader if write buffer
is not empty.

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 19:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 24 May 2022, cael wrote:
>
> > Thanks for the answer, yes, there exists a race between reader and kwor=
ker,
> > but it's OK. Before checking chars_in_buffer in kworker,
> > ldata->no_room is set true,
>
> Nothing seems to guarantee this.
>
> > if reader changes ldata->read_tail in n_tty_read when kworker checks th=
is value
> > which makes the check fail, then when reader reaches end of n_tty_read,
> > n_tty_kick_worker will also be called. Besides, kworker and reader may
> > call n_tty_kick_worker at the same time, this function only queues work
> > on workqueue, so it's harmless.
>
> I'm not worried about the case where both cpus call n_tty_kick_worker but
> the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
> !no_room.
>
> --
>  i.
>
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=
=B45=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 17:11=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 24 May 2022, cael wrote:
> > >
> > > > We have met a hang on pty device, the reader was blocking at
> > > >  epoll on master side, the writer was sleeping at wait_woken inside
> > > >  n_tty_write on slave side ,and the write buffer on tty_port was fu=
ll, we
> > >
> > > Space after comma. It would be also useful to tone down usage of "we"=
 in
> > > the changelog.
> > >
> > > >  found that the reader and writer would never be woken again and bl=
ock
> > > >  forever.
> > > >
> > > > We thought the problem was caused as a race between reader and
> > > > kworker as follows:
> > > > n_tty_read(reader)| n_tty_receive_buf_common(kworker)
> > > >                   |room =3D N_TTY_BUF_SIZE - (ldata->read_head - ta=
il)
> > > >                   |room <=3D 0
> > > > copy_from_read_buf|
> > > > n_tty_kick_worker |
> > > >                   |ldata->no_room =3D true
> > > >
> > > > After writing to slave device, writer wakes up kworker to flush
> > > > data on tty_port to reader, and the kworker finds that reader
> > > > has no room to store data so room <=3D 0 is met. At this moment,
> > > > reader consumes all the data on reader buffer and call
> > > > n_tty_kick_worker to check ldata->no_room and finds that there
> > > > is no need to call tty_buffer_restart_work to flush data to reader
> > > > and reader quits reading. Then kworker sets ldata->no_room=3Dtrue
> > > > and quits too.
> > > >
> > > > If write buffer is not full, writer will wake kworker to flush data
> > > > again after following writes, but if writer buffer is full and writ=
er
> > > > goes to sleep, kworker will never be woken again and tty device is
> > > > blocked.
> > > >
> > > > We think this problem can be solved with a check for read buffer
> > > > inside function n_tty_receive_buf_common, if read buffer is empty a=
nd
> > > > ldata->no_room is true, this means that kworker has more data to fl=
ush
> > > > to read buffer, so a call to n_tty_kick_worker is necessary.
> > > >
> > > > Signed-off-by: cael <juanfengpy@gmail.com>
> > > > ---
> > > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > > index efc72104c840..36c7bc033c78 100644
> > > > --- a/drivers/tty/n_tty.c
> > > > +++ b/drivers/tty/n_tty.c
> > > > @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struct *t=
ty,
> > > > const unsigned char *cp,
> > > >         } else
> > > >                 n_tty_check_throttle(tty);
> > > >
> > > > +       if (!chars_in_buffer(tty))
> > > > +               n_tty_kick_worker(tty);
> > > > +
> > >
> > > chars_in_buffer() accesses ldata->read_tail in producer context so th=
is
> > > probably just moves the race there?
> > >
> > >
> > > --
> > >  i.
> > >
> >
