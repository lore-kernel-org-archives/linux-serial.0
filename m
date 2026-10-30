Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382853;
	b=HX834kn910U3yCtazV6XlfeOsEHwRUvfnbEPJ3mbR51wTx+Z1lnKhlH1QH167zBak+MP
	 bXzqDnhavd9/xE01qVzyRlfRPT1ij0AltAunflyZCDz3rcm2FHGjyd0hi/N3vzwII4R/z
	 5idsea7T5kihWtlK3rdh3x5/MjF0rphqf0jWE2lPu70RQLPOgKDfGvhu59vUO+1SDzri/
	 YfCYfnV6EEf0/5/6Xi5Fd7e4p+rqNaNuqWQfenmdkD26nFPYyu191m8+BHtImCjaXVLvY
	 XATHdGGE6wN7fWrqQAyIyQeBxi47j4OmAUwQymgWUejKNR4acOE4+ghRSkcHDWCXFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382853;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=vFtK92loJ0xr1IzJVV1xwMCKKp55jpNQBYy00GgLoCA=;
	b=pMux3f9towrPAoUjMDPjh5RZrOve8/ZlvLAbR0r7VFZEm3D9CfCTDRJRPLxiL42Z8bIU
	 9Zpyd1PTa5Jkj+TC2DrrQWTWVewMkK3earuXkBaHlzcJoOo2R2H7wBpVCxBvRrIwmk8H2
	 K8nVJbA6+Mj8ARrgHtOmMLuoX2nB8EvVabJFm2T2tWMgSUBkJ1oNdtex6FNwY7smP/MSs
	 JHVfmM+O4oQU+DTpS1e2jOHlEYoymcClxqW2Ho3rLs6BTS9j7o/mJTvF2sy8B2pfHY1fw
	 BUqb3QJaS9X7bJgwhCjpLYBJqKPGi1S7D2lpTMurtC91JOufGlIaY8ofGLTmPg2cccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HXiv2R96;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47178606A31C;
	Fri, 30 Oct 2026 17:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47178606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HXiv2R96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793382853; x=1824918853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IzqHLossDmxKbFc+aGxUKjOQbcSxP3c6buURWcuw2Tc=;
  b=HXiv2R96nL23J3TEKA7EuVFwW+y+FvRBx+gSYbOTbPqpzFN5jsQDBY8N
   W7ICTJLAGMeNUaqwkGXma5686S6TO8G6DJ5/xi0q4GZyEy96BSjzOZ5kc
   7sHOAItt8rntURs4qiKoNHvo2vo8P2zg8N8TZWKVCj5wXcPUUTnBJl9cQ
   y6uRLRgupKrrU6Cv9DmAmrijK7Ky6s2zyOtiWZqcjnNaj2ydhKFdcQsYa
   uLSH4BI2Xrw3TTT7NSgc/AFc/TSjY4S4/ISHIoDl+rSvLxp70cmxB/vV0
   AQF0zPNiz/yt2Fcdxy9uoCdytrWqMQyS17BkCx9RQlA3eHykxQKNW+2hK
   Q==;
X-CSE-ConnectionGUID: ZmrW4xZrSeeV/9XF1B1VpA==
X-CSE-MsgGUID: w8HWwnfBSrCGCi7D3XA9tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2170307"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2170307"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:54:07 -0700
X-CSE-ConnectionGUID: 4l33Hy4iTb6mNx52iAPxHQ==
X-CSE-MsgGUID: aoBFLn+ZRDe7lWiftDeSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5516478"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:54:01 -0700
Date: Fri, 30 Oct 2026 19:53:58 +0200
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
Message-ID: <auTZtteCFnuoMD3p@ashevche-desk.local>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
 <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local>
 <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
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
In-Reply-To: <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> On Fri, Oct 30, 2026 at 3:40 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:

...

> > > > > +     while (rx_ret || tx_ret) {
> > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > +                                 "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > > +                                 rx_ret, tx_ret);
> > > >
> > > > > +             msleep(100);
> > > >
> > > > Huh?!
> > > >
> > > > > +             if (rx_ret)
> > > > > +                     rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > > +             if (tx_ret)
> > > > > +                     tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > > +     }
> > > >
> > > > This is unacceptable. Sleeping is okay, but value should really match the
> > > > baudspeed and other parameters of the transfer.
> > >
> > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > an error, rather than an estimate of UART transmission time. Each
> > > retry asks the provider to stop the channel again; elapsed time is
> > > never treated as evidence that the resources are safe to free.
> > >
> > > The particular 100 ms interval has no hardware-derived justification.
> > > However, I don't yet see a sound way to derive the retry cadence from
> > > baud rate either. RX can be waiting for input, TX can be held by flow
> > > control, and callback retirement is a separate requirement from
> > > moving bytes through the UART.
> > >
> > > Do you have a particular provider failure mode in mind where retrying
> > > termination should follow the serial transfer timing? I'd like to
> > > base the interval on the condition that can make termination succeed,
> > > rather than substitute a wire-time estimate for an arbitrary delay.
> >
> > Termination of DMA sometimes require to clean up internal FIFOs and other state
> > machines. That's what happens on HW side. In the software waiting for too much
> > may lead to the very big undesired latencies. The value of 100ms sounds insane
> > to me for the HSUART cases (megabaud range of speed). Also note, not every PCB
> > design uses HW flow control, so this may be even worse for them.
> 
> The 100 ms interval can add unnecessary teardown latency if a failed
> termination becomes retryable much sooner. There is no hardware-derived
> justification for that particular value.
> 
> The FIFO/state-machine draining is part of the provider's stop sequence.
> For example, DW performs its FIFO-empty polling inside
> dwc_terminate_all(). If termination succeeds, this patch proceeds without
> the retry sleep, regardless of baud rate. The sleep is only reached
> after an error during DMA release, not during normal RX delivery.
> 
> Baud rate can influence how quickly a transmit FIFO drains, even without
> flow control. However, the termination error does not tell 8250 whether
> that drain is still progressing, how much remains, or whether the
> controller needs a different recovery operation. That distinction matters
> when choosing a retry interval: a shorter interval reduces the added
> latency, but does not establish that retrying can recover the channel.
> 
> There is also a specific API detail here: dmaengine_terminate_sync()
> returns immediately if device_terminate_all() fails, without reaching
> dmaengine_synchronize(). Consequently, an error leaves callback draining
> unconfirmed as well. The retry cadence can change, but resource release
> still requires successful termination and synchronization.

Most likely this is AI slop. I can't see the justification for 100ms.
Can you explain that?

> > > Regardless of the retry interval, shutdown cannot release the buffers
> > > until the provider establishes that DMA and its callbacks have stopped.

-- 
With Best Regards,
Andy Shevchenko


