Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF342CDB47E
	for <linux-serial@archiver.kernel.org>; Wed, 18 Oct 2023 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjJROZz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbjJROZb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Oct 2023 10:25:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857D193
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 07:17:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12330a12.0
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697638633; x=1698243433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOE/HwXbjXBM8pvrHd8gpMB/9CB4hrW/MzpGagoB2q0=;
        b=0t0nAVvHIAmh1ekQB8kNEH/ekimf1bdP9TqJyMJMAzlrC/61akbCcHKl2FTG8Ggyt7
         2bRwZf31LtuYyaql30L3t1pXyfqqXdhMfNFLu5l0T7ERcNUin+BSJzGulJnr6s3G4hvS
         i6JQmCdj+DtnvG7ltbNybrfYyAy0A4T/rXWv7iJSaN93/S6EzTJU1KWyEDcaejjQ8kOJ
         vlK5vwPMGmkg/6IblukKn6PQRwP+D5WPfyTTCQ2F16NEAC5DDzD4il7/3bef/xlz9GmX
         iMbyD9o9Lp4dINnTAdl76MFT8FEs1aVv0oG0RlHq3uuA2F/Is56JzQk6pi8tFkGWQXRO
         GxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638633; x=1698243433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOE/HwXbjXBM8pvrHd8gpMB/9CB4hrW/MzpGagoB2q0=;
        b=Tzv+32hFxww2gSEm81WNkmlK86GKI6sIFREbmjeXpCKeSUK8Idjuz8ZPr2kkhGX/rC
         Tcry4fTsUOgnSeM2oID/OpARSrnguT4lri5lyB7D0GTNGQdyjnRny+rvywh0mm369IlF
         Xaa/2hjamV3OuHi6BYbi90reZbkiXOh9Dehtv/eE6OM8gcanvf3m/Ksid3+05ZsN/ixc
         EhRnl8sNWaSCsC/r7zzM8TGOJCs37KW/03qMLTo5wTCbVdyC8d//wmhUwUDCX/TIfLhV
         EbiIbbYg+9hMTvNceBSQWWfGLcgUbA1ZUVNkxwEPOxRx1chIJ6kLY3jJqhgSbylgpMLv
         Yeeg==
X-Gm-Message-State: AOJu0YxP6PFUqGAjVY3L68KjtO8yGlD2XMqiRaa3tebYA3udKXP+Kcz5
        mP1mkhdrvqN88ZO77SITctArQkom1C+RIN+kwINjJw==
X-Google-Smtp-Source: AGHT+IHmL8s7uMe74PQsFSvo3cbKUEO4eKQ6ofJYGQCkXl0yaoYhv0BaAcEdSxe3CnHa/wjM6y76eZdS/9Xom2hW1rY=
X-Received: by 2002:a50:9f03:0:b0:52e:f99a:b5f8 with SMTP id
 b3-20020a509f03000000b0052ef99ab5f8mr99470edf.7.1697638632991; Wed, 18 Oct
 2023 07:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
 <20231014104942.856152-3-vamshigajjela@google.com> <b0ec67b1-24a2-d67d-d7c1-9c3fdafdb570@linux.intel.com>
In-Reply-To: <b0ec67b1-24a2-d67d-d7c1-9c3fdafdb570@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 18 Oct 2023 19:46:59 +0530
Message-ID: <CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10VRYD9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: core: Make local variable size to u64
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 16, 2023 at 5:09=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 14 Oct 2023, Vamshi Gajjela wrote:
>
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > The variable size has been changed from u32 to u64 to accommodate a
> > larger range of values without the need for explicit typecasting.
>
> Don't use too broad/generic terminology in shortlog (on [PATCH] line in
> subject) or changelog but explicitly mention the variable names please.
name of the variable is "size", may be now I will rename the variable
to "frame_size" in v2
>
> > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 7bdc21d5e13b..fb4696d17a8b 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -410,10 +410,10 @@ void
> >  uart_update_timeout(struct uart_port *port, unsigned int cflag,
> >                   unsigned int baud)
> >  {
> > -     unsigned int size =3D tty_get_frame_size(cflag);
> > +     u64 size =3D tty_get_frame_size(cflag);
> >       u64 frame_time;
> >
> > -     frame_time =3D (u64)size * NSEC_PER_SEC;
> > +     frame_time =3D size * NSEC_PER_SEC;
> >       port->frame_time =3D DIV64_U64_ROUND_UP(frame_time, baud);
> >  }
> >  EXPORT_SYMBOL(uart_update_timeout);
>
> This is actually a good cleanup all by itself unrelated to the other
> change but you need to adapt the changelog to reflect why this is helpful
> instead wording it based on the other change.
I shall submit this as a separate patch. As mentioned in 1/3 patch
I will also add a cast u32 before assigning the value to port->frametime
along with variable name and size change.

>
> --
>  i.
>
