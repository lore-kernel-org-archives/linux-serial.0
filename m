Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792849331;
	b=DeVRVIj7HIvPdZvqHJv6Qt4ZTiZRDP9/ohIPFIUxA8L5RzUO00yxRcd0JWSNhV3V8MCR
	 PhiaQ88Kfl0LzhanodZrmnJv/D4xbKSrYpHLX3seRxWs5Zv2OaQSUzrLpPoDtlbrLBg5z
	 29wWpRYTD7LzyNFC20T3gKFEXILZ9hul3GIfi5N3ksqPeEtz4t+aAglcMOOF0EW25SeYM
	 +IEMqssThWkEqpnaE1VD+8Z6MZMoTXR1xKE870MAe8C2ktXyzmcLhngo1Y6q6Ds75LdCM
	 DbSOeSu8mvZDl0EtDgFSFGFDzTVpP3y17cEvRCdGNIJAAroZxhVWQJvJtOmpe9GC+gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792849331;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VR4wE0obqEETTnkvc1cZD7oRkkv5XdPKp0vhsRHmEPU=;
	b=GkcTJVS0+yZDYky7iz0FcJaAo/jddolVei6ztnetpB7nF4Hz5Ix5wUziAgbEV9WFOHF+
	 QKcUuU5P7qTNPjs/DI/UUuBJV+BpD2NYEgEDExsda3Y6VN/0pmL8429QNrXX0YoYgkWl8
	 p6nUfpsv4cWCqfmrymVq8gI7xkeSVhpmT9oXSBo/sqEZB2lagaRs5f7IvufktfMoIIcW9
	 YDVhvWZCdIB/1zuanrrmx/58ttspS2wOC46AFz0ws7zUfdKyk4GX28jr8JSI+kTycNcpp
	 hSKLtZf2L1hAfRkpATzsBfs2cEJuwb8sbVXlz9UEs0FWemG8BJvycNV30nNgX6LX2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbwoWAdP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A3606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbwoWAdP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DD81F031E6
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792849330;
	bh=VR4wE0obqEETTnkvc1cZD7oRkkv5XdPKp0vhsRHmEPU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=VbwoWAdP1jav4AQginmjgRlN4qTSlFXGRM6SdLPbsAU1bILpiEGmgDAA9EGFrwGnL
	 TPXJUwpgI0xCf+xr7Qp7+F+xNrj5UyUDYwwSAbBvEoAHVpMbIYqZUGFz+W2ODLq4+Y
	 ocwGO0vgNkShOXPj/9k1UXzs/3GiW0zfZ2YqCZh1Iip2tbSiUfM1JzQu+Dl0jQllhs
	 ZufPdxQ9bFabAx9x7kOmGrCNcEE5X0F1DnBUR7Lhoq85/KhJ4rW0yvQXpuAbIOiKd4
	 g/lbt8NGys8TUM5zh3e1Dy6ChPxghStytGUPhrvoJIr0HpeHm7nRvf1QhvDICvH5WC
	 orDsUHTArXnsw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a772ec8389so11710111fa.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:42:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxaFPP3ZVcD0GUFpb+gqCT3l5Uos1k2KW0LAfHGpXoGL3dPWS9ZGGMZCpWRNth25RYELj+f476vYnAzBc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvIJdgEj172eGbD8ckX860df+zDwbJY3OmrUSu671qlkGkxDON
	e0euM+/KT5xZuYwiKKcDj/Z9ESaG85UGeN6+gRWxe+VLNeItfWXsf8DxzjyOydaVslhMpAnHP9B
	uWdyrBieU7rbAmwPtB+FSIv/uE+A0rC8=
X-Received: by 2002:a05:651c:a11c:10b0:3aa:f94b:842e with SMTP id
 38308e7fff4ca-3ac758f2ab8mr1313291fa.23.1792849329124; Sat, 24 Oct 2026
 06:42:09 -0700 (PDT)
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
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com> <atywVnHU5NsP_gOP@ashevche-desk.local>
In-Reply-To: <atywVnHU5NsP_gOP@ashevche-desk.local>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 24 Oct 2026 22:41:55 +0900
X-Gmail-Original-Message-ID: <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
X-Gm-Features: AclHuK9FDF2lgZeM1hRUmkk4PVa4hWifzNBxVn4_Mwsx2Yyiyx2HnawGxsTc9R8
Message-ID: <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:
> > On Sat, Oct 24, 2026 at 12:12=E2=80=AFAM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > > On Fri, Oct 23, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrote:
>
> ...
>
> > > > >       /* Internal 8250 only */
> > > > >       UART_PORT_AIROHA                =3D 124,
> > > > >       UART_PORT_AIROHA_HS             =3D 125,
> > > > > +     UART_PORT_DW_APB_256    =3D 126,
> > > >
> > > > Why? Besides the poorly chosen name, what prevents us from modifyin=
g the
> > > > corresponding parameters at probe time by leaving the one of the ex=
isting
> > > > types?
> > >
> > > The new type was primarily a way to reuse the core's FIFO configurati=
on
> > > table, including the RX trigger mapping. H616 uses thresholds of 1, 6=
4,
> > > 128 and 254 bytes, whereas PORT_16550A maps the same FCR bits to 1, 4=
, 8
> > > and 14 bytes. Overriding only fifosize and tx_loadsz would leave
> > > rx_trig_bytes reporting and selecting the wrong thresholds.
> > >
> > > The core already has get_rxtrig/set_rxtrig callbacks, though. I'll re=
work
> > > this to retain PORT_16550A, supply the H616 FIFO parameters during se=
tup,
> > > and use those callbacks for the correct trigger mapping.
> >
> > Please consider just taking the FIFO size from the DT. On some chips
> > not every UART has the same size FIFO, so we already need to deal with
> > it.
> >
> > Also, FIFO size is a standard UART DT property, though somehow not incl=
uded
> > for dw-uart.
>
> FWIW, it supports all standard properties for UART.
> Check what uart_read_port_properties() does.

Ah, that's nice. I hacked up something [1] in the past to get it to
work, but that was probably before you added the helper. I never got
around to splitting up the commits and sending it out.


ChenYu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/commit/?=
id=3De7e0741fa04f349ad9f94a4059e32467a30ef5d9
