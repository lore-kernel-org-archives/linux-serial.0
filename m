Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20F437130;
	Thu, 27 Aug 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823937; cv=none; b=aF21flWZoLzzH0tlb1zaqWUQcrspkdIJPKrOCyff908lcYEiUMBCjji0AoE7yWhZx4zGTlux5mim8mdRUzGU6jxJhC8exzbDUVyZ4kSIzl+FTiWlbO8PdadkCfIs8Y4dwyRT0vRX8+i3vVNE9z8Idj7GzuZq3LGM0vetKd10etw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823937; c=relaxed/simple;
	bh=G2Vqu+n6CHDCYlAOih5PbTcU8zIr26Lqkc0o8vZwTXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ/tIZgNXs/sK427yMNyxCoMmkaTtekNqsphIBVhBRxUT2SMAVZRRXexXyUaLdzbQ2cxV5iL9PR6b4lzMKXcz3kzA+wl93u45OT5RuOV3eCwlV4UQ1v8Q3Afk+osQYpTNjC3ko2SrMpVBwbRPD32GO11W/SQ6wHVovCJY2DT8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXSqcdKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXSqcdKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0A91F000E9;
	Thu, 27 Aug 2026 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823930;
	bh=SHBWRs4Qno6qVtIJprw+hywFhvx/zVhgMmQwZ2yFLO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXSqcdKmDOk8/JzfxOrlJ1CDybFToyuk35KlP+L42iugZj+fzIZl4F5yD4OoyXJp1
	 wk3Iw/YRQI3a4RGW0af+J9uYIGWKD4j083A/Y2D2x04e0wO9QFabNsjmXu3fJA1qeF
	 pckF/5aOeb7kMZeGidA8yzPm9Q9sZFHl1CTiUiB94ea+pWUeph6syth3I1suLso5EQ
	 M7SDQvF8yVOkMxnhEqOeAS+MsVq4QPZbiiRBtXZnlhYrHtq6yWb0GAyHsVTEC5aP6R
	 5EBsE2qPKzmN64eCUEYGGjVLOgEumwlD5uNxeDgtMdWuxDOJeJC0gKIGToO3v2ZmUB
	 jqffGBbi3nNwA==
Date: Thu, 27 Aug 2026 11:45:27 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>, 
	Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader <osama.abdelkader@gmail.com>, 
	Fushuai Wang <wangfushuai@baidu.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	linux-serial@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <apAEsebh17YagOsa@orome>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <87a4qh9gyk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6l4652caujow2si"
Content-Disposition: inline
In-Reply-To: <87a4qh9gyk.fsf@jogness.linutronix.de>


--d6l4652caujow2si
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
MIME-Version: 1.0

On Thu, Aug 20, 2026 at 01:26:03PM +0206, John Ogness wrote:
> On 2026-08-18, Petr Mladek <pmladek@suse.com> wrote:
> >> [0] https://pastebin.com/FhQVSqfy
>=20
> ...
>=20
> > Almost everything works as expected except for:
> >
> >   1. I am not sure why "printk: console [ttyS0] disabled" is printed.
> >      It does not make any sense to me.
>=20
> I have seen this in the past. It can happens unregister_console_locked()
> has always printed the disabled message before actually checking if the
> console is registered.
>=20
> IIRC it has something to do with serial8250_register_8250_port() calling
> uart_remove_one_port(). I remember starting to look into how to fix it
> but then was going down a rabbit hole that exceeded my scope at the
> time.
>=20
> >   2. The WARNING would be handled with NBCON_PRIO_EMERGENCY.
> >      I wonder if this warning happened also with "v5" of this
> >      patchset.
>=20
> The tegra issue we had with v5 was related to irqwork being scheduled
> when suspending. When keep_bootcon is specified, there will be no
> irqwork scheduled during boot because legacy_direct=3Dtrue.
>=20
> From the backtrace in the posted boot log we see that the warning is
> within tegra_pmc_enter_suspend_mode(). I am wondering if this is the
> same issue we saw with v5... an irqwork getting scheduled when the tegra
> is entering some suspend state.

You mentioning tegra_pmc_enter_suspend_mode() jogged a memory. We have
to play some weird cpuidle tricks when PCI interrupts are anebled
because of a hardware bug. That bug, as far as I know, is only Tegra20
specific, so it doesn't explain this. In this particular case we're also
not talking about PCI in this case, *but* I wonder if there's maybe
other IRQ issues related to cpuidle.

It's a bit of a shot in the dark, but we could try disabling the various
suspend modes via the PMC DT node. Notably LP2 seems to be the one
that's causing issues on Tegra20 with PCI, so maybe changing
nvidia,suspend-mode to something like 0 or 1 would help narrow things
down?

Thierry

--d6l4652caujow2si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqQBysACgkQ3SOs138+
s6FkyA/9EzajeGAeGYsjltP4Hari7Vi/6saWUV+qJcf0iX4pM6l9mwUZ/O+s2HX0
iqXe/ctdeUchq5Sk2mlVlaqc7rqDRLR4krIp6pjj5dWcmchCySmjfDG7FSU4bRLn
DH559HYLAArep1KbUGrxkN/SzzyfGeHEskkU5d6nr2EXRz7Nlb4j1/nyr3orYM7V
BG891/OroE7UnhyJWyqpeJJ/kHoNg2XJmEI1IyD1tLQM5XxXyMcc4/FSAhRmQNhz
9uiwZHuz/n26tsrDkUhMwv2SUAc3ja+iqPPijuMsiqtlNqLIq5VQqPf7IAoI4UHt
5cscLdP41JybtZNvDEjiETx2i7TjAk+ZMYnSoyiZq2tMYRoO2f5UjoHPPVa6SuSP
EkgJIXHM4Iu4wWXHOYuB7pk7vAP4nT3Rv8BOmDKH7ScHMH29U4CFfm5b9BpPL+8D
wt5KPMmTy2Ve7SSASLDTrm2L0ZwaW6YnsA3pCmIc0yMwKFx+nhq9G9X38q8+guP7
15IoGA7UdYgfdYHXroW2Jyyt1GZbvy9JA9MI2mYn/DTG12YmCTK0oRvw8ojkfCuk
PjcnTbJgmRA+mAHdObQ6QE9BrBQcuFpPWnJQSJmCTB2mN3+AkZpYEDA4sU0Yl0e0
nrLrwFf6kICwOHxc9KnDcK0pTuz5b8pe0cgB872aZHWCKh8Spcg=
=asUN
-----END PGP SIGNATURE-----

--d6l4652caujow2si--
