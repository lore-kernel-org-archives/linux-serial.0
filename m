Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045871;
	b=ufG0s9Cz+EaRZkg/iuhFa3/vDg9gM713T/lNBFQS/tCHrjbu1cPJXYFdfOL4ZyJBwNny
	 uGNCgyClsIk1YD7jFqFPYsJmkFKzWHoIu+DpR1S5WFdjU/5g0tvE11ffjNBFkPGwTS2dz
	 L8OkwGwXLhj7LrA2hw8NyRpAqCdRS7Dhjueq5O2J3jTLJCnQqVsa6hHQYnz1Tfv3QlyNZ
	 +aEDdJzov/nsse5J+OeC85ITv2+uYplfq3PCm6+bzgZcKyPRUVGfeRbXbdal2jWS3IBp0
	 fFjzOUrzgJ5+Uzp6Id801n3FXA20F0pxfKMdRd3xpdYqA7clP/XaETlqv4DeBawwChw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045871;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=EXPccEg8PSk/FPbldfN5ElUkJbs3+4X/rrbmRLSFjcI=;
	b=uavbvPnX9LTpOUWXiTuXhMTNKWqokZIC4TadXuDIRPbqifySZWWyaOx0yNWQkZzOcvTc
	 foI8oUuUroJGTM3IUy9mWkM9NQ7Ods4UnCtySbLegrQZ4S6WsblV2xv1e6MOXwYvOdYKV
	 bLCLq6cNKtM9qufQU3a9/Q+pYr76W4gZ/N9R8XBnacKVDMRUGg/j4jl0I3zXG9FOc6YnF
	 lJyIKKNGwIUEpEizraWKUzR1AzxR4aa3un0Ssp8t/VzDkO5WJSGi0OdQoBNUl0Un2XqGA
	 IhK2nqiYxvUIrpzdyb6vy+WH1fxgbHCtoYODHA/1/YWxOvcBw628zG9Zt3hksdCe2CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="WQIqj/SU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7C606A31A;
	Mon, 26 Oct 2026 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WQIqj/SU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099921F01825;
	Mon, 26 Oct 2026 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793045870;
	bh=EXPccEg8PSk/FPbldfN5ElUkJbs3+4X/rrbmRLSFjcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQIqj/SUn/Ep8siMYxNqhk65QHI6lcikUCAau4WKhbMqOIl/8zBKdF6cqe1Q/4Yli
	 k2wRhtdJL3Rf9DtT8MMm78k5j/NIi/pvfSUk7R8hMnm0uEVBHZhEuSI+qgfPAY4T/S
	 5xgihK4Ioq2m0TrRcn0CNSyRgre/w+Wfrf+wP7oo=
Date: Mon, 26 Oct 2026 21:17:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <2026102631-stove-preview-b534@gregkh>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local>
 <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local>
 <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local>
 <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>

On Mon, Oct 26, 2026 at 01:59:06PM -0600, James Hilliard wrote:
> On Mon, Oct 26, 2026 at 1:53 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > > On Mon, Oct 26, 2026 at 3:33 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > > > On Sun, Oct 25, 2026 at 2:44 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
> >
> > ...
> >
> > > > > > Some people might want to test the stuff. And sending too often you actually
> > > > > > will get the opposite results, people will be tired to even start reviewing
> > > > > > and/or testing your code as it's changed way too quickly.
> > > > >
> > > > > My thought process was that people wouldn't want to be testing code that
> > > > > had known bugs flagged in Sashiko reviews.
> > > >
> > > > Sashiko reviews are not visible in my or any other mailbox. To see them I have
> > > > to go to some URL and so on, meaning to waste time to see why on the earth the
> > > > new version has been sent.
> > >
> > > Maybe the Sashiko reviews are getting caught in spam filtering or something?
> > > They are showing up for me and on the mailing list[0] so I'm a bit confused why
> > > you aren't seeing them. You shouldn't have to go to the web interface[1] to look
> > > up the reviews.
> > >
> > > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> > >
> > > [1] https://sashiko.dev/
> > >
> > > > It's better before addressing Sashiko comments,
> > > > reply to all people involved and to Sashiko's original email, so it will be
> > > > visible in the previous version why you issued (actually about to issue) the
> > > > next version.
> > >
> > > Hmm, maybe it makes sense to enable recipients in the reply_to config[2]?
> >
> > It's up to the list owners / subsystem maintainers.
> >
> > > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/mailing_lists.toml#L290
> > >
> > > > And before even issuing it, wait for a while, people might
> > > > disagree with Sashiko judgement or your replies on how to address that.
> > >
> > > I was assuming everyone was seeing the Sashiko reviews getting posted to
> > > the mailing list already. The are ending up in lore so unless someone isn't
> > > subscribed to the list I'm not sure why they wouldn't be seeing those reviews
> > > already.
> >
> > I assume you already answered your Q. mailing list in this sense doesn't mean
> > recipients. I think it simply goes to the mailing list without forwarding.
> 
> Do we want those reviews going to recipients as well as the mailing list?

For serial patches, we decided to only have it go to the submitter and
the list.

thanks,

greg k-h
