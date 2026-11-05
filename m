Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839443;
	b=C0T24crZktaf26dTdNfFBYbimP0UqSL9GLViMs1rdm83t3eefzjX1wmNju3cIf/w+LEv
	 bGBELpR/nwNboIeiBanmeaE/rVuXlzTUoaDkWM4KuMEqdWDGk4pUsF/vbrnoHxZRPhLob
	 HCfzloj4C39uoIKUSMVcbQknpYjX6YLitJZIURkREqF9EE6WlO59RmBBBFBWoPX/Ds09J
	 6csRokCpQgHi16MjI70YXDegHPej+fH8BfnutQTAaAg6zKkVAwbicqMwNFTs0kmgU0Ybq
	 W16j8rg9MYuf4Zpo9qCnSERh9QCF914Sg6m/cQ3anGKFCWBp8kEYi6vv9stH0jE9BJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839443;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=3DdLetrTV4u5cttIyzMBSRRtMnG/YzDqmUfbr2V0daU=;
	b=sfcbiUwUD6hEEWAJDvRMIXdcWo3DuzTni3hei9SxM8Hq3epMweXxeHEiUbqWOxQObsyd
	 6RA7eVDb7gDC8ZSW+c4IraDNmTZgX7b16GAgfq61qMWRUyiuOBGpW4CC4rOUQSF54BL6A
	 rcpeXXNVKPeMZ8xRYpNYQLO9dJwTx/kIdDH8yFX9ILMe3YMwRlPi8nEQSvWmGRsUOE28S
	 akAaDpmMXRPJlPzl8zIYUcpJil9cKJ7qosQ+ZG9ygKbOYC3zog0Apj0JbRXNd4rGPdYp2
	 Ejbj84z8+Kar2+ZGzTJP00ChMFUhhDPKldHJodcGFY2i8qYgdaGPVwCLquPVf9FoLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51A606A33F;
	Thu,  5 Nov 2026 00:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E51A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2576992009E; Thu,  5 Nov 2026 01:43:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1E3C692009C;
	Thu,  5 Nov 2026 00:43:54 +0000 (GMT)
Date: Thu, 5 Nov 2026 00:43:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hugo@hugovil.com>, 
    sashiko-reviews@lists.linux.dev
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    Johan Hovold <johan@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: Unify uart_get_baud_rate() success
 return paths
In-Reply-To: <sashiko-outbox-196103@kernel.org>
Message-ID: <alpine.DEB.2.21.2611050021560.6502@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk> <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk> <sashiko-outbox-196103@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Nov 2026, sashiko-bot@kernel.org wrote:

> [Severity: High]
> Can this break B0 hangup and trigger a division by zero when max is less
> than max(min, 9600)?
> 
> Commit 091ea8e5d34e ("serial: core: prevent division by zero by always
> returning non-zero baud rate") removed the hung_up guard from the
> out-of-range fallback path in uart_get_baud_rate() because baud == 0
> returned max(min, 9600) immediately before reaching the range check. With
> this change, B0 is subject to the baud <= max check, and if that fails it
> falls through into the termios-mutating fallback path:

 I maintain that unifying the success return paths does have a value and 
instead the failure path needs to be corrected as per 
<https://lore.kernel.org/r/20261020184131.2893575-4-hugo@hugovil.com/> 
outstanding (thanks, Hugo, for sending the ping for the series I've meant 
to refer anyway, it made it easier for me to find it).

> Several in-tree callers can pass max < max(min, 9600) to
> uart_get_baud_rate():

 Well, if that is indeed the case (I thought 134.5bps times are long gone 
and everyone does at least 9600bps nowadays), then shouldn't the (fallback 
as from 2/2 in this series) B0 rate be min(max(min, 9600), max) instead?

 It's not in the hot path, so I think we ought to do this clipping anyway, 
for safety.

> Note that the follow-up commit "serial: core: Don't clobber the baud rate
> on hangup via B0" changes the B0 assignment to:
> 
> 	baud = port->hup_speed ? port->hup_speed : max(min, 9600);
> 
> which still fails the baud <= max check whenever port->hup_speed is 0

 Well, this is obviously rubbish.

> (such as before any valid speed has been saved, or when max == 0) or when
> port->hup_speed exceeds a reduced max.

 See the discussion above.

  Maciej
