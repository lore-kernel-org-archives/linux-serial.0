Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487B242D60
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252864; cv=none; b=TEQq86FLIxxCwfIZtRwDE3/qt2XF9SmBj+H9eMEZ8unbab3DjcmXhMt/nd9/ywR4Dd6uvQwdMyzCEJ3ZPLwXmswnEeMAJYqSueOyIV8SSGyxDrPd3unMpfJDr3kmmLDsKRV8uLrgoKuB12ChNkBtamTGu7u6vQrAN5qrV6njeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252864; c=relaxed/simple;
	bh=AJLtM91/33fmVR/qlQdypVuIczViZNMesjHgSFxWODs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6157zVNFth7T1vGV8gyn5y20IkRXzGfRTds6qzYFuyWEnfw6Ntg7P5wiYe1i1MHPgWX6CxCw8f+GI7/NfmVScKd2TgNN8ytlDIlExViLPhMZzKJotS/IWrtFNxEVsiB89WVhTDvSekZ5SI2ExGwd6mO3OowBd8esconA7CphDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=xFbGRuG/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="xFbGRuG/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso8556282a12.1
        for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2025 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1759252859; x=1759857659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeBiFZ8CYYNIOcno906wggBnrfnmw8kk5vZNSaIIco=;
        b=xFbGRuG/PMyyMgxQRSfN2ZQD3EySNO6QvfQIwPh8B/XPwGvFYQNUMzDjYMuXGrKIde
         54rUl/jY1ZoKPdonw9g+2qS1usCH8ofNbUn31f5wFEl/aOU66cr8zCB1MtFBcTjoPz2N
         Vw810d8ISL+d4NxzlUz0PmA2k5VVNFCEHZZsdqvskRNoWw9n+6i6nGM/UWqIlBBbJIKQ
         n5wdoppZmtPuSHZQv/xY2PrTJavn0kfEcAu2ik9K3Xzm3jnEsMlzwuPcutM2IRfyrTNe
         oE/tKbtxeKYYXVtyBh1P/MNHnh8833ojOsKPDO+sJeQD0PqDgz33W9byAMzIEALm9oJJ
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252859; x=1759857659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeBiFZ8CYYNIOcno906wggBnrfnmw8kk5vZNSaIIco=;
        b=WRtd1LY9b1D3SvYfV4Rphx8diiFZrjLPgvBzAczmS8VKGoJcgeh3aBN5XAYzNtEuEE
         XLIH1g7d4LL+Ka2bdDld8479gevPn3UP3buiI3a6Z9VGtCIpnSimQtCX9GyVgnA84sy3
         FnDzkmYu7vIRp2QQEWEVOawcBCQk3sIhJaWECQZ2ZHYNP/H2YcxisGV+bi7TlVxrVVpv
         Zu71fO02NUDhPoBsl0KwRnSURpVmqb2IhUrLHadKOatZ4PL5ZrSBwxvxZ9FdOuiPy0X8
         phIYBBnLSQz/VaFzLnyeXjUf9R+r28Dj2+dTxUv3YYKcr3uISLLWxTlSwp3kosu4z7va
         gLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4X6SJgXY0eB8t1HrMKPFGyJ9COap+HFjvYAREW33VPnXGRwdyzwkUuNyK+RJgIoXOF0NSX+iKjbiVfZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIhkctDZUPHXI6klW7gF7W9vsx2awQk+RFViFUkBAYBUB9ajg
	iWtM+MCZfSJqeMyi5uZdSU7trlkvi7SEeAlQ0o9xHUsyWD25qBPRLqvuJW+PWJkiD0jq4uccc6j
	Bz+Pn2ejkYLuIkflJakB02CwTLVePB0ERzgx9+SZA/g==
X-Gm-Gg: ASbGnctuGMQgNT6bJJhqEkTUm/o2q/7QFFPN9cNpFHYTPTWtpW8+ZodOcrFKhfyWMB8
	ElRqt6Z0VJInf+3K5EGzuWe8YrRn2tDqP4vrwNyeLSsznchEj3AiTdQ3kWbafipOVLbKz2zUQ4Z
	z67RYbXEKPid2cAzQsgh7EZGIBTzSgViKPPwjhdPVJQVtGf6SiBzJ6y5QaNdzOXRb4sglk3Rf+6
	XltM1xUoUjmG3oKNPGxKybLibVEYyoR
X-Google-Smtp-Source: AGHT+IF6gmWMMmnvd8SXAqteiQRvavbIiqTU4ziQkpjq2GxFYPnxTuZRkuqmxUhWfFskN7jiuo/ToSuXYLZtYEdbzhQ=
X-Received: by 2002:a05:6402:4305:b0:634:a584:6e44 with SMTP id
 4fb4d7f45d1cf-63678ca5df9mr759820a12.18.1759252859032; Tue, 30 Sep 2025
 10:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923221756.26770-1-marnix.rijnart@iwell.eu> <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com>
In-Reply-To: <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com>
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
Date: Tue, 30 Sep 2025 19:20:48 +0200
X-Gm-Features: AS18NWBUxk6JDFUrYMRmquwKP7cxr7696-nl8HLRBqtqZNVEfYHLfT27GfYxE-I
Message-ID: <CAAn10+fRb8VXnDEsSuCj782rp43ZEeov2yXnB2pYxXGNc-2niQ@mail.gmail.com>
Subject: Re: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for F81504/508/512
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is my first interaction with the kernel community, so I did my
best to read up on the expected practices but maybe I missed
something.

I didn't add a Fixes tag for commit 4afeced because it doesn't cause
the bug by itself, it's the interaction between it and an older commit
(456d523) that create the issue together. What's the right way to tag
this?

I didn't Cc stable because I understood this to be only required for
point release regressions within a stable series
(https://docs.kernel.org/admin-guide/reporting-regressions.html).
Release 6.8 introduced this regression. Should I still Cc them?

If these tags need to added, what's the best way to do so? Resubmit
the patch (as a v2)?

Thanks,
Marnix

Op di 30 sep 2025 om 13:32 schreef Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> On Wed, 24 Sep 2025, Marnix Rijnart wrote:
>
> > Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
> > introduced a regression making it impossible to unset
> > SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
> > unsupported. Because these devices need RTS to be low on TX (fecf27a)
> > they are effectively broken.
> >
> > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
> > so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
> > similar to commit 068d35a.
> >
> > Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
>
> The Fixes tag is missing?
>
> (And Cc stable tag will be necessary as well).
>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index 152f914c599d..a9da222bd174 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_po=
rt *port, struct ktermios *term
> >  }
> >
> >  static const struct serial_rs485 pci_fintek_rs485_supported =3D {
> > -     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> > +     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_=
RTS_AFTER_SEND,
> >       /* F81504/508/512 does not support RTS delay before or after send=
 */
> >  };
> >
> >
>
> --
>  i.
>
