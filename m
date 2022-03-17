Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64852C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 17 Mar 2022 12:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiCQMZF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiCQMZE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Mar 2022 08:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF796C12FD
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647519827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jeq6srkn3vKPjwF7bOhXJrvBVH81gTqAX2FFARSZuA=;
        b=jNKW0nwMRFtuaWfkyvk8gkGMShGg+yumKpN8mV05W5bcM+OCA73dC87a+y0KxLdNV3K3kZ
        AChh/CjDVpfdwglWPcwi/xc7AsdLzzkzfrRudKKrdNWGOC1I21GbUOJQJ77FZq04EzIEkT
        LfHlcjRLQXOyHzdglKxHlx+qfYtXrrs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-K2ZVRVvuO0y7xGD_AjQ5bw-1; Thu, 17 Mar 2022 08:23:46 -0400
X-MC-Unique: K2ZVRVvuO0y7xGD_AjQ5bw-1
Received: by mail-lj1-f197.google.com with SMTP id 132-20020a2e098a000000b002496771ab30so164929ljj.4
        for <linux-serial@vger.kernel.org>; Thu, 17 Mar 2022 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jeq6srkn3vKPjwF7bOhXJrvBVH81gTqAX2FFARSZuA=;
        b=ZtdyIc9L/ZIx50GHe8+QTK4lyWTU7jEmmX2cVJ9mPNciPjNPaSH34TPzFNU6i8EmO2
         hTPRI0ekvHaib8DP1cHiBA1sACnAozaDVpg+th6jBpRkWo+WaHOfw4qT6/E4JuuZpDH3
         LNpkzFaBV9fWCiXx7BdyM61expM+KdYu+k8LVan4/Cbuj7o4LStcJJwi9A+dJsWM6Fcv
         eSBJCaB4yH4qs/4NxDssA87sENTK+UGxGzP4X3i/BBBlD4rCUzCWQ9Enr1RJ36/KX+5c
         jHJnAleyfkO1SS6IgvMPR+rpYIPWIFIZFL/FOW4URWXxfHOr5yOuqJDYGT8H6crH4UMX
         hV5g==
X-Gm-Message-State: AOAM531f/A8vUwpAh5aIaAPnnRBQUrq/vcX3tIeDcyjLT6IxGg+J0Ql5
        HZZ8R4Ke3XZsg4enc9/QJXLeeSqkD8EMb+Zc3bzcKGhpM6tlIMsO6YpF/5cRgrIEcYFoj9WDJn+
        mORzGRlgHvTqzfCRZ2ZMbzN7BZkwTwxZJujS8VI+N
X-Received: by 2002:a2e:a0c3:0:b0:247:eba1:366b with SMTP id f3-20020a2ea0c3000000b00247eba1366bmr2704381ljm.190.1647519823612;
        Thu, 17 Mar 2022 05:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo3UqII19WI/p0VdLBXfqVvN1WLU0NnXb91JTrd0VJzRLZZMnD/ko+J4pnliY77wNGREXUQCtRUbMO1vDsylc=
X-Received: by 2002:a2e:a0c3:0:b0:247:eba1:366b with SMTP id
 f3-20020a2ea0c3000000b00247eba1366bmr2704371ljm.190.1647519823413; Thu, 17
 Mar 2022 05:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-6-wander@redhat.com>
 <2f3d386-b82a-9ae1-eaba-f2123b1346f8@linux.intel.com>
In-Reply-To: <2f3d386-b82a-9ae1-eaba-f2123b1346f8@linux.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:23:32 -0300
Message-ID: <CAAq0SUndENR-Of76g32sAOOD80=nnhmwOfeKzUq7XCboLyFsNQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] serial/8250: Only use fifo after the port is
 initialized in console_write
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

On Thu, Mar 17, 2022 at 5:44 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 16 Mar 2022, Wander Lairson Costa wrote:
>
> > The serial driver set the value of uart_8250_port.fcr in the function
> > serial8250_config_port, but only writes the value to the controller
> > register later in the initalization code.
> >
> > That opens a small window in which is not safe to use the fifo for
> > console write.
> >
> > Make sure the port is initialized correctly before reading the FCR
> > cached value.
> >
> > Unfortunately, I lost track of who originally reported the issue. If
> > s/he is reading this, please speak up so I can give you the due credit.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 4acf620be241..7e2227161555 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
> >               !(up->capabilities & UART_CAP_MINI) &&
> >               up->tx_loadsz > 1 &&
> >               (up->fcr & UART_FCR_ENABLE_FIFO) &&
> > +             test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags)=
 &&
> >               /*
> >                * After we put a data in the fifo, the controller will s=
end
> >                * it regardless of the CTS state. Therefore, only use fi=
fo
>
> So it looks like 2-5 just contain your development history and should all
> be merged to 1/5 (perhaps with Co-developed-by: tags where appropriate).
>
> And please don't just merge them "silently" there w/o describing in the
> message _why_ you ended up doing the things the way you did in the end.
> The messages you've written for patches 2-5 will serve you as great sourc=
e
> material (with small mods, obviously).
>

Ok, I will merge them in v5.

>
> --
>  i.
>

