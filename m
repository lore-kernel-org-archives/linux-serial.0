Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B890C43334
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jun 2022 06:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiFKGvJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jun 2022 02:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiFKGvI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jun 2022 02:51:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B849936
        for <linux-serial@vger.kernel.org>; Fri, 10 Jun 2022 23:51:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c83so727984qke.3
        for <linux-serial@vger.kernel.org>; Fri, 10 Jun 2022 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TUei/67xIW/lOeBnvHl1cLRtCHAU+Kl2ibHPHCGWGDQ=;
        b=n1ptoOVpPWpYHJU+eUHgSvjHyKH36e3qG8XZtTuUmACHAmgXLbWpW8Tsi3yxkY3ALZ
         NPtyDpsZMIALvwpXxNimuNJ4M7NrHa598HA0Io+MWjRbnmLN5Nfahy2zJ58Nm8717/aI
         kd+Pq8PsYJh7OPWOzVx2vZ3titmSWHXuqLdlj7sDKmCtARZnkydxLDmk+5JBMlQeQ92Y
         SLVnrfizWG7StOAuCTsq81CUATVxSfY99msUW9vY+z6Ftg/kfRG0w/uqF05/A7+iCb6v
         b1ci3JLorTlAXKC22MYwB2rT08UywRvcMuo3t57c+LCiT54oBlWtsOb3ql/x4vf/Mgnv
         aQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TUei/67xIW/lOeBnvHl1cLRtCHAU+Kl2ibHPHCGWGDQ=;
        b=DFUe9AvQtNonMSkUU0lJsAqdicQPs0rb+CacN0xMgDnHXo4SPmAtD3BiD8RcUJjEYa
         HW/UO8MnWvBPf9UHafu6wKj3hMLico07p2h1SAMiw6YuQvHe5ENO/4IBlLV0nMcY27Ih
         uXnuCAujn948ThHmZFKpxq3ggtugN5qbzqEieiVvhtXBMF1GtRrtAOZL5ya0kYogt8sK
         PII6DnNutJ+QiTtIl0TmWu+WqHCf2NwwOHaKQoBFMJrMK1UcK3+LluYeGWnACt9pYjHP
         eh/j+QOrppJveRrfSsSmwb2SF/NYs447Lr9cCqrHvXaM1ZGuf9jp8uYUW0q3dLuc+oVa
         EKaQ==
X-Gm-Message-State: AOAM5330n5c11WOnU5L2Rk5zhSdCQd7zKmjEwtYCvtlwyiRMP3MDXxkz
        aLDGBM/US74dyE90p/p+LBxdq2ceLm57rMt1D+A6FMeeb0Q=
X-Google-Smtp-Source: ABdhPJz0sWDvYX62Q21kEJj5oMSDscNgZd31JuzVbQGFYtRS5QxQvT5YXHgulEWhskfmMMVG0X3sjGzHajpQLZopmyQ=
X-Received: by 2002:a05:620a:2409:b0:6a7:641:a9d7 with SMTP id
 d9-20020a05620a240900b006a70641a9d7mr11069223qkn.132.1654930265961; Fri, 10
 Jun 2022 23:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <YpczhMOT5BvxqL/P@kroah.com> <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
 <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com> <CAPmgiUL4XU7qeLvCdTe=G0AWMStKVu78GjmdPMzakLqgEei9yQ@mail.gmail.com>
 <Yp4Sh8pMVhwBKUzU@kroah.com>
In-Reply-To: <Yp4Sh8pMVhwBKUzU@kroah.com>
From:   cael <juanfengpy@gmail.com>
Date:   Sat, 11 Jun 2022 14:50:54 +0800
Message-ID: <CAPmgiUJzTg7YMuVp=wmZnoDKAjcig7Uw2O-qRxtWc7RU2mP+YA@mail.gmail.com>
Subject: Re: tty: fix a possible hang on tty device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: cael <juanfengpy@gmail.com>
Subject: [PATCH] [PATCH v3] tty: fix a possible hang on tty device

We have met a hang on pty device, the reader was blocking
at epoll on master side, the writer was sleeping at wait_woken
inside n_tty_write on slave side, and the write buffer on
tty_port was full, we found that the reader and writer would
never be woken again and block forever.

The problem was caused by a race between reader and kworker:
n_tty_read(reader):  n_tty_receive_buf_common(kworker):
                    |room =3D N_TTY_BUF_SIZE - (ldata->read_head - tail)
                    |room <=3D 0
copy_from_read_buf()|
n_tty_kick_worker() |
                    |ldata->no_room =3D true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <=3D 0 is met. At this moment,
reader consumes all the data on reader buffer and call
n_tty_kick_worker to check ldata->no_room which is false and
reader quits reading. Then kworker sets ldata->no_room=3Dtrue
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if writer buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

This problem can be solved with a check for read buffer size inside
n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
is true, a call to n_tty_kick_worker is necessary to keep flushing
data to reader.

Signed-off-by: cael <juanfengpy@gmail.com>

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..544f782b9a11 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
        struct n_tty_data *ldata =3D tty->disc_data;

        /* Did the input worker stop? Restart it */
-       if (unlikely(ldata->no_room)) {
-               ldata->no_room =3D 0;
+       if (unlikely(READ_ONCE(ldata->no_room))) {
+               WRITE_ONCE(ldata->no_room, 0);

                WARN_RATELIMIT(tty->port->itty =3D=3D NULL,
                                "scheduling with invalid itty\n");
@@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
                        if (overflow && room < 0)
                                ldata->read_head--;
                        room =3D overflow;
-                       ldata->no_room =3D flow && !room;
+                       WRITE_ONCE(ldata->no_room, flow && !room);
                } else
                        overflow =3D 0;

@@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct
*tty, const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (unlikely(ldata->no_room)) {
+               /*
+                * Barrier here is to ensure to read the latest read_tail i=
n
+                * chars_in_buffer() and to make sure that read_tail
is not loaded
+                * before ldata->no_room is set, otherwise, following
race may occur:
+                * n_tty_receive_buf_common() |n_tty_read()
+                * chars_in_buffer() > 0      |
+                *
|copy_from_read_buf()->chars_in_buffer()=3D=3D0
+                *                            |if (ldata->no_room)
+                * ldata->no_room =3D 1         |
+                * Then both kworker and reader will fail to kick
n_tty_kick_worker(),
+                * smp_mb is paired with smp_mb() in n_tty_read().
+                */
+               smp_mb();
+               if (!chars_in_buffer(tty))
+                       n_tty_kick_worker(tty);
+       }
+
        up_read(&tty->termios_rwsem);

        return rcvd;
@@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct
*tty, struct file *file,
                if (time)
                        timeout =3D time;
        }
-       if (tail !=3D ldata->read_tail)
+       if (tail !=3D ldata->read_tail) {
+               /*
+                * Make sure no_room is not read before setting read_tail,
+                * otherwise, following race may occur:
+                * n_tty_read()
|n_tty_receive_buf_common()
+                * if(ldata->no_room)->false            |
+                *                                      |ldata->no_room =3D=
 1
+                *                                      |char_in_buffer() >=
 0
+                * ldata->read_tail =3D ldata->commit_head|
+                * Then copy_from_read_buf() in reader consumes all the dat=
a
+                * in read buffer, both reader and kworker will fail to kic=
k
+                * tty_buffer_restart_work().
+                * smp_mb is paired with smp_mb() in n_tty_receive_buf_comm=
on().
+                */
+               smp_mb();
                n_tty_kick_worker(tty);
+       }
        up_read(&tty->termios_rwsem);

        remove_wait_queue(&tty->read_wait, &wait);
--=20
2.27.0

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=80 22:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 06, 2022 at 09:40:16PM +0800, cael wrote:
> > From: cael <juanfengpy@gmail.com>
> > Subject:[PATCH v3] tty: fix a possible hang on tty device
> >
> > We have met a hang on pty device, the reader was blocking
> > at epoll on master side, the writer was sleeping at wait_woken
> > inside n_tty_write on slave side, and the write buffer on
> > tty_port was full, we found that the reader and writer would
> > never be woken again and block forever.
> >
> > The problem was caused by a race between reader and kworker:
> > n_tty_read(reader):  n_tty_receive_buf_common(kworker):
> >                     |room =3D N_TTY_BUF_SIZE - (ldata->read_head - tail=
)
> >                     |room <=3D 0
> > copy_from_read_buf()|
> > n_tty_kick_worker() |
> >                     |ldata->no_room =3D true
> >
> > After writing to slave device, writer wakes up kworker to flush
> > data on tty_port to reader, and the kworker finds that reader
> > has no room to store data so room <=3D 0 is met. At this moment,
> > reader consumes all the data on reader buffer and call
> > n_tty_kick_worker to check ldata->no_room which is false and
> > reader quits reading. Then kworker sets ldata->no_room=3Dtrue
> > and quits too.
> >
> > If write buffer is not full, writer will wake kworker to flush data
> > again after following writes, but if writer buffer is full and writer
> > goes to sleep, kworker will never be woken again and tty device is
> > blocked.
> >
> > This problem can be solved with a check for read buffer size inside
> > n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> > is true, a call to n_tty_kick_worker is necessary to keep flushing
> > data to reader.
> >
> > Signed-off-by: cael <juanfengpy@gmail.com>
> >
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index efc72104c840..544f782b9a11 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tt=
y)
> >         struct n_tty_data *ldata =3D tty->disc_data;
> >
> >         /* Did the input worker stop? Restart it */
> > -       if (unlikely(ldata->no_room)) {
> > -               ldata->no_room =3D 0;
> > +       if (unlikely(READ_ONCE(ldata->no_room))) {
> > +               WRITE_ONCE(ldata->no_room, 0);
> >
> >                 WARN_RATELIMIT(tty->port->itty =3D=3D NULL,
> >                                 "scheduling with invalid itty\n");
> > @@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
> > const unsigned char *cp,
> >                         if (overflow && room < 0)
> >                                 ldata->read_head--;
> >                         room =3D overflow;
> > -                       ldata->no_room =3D flow && !room;
> > +                       WRITE_ONCE(ldata->no_room, flow && !room);
> >                 } else
> >                         overflow =3D 0;
> >
> > @@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct
> > *tty, const unsigned char *cp,
> >         } else
> >                 n_tty_check_throttle(tty);
> >
> > +       if (unlikely(ldata->no_room)) {
> > +               /*
> > +                * Barrier here is to ensure to read the latest read_ta=
il in
> > +                * chars_in_buffer() and to make sure that read_tail
> > is not loaded
> > +                * before ldata->no_room is set, otherwise, following
> > race may occur:
> > +                * n_tty_receive_buf_common() |n_tty_read()
> > +                * chars_in_buffer() > 0      |
> > +                *
> > |copy_from_read_buf()->chars_in_buffer()=3D=3D0
> > +                *                            |if (ldata->no_room)
> > +                * ldata->no_room =3D 1         |
> > +                * Then both kworker and reader will fail to kick
> > n_tty_kick_worker(),
> > +                * smp_mb is paired with smp_mb() in n_tty_read().
> > +                */
> > +               smp_mb();
> > +               if (!chars_in_buffer(tty))
> > +                       n_tty_kick_worker(tty);
> > +       }
> > +
> >         up_read(&tty->termios_rwsem);
> >
> >         return rcvd;
> > @@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct
> > *tty, struct file *file,
> >                 if (time)
> >                         timeout =3D time;
> >         }
> > -       if (tail !=3D ldata->read_tail)
> > +       if (tail !=3D ldata->read_tail) {
> > +               /*
> > +                * Make sure no_room is not read before setting read_ta=
il,
> > +                * otherwise, following race may occur:
> > +                * n_tty_read()
> > |n_tty_receive_buf_common()
> > +                * if(ldata->no_room)->false            |
> > +                *                                      |ldata->no_room=
 =3D 1
> > +                *                                      |char_in_buffer=
() > 0
> > +                * ldata->read_tail =3D ldata->commit_head|
> > +                * Then copy_from_read_buf() in reader consumes all the=
 data
> > +                * in read buffer, both reader and kworker will fail to=
 kick
> > +                * tty_buffer_restart_work().
> > +                * smp_mb is paired with smp_mb() in n_tty_receive_buf_=
common().
> > +                */
> > +               smp_mb();
> >                 n_tty_kick_worker(tty);
> > +       }
> >         up_read(&tty->termios_rwsem);
> >
> >         remove_wait_queue(&tty->read_wait, &wait);
> > --
> > 2.27.0
>
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/email-clients.txt in order to fix this.
>
> - Your patch was attached, please place it inline so that it can be
>   applied directly from the email message itself.
>
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what a proper Subject: line should
>   look like.
>
> - It looks like you did not use your "real" name for the patch on either
>   the Signed-off-by: line, or the From: line (both of which have to
>   match).  Please read the kernel file, Documentation/SubmittingPatches
>   for how to do this correctly.
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
