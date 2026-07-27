Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1130EF91;
	Mon, 27 Jul 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165742; cv=none; b=S9os2ri3PswsOpCe32q3780XckuFl7W/5Ry6X6x8RQsj6J0Gyau/S+/amAjDoY7JEao0dQ/lq0XUvuJEH3uzh3Wn64ryTZZJsD1C0kFF4Etl0cElg9yIL6ziWzAJYehVems8RE3ynkeZWUJWPU/anT25q+BkpeThFfCaDiToQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165742; c=relaxed/simple;
	bh=+bCeGwQ2aKt6ib1irdumdjPAY0Z2wer7W0ACr9BBbRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z0XHiUd5kTOg4IsoBQ0R4bfJeYceIFtJmAQydzuJg0nGHABbNEuJsA3HOvCDkgNJmRVaa/8gI4ZrFJxQRLBpcJrSX8sPGTzM3c+myFTAy5Hn66XM8+ksm1PE0962RD+opWfS0kHQXBQV53LAuhakCgH6jhDoueTpJggq7HdKe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=dReuZK1X; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="dReuZK1X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=fUEeocKVFKbZfl9xNdCuwkJjnUL9YzO1R+TyoyssiRc=; b=dReuZK1XE8BR7/b1buxYbu/i1G
	kQAI1sCBEUr+Bm6gmxFWo/hSvpShEHAfomAKM2fNvt40ktM4G0w1OvtBRp7hpymZ+F3tl9W3Dlemo
	D4S+HsympKEvNhWX25I/kFP05hvTkrCp1HG0gDg/cJF1HwwrqlvPmko1/4J4kW9Kuy9c=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1woN9f-000000007lQ-0te7;
	Mon, 27 Jul 2026 11:22:11 -0400
Date: Mon, 27 Jul 2026 11:22:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-Id: <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
In-Reply-To: <amMZoJ41FKcd2ddG@monoceros>
References: <20260720080812.1223096-2-u.kleine-koenig@baylibre.com>
	<al34uIyOue73MMN0@monoceros>
	<20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
	<al6PfMCuRiYcOBQV@monoceros>
	<20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
	<amGYgUhPrSdR5srV@monoceros>
	<20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
	<amMZoJ41FKcd2ddG@monoceros>
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

On Fri, 24 Jul 2026 09:58:13 +0200
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> On Thu, Jul 23, 2026 at 11:13:59PM -0400, Hugo Villeneuve wrote:
> > > For me the open question remains if the driver works in the
> > > configuration CONFIG_SERIAL_8250=3Dy (and thus CONFIG_SERIAL_CORE=3Dy=
) +
> > > CONFIG_SERIAL_8250_HUB6=3Dm. In this case at least commit
> > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hu=
govil.com/
> > > introduces a logical change in uart_match_port() that isn't explained=
 in
> > > the commit log.
> >=20
> > Not sure what you mean by that logical change?
>=20
> With said configuration and before
> 3d406299d8829747fe2e8692f4c29fe3dc1d101f uart_match_port() returned
>=20
> 	port1->iobase =3D=3D port2->iobase && port1->hub6 =3D=3D port2->hub6
>=20
> and with 3d406299d8829747fe2e8692f4c29fe3dc1d101f (and your fix on top)
> it returns false (because when drivers/tty/serial/serial_core.c is
> compiled IS_REACHABLE(CONFIG_SERIAL_8250_HUB6) evaluates to false).

this change was certainly not intended, sorry about that. Looks like
there are still subtle Kconfig-isms (and 8250-isms) that I still need to
master...

So to be sure i understand this correctly:
I will submit a patch to replace IS_REACHABLE with IS_ENABLED, which
means that the configuration CONFIG_SERIAL_8250=3Dy and
CONFIG_SERIAL_8250_HUB6=3Dm is not supported, as you stated that
it currently cannot happen?

--=20
Hugo Villeneuve
