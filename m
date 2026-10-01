Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA952189B
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882468; cv=none; b=SHqEBRBRviKLf7s++GpJVZWDVm9p19S581+M/XNelXC8EYsMb5+yUIfFJklqGVE9z3lqr+tVqgkPYm1eJI11MKwa3KNgubLwmLY2BufWmONFCvbTCEBhC8CujUWUr9zy/Q3WPHWgMMSko9KBuRE1gFFmHQCC/z8xxHVUKgQHsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882468; c=relaxed/simple;
	bh=FADf0IKjYIk+d71I+Acg+xKfQUbv7uBkMqU7iZW2Ooc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVnUxkXGNosyIb8aJ1OZtNpBG2DYt/dTsqcohJiP0NmiW/XmC1nidZSWDQ8FehENCOyzYfykMHaqfAh9CtYOSDmGUoRbuBKqoO3SO6Hn3X3I+lLf3V+J2igVJR9ct3iDul+Nz0huUJI/TwAOPg/Yirsq3LA9YueEDky7xH+BkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvm4NUKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvm4NUKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC91F00893
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790882465;
	bh=BxCWISzbU0IXRc12DxDKUphueVrKbysRD9EKFe3TIvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fvm4NUKds+Zu8wrn2D8F5EozOmlUF37voRlk7UMJjayTCs4tOMWvfu2czPLFecz8M
	 Se2Id3O7FlBuTKPDKA8TmURR8yuCTXpt4Hi/xxr51q6GzPGcCyhWIM0L1Gyqfeyqow
	 goPGMwlOgEw0dpAY/s1QtKs0yZika9BvUtr9eAEpz1FcVq9xdv3Sj8gCIIMaRI+1g6
	 vJZu8zUxiyxz5voA5GesRL9ktiv1ePETwCkJrCdpVGjdzph5z1kBtI1MZ/wbJCW1k1
	 5wardAfPmqPO6Pih64+/J+RfWWRf3dEI2rbeUZT32i7Z5cO6L8Hd2rpoQoNCGQZDdh
	 TXHapX7sG4YLQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d84150dso2238651e87.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 12:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFxj0n6Oou1gtSMNmpEpyxoAvWaJI9CvHcXPJF6l0bvlirkydUtI4sjn6DIFkkBHKuBqyl71WSVKh0U+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEt3etP9Lq+sEmSzMPTreYfL8E/tdo5GuyizX6fO8H2+45Ells
	+27e0IwxAyy9XoOTWKL5qev0Sv2Fe4UZUri7opcJmlpGSDd4Z0/WlsZP4e5Vza0eGEMOBr154Qu
	0eZUkKJZjN21+DmHyr1LidMntSXLIJMo=
X-Received: by 2002:a05:6512:6681:10b0:5b8:f4ad:6e4b with SMTP id
 2adb3069b0e04-5bb9bb10485mr52668e87.18.1790882463996; Thu, 01 Oct 2026
 12:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com> <2026100140-overbite-mundane-fc79@gregkh>
In-Reply-To: <2026100140-overbite-mundane-fc79@gregkh>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 21:20:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLnv1Q7ChHuLo=ad9edqhZL8MNaMab8huMAepK_LwqVzGQ@mail.gmail.com>
X-Gm-Features: AclHuK-xwkb5oiKwTZeGukzhni2eOhkFeU3cVe4kmkvR6xpTKv4UHYXaQGsg3Rk
Message-ID: <CAD++jLnv1Q7ChHuLo=ad9edqhZL8MNaMab8huMAepK_LwqVzGQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/15] serial: 8250_dw: add Ambarella CV75 quirks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 01, 2026 at 08:41:02PM +0800, Long Zhao via B4 Relay wrote:

> > From: Long Zhao <longzhao@ambarella.com>
> >
> > The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> > licensed block. At the register level it is close enough to DW APB UART
> > that a full custom UART driver is unnecessary: reuse 8250_dw with a
> > small platform quirk.
> >
> > Quirks:
> > - keep IER ETOI (bit 5) set for RX timeout behaviour
> > - skip set_rate; baud clock is managed outside the UART block
> >
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Long Zhao <longzhao@ambarella.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 32 +++++++++++++++++++++++++++++++=
+
> >  1 file changed, 32 insertions(+)
>
> When you submit lots of different subsystem patches all in one series,
> it's hard, if not impossible, for subsystem maintainers to take them :(

In my experience people do this in cases like this it is because they
essentially dump out their "bring-up" tree, the thing they have
booting on the hardware so they know the pieces work together.

Long: can you split it up in topic branches and work on e.g. the
serial driver on a separate branch?

A better way to test the whole set of patces is to just create a
mixdown branch where you merge all the topic branched into
one "test" branch, then you boot and test this before sending
out each branch separately.

Each topic branch can be versioned separately with b4.

Yours,
Linus Walleij
