Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F997C0044D
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 02:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD420734
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 02:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a+9TM53e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgCLCg7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:36:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLCg7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 22:36:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id l20so3235283qtp.4
        for <linux-serial@vger.kernel.org>; Wed, 11 Mar 2020 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faWpUg+LE2/N1Y0T5FmZCDAU16Eeu82lWgxkIXEoRSM=;
        b=a+9TM53emBGV+ZoqvnaXKlCyI0G7M3o7DQci1N4S/xM3SqdIRyuXnhROgqIZALgZGN
         WsyX12Q+kKapBCiQzBuFyJ1EHOsJt4cUIZ4FBen6X6lYZRjgn0R1qZkbzF0uIJd2QYK0
         r31T7StlLu7FdOiADVU9GdgVbMFKp9OQLI7SRcwPeZcXv1KeM55IxFQ22vNCTSpbgncE
         CdpRVO8k9pm7E4REwSOY0+NapxfEF4O9+aQ8jPY5/7VcMQ7S+8HKjUm+frFZHnm7Np5d
         KhU27PPLVP7LCXyJONUYpdxOQzfV7H9/UUQxPnLdM+3E+KCONfev7npJP+bmLsa4vDQs
         upww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faWpUg+LE2/N1Y0T5FmZCDAU16Eeu82lWgxkIXEoRSM=;
        b=HnO6CMhkpuzcE1+ek9um1WII1L1ZrnHPClXCQBQTynbOMEmkU8c5Plz5UoQoLXlTan
         ZPf/YR5RdE1GSPicuJYXsa+dasVr87G4O7VXn/POTyuczQeUbrLsaScp2GVqoQw9UD3w
         GmEYGatOCj1f1Dald78sxXzApYq60Hz15ku21K+HJ7FVe6SGi0lMDz/ShAF4fHph9GGS
         btMRKhUNvVAOIduG2vW7dBnBfkSLUTZKXG9fCJxrtDbjBzZ2u57fSGlwHl3aYQTr4CAy
         DDCJaz3l9TgjKwt+8x0KCeenMx0AGvWIkJCd74xFCIAgSRwcoI8GGJJmZmNFKxf/A5Ys
         d5Og==
X-Gm-Message-State: ANhLgQ3Si99dCNmBLn7vYoAlSg8AA63JaLkIm5272VG7hYDME+lb9ERe
        5Wep3TvhGKykBov3Jiw1aXUbn8CTN1LZphce0dG+d5m4RdfrcQ==
X-Google-Smtp-Source: ADFU+vu7D7I/KxqhTI33Btk5Vo27UwFDEur84H7SBerYlWEcjxh9uN0Uv2fDhZ8EPiPWuGJ3Y+pW9sN4NWNBpudPiaA=
X-Received: by 2002:ac8:24db:: with SMTP id t27mr5452633qtt.49.1583980618106;
 Wed, 11 Mar 2020 19:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <1583224900-25824-1-git-send-email-vincent.chen@sifive.com>
 <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1> <20200307085127.GA3878075@kroah.com>
In-Reply-To: <20200307085127.GA3878075@kroah.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Thu, 12 Mar 2020 10:36:46 +0800
Message-ID: <CABvJ_xjXCX2WVxQrrYWmP2n-xp2fpwade9JBbna=j7UkYOkY2Q@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Add CONSOLE_POLL support to SiFive UART
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, jslaby@suse.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 7, 2020 at 4:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 06, 2020 at 10:13:56AM -0800, Palmer Dabbelt wrote:
> > On Tue, 03 Mar 2020 00:41:40 PST (-0800), vincent.chen@sifive.com wrote:
> > > Add CONSOLE_POLL support for future KGDB porting.
> > >
> > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > ---
> > >  drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > > index d5f81b98e4d7..acdbaca4de36 100644
> > > --- a/drivers/tty/serial/sifive.c
> > > +++ b/drivers/tty/serial/sifive.c
> > > @@ -818,6 +818,29 @@ static int __init sifive_serial_console_setup(struct console *co, char *options)
> > >     return uart_set_options(&ssp->port, co, baud, parity, bits, flow);
> > >  }
> > >
> > > +#ifdef CONFIG_CONSOLE_POLL
> > > +static int sifive_serial_poll_get_char(struct uart_port *port)
> > > +{
> > > +   struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > > +   char is_empty, ch;
> > > +
> > > +   ch = __ssp_receive_char(ssp, &is_empty);
> > > +   if (is_empty)
> > > +           return NO_POLL_CHAR;
> > > +
> > > +   return ch;
> > > +}
> > > +
> > > +static void sifive_serial_poll_put_char(struct uart_port *port,
> > > +                                   unsigned char c)
> > > +{
> > > +   struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > > +
> > > +   sifive_serial_console_putchar(port, c);
> > > +   __ssp_wait_for_xmitr(ssp);
> >
> > So we still have that TX watermark bug in the SiFive UARTs.  If this function
> > is supposed to wait until the word is actually out on the line then this isn't
> > sufficient, but if it's just supposed to wait until the next write won't block
> > then this is fine.
> >
> > I'm not really a serial person, so mabye someone else knows?  For those
> > unfamiliar with the issue, there's a pretty good description in the patch to
> > fix it
> >
> >    https://github.com/sifive/sifive-blocks/pull/90
> >
> > Poking around we don't have any PRE_RATE_CHANGE hook, so I'm going to take a
> > whack at adding one -- not really related to this patch, though.
>
> I do have to drop this patch from my tree, as it breaks the build, so it
> needs to be redone anyway :(
>

Thanks for the test to find out my mistake.
I will fix it and resend the 2nd version patch.
Thanks
