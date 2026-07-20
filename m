Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F91389455;
	Mon, 20 Jul 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556440; cv=none; b=tXHEbbxFMaIwHS9famKWCM6BR7Z1ZAIvf9d8HKf0kYzN9xLls25lsspRaurSaocRdMIJ2T+LqBmFUiV2Fw9QBuMufeNQ9fGTLVw3qnmPRYpS545a6Wb8B+uAf1IM8tDM+wscfsRxi875QnrF5ez/pcVC5eqKKJBrQhdpMSGmykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556440; c=relaxed/simple;
	bh=yYZ70saqUACf/IL1Vo/EY4U1TjOqnb2Vu9Hsm5Mk2EE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WGnz3CCgrB7w4QimembIhCJEBcCX438sxbNlIeIEiA5rNvEco9u3dfIngvYps2mMA/dG+Dm789CIr3VcvhMuJ6ZyW9BioLw2z9SQKm4NRtvAydW3+IJ9pIdBh60rq9+d/PTmiba1gpDzcvJFVJ/1MfWRJ4747hc9vfBTBx61sl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mt7mkFDo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mt7mkFDo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=AY3+WPWTmnzoUbYnXKrbFciUA/tg3zPcppn2BkG2wwg=; b=mt7mkFDor7iAQm+WvImCbJxL66
	yWc7KXWMTAq3/kJgtxq4Kff6Um2gTGnoB40VpN9Layzm6ChZRs4Ng56ekE1kL/Q8Mbc0voblMewva
	YIo4Z0e3Ae6ZnSFMX5v3x+EhT1U/fJLl5c9+yDrJEUkPkfbma6hQeAXastAz2Q0NXHbE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wloeD-000000008Qu-1c1N;
	Mon, 20 Jul 2026 10:07:09 -0400
Date: Mon, 20 Jul 2026 10:07:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= (The Capable Hub)
 <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-Id: <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
In-Reply-To: <al34uIyOue73MMN0@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
	<al34uIyOue73MMN0@monoceros>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

Hi Uwe,

On Mon, 20 Jul 2026 12:31:31 +0200
Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:

> On Mon, Jul 20, 2026 at 10:08:12AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > With CONFIG_SERIAL_8250_HUB6 configured as module
> > (CONFIG_SERIAL_8250_HUB6=3Dm) the cpp symbol CONFIG_SERIAL_8250_HUB6 is=
n't
> > defined (only CONFIG_SERIAL_8250_HUB6_MODULE is). In this case
> > hub6_match_port() is defined in drivers/tty/serial/8250/8250.h as static
> > inline and in drivers/tty/serial/8250/8250_hub6.c as normal function.
> >=20
> > Use IS_ENABLED() to also handle the modular case correctly.
> >=20
> > Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >  drivers/tty/serial/8250/8250.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8=
250.h
> > index 9d1068d0489d..fb9a7117d145 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -334,7 +334,7 @@ int fintek_8250_probe(struct uart_8250_port *uart);
> >  static inline int fintek_8250_probe(struct uart_8250_port *uart) { ret=
urn 0; }
> >  #endif
> > =20
> > -#ifdef CONFIG_SERIAL_8250_HUB6
> > +#if IS_ENABLED(CONFIG_SERIAL_8250_HUB6)
> >  bool hub6_match_port(const struct uart_port *port1, const struct uart_=
port *port2);
> >  #else
> >  static inline bool hub6_match_port(const struct uart_port *port1, cons=
t struct uart_port *port2)
> >=20
> > base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
>=20
> There is an earlier fix already at
> https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugovi=
l.com/
>=20
> It's a bit different, but essentially equivalent. So please stick to
> that older patch.

They are not essentially equivalent. If=20
CONFIG_SERIAL_8250=3Dy and CONFIG_SERIAL_8250_HUB6=3Dm, and using
IS_ENABLED() gives this linker error:

ld: vmlinux.o: in function `uart_match_port':
(.text+0x723aac): undefined reference to `hub6_match_port'

Using IS_REACHABLE() fixes this.

--=20
Hugo Villeneuve
