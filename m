Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C44C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 17 Mar 2022 12:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiCQMFe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiCQMFd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Mar 2022 08:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F3219315A
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647518657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdTSBCWZfRB7gl4NcFBlztb/OOGHep3RIbzmatr6VFQ=;
        b=doYa7O7SpvTlH0Wc3RixiVHVUzdCBa6XZU2S79U6dO8d989sNw1XMgkeizivEjoIyTQrWj
        Hed6gl91pKO7Jv6Kmu71hTUKqaaTy8qO69S9mrs3IxoUhduJw1yPGQW3LwJnECXuo5ebU4
        B9j1cAbqii6JCc1WlmPsWMEJS5yp4cQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-CfcskwFrPeivHdO6XbTfAA-1; Thu, 17 Mar 2022 08:04:16 -0400
X-MC-Unique: CfcskwFrPeivHdO6XbTfAA-1
Received: by mail-lj1-f199.google.com with SMTP id f12-20020a2e918c000000b002496651f1d6so271120ljg.0
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FdTSBCWZfRB7gl4NcFBlztb/OOGHep3RIbzmatr6VFQ=;
        b=oaBdNUWXG4acvDiyMT4/zicz6wV8PNJP3ikb0l6x66AdsH7k3we5NzUWh+jVgvA3mR
         5kDmgFeY+hFMLPel432sOPuTV4ZVdKXzUmJTm51p22ZgGzCr6TikRberDavVdZM5onqx
         5fpzOvA2aAda/BLBIj446bl2bwxhE+VOG1NkXPt9Asc783dDyOgZ7b2tCi6ANQNnRlie
         czVhjVsmNi1RNqKAdV1ScLAqSk9H8zgQiEv7xCLQmUBGhG8xao+6HenkjtDZESnN0X20
         +z3/FTfCowKBHsE9HuO5jh1P93ZnX/8T9K1btU4iuFL0Fek9UiGfCnMXkyIU53fwGshG
         xumg==
X-Gm-Message-State: AOAM532c+V9c4Mg6sJlGeLjO8102qCJR7HbQkbXbIsA0bDQpjYlxLtIR
        sjkK6kpXA2+qh64xGLDQqpxDHsD9g6LzyvW07QVFiTMHug2mXd27O1cFG2BPO6HRJOox7hMzHe3
        hzfU/rNeoUtJUAPpvzuNCxu6zvLPXxl5149oJZoMi
X-Received: by 2002:a05:6512:44f:b0:449:b929:a301 with SMTP id y15-20020a056512044f00b00449b929a301mr2699667lfk.180.1647518649547;
        Thu, 17 Mar 2022 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn2/gammYMEhSTgjHb3uCUKDlyraLf9N+wqpMA6XqrZ9+XtOOCoVlma0IkJ0zgfZJMfBknwy+BxtFxUgrIIYI=
X-Received: by 2002:a05:6512:44f:b0:449:b929:a301 with SMTP id
 y15-20020a056512044f00b00449b929a301mr2699643lfk.180.1647518649298; Thu, 17
 Mar 2022 05:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-3-wander@redhat.com>
 <ce8be768-6210-c3b-2131-de302a7757d@linux.intel.com>
In-Reply-To: <ce8be768-6210-c3b-2131-de302a7757d@linux.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:03:55 -0300
Message-ID: <CAAq0SU==UJpdTN2YNm_2KNGQmSKMOU97fFb-wTV2VM=vO5pPCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] serial/8250: Use the cache value of the FCR register
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 17, 2022 at 5:31 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 16 Mar 2022, Wander Lairson Costa wrote:
>
> > commit 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
> > erroneous tries to read the FCR register content, but this register is
> > write-only.
> >
> > This patch fixes that by reading the content from the port struct fcr
> > field.
> >
> > Thanks to Jon Hunter and Jiri Slaby.
> >
> > Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 2abb3de11a48..9f3fa9fe2a4e 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3410,7 +3410,7 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
> >
> >       use_fifo =3D (up->capabilities & UART_CAP_FIFO) &&
> >               port->fifosize > 1 &&
> > -             (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &=
&
> > +             (up->fcr & UART_FCR_ENABLE_FIFO) &&
>
> Didn't you just add this line in 1/5? Please merge this kind of fixes tha=
t
> are due to development history of a change to the main patch itself.
>

The reason is that 1/5 has been applied in 5.17 and then reverted, so
I thought it would make it easier for reviewers if I sent the new
fixes in different commits. If that's not the case, I can send a
squashed version with the changelog described in 0/5.

