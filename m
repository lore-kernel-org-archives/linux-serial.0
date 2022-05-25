Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0550C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 25 May 2022 10:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiEYKhG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 May 2022 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiEYKhF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 May 2022 06:37:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787BE980BF
        for <linux-serial@vger.kernel.org>; Wed, 25 May 2022 03:37:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p8so350082qtx.9
        for <linux-serial@vger.kernel.org>; Wed, 25 May 2022 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=78PZjJxXke3DNuZLp26h9bkIcQ8dkpJIu+JsQEirXRs=;
        b=ashbv7zx3heMFvsJGucFdep0FA+5u06730rnKuzO1vf5MbH4YfzN0qZ2ICno1O63Fx
         Hw2ikTvyRCBeL/d9zZidXdxM47hA8PFzWYQBUFbC8P4hdk79bUxocWXIt+4o2mk8yjwV
         OIyIf/6bUpxU/WPqcb6HIOfIG1G6fIvvUbP6eV+uBHge4dp4OLGtH/ikWp04rtmDkGQo
         zpyGA0Dl4xUiYZq0294iLVlJx5cKB4k3myoTbBJgvzKO7A97LW/X6XDNcqYQLmhoOpM1
         gHsW4LWGlqyM7nMBuCmzixfF6O5OX5zDecXPdA+UF7/Hved9RG7tj2UgpTfYiCZmmqRT
         IyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=78PZjJxXke3DNuZLp26h9bkIcQ8dkpJIu+JsQEirXRs=;
        b=ytoxmGpKPNPfvWFAlmbqtCtF2dP2Ll8uQoxAV0ImApZihH1xohVL3mkMlAxBediCmZ
         pIefoxbThFqpfyy4wHEXjBgDlH75eKn9mbRsQ7Y8SkLf4xT1kkQ/tzsts1RTo03we3dv
         SQ2CoaAJT9gZKp4QCGU3NJgaJ6e8r0lLbaBUg3pjlJhxWYMcMZ55w0B9p6SA4waD85ez
         IXxBIk45ZGwfY992vjqCqPdYMfYOPg9n2ySxwpLCipS9Ch6xabiGbVTafQ8pyzYfQfiT
         J+Fy2arFTvQJCyXCW4Q/PIiHwqybU8Bkqes9gu7ndmOkEuxzDYMdZAB3DGoRnUX57N6R
         9vmQ==
X-Gm-Message-State: AOAM533ImPdP6Y2N6D1qVJd8N7z9HZqKN0O6bwSBoMiMd09L4FlSuH4c
        7MED+xHqw4bR9+xPPK8DGSqnwV2UNd2g7tEJ7IcQSSCFF04=
X-Google-Smtp-Source: ABdhPJxYvxBg+JbP/B1ZSedTnbK+oEhiPz1K1OOlRJaLFv/CuqmQJfvLQtAX1deZrWNqUZovww2+GHRZTDSajnC7dR0=
X-Received: by 2002:ac8:7c4d:0:b0:2f9:4113:d509 with SMTP id
 o13-20020ac87c4d000000b002f94113d509mr6222490qtv.589.1653475023598; Wed, 25
 May 2022 03:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com>
 <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com> <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com>
 <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com>
In-Reply-To: <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com>
From:   cael <juanfengpy@gmail.com>
Date:   Wed, 25 May 2022 18:36:52 +0800
Message-ID: <CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com>
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

>Now you switched to an entirely different case, not the one we were
>talking about. ...There is no ldisc->no_room =3D true race in the case
>you now described.
So, I think we should back to the case ldata->no_room=3Dtrue as
ldata->no_room=3Dfalse seems harmless.

>I'm not worried about the case where both cpus call n_tty_kick_worker but
>the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
>!no_room.
As ldata->no_room=3Dtrue is set before checking chars_in_buffer(), if produ=
cer
finds chars_in_buffer() > 0, then if reader is currently in n_tty_read,
when reader quits n_tty_read, n_tty_kick_worker will be called. If reader
has already exited n_tty_read, which means that reader still has data to re=
ad,
next time reader will call n_tty_kick_worker inside n_tty_read too.

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 24 May 2022, cael wrote:
>
> > if  ldata->no_room is not true, that means kworker has flushed
> > at least n characters to break the while loop, so return value of
> > n_tty_receive_buf_common is not zero, flush_to_ldisc will
> > continue to call this function to flush data to reader if write buffer
> > is not empty.
>
> Now you switched to an entirely different case, not the one we were
> talking about. ...There is no ldisc->no_room =3D true race in the case
> you now described.
>
> --
>  i.
>
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=
=B45=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 19:40=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 24 May 2022, cael wrote:
> > >
> > > > Thanks for the answer, yes, there exists a race between reader and =
kworker,
> > > > but it's OK. Before checking chars_in_buffer in kworker,
> > > > ldata->no_room is set true,
> > >
> > > Nothing seems to guarantee this.
> > >
> > > > if reader changes ldata->read_tail in n_tty_read when kworker check=
s this value
> > > > which makes the check fail, then when reader reaches end of n_tty_r=
ead,
> > > > n_tty_kick_worker will also be called. Besides, kworker and reader =
may
> > > > call n_tty_kick_worker at the same time, this function only queues =
work
> > > > on workqueue, so it's harmless.
> > >
> > > I'm not worried about the case where both cpus call n_tty_kick_worker=
 but
> > > the case where producer cpu sees chars_in_buffer() > 0 and consumer c=
pu
> > > !no_room.
> > >
> > > --
> > >  i.
> > >
> > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=
=B9=B45=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 17:11=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, 24 May 2022, cael wrote:
> > > > >
> > > > > > We have met a hang on pty device, the reader was blocking at
> > > > > >  epoll on master side, the writer was sleeping at wait_woken in=
side
> > > > > >  n_tty_write on slave side ,and the write buffer on tty_port wa=
s full, we
> > > > >
> > > > > Space after comma. It would be also useful to tone down usage of =
"we" in
> > > > > the changelog.
> > > > >
> > > > > >  found that the reader and writer would never be woken again an=
d block
> > > > > >  forever.
> > > > > >
> > > > > > We thought the problem was caused as a race between reader and
> > > > > > kworker as follows:
> > > > > > n_tty_read(reader)| n_tty_receive_buf_common(kworker)
> > > > > >                   |room =3D N_TTY_BUF_SIZE - (ldata->read_head =
- tail)
> > > > > >                   |room <=3D 0
> > > > > > copy_from_read_buf|
> > > > > > n_tty_kick_worker |
> > > > > >                   |ldata->no_room =3D true
> > > > > >
> > > > > > After writing to slave device, writer wakes up kworker to flush
> > > > > > data on tty_port to reader, and the kworker finds that reader
> > > > > > has no room to store data so room <=3D 0 is met. At this moment=
,
> > > > > > reader consumes all the data on reader buffer and call
> > > > > > n_tty_kick_worker to check ldata->no_room and finds that there
> > > > > > is no need to call tty_buffer_restart_work to flush data to rea=
der
> > > > > > and reader quits reading. Then kworker sets ldata->no_room=3Dtr=
ue
> > > > > > and quits too.
> > > > > >
> > > > > > If write buffer is not full, writer will wake kworker to flush =
data
> > > > > > again after following writes, but if writer buffer is full and =
writer
> > > > > > goes to sleep, kworker will never be woken again and tty device=
 is
> > > > > > blocked.
> > > > > >
> > > > > > We think this problem can be solved with a check for read buffe=
r
> > > > > > inside function n_tty_receive_buf_common, if read buffer is emp=
ty and
> > > > > > ldata->no_room is true, this means that kworker has more data t=
o flush
> > > > > > to read buffer, so a call to n_tty_kick_worker is necessary.
> > > > > >
> > > > > > Signed-off-by: cael <juanfengpy@gmail.com>
> > > > > > ---
> > > > > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > > > > index efc72104c840..36c7bc033c78 100644
> > > > > > --- a/drivers/tty/n_tty.c
> > > > > > +++ b/drivers/tty/n_tty.c
> > > > > > @@ -1663,6 +1663,9 @@ n_tty_receive_buf_common(struct tty_struc=
t *tty,
> > > > > > const unsigned char *cp,
> > > > > >         } else
> > > > > >                 n_tty_check_throttle(tty);
> > > > > >
> > > > > > +       if (!chars_in_buffer(tty))
> > > > > > +               n_tty_kick_worker(tty);
> > > > > > +
> > > > >
> > > > > chars_in_buffer() accesses ldata->read_tail in producer context s=
o this
> > > > > probably just moves the race there?
>
>
