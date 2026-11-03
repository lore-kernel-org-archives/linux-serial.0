Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737535;
	b=ufeNpVGFJHDxfCXlWiTyP41IINAGKdMkfiDuPc89Ddim/EDs4+fjlEeIZqwej9lFYbMo
	 wmbrslVJyhO/PtUlfeRbNvckAkmHBR19gamje5E0CGtRBgSYDK5IF1YS+De6KnO3DSgES
	 r19bBrc62C3LvFjSstgBjSPb/3TRQqD3kgbg+LtzhvfqOBqUTYbbWJqK2b4Ri7hkDIkNs
	 dD9PwgG6YweUYALZTULPvvlkqHHsGbp9Sb7oApHCs8tVUx4m1rrbhbDsQi6BOZWAl7cu3
	 lJeLFLeuwgErPbkNrFPPgTW2xm5IeGzG63QmDvk2mR5cpXfJxLZenIP8/x8VrpAlEHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737535;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=hywMFMGWC22FCsnfeYWHg5SybWSfpDHUd/LvoxS7oLY=;
	b=X5/DT2uRSm6xzSqs/4gyc9h2+xBqY05qgohiLm16lhpBeMv3AcT0MZpl/MyK3/GP+y23
	 tWm1qY8UJ6UVpudhpRtibSQUylWMqDdhbmHVMwL9Dy8OGm2/VSWcq35VzXo4P7IFhcO0P
	 eoVqLkWILy8LpkJYAeXh2FWdJZqaBa7FzpKk7q5zIr4WqKF0Hx75DhDUP/+E8MQaQAfwj
	 uShoECPO88q+Mdg+J3y5JX9fr1N0+9lLGlnmraSeta3WPxGT79usjVyrglIBri6pBSO3z
	 wE4J2m4w2Z27slDo7tDBwc5YiHlGuTUBXrHfl2Q4ZGEdPiLpOdu4Tf8Xai/zgiP+14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756CD606A326;
	Tue,  3 Nov 2026 20:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 756CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 38B0092009E; Tue,  3 Nov 2026 21:25:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 321B692009B;
	Tue,  3 Nov 2026 20:25:31 +0000 (GMT)
Date: Tue, 3 Nov 2026 20:25:31 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, 
    Peter Ujfalusi <peter.ujfalusi@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups with
 the port lock
In-Reply-To: <auoUlkzXsl9WJG8B@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2611031947260.15685@angie.orcam.me.uk>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com> <auoUlkzXsl9WJG8B@ashevche-desk.local>
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

On Tue, 3 Nov 2026, Andy Shevchenko wrote:

> > +static unsigned long sccnxp_handle_events(struct sccnxp_port *s)
> >  {
> 
> > -	int i;
> > +	unsigned int i;
> 
> This change seems unrelated to the patch. Again, slow down and READ what AI
> produces before sending, please!

 Indeed.  FWIW I've thrown v8 at hardware I look after, that is:

 drivers/tty/serial/dz.c            |  9 ++--
 drivers/tty/serial/sb1250-duart.c  | 25 ++++++----
 drivers/tty/serial/zs.c            | 94 ++++++++++++++++++++++++++++----------
 drivers/tty/serial/zs.h            |  3 ++

and that has caused no observable regressions in my simple verification as 
direct terminal lines, both in the line mode and with ncurses.

 I have no leased-line modem hardware to put this under stress with all 
the signalling; I could see, and probably should, whether I can set up a 
SLIP connection with a direct serial link and see how it performs, but 
it'd take me more time than I can afford right now, especially as I'm 
locally short of one PSU for the systems in question that is waiting for 
parts to arrive for repair, and swapping the one working unit between 
systems is quite involving (ones in the lab won't run SLIP owing to the 
firmware limitation of the console servers they're wired to).

 But I didn't have a chance to reply before v9 has been posted with more 
updates, so I'll wait for things to settle before reviewing the changes in 
detail.

 Please consider this a NAK for the drivers listed above until the final 
version of the patch has been posted and I've had a chance to verify it.

  Maciej
