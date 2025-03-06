Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33912E3388;
	Thu,  6 Mar 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741235534; cv=none; b=tN7sJb6t6GxTaQBFc/DJG0zCJEnReljIcadrolUfvTe8FGUu7vud35eH4B/oFWcI0P5DzgbSlBZBAe++dg98P1XflYMIpD4WrYp8OLbE7UGsczs8vvbp81zoqh+9DH7s06zdEsePBE47E73FMi2XshlDSHobq/+3RXgcu0bcx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741235534; c=relaxed/simple;
	bh=xkhEKkUC7blEgMYB8E+nSpBLpOAnSW6t/WgQrTQH0Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Emqo3pBIxrD2cy/vskDvRa4FdMgEneWVKfML/fvdrgzzeRCEnCxlC1m5N9dlCQdBcXdkq4i45DkuX/pmSvMOe7qWAUwUeacFtPsPUM8tY4CujKhfT0UKhQGO5yHAOwNhtTqJcoFVR+XtH5NVxOulms4bTnDjDADk0rFNFg57mqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOYjiP0y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOYjiP0y"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4750ca77d47so1832351cf.0;
        Wed, 05 Mar 2025 20:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741235531; x=1741840331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo9vMnshP+gQzXIBd9hFsb1B6YkjwP/ySXah+gVflkw=;
        b=YOYjiP0yIBJNSfGITnEa5IJ0inm1ZYkiHPfM+wb4AWZpxV96l1hJJP3X2YEBiX1TJ9
         VCVN3EEXpYwJyR/dCN6AFnWGC8xgBpCYt7WcGJQdZJuSA8Moo5BPdw5YW/Wx/pt3vPeJ
         G8zUz3ApEqb5MW6wiKUAGBe+kqamF8NKqZU04ZGw/7yNiO8V6bzkjQVR2RmNhS/K1s7p
         HDmLqqhsR0W62gdghZo7S9223dS1+wuwTduDyZ+fxaVuIgTep7vdasridw0bTQaY7DnK
         Qu18eaAZH4YJizgBrm1ZVCqIb5KAJTs+eXpFcWuqkL30bspOWE28F139SQExcS1PlKxs
         9spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741235531; x=1741840331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo9vMnshP+gQzXIBd9hFsb1B6YkjwP/ySXah+gVflkw=;
        b=lGRvJY7SzFsyKpiAoUUFbHo4aIRFp5Sm9Gonk3i0bo3Bk7gxlR6BP5WitmILfqNyZ2
         H1SugAnCrksc3uhpYbIVm9EEdcgyetvGfTVbQl3kPgz00KlBcufecr4wI/NwpxbAJfd9
         vSv4kV9vouo8/6PAXM8HGGFkRDgel8424vBnkB1xQBR/UEQtAN0DDYqmUyCIKSegjZsI
         xcwEgRso6JlyHDcQT9gkXSjH6lGf06foWS/o6pzdU4NTFWT106Bm0Y42Hc8sIxQYxvGf
         VfdHXDPKo0tmaDQsithQIpXG/tZRm+XxUI9atBPpNeQW6/KzLaxruoOTzTNNzLuSotl0
         tHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLQJm3GnvA1isqRrL6xutb3r1c58t1aa3DqAj4awbLt46RudOI03q+EZY0P+307nHyx287bYfPaJ9QH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlh4pe9r4Yo4+mSgkx6B5pSF2u53iga4wP2CU0GILyZaqS5v47
	c2yyfNQ9uVBtbXMC7bNw5PRHLifto1p0K2mjEi10XoX2Ph4h25qI
X-Gm-Gg: ASbGncubXf1SHOLOKlLOxe9vlBcmMDmMuWti5rFLkMUlReh6XmfCeEV5DDI/LO29Dpd
	+/IECdJKzch2i0XCmHkNjo6jl/GsYL+oiU2Wyq9XpSrbYqJ78ezAojMiqm9LyPYyG0olto50RNX
	FLqABek9nOW4kXDdtNUR9YnK6cWlfhDZ27Lu241IDYZEq9PNOl/lHlfH8JNZmIDaCA7MolOBZgf
	zDAH9dGR3uQVA8guNzWsSuU0f29p1mpfzCKNfZDP23G+74dQXOKN2ElFDHNd4w+Sc+r5ATGHLa8
	ntx8QFV0BSQj5rqS+EDkMswTQkvKM2eAV4LxIqgG2k+5z6mMUWBNIwjKmftdaY0U8w==
X-Google-Smtp-Source: AGHT+IH3w3iQKgLlDu7tnyyWZ+7J7XmX1B0tq1Sdtd/dwUm1EtMnrv/MzSUvz02yVOWFeWNWq5JriQ==
X-Received: by 2002:a05:622a:386:b0:472:636:f60e with SMTP id d75a77b69052e-4750b4bf362mr68420651cf.34.1741235531475;
        Wed, 05 Mar 2025 20:32:11 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:2726:6286:a126:9027])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96b568sm3123801cf.25.2025.03.05.20.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 20:32:11 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject:
 Re: [PATCH v7 3/3] tty: Change order of ttynull to be linked sooner if
 enabled as a console.
Date: Wed, 05 Mar 2025 23:32:09 -0500
Message-ID: <8533590.alqRGMn8q6@nerdopolis2>
In-Reply-To:
 <CAHp75Ve02Ma1EswjnsxiV5uyh3A9NU0B90QLFGS13ifr594QFw@mail.gmail.com>
References:
 <20250305042930.3453265-1-adamsimonelli@gmail.com>
 <20250305042930.3453265-4-adamsimonelli@gmail.com>
 <CAHp75Ve02Ma1EswjnsxiV5uyh3A9NU0B90QLFGS13ifr594QFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, March 5, 2025 2:22:06 PM EST Andy Shevchenko wrote:
> On Wed, Mar 5, 2025 at 6:30=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
> >
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> >
> > If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disable=
d,
> > ttynull will become the default primary console device, based on the li=
nk
> > order.
> >
> > Many distributions ship with CONFIG_VT enabled. On tested desktop hardw=
are
> > if CONFIG_VT is disabled, the default console device falls back to
> > /dev/ttyS0 instead of /dev/tty.
> >
> > This could cause issues in user space, and hardware problems:
> >
> > 1. The user space issues include the case where  /dev/ttyS0 is
> > disconnected, and the TCGETS ioctl, which some user space libraries use
> > as a probe to determine if a file is a tty, is called on /dev/console a=
nd
> > fails. Programs that call isatty() on /dev/console and get an incorrect
> > false value may skip expected logging to /dev/console.
> >
> > 2. The hardware issues include the case if a user has a science instrum=
ent
> > or other device connected to the /dev/ttyS0 port, and they were to upgr=
ade
> > to a kernel that is disabling the CONFIG_VT option, kernel logs will th=
en be
> > sent to the device connected to /dev/ttyS0 unless they edit their kernel
> > command line manually.
> >
> > The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
> > maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> > CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
> > is not dependant on hardware configuration by default, and avoid
> > unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > port.
>=20
> ...
>=20
> Since it touches the link order only under drivers/tty the commit
> message should mention what the effect will be on the consoles drivers
> for which are located elsewhere.
>=20
>=20

OK, I will think of what to say. Based on what I tested in throwing a prefe=
rred
console in x86 though, it seems like ttynull was still at the top of the li=
st
of /proc/consoles still, I just have to come up with a good way to mention =
that
in the commit message.


