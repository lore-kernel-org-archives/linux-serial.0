Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F1BCCA47F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351741AbiFONdx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351712AbiFONdv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 09:33:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FF24F32
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 06:33:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x75so8680302qkb.12
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wt9UabH04m75py7CX2dKLL5QgLM6Mwlm7YmMo02jF10=;
        b=LEZoi1U5j3VNo/i9Ti2xQGouITnkRKw2LEz6sbXwn5eShR+CzH3rXyb2bmg86JFUYp
         jJ/McePvc2onCoPUBC1skdSB+nM6iHSg2VsydoMdED7dO6lvGI7ZvLjQKAzMHpAuKA6V
         7X5tUdUvmRQTfcED1z1hcI1THYuNP45NVWxcOHaLSKOmLjGIUYoF6fAcIVNWHnSmXFW0
         HyUmxOLnWlS0J1+ZsJMTwfPhsV1JXhX97tcqTii+E2jn/ZL/mfLOtsBIR2TPVuhn4vuj
         0WVMOQLDAq8sqBw5xxNYprXGB/DDseYNu0WhkG9oASsCethfQtYMJ4pbyLpBWHyu649H
         H/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wt9UabH04m75py7CX2dKLL5QgLM6Mwlm7YmMo02jF10=;
        b=crTsfbyUNsG5BA1EIt5W8S3fVCBf7Wo/VHs0eAq4sRTrw1/l4D4KZ0TLXWsyLdww+H
         kMdOBsqr2eDgtNrbPKtOLnAQJ3Vx+vopWSVW54jTy4gW6/XVZiulXzO4gDOeh3I+Ta6t
         f/6JIwLaD9ct8OSWaGs1NXlNPt29/lm0lvOcAzGO2ln+WnAAtJJ4rUEo5pAcqR5ceEQr
         VTFRzh3UqopPw/5MihTQ6DCx+jl5WAjmW3cghECCWzhTCLIjOAaUM+zpNqZWAC5EoOGW
         IAL/gH2BibZRnbqHkkGyLsy5TkIFIB+/5n3hov19ZBRBKC/rjgvYlfLQYwcOpwUL9w2H
         pDKg==
X-Gm-Message-State: AOAM532FSQJs0lqqb+AoxhAkvCY8pScnKd80dwdsIZTCl7vHaATFOPTS
        GW3n0FVjrjyCOFNfzsSpSDabrSlxy6ebbNaGTHxr0bOjO/A=
X-Google-Smtp-Source: ABdhPJwghxeiG3FayNDvHsCOS60o3rPiddFVO+tZ9yDnmEI0lnwVhX5mkZto9dQsfsDH6w+Rodg0XvsUyGlQbK7Q2Dg=
X-Received: by 2002:a37:c20a:0:b0:6a6:bfa7:ca5a with SMTP id
 i10-20020a37c20a000000b006a6bfa7ca5amr7776397qkm.283.1655300028925; Wed, 15
 Jun 2022 06:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <YqmmdRynrDSzNL0W@kroah.com> <1655291821-19676-1-git-send-email-juanfengpy@gmail.com>
 <4354aab5-e01d-c631-9479-cc7c9246d68@linux.intel.com>
In-Reply-To: <4354aab5-e01d-c631-9479-cc7c9246d68@linux.intel.com>
From:   caelli <juanfengpy@gmail.com>
Date:   Wed, 15 Jun 2022 21:33:37 +0800
Message-ID: <CAPmgiUJanAd9xAwi2NGiXBgST1Y64-=PhVFN7i91hkXSPk9eMQ@mail.gmail.com>
Subject: Re: [PATCH v5] tty: fix hang on tty device with no_room set
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, benbjiang@tencent.com,
        robinlai@tencent.com, linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It seems done, thanks for your opinion and help. The original patch
(without barrier) was tested in our environment and seemed to work.
The main idea is around when to call n_tty_kick_worker, calling it
periodically still works, the current solution seems to be more
reasonable and obvious.

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=B46=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 19:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 15 Jun 2022, cael wrote:
>
> > From: caelli <juanfengpy@gmail.com>
> >
> > We have met a hang on pty device, the reader was blocking
> > at epoll on master side, the writer was sleeping at wait_woken
> > inside n_tty_write on slave side, and the write buffer on
> > tty_port was full, we found that the reader and writer would
> > never be woken again and blocked forever.
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
> > reader consumes all the data on reader buffer and calls
> > n_tty_kick_worker to check ldata->no_room which is false and
> > reader quits reading. Then kworker sets ldata->no_room=3Dtrue
> > and quits too.
> >
> > If write buffer is not full, writer will wake kworker to flush data
> > again after following writes, but if write buffer is full and writer
> > goes to sleep, kworker will never be woken again and tty device is
> > blocked.
> >
> > This problem can be solved with a check for read buffer size inside
> > n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
> > is true, a call to n_tty_kick_worker is necessary to keep flushing
> > data to reader.
> >
> > Signed-off-by: caelli <juanfengpy@gmail.com>
> > ---
> > Patch changelogs between v1 and v2:
> >       -add barrier inside n_tty_read and n_tty_receive_buf_common;
> >       -comment why barrier is needed;
> >       -access to ldata->no_room is changed with READ_ONCE and WRITE_ONC=
E;
> > Patch changelogs between v2 and v3:
> >       -in function n_tty_receive_buf_common, add unlikely to check
> >        ldata->no_room, eg: if (unlikely(ldata->no_room)), and READ_ONCE
> >        is removed here to get locality;
> >       -change comment for barrier to show the race condition to make
> >        comment easier to understand;
> > Patch changelogs between v3 and v4:
> >       -change subject from 'tty: fix a possible hang on tty device' to
> >        'tty: fix hang on tty device with no_room set' to make subject
> >        more obvious;
> > Patch changelogs between v4 and v5:
> >       -name is changed from cael to caelli, li is added as the family
> >        name and caelli is the fullname.
> >
> >  drivers/tty/n_tty.c | 41 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 37 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index efc72104c840..544f782b9a11 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tt=
y)
> >       struct n_tty_data *ldata =3D tty->disc_data;
> >
> >       /* Did the input worker stop? Restart it */
> > -     if (unlikely(ldata->no_room)) {
> > -             ldata->no_room =3D 0;
> > +     if (unlikely(READ_ONCE(ldata->no_room))) {
> > +             WRITE_ONCE(ldata->no_room, 0);
> >
> >               WARN_RATELIMIT(tty->port->itty =3D=3D NULL,
> >                               "scheduling with invalid itty\n");
> > @@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, =
const unsigned char *cp,
> >                       if (overflow && room < 0)
> >                               ldata->read_head--;
> >                       room =3D overflow;
> > -                     ldata->no_room =3D flow && !room;
> > +                     WRITE_ONCE(ldata->no_room, flow && !room);
> >               } else
> >                       overflow =3D 0;
> >
> > @@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct *tty,=
 const unsigned char *cp,
> >       } else
> >               n_tty_check_throttle(tty);
> >
> > +     if (unlikely(ldata->no_room)) {
> > +             /*
> > +              * Barrier here is to ensure to read the latest read_tail=
 in
> > +              * chars_in_buffer() and to make sure that read_tail is n=
ot loaded
> > +              * before ldata->no_room is set, otherwise, following rac=
e may occur:
> > +              * n_tty_receive_buf_common() |n_tty_read()
> > +              * chars_in_buffer() > 0      |
> > +              *                            |copy_from_read_buf()->char=
s_in_buffer()=3D=3D0
> > +              *                            |if (ldata->no_room)
> > +              * ldata->no_room =3D 1         |
> > +              * Then both kworker and reader will fail to kick n_tty_k=
ick_worker(),
> > +              * smp_mb is paired with smp_mb() in n_tty_read().
> > +              */
> > +             smp_mb();
> > +             if (!chars_in_buffer(tty))
> > +                     n_tty_kick_worker(tty);
> > +     }
> > +
> >       up_read(&tty->termios_rwsem);
> >
> >       return rcvd;
> > @@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct *tty=
, struct file *file,
> >               if (time)
> >                       timeout =3D time;
> >       }
> > -     if (tail !=3D ldata->read_tail)
> > +     if (tail !=3D ldata->read_tail) {
> > +             /*
> > +              * Make sure no_room is not read before setting read_tail=
,
> > +              * otherwise, following race may occur:
> > +              * n_tty_read()                         |n_tty_receive_bu=
f_common()
> > +              * if(ldata->no_room)->false            |
> > +              *                                      |ldata->no_room =
=3D 1
> > +              *                                      |char_in_buffer()=
 > 0
> > +              * ldata->read_tail =3D ldata->commit_head|
> > +              * Then copy_from_read_buf() in reader consumes all the d=
ata
> > +              * in read buffer, both reader and kworker will fail to k=
ick
> > +              * tty_buffer_restart_work().
> > +              * smp_mb is paired with smp_mb() in n_tty_receive_buf_co=
mmon().
> > +              */
> > +             smp_mb();
> >               n_tty_kick_worker(tty);
> > +     }
> >       up_read(&tty->termios_rwsem);
> >
> >       remove_wait_queue(&tty->read_wait, &wait);
>
> I think the code looks fine. What I'm not entirely sure if there is
> supposed to be some other backup mechanism to handle this case.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> Note to Cael: you don't need to resend the patch just to add my reviewed
> by, it would be picked by the tools automatically. But if you need to
> resend due to other reasons, please add it in that case.
>
>
> --
>  i.
