Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874142236EB;
	Fri, 31 Jul 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506377; cv=none; b=Jjp0CB75BFlgFu4T+kWaHg97B1Sj7PTIu2xgn62XPz4xcrJR7wzJ1VmoJOc+D34/WLx4Pfb4C3hOFW55yL7aHB1Dsz2sOgzli9wnuFJoi/VZV96bWjBbgkdEQimzwjypU6l18oKYkTNKKGY9TxhAEAIkukkC4pgtrkXyFxf73Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506377; c=relaxed/simple;
	bh=pPZ7dgOOfIaJvWKxwd8l0YFYNVrepN+OFadYUtoWQL4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QO+gCRyLC4CCuZua8uXtKdcn5Bggu7qWJXywvdQUGEYLfMjpEAZk2/49+kK9AZRtSVkMOoCT09x/HMnjXHgkgJtbP7L1OMlGMpbxTQvVJvmaKXLLE7idCIwZ4F+lJwpG7YCv14K+aFwkyB5+JdreAoVvHaExHSgEAgNu9vM4qdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OFhf+OmO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OFhf+OmO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=pPZ7dgOOfIaJvWKxwd8l0YFYNVrepN+OFadYUtoWQL4=; b=OFhf+OmOx8YR7yVU5Y8pSuSqFy
	DQMp0rMPDxaCLon050QipWSI/4yrm4hGRDPuUSyyxSyZsxHFGGpXdjN+5r4YcS53oeJwV0qxL0MbT
	7JNbKuVUz/ZMZgJwxDtLu+KYjqA3MA58zXSWz/Sb8n1TfmauICSzViFiGdfDU7x2HgHU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wpnlr-000000004hA-3ksc;
	Fri, 31 Jul 2026 09:59:32 -0400
Date: Fri, 31 Jul 2026 09:59:31 -0400
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
Message-Id: <20260731095931.3d17b9b09248f531ca54b903@hugovil.com>
In-Reply-To: <amyg0sR7SafpFuKR@monoceros>
References: <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
	<amGYgUhPrSdR5srV@monoceros>
	<20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
	<amMZoJ41FKcd2ddG@monoceros>
	<20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
	<20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
	<amn8Hb2dbv_Sah_Y@monoceros>
	<2026073028-anointer-unlinked-c0ea@gregkh>
	<amusQjI0DOPzL4jM@monoceros>
	<20260730161516.3def31f58d3c1d6f8eb3f4a0@hugovil.com>
	<amyg0sR7SafpFuKR@monoceros>
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

On Fri, 31 Jul 2026 15:20:46 +0200
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Heyho,
>=20
> On Thu, Jul 30, 2026 at 04:15:16PM -0400, Hugo Villeneuve wrote:
> > On Thu, 30 Jul 2026 21:57:01 +0200
> > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> >=20
> > > On Thu, Jul 30, 2026 at 04:49:45PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Jul 29, 2026 at 03:30:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > I think the real fix would be to just copy uart_match_port() into=
 the
> > > > > two drivers that actually use it (and remove the then dead code p=
aths).
> > > > > Then it would be drivers/tty/serial/8250/8250_core.c using
> > > > > hub6_match_port() only and that can be handled by a proper depend=
ency.
> > > >=20
> > > > I'm totally confused, so I'll drop this patch from my review queue =
and
> > > > wait for you all to figure it out :)
> > >=20
> > > Does my suggestion make sense for you? Do you intend to work on this =
to
> > > unconfuse Greg?
> >=20
> > I am not sure to fully understand what you suggest. Copying the same
> > function code to two drivers seems like a waisted opportunity for code
> > reuse?
>=20
> FTR, I prepared a patch for what I had in mind, see
> https://lore.kernel.org/linux-serial/cover.1785489518.git.ukleinek@kernel=
.org/

Thank you, i will look into it.

--=20
Hugo Villeneuve
