Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436251;
	b=X4d8erjxDL+LA8oJJb8nX5z9BiWHKpLjJr9DI0Aboo6GPgEFqFwHQRr8PT1jgWZL2XPm
	 2y59tEjAXH+/ymNZo2bXCVBS0qWz6jDSottOaGXad9aZlDY414xYfuJS0ibyi0sY+TYyQ
	 A6BIn+jPnhksOzCDT2p76Z3Rk2UscLRdDkZPv5zb1G9XkDiheHEo2fAmxMqQzkIarsfbE
	 PbHOMGMNDXt4H+ipDOq1Yr52Fa5uaklGcFD3Q8n6ZWBfgIPthGNr8IgSVC+tf4Eq8vf+m
	 q6+ZiXM5ARv47AIPQSZUhtjhgD7/jGn2CLbHenBPvwhbJINlEZqiuBfla22TqXqt8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=W7C9cpmzdFca870tYxpXsF2MjrgsKkdtNJLk6fjsOEI=;
	b=C8dO34n1vZaHpFQI/Oxr9TDdmbMKhVqZm+gSZcuU2TSenVcVWiwM9Z3zyMP2OfitfrlO
	 duuw1TnkhYS7tfZTWQWDWq+86mGU+r6GbJ6HPBc7kazk1Z3IFe+a+T429I1bd+NoyioM8
	 +g2DJfKbSd+rCeoAlj1UrzXgGQQf5WgX8VFNjjfOeyRtIwDwiHm8bZLHxP64u+dQQwqdG
	 jjUCaL3Zd/EPkp8pdNytTYj8jS5NGlvtdX7enaTxGEQep8GLYPInbuGhNtq7TCz0DBIfo
	 ntMlplvbF5imLchjZPfRF897FTciW9woE7uUO4XCToXE66Y24ex9H1H/cHyQwqe5Xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MJNJZifK;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFD606A31C;
	Sat, 31 Oct 2026 08:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MJNJZifK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793436249; x=1824972249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wn8SFowoel5epk8m5Si6mxTN8wfKc2MuePpSe+sjbLY=;
  b=MJNJZifKks8msiDDTcsubAz8Flw64AfLcsvFH3BruUk9obfl7QY2NXb3
   NpRsus+d2uLYRFgYZGOHVvhordHKa+0vmTubjylePTHxleVy03LDmFoe0
   EluMIMucdmTBJmInPRzTb69QuqzCUrOI0zKgCHGOabJLH7SwuOF2oMxxn
   4rct3ChXXshKoAH2i9KwXky8H4CeycU33xHzkXkSwoyd3dvqNsZ+Hpigj
   xojbqz76MwGxVzgwQzcnfXtIFY5cbZNbUqyltTmP9AFllcS3+jvzsyFzR
   XcjQkzmZlJbItfNVAxB8d3PKu6wCH2ZVjD1ittFhY/MVMxS4Mt7cQH8+m
   Q==;
X-CSE-ConnectionGUID: avOEHitMR72MqAImxd8aYA==
X-CSE-MsgGUID: DsCaJd+UTumHnlgAusFkXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2185102"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2185102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:44:08 -0700
X-CSE-ConnectionGUID: kFJld0R6TF22hO1251niqA==
X-CSE-MsgGUID: vR+J2NnMRyGUqn4j6kuC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="6184723"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:44:03 -0700
Date: Sat, 31 Oct 2026 10:44:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
Message-ID: <auWqUIBUs0_7bnGU@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
 <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local>
 <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local>
 <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
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
In-Reply-To: <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 12:08:52PM -0600, James Hilliard wrote:
> On Fri, Oct 30, 2026 at 11:54 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > > On Fri, Oct 30, 2026 at 3:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:

...

> > > > > > > +     while (rx_ret || tx_ret) {
> > > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > > +                                 "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > > > > +                                 rx_ret, tx_ret);
> > > > > >
> > > > > > > +             msleep(100);
> > > > > >
> > > > > > Huh?!
> > > > > >
> > > > > > > +             if (rx_ret)
> > > > > > > +                     rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > > > > +             if (tx_ret)
> > > > > > > +                     tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > > > > +     }
> > > > > >
> > > > > > This is unacceptable. Sleeping is okay, but value should really match the
> > > > > > baudspeed and other parameters of the transfer.
> > > > >
> > > > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > > > an error, rather than an estimate of UART transmission time. Each
> > > > > retry asks the provider to stop the channel again; elapsed time is
> > > > > never treated as evidence that the resources are safe to free.
> > > > >
> > > > > The particular 100 ms interval has no hardware-derived justification.
> > > > > However, I don't yet see a sound way to derive the retry cadence from
> > > > > baud rate either. RX can be waiting for input, TX can be held by flow
> > > > > control, and callback retirement is a separate requirement from
> > > > > moving bytes through the UART.
> > > > >
> > > > > Do you have a particular provider failure mode in mind where retrying
> > > > > termination should follow the serial transfer timing? I'd like to
> > > > > base the interval on the condition that can make termination succeed,
> > > > > rather than substitute a wire-time estimate for an arbitrary delay.
> > > >
> > > > Termination of DMA sometimes require to clean up internal FIFOs and other state
> > > > machines. That's what happens on HW side. In the software waiting for too much
> > > > may lead to the very big undesired latencies. The value of 100ms sounds insane
> > > > to me for the HSUART cases (megabaud range of speed). Also note, not every PCB
> > > > design uses HW flow control, so this may be even worse for them.
> > >
> > > The 100 ms interval can add unnecessary teardown latency if a failed
> > > termination becomes retryable much sooner. There is no hardware-derived
> > > justification for that particular value.
> > >
> > > The FIFO/state-machine draining is part of the provider's stop sequence.
> > > For example, DW performs its FIFO-empty polling inside
> > > dwc_terminate_all(). If termination succeeds, this patch proceeds without
> > > the retry sleep, regardless of baud rate. The sleep is only reached
> > > after an error during DMA release, not during normal RX delivery.
> > >
> > > Baud rate can influence how quickly a transmit FIFO drains, even without
> > > flow control. However, the termination error does not tell 8250 whether
> > > that drain is still progressing, how much remains, or whether the
> > > controller needs a different recovery operation. That distinction matters
> > > when choosing a retry interval: a shorter interval reduces the added
> > > latency, but does not establish that retrying can recover the channel.
> > >
> > > There is also a specific API detail here: dmaengine_terminate_sync()
> > > returns immediately if device_terminate_all() fails, without reaching
> > > dmaengine_synchronize(). Consequently, an error leaves callback draining
> > > unconfirmed as well. The retry cadence can change, but resource release
> > > still requires successful termination and synchronization.
> >
> > Most likely this is AI slop. I can't see the justification for 100ms.
> > Can you explain that?
> 
> 100 ms was an arbitrary backoff to avoid a tight retry loop if
> termination keeps failing. It was not derived from the baud rate,
> FIFO depth, or a DMA provider's recovery timing.
> 
> That motivation explains sleeping between retries, but not choosing
> 100 ms. I don't have evidence supporting that particular interval.

Yep. And that's what my point is about. Any big sleeps has to be explained
and justified.

> > > > > Regardless of the retry interval, shutdown cannot release the buffers
> > > > > until the provider establishes that DMA and its callbacks have stopped.

-- 
With Best Regards,
Andy Shevchenko


