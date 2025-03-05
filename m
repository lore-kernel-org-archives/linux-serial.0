Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A182512ED;
	Wed,  5 Mar 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200761; cv=none; b=NMEX5H3pP5VkYX12QW8gRaRCTwpinqJ5DHqXkTBw56LDTVCcFqRs56V7WWLUnniffRJhRK9MfaF0kVdmQgoqbGurFzH/q1qpiCP+lVelR3I7qHpsmUksHgVvjDbU/EbrK4w/R6MDcrxZfdJkDwU7Qk/CGPAcL0yOHrFh2BbFVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200761; c=relaxed/simple;
	bh=5OGi9WhU9Aq5b60t6Jt1Mzylgj73/YdOQ5kzSR0pyxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHcpffpCCReHbrXoB1bhIbSH/DugriiDgrhxPaaetVs0mYJWwfBb8o9IVYhAKWsyLPyeVXiLYOi4mA4H95Gk2BpStrYI7sKAqB8o9fFNljXAE/rPY7tn14g4ZnjfQvtFWU2pwAy7DKrDavXKVjq7atz/oFrc4QFzD8KOaTlLsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD9HdkkZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD9HdkkZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so9560167a12.2;
        Wed, 05 Mar 2025 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200758; x=1741805558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asKVsq7k90t+anWTAyo3VJyh0AkcVitH69hdmM8MsTo=;
        b=hD9HdkkZJXOY0w8E5UIZpnNtcz0Owexu06G6wFlOzGZRnYq0NE+gYQP4ysZmdetceK
         1ZanYZneSURLtw2q7aegazrrA/W/zbYtSELvKSSLMcn8cxEji/WeJ/xasVccKldBKCob
         2HxFtncdNCLdoffgCoLDE8f5Pkhryx8cTfUh+h0V0FGpjl0oRGcsK78Qdk4LaV5PsY1W
         G7x/XwHp0Y/Q/MffLRAFyg69KdsAc5OgGv2m5gMPUvKbjxk9gnoSV8NldwpJCV9MUV2R
         C/MktraU5Yc1mnnoVAdSTwA81fSRaMT2ZslDRyVPUBw0GeNRiMA4sACU1uYE9wgvdGfv
         rmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200758; x=1741805558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asKVsq7k90t+anWTAyo3VJyh0AkcVitH69hdmM8MsTo=;
        b=dkrki8ZzQZKOZIbBsOl/SS3WXxbnlTudJ7uF7kE2Q2B+v60iZX69CxrJ9e6fqwXmhs
         560cOFYW293aADFXEWWQs4CKLNYquBGo3yeLa2fc978O7SdF4DtGPPZNkVVWSYac781X
         DH1wWp/uD9t/eVJLUFUwy5A0cNuONblmmetBviZvw+Feyk/VgJadlw9m8YiQ2/rnnqO4
         OVWPjOs+AHz33ii0a6rrtTApC0vX+gNsa+2hdRSZHkbBSr3ItbwzpxwrvkmKDNt6l4kR
         wbztZSc5LLecOFCYT9iUxDVGVoVjyDmg6liCRJJNjlEQMdDmAZBjlkfEztsBVenFFaXD
         yThg==
X-Forwarded-Encrypted: i=1; AJvYcCXK3ldd46uc4mpcNn1GNGRCkW1A/+QoXVjwf+yFJDbGiVv1JCKbn8X7kfiK8cZPMQHA0idY9eJtSfMs2bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGEmAIRXiIfiCceR4/hJXqfmZ7im7AoJduq0PP4vIKf6bKt5v
	cXg/k/ZDCRsEXYn/mtx2rGQ3FwbfXMmDfgznpUY9KOyTxtrC8qSVVUwSB20HmWcErv3eRmN1M0n
	wJwAO7gTsXRzO25GIDff/QEkn0iQ=
X-Gm-Gg: ASbGncti1tSJkdKwTT56M8enffVJ8Nm3xA3/D6B4UF3WMm06qDeBFOo9HXYOYxzaePy
	M/jsQ7fQY/vc2cRYouQEsKFW4PK6xYPcSPeppV0dCNaHj2mYf6v/WRO0Rm7Z6Kw3IbUHe9z2ikO
	R7NKCi9lR9OXJeiCEDEdh73rK5Ygie
X-Google-Smtp-Source: AGHT+IFJvcOkeuIanqvTEWrSBlSvIhPEkB5zsmiNSFjOpGMFhf9m/19uwK5aTIkNOkInZMH31fSH43ty33pM+/ypuiQ=
X-Received: by 2002:a17:907:9726:b0:ac1:da09:5d32 with SMTP id
 a640c23a62f3a-ac20d84621cmr487306166b.6.1741200757572; Wed, 05 Mar 2025
 10:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <20250304035447.3138221-4-adamsimonelli@gmail.com> <CAHp75VftQASqajiG_z-==CmVMu5Orv_Q8QMj-7W=sxsJPq6bJw@mail.gmail.com>
 <7969025.Sb9uPGUboI@nerdopolis2>
In-Reply-To: <7969025.Sb9uPGUboI@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Mar 2025 20:52:00 +0200
X-Gm-Features: AQ5f1JpVHY8TTQrybjZBq3aG7LWM0EtWCpvAUrhdlktBqZTOU-Uz1UtaifmdCIM
Message-ID: <CAHp75VfadXS8Z2G6U_DcOOZFFmaOSn_9uQN_N7Psse3kiSGj0g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:06=E2=80=AFAM Adam Simonelli <adamsimonelli@gmail.=
com> wrote:
> On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> > On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:

...

> > >  obj-y                          +=3D vt/
> >
> > + blank line.
> >
> > > +# If ttynull is configured to be a console by default, ensure that i=
t is linked
> > > +# earlier before a real one is selected.
> > > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > > +                               +=3D ttynull.o
> >
> > Here is the question: are you sure that all console drivers that exist
> > in the kernel happen to be here? Have you grepped the source tree for
> > checking this?
> >
> Grepping for console_initcall, the only other places I see outside of
> drivers/tty/ is
>
> arch/mips/fw/arc/arc_con.c
> arch/mips/sibyte/common/cfe_console.c
> arch/powerpc/kernel/legacy_serial.c
> arch/powerpc/kernel/udbg.c
> arch/powerpc/platforms/powermac/setup.c
> arch/um/drivers/stderr_console.c
> arch/xtensa/platforms/iss/console.c
> drivers/s390/char/con3215.c
> drivers/s390/char/con3270.c
> drivers/s390/char/sclp_con.c
> drivers/s390/char/sclp_vt220.c

Which means you need to test your stuff on those cases, to see how the
linker order is done there. It might be that your change wouldn't work
there as expected (quick workaround is to mark the new option as
depends on !S390 && !PPC and so on.

--=20
With Best Regards,
Andy Shevchenko
