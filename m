Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851055;
	b=V/rHEKSk+IMZGXTNagK45A4cGKPQ3GdLJAnN5Ue9MRz25mCtsOgnwOqPkubd9RIad9hp
	 tYnljNXsud82KQbUbtAVdm2xtHxHpLPWIERnq/jPWoW8Rctp7HiiRWP64ldZN4r4YNTXN
	 phV+iHLp4z0oRmhQQUCfmvhAf8BabNMF3QniDFtkWqnsbh7T0DHroQtR+xaNSKney/mHj
	 Cp5iRp7NHJtWOozHUWNR8GeWzvpGnbWZOmpzv2wV5Hk7PRaYg3c89R5alSIhJ4FCZ0Xzn
	 oBTtZBUGM79WdAmXXBmPmjJTA4lu3uCAB1po3W1TqAr+Zl5Mek23kIcfcEGqy1oC/wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851055;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=77L0zCZoOr1z13ZaKANU7WNCtV3LEiZYs/dClJg+u74=;
	b=bRbgcu7QFh/hxP9PLBpGrw9na81xAXVhaLeJ5ljiIRtpKUiK+tqL+xdnBYOipEXSeTjR
	 FKL6yWIhWdo/1Cjbv3L0RSacG7HqWlOouDPDWlKHGFUe3f7JmsuBkLvP3Ay9XoI+AdVKn
	 lj91cBKrGIE479InHk7A+qyHAp3g1CMLM7WK8i4K2KVcQYCrC7CGPeAVceAtuC1+4rdMg
	 lRx6odzTuQHeuaci/U3iq+tNz7RVgbWGVcIbyv5wWJN5JQLhTvh2PgBQIAmBhOD054N2e
	 AUeoS3pH8YtPJyDhsFlxXXqsqI24fTvr2q9kZyBT3FC7cMZFZTsT4e4Qm1Gd9IVLdzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIaRE0t0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235E606A323
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIaRE0t0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B91F031E6
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792851054;
	bh=77L0zCZoOr1z13ZaKANU7WNCtV3LEiZYs/dClJg+u74=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=DIaRE0t0eLJ9ts/KqrWBjMZ1wNMZ9fLyQsiIWTchL+W20YM+JKio8qPKaHTCEpqMX
	 O0gq2uu+G2hu6q3F3RGhtbcvimgiG0kaPv8lh+QGNoev8VRS7RWoEHOrraL9F3tZ2V
	 oqMkAnDSU4aZ7RHk+8Yl8Y5nGBDK9DGO+PkY2j+roB+cF0PBOppVgt+NEoqgmzSwU+
	 d0UnAXejbYGWn08Cui262kFQZh45e/3LbZ7b0TSYOa5LZP3W/gALk6Io8IaIe+xDOR
	 kPBN0dZmK7k5r3jvaVFFXOma8qDx6QcsaSd1lYqrW3p1wtXtZLfF9rJqV2IGa6jtPK
	 KrXI9RqzvR55w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so10523941fa.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 07:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzk133MFcVkpsC2qF0f9/Sg1in68DjARGv7EBINjz0k0LsHRiEEdhDwrev2hj3lbmCRN7gr+Id7gv981dg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPEMHF3eyXyZiB5wLm3vlvwUmvR4aWae62RCqY1TAANozt0/EB
	3B/aNrA9ZLGTwUX110fZNrapc/xlfUM8vN8nuGbD55qdV6GoFSDmK5NBZzygZXo0V1YwD9OQfeK
	I7g0gR6TqXYn2JXZQ0CzLCF9TSlBxM1M=
X-Received: by 2002:a05:651c:b1f:b0:3a5:e792:2dc8 with SMTP id
 38308e7fff4ca-3ac6fd2b91fmr5065141fa.16.1792851053288; Sat, 24 Oct 2026
 07:10:53 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
 <atseYvQUYvpMFEIM@ashevche-desk.local> <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
 <atywVnHU5NsP_gOP@ashevche-desk.local> <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
 <aty37_xHO-QRa7hQ@ashevche-desk.local>
In-Reply-To: <aty37_xHO-QRa7hQ@ashevche-desk.local>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 24 Oct 2026 23:10:40 +0900
X-Gmail-Original-Message-ID: <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
X-Gm-Features: AclHuK8in-RebYr4WdGY52-xcg2ve7F2PHG1dtE5MpFbEAzuaEhl8yb8pdBRewE
Message-ID: <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:41:55PM +0900, Chen-Yu Tsai wrote:
> > On Sat, Oct 24, 2026 at 10:19=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:
> > > > On Sat, Oct 24, 2026 at 12:12=E2=80=AFAM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > > On Fri, Oct 23, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrote:
>
> ...
>
> > > > > > >       /* Internal 8250 only */
> > > > > > >       UART_PORT_AIROHA                =3D 124,
> > > > > > >       UART_PORT_AIROHA_HS             =3D 125,
> > > > > > > +     UART_PORT_DW_APB_256    =3D 126,
> > > > > >
> > > > > > Why? Besides the poorly chosen name, what prevents us from modi=
fying the
> > > > > > corresponding parameters at probe time by leaving the one of th=
e existing
> > > > > > types?
> > > > >
> > > > > The new type was primarily a way to reuse the core's FIFO configu=
ration
> > > > > table, including the RX trigger mapping. H616 uses thresholds of =
1, 64,
> > > > > 128 and 254 bytes, whereas PORT_16550A maps the same FCR bits to =
1, 4, 8
> > > > > and 14 bytes. Overriding only fifosize and tx_loadsz would leave
> > > > > rx_trig_bytes reporting and selecting the wrong thresholds.
> > > > >
> > > > > The core already has get_rxtrig/set_rxtrig callbacks, though. I'l=
l rework
> > > > > this to retain PORT_16550A, supply the H616 FIFO parameters durin=
g setup,
> > > > > and use those callbacks for the correct trigger mapping.
> > > >
> > > > Please consider just taking the FIFO size from the DT. On some chip=
s
> > > > not every UART has the same size FIFO, so we already need to deal w=
ith
> > > > it.
> > > >
> > > > Also, FIFO size is a standard UART DT property, though somehow not =
included
> > > > for dw-uart.
> > >
> > > FWIW, it supports all standard properties for UART.
> > > Check what uart_read_port_properties() does.
> >
> > Ah, that's nice. I hacked up something [1] in the past to get it to
> > work, but that was probably before you added the helper. I never got
> > around to splitting up the commits and sending it out.
>
> Hmm... The helper is in the kernel for the past 2.5 years.
> Maybe you rebased it and it lost original dates?

I had been carrying the changes locally without committing them. I only
committed them recently to back them up remotely. So yeah, the dates are
not accurate.

> But if it's not working, we need to address that, I believe it should wor=
k out
> of the box, because the same function is used across dozen of serial driv=
ers.

The new helper probably works fine. I can rework my code to use the values
given by the helpers and give it a try sometime next week.

> It might be an issue in 8250_dw.c, but I can't tell for sure.
>
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/comm=
it/?id=3De7e0741fa04f349ad9f94a4059e32467a30ef5d9
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
