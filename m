Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B371F4CBB;
	Fri, 28 Feb 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769213; cv=none; b=cOC9BnJpmeWgr1Hk2P1w/s+DkEUDJHcyWxertR353XAU3M2w3lqU+fuN7AcnZ8NHg81DY/EnGcHFPjDzU/QWgFf9igQY8wLXnpDPcHih8ASPaA0gmeczf1BGy3/DjxRqyWjvHQFn+HFMWKhYcF/K9oN6VVT7BoRv0BVdwI0hirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769213; c=relaxed/simple;
	bh=IZtynmfaHRYFxrZRerGB9UiuIb2V4Xf2oQxs/bBYEho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZDEOjx3+pI6auIQakKnXS2adtNX6btb+3FjP3zoP01G46plfR59t0wOdOjulN1p3xCHvKMhQDPTRbKqLvgvCOKV2yLxY4OLMO9dTf03ohHf+3eS3XmxfEbPSuyrrBH7fknl9cSSO91wJsCGKRamQWcZyPhSDZRx22Edm0oDc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz/id3/0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz/id3/0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbdf897503so630790166b.0;
        Fri, 28 Feb 2025 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769207; x=1741374007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZtynmfaHRYFxrZRerGB9UiuIb2V4Xf2oQxs/bBYEho=;
        b=Dz/id3/0xW9H/FONPtubDK1cyDmJDZGXAit6qfHJZjZtghBgFugyrvGjYC16sUAfPb
         9/LdHQ1RLHc2XV7vrsr1N+lg3G87BX6aiFnu0tbttkdUuxB/Xd+JL7tFkQ7O49cyBkUf
         /6Hoggf2fN4crf4qWINbGjGIcYSFFeNbyVt9if9OawaKAB+KZ5CoDZtnMC7NKwQseyVn
         9XgwtVwTVc/FsBd5cTnM34+d/QLfQb9Uj87atkpDdpV0vfXbAD0BtTD043ur7X+8izHA
         lG32VPG+SiCdvTr8CAbc1s2Bh8M6K2ky+60Hlk6gJMoOTKLkkyBIgY01wmrDwz2ajt3F
         0WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769207; x=1741374007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZtynmfaHRYFxrZRerGB9UiuIb2V4Xf2oQxs/bBYEho=;
        b=W85uqORbVpYkWipUvdUBXqZKL7ONyTW700sRl8tiVyKwKJ+X+FgKdeyLRM+jMm40nE
         fGFrjX8jOOWmmTDTK4q3t+Z+rYjYpCii0EU3o3ZN0THbA/N+l7FUxKN9L+LevYXYxsu5
         KJBNZSpWOQEs9WD6rrLSb15hdnm6nOLH9OJmavpGJIWEQTtx5r7+ORcrp+pvUo9AQixN
         mw2ptoW525QhVSns717qMtSNF8sfAV4tCWuVIpWGAMQRMNjVSXDXgFroCGqklaxVLLLz
         7tm5XTVN4t+HCCKX93E7BhFM1u96nrbEg8a/s8ApZX2PzNe+eszHlW04vI5YttjWwY6w
         UtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZwZcLR2x67XwbWznSDD8FHSnzZOU2UOM/SXuZuqQ2S+nWqI1WFkPllIxRC6BraLBeaPwrGM8sJ4REqd4=@vger.kernel.org, AJvYcCXxg5rGYXS0w9u61/eOrPbPs/67y7q+0cLcwwrGlqeFXSgI0K0O1V54h7RaV5CFwlFIkNGu3S5lyhsjp3X7@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWIITOvqDzDpnMtWZ+YgaROLXLkZRt+qYAdQBxsN+qK+xus9v
	FoUz/B9i9wCkYhxIFpFZahDLSiid3cDbQIvRp63fH4rq6qt7DWhsiM8GDfGjuZBO8AU1gNt9ETt
	auD4N+J5YQq8NbO3JXYuiluoxcXxkyIrq
X-Gm-Gg: ASbGncskDiY/FfcpZtQNVFXEPOBMHixpOrYv5UjckGJ6/D5hGb5KSTATaos8jsae2LL
	tr6K7SfCPrPTYLnUjIZL84z4yQ5lOcl21l9ygzurjK/SNqfuoalpO5KVPyd2dbgYDFMx4WpgfRE
	SXKqv5YWd14g==
X-Google-Smtp-Source: AGHT+IGd4VuamC1sfoziA2cP0WT4A9zfwnXmm3ifKaysfOSYwDZ8uAg4ukqWuvhrwMw9LVy4clMiZVIclyY761MhFiE=
X-Received: by 2002:a17:907:c298:b0:abb:bb82:385b with SMTP id
 a640c23a62f3a-abf0605ed65mr955612766b.13.1740769206729; Fri, 28 Feb 2025
 11:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <10194425.EvYhyI6sBW@nerdopolis2> <CAHp75Vdr1yNamVMP12X2bZs5=PL=R+Lsio5b+ba_NaPOsvzobA@mail.gmail.com>
 <10956921.NyiUUSuA9g@nerdopolis2>
In-Reply-To: <10956921.NyiUUSuA9g@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 28 Feb 2025 20:59:29 +0200
X-Gm-Features: AQ5f1JoDSux9fY8lEWh4zn7o-7nkfwYUOpPZ_sMPDki09yRSXyMzxRbLEp32hsA
Message-ID: <CAHp75Vdz6J_zx28LMtDvM7HDVOSsTU6pkXtyWoWSobM8MqMxJw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 6:39=E2=80=AFAM Adam Simonelli <adamsimonelli@gmail=
.com> wrote:
>
> On Wednesday, February 26, 2025 2:22:20 PM EST Andy Shevchenko wrote:
> > On Wed, Feb 26, 2025 at 3:39=E2=80=AFPM Adam Simonelli <adamsimonelli@g=
mail.com> wrote:

...

> > Just a side note: strstr() is fragile as theoretically "console=3D" can
> > be part of an argument unrelated to the console, like
> > foo=3D"bar,baz,console=3D10,key=3Dvalue". Although I haven't checked if=
 this
> > is allowed by cmdline parser (lib/cmdline.c).
> >
> Dang, good call. As a crude test, console=3Dttynull=3D results in a panic=
, so it
> does look like it allows =3D's in parameter values, as it looks like it i=
s
> handling the =3D...
>
> Gotta find a better way to parse it if I'm to do the `add_preferred_conso=
le`
> route, Maybe I can try get_option...

It's rather next_arg() and its derivatives. I dunno if we have a
helper for the "give me an array of this options from the command
line", but it might be somewhere lurking as a static function. If that
 is the case, one may make it global and visible to other C-files
inside the kernel.

> What do you think of the placement of it too?
No particular ideas.

--=20
With Best Regards,
Andy Shevchenko
