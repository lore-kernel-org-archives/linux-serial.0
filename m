Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76287C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 13:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiE3NNl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiE3NNj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 09:13:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE235A80
        for <linux-serial@vger.kernel.org>; Mon, 30 May 2022 06:13:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c12so622332qvr.3
        for <linux-serial@vger.kernel.org>; Mon, 30 May 2022 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o/aZXwXBuN81Nfmz0wfUZhmQYBBH9mgz/65/1poT6dk=;
        b=cQOAFJnuGpzWRJUKEmzHLcrhfEMoWwwsIaOniC+jEWZG4MWM3YFfDFKu79Nm2bpoyV
         5MpFyDsMBds+yCEQ/ZlE+X0XkttgWUzfrf50TIJQU3cb3Dk7ae3b7xs/If5RNoHNhi7n
         iUGTZIQmk2vMOf/TboGZWoYeDzPLNFwAavjYZNLIm0fsUwij3YOHgAUb7GdDxXnIS+XG
         v8GmY7Z2H1k63y/ijpkHD7hLRNMQGb0c24QBORyLghRTEajpuGrhrW1VNtSwE2EbS71y
         LMy2tiY92jOJup0H1o8w6hBTU/eRc6fGpjzyd7qrUVuL8BwKroToEZmQNSWHcZj7o5WH
         lCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/aZXwXBuN81Nfmz0wfUZhmQYBBH9mgz/65/1poT6dk=;
        b=yGq0oS/wUV2EKe2SiR0zHQqDBKCWzQbGx+GEaXYbqxegWVm/ZHkr7fG3HmBrfrLSyl
         /s4P4zy9tpzTrb9h7eeGoPoc1N0iVeOKUYWroI68VMaWAIeVaVTBLXOJzbJ8VWisRC5a
         32iNZVBwOp/X2/6Py7w8orX3UxCn7ekX6PlD+bN8WeabzqizckyaBDRd1jU8dh9FLTp+
         k57AJsv6mZ/HgjM/M7A9uDvEMhuhpA+8oXWaADq1PUdp/IHi+CH/hIs4kQ0EV82HKLd4
         bPmsw8ASjP/RwTR8S40i45xpzS4fEdLn0rFqOeYAhj6syJKb2AwUJP6c2/eMFwOtDNWG
         Oy3g==
X-Gm-Message-State: AOAM532Bl4TgRcfnPcNSfgPIIM/xe9+huYitUMEcDxRK2TGWS/vW9WnH
        E2vfBSDV5apEU5qfd8y/mcdLppvt8IpOBVZ9g18=
X-Google-Smtp-Source: ABdhPJxKsj/Bs/IgvyTXG0X/rg4rHYtYaVIVRbbNWEL+AzHl97NZYtQBmY6lF9OrtqxzVOVdVR8s/hhDS1109vgrmA4=
X-Received: by 2002:ad4:5b8e:0:b0:464:50c4:c568 with SMTP id
 14-20020ad45b8e000000b0046450c4c568mr3894275qvp.115.1653916417281; Mon, 30
 May 2022 06:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com>
 <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com> <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com>
 <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com> <CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com>
 <269a9a97-dc62-a89-d978-3be8e9d1f7e4@linux.intel.com>
In-Reply-To: <269a9a97-dc62-a89-d978-3be8e9d1f7e4@linux.intel.com>
From:   cael <juanfengpy@gmail.com>
Date:   Mon, 30 May 2022 21:13:26 +0800
Message-ID: <CAPmgiUK=aTDJjPYooQGDbNvdOs+z6AbAj5zU7e_0SJhSk2pz9w@mail.gmail.com>
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

Thanks, You are right, barrier is needed here. I changed the patch as follo=
ws:
1) WRITE_ONCE and READ_ONCE is used to access ldata->no_room since
n_tty_kick_worker  would be called in kworker and reader cpu;
2) smp_mb added in chars_in_buffer as this function will be called in
reader and kworker, accessing commit_head and read_tail; and to make
sure that read_tail is not read before setting no_room in
n_tty_receive_buf_common;
3) smp_mb added in n_tty_read to make sure that no_room is not read
before setting read_tail.
---
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..3327687da0d3 100644
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
@@ -221,6 +221,7 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
        struct n_tty_data *ldata =3D tty->disc_data;
        ssize_t n =3D 0;

+       smp_mb();
        if (!ldata->icanon)
                n =3D ldata->commit_head - ldata->read_tail;
        else
@@ -1632,7 +1633,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
                        if (overflow && room < 0)
                                ldata->read_head--;
                        room =3D overflow;
-                       ldata->no_room =3D flow && !room;
+                       WRITE_ONCE(ldata->no_room, flow && !room);
                } else
                        overflow =3D 0;

@@ -1663,6 +1664,9 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (!chars_in_buffer(tty))
+               n_tty_kick_worker(tty);
+
        up_read(&tty->termios_rwsem);

        return rcvd;
@@ -2180,8 +2184,10 @@ static ssize_t n_tty_read(struct tty_struct
*tty, struct file *file,
                if (time)
                        timeout =3D time;
        }
-       if (tail !=3D ldata->read_tail)
+       if (tail !=3D ldata->read_tail) {
+               smp_mb();
                n_tty_kick_worker(tty);
+       }
        up_read(&tty->termios_rwsem);

        remove_wait_queue(&tty->read_wait, &wait);
--
2.27.0

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=89 19:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 25 May 2022, cael wrote:
>
> > >Now you switched to an entirely different case, not the one we were
> > >talking about. ...There is no ldisc->no_room =3D true race in the case
> > >you now described.
> > So, I think we should back to the case ldata->no_room=3Dtrue as
> > ldata->no_room=3Dfalse seems harmless.
> >
> > >I'm not worried about the case where both cpus call n_tty_kick_worker =
but
> > >the case where producer cpu sees chars_in_buffer() > 0 and consumer cp=
u
> > >!no_room.
> >
> > As ldata->no_room=3Dtrue is set before checking chars_in_buffer()
>
> Please take a brief look at Documentation/memory-barriers.txt and then
> tell me if you still find this claim to be true.
>
> > if producer
> > finds chars_in_buffer() > 0, then if reader is currently in n_tty_read,
>
> ...Then please do a similar analysis for ldata->read_tail. What guarantee=
s
> its update is seen by the producer cpu when the reader is already past th=
e
> point you think it still must be in?
>
> > when reader quits n_tty_read, n_tty_kick_worker will be called. If read=
er
> > has already exited n_tty_read, which means that reader still has data t=
o read,
> > next time reader will call n_tty_kick_worker inside n_tty_read too.
>
> C-level analysis alone is not going to be very useful here given you're
> dealing with a concurrency challenge here.
>
>
> --
>  i.
>
>
