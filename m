Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE6C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiFANjl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiFANjk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 09:39:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52997983F
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 06:39:39 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x20so1141650qtp.8
        for <linux-serial@vger.kernel.org>; Wed, 01 Jun 2022 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lYT6vkKhoxi+C71B0x/kXfHY61ignH5X4XMR052omCI=;
        b=dTkVjStHB/sP8tw573f0wqO5XLqv8KSgPnKkTNveGsKGk40ErXhU5frzv4sAVGgV4w
         X/oSLNCJjdtza7SeG2EvTG+OAtbFfJLbUIGef3Qf8d/u4fkXCfLSEthcAQdYnKUJaavT
         sp3jKR53ivjzXG102T7YxHaLonsFY37hJ8y9L/+q7E7G23XtQZXhBQIRwO/L+6EMYF8d
         M8RvSDEtiBlEROEpASo+FfGwAJGe8jUPFla/XHGviircXoiA0dtNdJApB1wfJJEUgBQq
         lLOlitkk6zQuyRGjZo8thS4yJt88GNT5xzWgC++Ty8blJweZF5fci5SVfKF+kNu7kpZB
         xmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lYT6vkKhoxi+C71B0x/kXfHY61ignH5X4XMR052omCI=;
        b=6FBPNPax8LPeKPHRzC4cgw4Be9vngzZrgsJXm1J/Dzrl/Sm32dpvDWRUs/BPLuQnMJ
         t4Ty3v9G3AzefcXq7KWNPEYp5Uu9vQnoeseA6Hmxdzvnf/6NscwabBURQX7uanxWM3Cr
         HFyAHgveckPPEcssR/nR6sYA1xuhvAe7L2ryhg++JvK4TKfaubmfJUxJrAdGdC4mgwep
         Oj7pcCb7V+iAx8rho6Co4+zJrX4FFALbKsyPNH4zqt6MensQpIkHz5B6N617A/MLJM9C
         8kpAAVyv1M83ixmDKDx8Nc13O0L+CoNRq1Fvg1a+WncywNisuNvzFBXEa4O0IocEuiyg
         n9JA==
X-Gm-Message-State: AOAM531rfw67L8WpYzO9oarGJHKdDIQXEqBBEcJ7ZyqcUfd7ijXhlhYU
        ibuyYedOTmTbB+ssZEf54dqnVBg89ISugUtHQ5w=
X-Google-Smtp-Source: ABdhPJwmm77uF3TuUppV2W7naHImIkcRUl15fvt9P+3gBdKjoJP7u2mKf/8txKGRpePaRLc+exZnlXxE5AyjdKbXC9c=
X-Received: by 2002:a05:622a:355:b0:2fc:dd8:8961 with SMTP id
 r21-20020a05622a035500b002fc0dd88961mr26004282qtw.281.1654090778962; Wed, 01
 Jun 2022 06:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <YpczhMOT5BvxqL/P@kroah.com>
In-Reply-To: <YpczhMOT5BvxqL/P@kroah.com>
From:   cael <juanfengpy@gmail.com>
Date:   Wed, 1 Jun 2022 21:39:27 +0800
Message-ID: <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
Subject: Re: tty: fix a possible hang on tty device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: cael <juanfengpy@gmail.com>
Subject: [PATCH v2] tty: fix a possible hang on tty device

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
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

---
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..21241ea7cdb9 100644
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

@@ -1663,6 +1663,21 @@ n_tty_receive_buf_common(struct tty_struct
*tty, const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (READ_ONCE(ldata->no_room)) {
+               /*
+                * Reader ensures that read_tail is updated before
checking no_room,
+                * make sure that no_room is set before reading read_tail h=
ere.
+                * Now no_room is visible by reader, the race needs to
be handled is
+                * that reader has passed checkpoint for no_room and
reader buffer
+                * is empty, if so n_tty_kick_worker will not be
called by reader,
+                * instead, this function is called here.
+                * barrier is paired with smp_mb() in n_tty_read()
+                */
+               smp_mb();
+               if (!chars_in_buffer(tty))
+                       n_tty_kick_worker(tty);
+       }
+
        up_read(&tty->termios_rwsem);

        return rcvd;
@@ -2180,8 +2195,14 @@ static ssize_t n_tty_read(struct tty_struct
*tty, struct file *file,
                if (time)
                        timeout =3D time;
        }
-       if (tail !=3D ldata->read_tail)
+       if (tail !=3D ldata->read_tail) {
+               /*
+                * Make sure no_room is not read before setting read_tail,
+                * paired with smp_mb() in n_tty_receive_buf_common()
+                */

+               smp_mb();
                n_tty_kick_worker(tty);
+       }
        up_read(&tty->termios_rwsem);

        remove_wait_queue(&tty->read_wait, &wait);
--
2.27.0
