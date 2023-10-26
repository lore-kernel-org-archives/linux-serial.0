Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45740C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 12:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbjJZM3D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJZM3C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 08:29:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EB1B3
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:28:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so13038a12.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698323338; x=1698928138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IBEv/O80HNkfZFTysz0lNdRsT33RzTkskLkw3trITY=;
        b=Dmi+v8z4x3YyTvUumRpW0CQnjft4HCgqEST7xUOIlcEzPuF5yQEXh0pg6HLUNweT3l
         Z0wwTsCUn7tZ0GPGJ2PL6gxLDP75fwUKBo/D0x6z6DJf6q0ebeCcXfm8lyKmPSBpH+FD
         v+uEBD7OmfdoXJq7697xpjSWwbwAk9/Yteq8Exw7ANxVwyqhikIoIgAspd4B2MyYA6r2
         +eVbv+dYhPMyc43r3CF6i+UBRVsq1scOnYYzmnp5U06Qf+hV8M5aVp2dRaG2GCEPPJYZ
         vqqlG79VswQqbEUTTubrKfedif1rYOvTO2mAJqBFQB65BjBecXAw7PZzlGk4sC6lI43H
         h9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323338; x=1698928138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IBEv/O80HNkfZFTysz0lNdRsT33RzTkskLkw3trITY=;
        b=fBiLOATCAhjXXQVsQNrDYCeOkAEg4ge5AMeuqerHf23lyGpU3oYr9PcNqCfqr3DWGy
         9gzvgOx6bz2/8CMqdIohtwgLF3zifDi32WkW2b4BZtZQuVQmWxwlJtklMGhY5uLWbjZO
         WFsq5I9+fpS+RAGQlkdVQ8aqEIcJmlyeBIg9chPiquKyv0P11QJZXcGSzd6jMPExq8HG
         294btm4RyZd3Eav60qFYFKjc8cTOCmdO3f4jKlw+CkQhQy1k380N2mzbe7FWkWyb5hEj
         d4jA2EMFnwmQ5zqpq0PjXqWOmfJeSlTTW39uDie1Ep8f5kK9XKwv6eeA9QFjqDmetxwP
         Ha3w==
X-Gm-Message-State: AOJu0YxSwuQjUcIv9V/ecYl7t752ZBQbxyQIuVPfbu8PhMUjCCTWMs94
        kGeSyLtM1v2xXQhY9jtSnVL+mp6wLRIftCLmF1P3h43O8fGR/L5h78rRdg==
X-Google-Smtp-Source: AGHT+IFJ/mJwORUULNzqI1O78KtuFscIiTydX36EK7ODBHhhC7oI/6KeDSqOKnCRVH9nPY69cw5BvsugfEssb70IpB4=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr264669eds.4.1698323337997; Thu, 26 Oct
 2023 05:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142609.2869769-1-vamshigajjela@google.com>
 <7e7eb495-8e54-49f3-bab7-0de72b2cf7b6@kernel.org> <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
In-Reply-To: <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Thu, 26 Oct 2023 17:58:45 +0530
Message-ID: <CAMTSyjq38Sj__rQiO2SKMubpFEtRc_3CvSAdPJTVFQZqTMhf2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 26, 2023 at 2:54=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 26 Oct 2023, Jiri Slaby wrote:
>
> > On 25. 10. 23, 16:26, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > >
> > > The function uart_fifo_timeout() returns an unsigned long value, whic=
h is
> > > the number of jiffies. Therefore, the function uart_poll_timeout() ha=
s been
> > > modified to use an unsigned long type for timeout values instead of a=
n int
> > > and to avoid truncation.
> >
> > Hi,
> >
> > there is no truncation possible, right?
>
> That's very likely true (I didn't run the calculations), thus it's correc=
t
> to not have Fixes tag. It's more about having consistent typing since
> we're talking about jiffies, so unsigned long as usual.
>
> > > The return type of the function uart_poll_timeout() has also been cha=
nged
> > > from int to unsigned long to be consistent with the type of timeout v=
alues.
>
> Don't write changes you make in the patch in the past tense. Just say:
>
> Change the return type of uart_poll_timeout() from ...
>
> The comment also applies to the other sentence above this one.
Sure, will update commit message.
>
> --
>  i.
>
> > > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > > ---
> > > v2:
> > > - unsigned long instead of unsigned int
> > > - added () after function name in short log
> > > - updated description
> > >   include/linux/serial_core.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.=
h
> > > index bb6f073bc159..6916a1d7e477 100644
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(str=
uct
> > > uart_port *port)
> > >   }
> > >     /* Base timer interval for polling */
> > > -static inline int uart_poll_timeout(struct uart_port *port)
> > > +static inline unsigned long uart_poll_timeout(struct uart_port *port=
)
> > >   {
> > > -   int timeout =3D uart_fifo_timeout(port);
> > > +   unsigned long timeout =3D uart_fifo_timeout(port);
> > >             return timeout > 6 ? (timeout / 2 - 2) : 1;
> > >   }
> >
> >
