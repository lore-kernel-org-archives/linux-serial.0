Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066BC43334
	for <linux-serial@archiver.kernel.org>; Wed, 13 Jul 2022 08:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiGMIRS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiGMIQy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Jul 2022 04:16:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4EBEB63
        for <linux-serial@vger.kernel.org>; Wed, 13 Jul 2022 01:14:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b8so9571980pjo.5
        for <linux-serial@vger.kernel.org>; Wed, 13 Jul 2022 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEs3G00VHY8EwtdUIttGPsPa/hYyZ0phbIsIaqIPwZ4=;
        b=NpZL51UbDNgo7qFQ5Xf5qaSGFTPBk4IEKOlXnzm4eKfW7EJvCzbAMawefAQJXlUDSc
         r9wE1Xrf8ejaEA1KTERugXUavnl4JM1no8mUtjoh+JiBRnRVXD8bCnEnF/ZndYe6dcrr
         TLH/biJ80ZpDu1E2+q2tmLFl5uUaOjfcgovutQwp8Ta9cl48hTPCh+sMMTvAfQjh6OV4
         Qu3/GK7+gfihiFE9dvKiCwrTHA6Ihj9idKKFnW0Wd/4RgNmvrGskMqrSd0FkY/ZhOFES
         GcaVUYZrS+1pDprBcaghqbSbY34aa/5hEgPrOH9XdWtKGr47DfvOTxs8wUqJ8YVkB0TM
         lJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEs3G00VHY8EwtdUIttGPsPa/hYyZ0phbIsIaqIPwZ4=;
        b=zZY/JN+ME0kyxtlaZcGDRwPOtbsg+RGEvUIrUcbVMzY+Mx217mDuHDX/Iu1GKDmq1i
         F+jU+4VZ+JE9Yv05cEaFF5eQxftDZI41CRfVErjvt60HYtyXs94hozjis91uPlhfwMQ+
         JM7D4xZ2Mp0n7caSHASEf9bw2dC/f7QdBpOIjr3MIRIP6POboQ6epyEqDvBxDRwzt1ng
         yFH89edPB5sWRaxs/QdIpy4K6D9JKlOix7y1nbmr30FO1CFmjv84HZmDKopdaHWvXVyC
         fCy3KXurlx64igaft5wj5jwfUkyQklgU55UuNP5lDUBovNkMWxZ5K0vSldw/mCuaLe/U
         zbzg==
X-Gm-Message-State: AJIora9VbUh4rYpy1uVNo3gMJYBpXJShIaT5CMzpSsJDJkh+u5hZt4Tk
        fuxeNDv5XPJWHEiwePGJlw1PUVUlRL2ngEfutiEMxg==
X-Google-Smtp-Source: AGRyM1tcPH/6ecESZNaup02lqJ98voKrU4plooytOmMe+IbjluLlfKDuzFMyhzAbNgin18/kBnUNG8klG76h1Eg7mVQ=
X-Received: by 2002:a17:90b:693:b0:1ef:4d94:412d with SMTP id
 m19-20020a17090b069300b001ef4d94412dmr8802447pjz.27.1657700036609; Wed, 13
 Jul 2022 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712131523.1874428-1-vamshigajjela@google.com> <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com>
In-Reply-To: <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 13 Jul 2022 13:43:44 +0530
Message-ID: <CAMTSyjrhSSYVEBq=bdu9wBCcuPdrkmxS4jszOgOQBBvSKyaa_g@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manu Gautam <manugautam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 12, 2022 at 6:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 3:16 PM Vamshi Gajjela <vamshigajjela@google.com> wrote:
> >
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > With PSLVERR_RESP_EN parameter set to 1, device generates an error
>
> the device
ack
>
> > response when an attempt to read empty RBR with FIFO enabled.
>
> an empty
ack
>
> > This happens when LCR writes are ignored when UART is busy.
> > dw8250_check_lcr() in retries to updateLCR, invokes dw8250_force_idle()
> > to clear and reset fifo and eventually reads UART_RX causing pslverr.
>
> fifo --> FIFO
> pslverr --> the error
ack
>
> > Avoid this by not reading RBR/UART_RX when no data is available.
>
> ...
>
> > +       unsigned int lsr;
> >         struct uart_8250_port *up = up_to_u8250p(p);
>
> Can we keep it ordered according to the reversed xmas tree?
agree.
>
> ...
>
> > +       /*
> > +        * With PSLVERR_RESP_EN parameter set to 1, device generates pslverr
>
> the device
> pslverr --> an
ack.
>
> > +        * error response when an attempt to read empty RBR with FIFO enabled
>
> Missed period.
ack
>
> > +        */
> > +       lsr = p->serial_in(p, UART_LSR);
>
> The only caller of this function already has the lsr value, why you
> can't (re)use it?
lsr is not read before, caller function (dw8250_check_lcr) reads lcr.
>
> > +       if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
> > +               return;
>
> --
> With Best Regards,
> Andy Shevchenko
