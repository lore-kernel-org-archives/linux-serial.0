Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC5C0044D
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 02:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165FB20754
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 02:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DOLbUlYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgCLCbR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:31:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42545 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbgCLCbQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 22:31:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so4244689qkg.9
        for <linux-serial@vger.kernel.org>; Wed, 11 Mar 2020 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nf1770vAHPjgs0AVRH7uHKcJYCmibKaWql/j0gb33Bs=;
        b=DOLbUlYYpMerzBss5qT2unt9DnC2mRT+tZJJgYqGNmNuR3riRkgQgB8KC88LLofCx6
         /SFUQL9mP/eyXRA154dalsvOWR7mtieMpSauu8II5cTLUB8kLNKd/B71AejqSTvvA9qk
         VjzEXy7wElhq2qvpjW4X5VgMPHfke6hLqITE3kNynEv6M2yCoCC/lDM58Im9fBPxz+LM
         Tm14uvl2xFBtvnwQNDezSfY+lI2KJtL7NtEaPzgzdTw8Ri5ji4snmB2kBcUgLgcKmQPQ
         nNul2veC4Ejc0wKdi1gpbG4Q5faAqAJxB4J6Db3+cduNpE5XziUS5varMxZD+smrASyf
         GcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf1770vAHPjgs0AVRH7uHKcJYCmibKaWql/j0gb33Bs=;
        b=Uv55vC9a//Qo39aNtNG6pQAZUxie5NrJNgPsSZ0yR8okF/pwY1Tgl8//VnUP4t2PbA
         3yx4sT2i3mOgoY6utdmJAdnDJx27yhZnhZOiFPXoYVfDWgnfv0ph4v5KGuw8avcO2WRW
         SwI5w/RYUHRPyyHSPb6/kKR0vhEi/GFEZHu/fZRu1UrN0TeowplfTY1KaHYDSJvscZda
         HRZLvT6mlx9FGbbPH7jgj7IKWz4VgQBOvvR0Mi9Ni9qP2HTws2UK55DWZFMrRgmwYp4B
         xpUe0ci9sJeX+naMNisKxxJXwHnesSftP2isIs4ohxyY+NBSdvh0qKCu7iln9/gI4OiG
         Ju4Q==
X-Gm-Message-State: ANhLgQ37u49OixR0/ZczbKyi9byUHYQOCGjZibwW0wxAUymRC06yNkf0
        QRpacIi8Tb+5tl/oLn4MCNDLK7zdfMmtxKQF21H8Vyj4C1i22Q==
X-Google-Smtp-Source: ADFU+vvpd5b+sdet2H+L9PrwvJ3OZmaHdW7Qzz8B/eoifKzVQUo+sznUkE89HzQf7tdtXQI0EAsmUYNhkwUjrdhfokY=
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr5564793qky.457.1583980275702;
 Wed, 11 Mar 2020 19:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <1583224900-25824-1-git-send-email-vincent.chen@sifive.com> <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Thu, 12 Mar 2020 10:31:03 +0800
Message-ID: <CABvJ_xh4UOZvF__hqBEj9DS1DbRm9qHHtKgM0ZSnKeT7JQDJMQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Add CONSOLE_POLL support to SiFive UART
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 7, 2020 at 2:13 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 03 Mar 2020 00:41:40 PST (-0800), vincent.chen@sifive.com wrote:
> > Add CONSOLE_POLL support for future KGDB porting.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index d5f81b98e4d7..acdbaca4de36 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -818,6 +818,29 @@ static int __init sifive_serial_console_setup(struct console *co, char *options)
> >       return uart_set_options(&ssp->port, co, baud, parity, bits, flow);
> >  }
> >
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int sifive_serial_poll_get_char(struct uart_port *port)
> > +{
> > +     struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > +     char is_empty, ch;
> > +
> > +     ch = __ssp_receive_char(ssp, &is_empty);
> > +     if (is_empty)
> > +             return NO_POLL_CHAR;
> > +
> > +     return ch;
> > +}
> > +
> > +static void sifive_serial_poll_put_char(struct uart_port *port,
> > +                                     unsigned char c)
> > +{
> > +     struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > +
> > +     sifive_serial_console_putchar(port, c);
> > +     __ssp_wait_for_xmitr(ssp);
>
> So we still have that TX watermark bug in the SiFive UARTs.  If this function
> is supposed to wait until the word is actually out on the line then this isn't
> sufficient, but if it's just supposed to wait until the next write won't block
> then this is fine.
>
> I'm not really a serial person, so mabye someone else knows?  For those
> unfamiliar with the issue, there's a pretty good description in the patch to
> fix it
>
>     https://github.com/sifive/sifive-blocks/pull/90
>
I read the description is this patch and it is very clear to
understand the issue.
Thanks for your sharing.

In this case, the __ssp_wait_for_xmitr() is used to prevent the word in the
TX FIFO buffer from being corrupted by the next write. Therefore, I
think it might
be sufficient to check thetxdata.full bit.

Thanks for your comment.
