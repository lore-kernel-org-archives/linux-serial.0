Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A635E1B1;
	Thu, 30 Jul 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442526; cv=none; b=N1dzs/Xiba0zH5bKpWYaeHRRBtAun5/XplnZ16AwFLzLWlCI4RFMtAaUaUn7zuM3pOo16kWhhM9hKbtvhLyVWom61joQWIyKaGBUDKOPS8IpQ77u7wiHAxWA9AFqVXlgbbcVOkwirfN7r0az4BThLqEPHxZuo9cpo7CK83ixL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442526; c=relaxed/simple;
	bh=YzMmqJVRKJtBPiJ9DqN38ZI5/nL9WVtpTgXETRuSwHU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nqN+mw7Qm6ING4B3wdzv8dAnGxJ2frwAdK2pIX9TDgAOBcbPqR/zTVvaN9kkW6Xd0rxX954ltlVRo6YACjVwQWQZS1jj/dSW5BPBdSu06PEaRUFq2rd4B3pkbu3Sn0Em3aDxJ//d3dcmDEDSLpp1bAuLC9VS/qsQljryxmdssJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=gHw3bMj4; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gHw3bMj4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=YzMmqJVRKJtBPiJ9DqN38ZI5/nL9WVtpTgXETRuSwHU=; b=gHw3bMj4Szp0HgM8bu49f/prKZ
	TQRhdjBOLbo+XHrWRKbv8+7hiWCmJC3T+l9SJnki+y/2vMXqVxScnI71MIoZy/RiMA2jUcQRBxMJ4
	23Hd/mVIG5HJ4pdi/gUyZPNhHNWCQXlZ5lMzODEzIVkCwx/tPJPhvyu9TiKMOy/VI3wY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wpX9w-000000004p3-37h9;
	Thu, 30 Jul 2026 16:15:17 -0400
Date: Thu, 30 Jul 2026 16:15:16 -0400
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
Message-Id: <20260730161516.3def31f58d3c1d6f8eb3f4a0@hugovil.com>
In-Reply-To: <amusQjI0DOPzL4jM@monoceros>
References: <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
	<al6PfMCuRiYcOBQV@monoceros>
	<20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
	<amGYgUhPrSdR5srV@monoceros>
	<20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
	<amMZoJ41FKcd2ddG@monoceros>
	<20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
	<20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
	<amn8Hb2dbv_Sah_Y@monoceros>
	<2026073028-anointer-unlinked-c0ea@gregkh>
	<amusQjI0DOPzL4jM@monoceros>
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

On Thu, 30 Jul 2026 21:57:01 +0200
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Hugo,
>=20
> On Thu, Jul 30, 2026 at 04:49:45PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 29, 2026 at 03:30:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > > I think the real fix would be to just copy uart_match_port() into the
> > > two drivers that actually use it (and remove the then dead code paths=
).
> > > Then it would be drivers/tty/serial/8250/8250_core.c using
> > > hub6_match_port() only and that can be handled by a proper dependency.
> >=20
> > I'm totally confused, so I'll drop this patch from my review queue and
> > wait for you all to figure it out :)
>=20
> Does my suggestion make sense for you? Do you intend to work on this to
> unconfuse Greg?

I am not sure to fully understand what you suggest. Copying the same
function code to two drivers seems like a waisted opportunity for code
reuse?

This hub6_match_port() stub was suggested in [1] by Ilpo, maybe I could sim=
ply
revert to what was done in V1...

[1] https://lore.kernel.org/all/716918cf-b240-43cc-a702-9b3d94dc75d2@linux.=
intel.com/

--=20
Hugo Villeneuve
