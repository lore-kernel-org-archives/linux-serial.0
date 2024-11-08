Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F617137E
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073218; cv=none; b=g8P81duEZL4dVrNCPE54lQpwe/iG8tsMdLETASQmDfGbbV71D3NvlpLiaOzdneOuaNXzkJncGz0HLJyemsMZ9IGar2j/P6E4QnYJWQd6fBRRBVWiMGExmgRumvUBAr7SFooGEYGds9WXOz07SGGL+r+QRIGNu3vly/0dFMSyas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073218; c=relaxed/simple;
	bh=lmh0z8bq/zzGYs+/6YkGeLdY+DCKygDX5CUuwOJL7Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGokNkND1aBkDL6XrpaoniLJEdXzUKucdz7YkRpzvuaC4suKTqfnOzhcbNoY2q7vFjzPgtB8H6UN8MBNDwx2ZnxA2RzhB8xjeLo76kCEzaugn+0z+LrSkXN85yZHo9oUI/jDUokILMLadim1EkbpMh/Am2AgPxMeqrO6HhSuz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=XV4zSLaV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="XV4zSLaV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1546789a12.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 05:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731073216; x=1731678016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8ZJwvOeV6Ng8VTt9n6SG5cFjyqB7gKUP8OuA6z3DVg=;
        b=XV4zSLaVX4syObbS9WbCp4I3umSYoCGxQNrr0vue2VxPeMl5rpqPys7fgWYBfUvRdB
         7e945IqgRXWPDRdwIHYVvA97uEPayvsC8VAgDjcE5y44QE274r9FCdhLh9F4U5Yc+/fa
         HhnGcHnTz+hkl7cDkyQGeIAaYX3brzoPqcjfBbfgKAKl/d480Q0n8WbDi/r576S6UqXP
         kfUe5rH9fj/8jJM1f32h6qjK9LPTMuFthwAOsqxjJJavRGy4Frw6FnWPUfmBkyB56SLy
         sj3atY7dMOapipSoAcdHhLZx6sO5DlVJKDHwdIGFeGjQ9pZ23sJnZJvgS6Nlbt0nfPsO
         2gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073216; x=1731678016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8ZJwvOeV6Ng8VTt9n6SG5cFjyqB7gKUP8OuA6z3DVg=;
        b=sKSZ5N+WFPFS0+ZmMwzKxV2cLuUUsfFtQwJORWbLgWB0janVfk2tNuYbxlnCOhu/fD
         U2q017It5np+mxyCqJIPTXF4TFEXyy04r0um1Ah/N4c3E2ZLb3Wr+2qylT5R059oGHNf
         Ty1B7bsVQ2/0e6VYZV+rxaf1tHVSV0fjImM6dBDdBoN/8A5nycJC54p/EhpDUJCtIU36
         EBSQSlgxw4e03cmVPY6dzl0fpydk1xAxsJWYGjXyz2wxhZFsvO1hGEfm1YOJ111KjemQ
         Ht+UZFtcAInr/Llj2PvF68kZk7h6Msb7rIj+4phsneRXPgmfICbaYghY9oCqNuwGRAnH
         qrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWsgpdeVrMclYJUVdJWUs80vviQGWpoi/57P9/gu34+7m0t3BJ/C3DtDdDjr1pvKTOlNb1z5OOQjJxCg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjamcsBfBHpl4RTTxAxWL7J6T00nMAn77bwDQI3koaNluyg6C8
	SRqhkFGUc9QWOXMMa+nFpNeCsejZvbqGPCIoKFrUpJzC5sQYOPlLOa+CKIoig61/TVGxzeoM/Rz
	weE7LDtKAyVWNTsLSJHto6bedfYMCKmMpDtfv6A==
X-Google-Smtp-Source: AGHT+IG6OWkcSu6zPwaHqEtkBnsm7V//38o9bsGqJYwF50bdWilViY347QwXIH+QFKTXlm4Y8ftOczB4h+DcYu9T4dg=
X-Received: by 2002:a17:90b:1f86:b0:2e2:cba1:67c9 with SMTP id
 98e67ed59e1d1-2e9b1754e25mr3320320a91.35.1731073215604; Fri, 08 Nov 2024
 05:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108112355.20251-1-robert.marko@sartura.hr>
 <20241108112355.20251-3-robert.marko@sartura.hr> <609ef9c4-18cd-4a80-9821-5df27727772e@microchip.com>
In-Reply-To: <609ef9c4-18cd-4a80-9821-5df27727772e@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Fri, 8 Nov 2024 14:40:04 +0100
Message-ID: <CA+HBbNFomosu+5_C0+6cqKcc3B9DFiXXPxexFYjY4ud2LmWqmg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tty: serial: atmel: make it selectable for ARCH_LAN969X
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, lee@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:25=E2=80=AFPM Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
>
> On 08/11/2024 at 12:22, Robert Marko wrote:
>
> A little commit message would be better.

Hi Nicolas, I basically reused the same commit description as for MFD
and else as all of the changes are
basically the same.


>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   drivers/tty/serial/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 45f0f779fbf9..e6cf20b845f1 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
> >   config SERIAL_ATMEL
> >          bool "AT91 on-chip serial port support"
> >          depends on COMMON_CLK
> > -       depends on ARCH_AT91 || COMPILE_TEST
> > +       depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
>
> Checkpatch.pl reports some "DOS line endings", you might need to fix this=
.

Hm, I ran checkpatch before sending in verbose mode and I dont see
such a warning,
my Sublime text is also set to Unix endings, I also just checked with
cat -e and I dont see
any DOS endings.

Regards,
Robert
>
> >          select SERIAL_CORE
> >          select SERIAL_MCTRL_GPIO if GPIOLIB
> >          select MFD_AT91_USART
> > --
> > 2.47.0
>
>
> Once fixed, you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>
> Thanks, best regards,
>    Nicolas



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
