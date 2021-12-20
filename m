Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45493C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhLTRC2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239883AbhLTRC1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 12:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640019746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMU+crRbPmjYFM4aE3gKGGI6VKsFtp6amlEI5UhnTVM=;
        b=bP60ZKz7FHCAqoze12WXkNqUW8EfBM4GU0xUrBQhU7Zi6nB6Vem1XXhxR+wEMD6dS8p61R
        IlCgiQ/iFzXbI1KBgwEYf9dmaZpRKvR3wyDiVL2foxoDjT3e3beslqJQ3ix4aw4T47BZ/H
        lpz3DaFnG7JElLqpzzLtZeYffZ/kkZY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-CKBWsYwAMJylVBe4EzI_NA-1; Mon, 20 Dec 2021 12:02:25 -0500
X-MC-Unique: CKBWsYwAMJylVBe4EzI_NA-1
Received: by mail-ed1-f72.google.com with SMTP id dm10-20020a05640222ca00b003f808b5aa18so8120150edb.4
        for <linux-serial@vger.kernel.org>; Mon, 20 Dec 2021 09:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMU+crRbPmjYFM4aE3gKGGI6VKsFtp6amlEI5UhnTVM=;
        b=YVZZ15EaNDnO4xjnJQVwAsDJ/mhsJlP1SNma2kfXghxJGkvMekRJn2t+MuY2pP+i1y
         NaJeZDNS2kjd+cvl6Urr8BswwBl+4QsMtq8Yeu50DIim7ZMoVQnMiTETcJEdjaojT9/c
         zQNskZPnT7CEGKTdOgbRqq7jmO6vWI044EESO7MW4go4Ak6Qz/Cbow6GXWR/nz4uVpPk
         ev6yEmBQoSD1qbl/ZC1ppSUA9CtZ1R89uiX7uNoIXX7yIxyiF3rUgvGYhVnP70iG8abJ
         SYBw4pVzKzXZ/LasGmn/0iYhBZqJWt3Wmj1ytrWAEybGPv/A8Ngy1DAzzOGE0e/Xg9N/
         gYBQ==
X-Gm-Message-State: AOAM5324OCi5sJaafPCGbAYBCnGp0KQ6UjtvX4bpLwLQJPSXVC4FE1rW
        Ku25Uey3ZdlYdhgGlRsx1FhK1EYXH34WrzEDkJUQ/gDF28Aq7YRV+oPwmPsO75bBe116znCNxsR
        Jfgr5dA5mRHd69b2wjbrcakDDbMN6Z+kEUFq1jJYG
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr17171222edb.360.1640019743124;
        Mon, 20 Dec 2021 09:02:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3uewW7dW2JUgtnmE5hrswtZYTJhzi+M3Hljl0JXA6W2KOd/ltCxASxmEBtTAIgQ7/+1mGgrxoW1uwmM7YFrg=
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr17171189edb.360.1640019742880;
 Mon, 20 Dec 2021 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20211104171734.137707-1-wander@redhat.com> <YcClBlhwp4arGWtw@kroah.com>
In-Reply-To: <YcClBlhwp4arGWtw@kroah.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 14:02:11 -0300
Message-ID: <CAAq0SUmVmyALNYUbM5dy3D0=Bp=ukNoNdodc1yxYQjm1SnBgAQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: Use fifo in 8250 console driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 20, 2021 at 12:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 04, 2021 at 02:17:31PM -0300, wander@redhat.com wrote:
> > From: Wander Lairson Costa <wander@redhat.com>
> >
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n bytes
> > to the serial console using the serco driver.
> >
> > Recently I got a report of a soft lockup while loading a bunch a
> > scsi_debug devices (> 500).
> >
> > While investigating it, I noticed that the serial console throughput
> > (called by the printk code) is way below the configured speed of 115200
> > bps in a HP Proliant DL380 Gen9 server. I was expecting something above
> > 10KB/s, but I got 2.5KB/s. I then built a simple driver [0] to isolate
> > the console from the printk code. Here it is:
> >
> > $ time ./sertest -n 2500 /tmp/serco
> >
> > real    0m0.997s
> > user    0m0.000s
> > sys     0m0.997s
> >
> > With the help of the function tracer, I then noticed the serial
> > controller was taking around 410us seconds to dispatch one single byte:
> >
> > $ trace-cmd record -p function_graph -g serial8250_console_write \
> >    ./sertest -n 1 /tmp/serco
> >
> > $ trace-cmd report
> >
> >             |  serial8250_console_write() {
> >  0.384 us   |    _raw_spin_lock_irqsave();
> >  1.836 us   |    io_serial_in();
> >  1.667 us   |    io_serial_out();
> >             |    uart_console_write() {
> >             |      serial8250_console_putchar() {
> >             |        wait_for_xmitr() {
> >  1.870 us   |          io_serial_in();
> >  2.238 us   |        }
> >  1.737 us   |        io_serial_out();
> >  4.318 us   |      }
> >  4.675 us   |    }
> >             |    wait_for_xmitr() {
> >  1.635 us   |      io_serial_in();
> >             |      __const_udelay() {
> >  1.125 us   |        delay_tsc();
> >  1.429 us   |      }
> > ...
> > ...
> > ...
> >  1.683 us   |      io_serial_in();
> >             |      __const_udelay() {
> >  1.248 us   |        delay_tsc();
> >  1.486 us   |      }
> >  1.671 us   |      io_serial_in();
> >  411.342 us |    }
> >
> > In another machine, I measured a throughput of 11.5KB/s, with the serial
> > controller taking between 80-90us to send each byte. That matches the
> > expected throughput for a configuration of 115200 bps.
> >
> > This patch changes the serial8250_console_write to use the 16550 fifo
> > if available. In my artificial benchmark I could get a throughput
> > increase up to 100% in some cases, but in the real case described at the
> > beginning the gain was of about 25%.
> >
> > [0] https://github.com/walac/serial-console-test
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250.h      |  3 ++
> >  drivers/tty/serial/8250/8250_port.c | 63 +++++++++++++++++++++++++----
> >  2 files changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 6473361525d1..c711bf118cc1 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -83,6 +83,9 @@ struct serial8250_config {
> >  #define UART_CAP_MINI        BIT(17) /* Mini UART on BCM283X family lacks:
> >                                        * STOP PARITY EPAR SPAR WLEN5 WLEN6
> >                                        */
> > +#define UART_CAP_CWFIFO BIT(18) /* Use the UART Fifo in
> > +                              * serial8250_console_write
> > +                              */
>
> Why do you need a new bit?  Why can't you just do this change for all
> devices that have a fifo?  Why would you _not_ want to do this for all
> devices that have a fifo?
>
The v1 patch [1] didn't have this extra bit. Andy suggested [2] to add
it so we only enabled this new code on tested controllers as a
precaution.
If it doesn't make sense to you, feel free to consider the v1 patch [1].

[1] https://lore.kernel.org/all/20211029201402.428284-1-wander@redhat.com/
[2] https://lore.kernel.org/all/CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com/

> thanks,
>
> greg k-h
>

