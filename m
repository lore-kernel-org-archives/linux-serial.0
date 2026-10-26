Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044438;
	b=Mnffk9w4FbEcaIUpI91d/CYrK5R5NZ/Nc0pxVBaj1J9vLqYd9RO0gDgjaApiAreSvjE7
	 bZ+G17NAHtUVgSq4W4n5OzqXVagmz7A5E4bU6JS4mCRAKUuOwVde/kzs9aZAv1FsMWrSJ
	 gey+bZj+aar8Mwiqq9KNm0uknq0YAQbgouj5HgK2oVB177H/xq4960hBymR/5LSB/2cNJ
	 HUTnnFrNZlmiTXCGmdfbCI4QPo3iUTKUMisfsySwsUGiKyPw+WTZlq/hhN7BOS+q35V+B
	 nzSxDJrsVUh+ObQG9pzE59e0lI7D2GFfsF7/kDwetc4eYeizLx83wyDlFkEEICmmgsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044438;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=i+NDmw4lwf3hRzODAHlKBNdsDK4Mb0dC93HrLNynbZA=;
	b=za1at7GWuVz08DgyKYEgr9M6aSB5lL3NxenOZ5UsL4MCGUisRzs6ywDVGy8F0SBDtJwx
	 fs0Eq4f7PoujLVUqBrrmSNoKplPEprLsn8UHJd6K6pM4LhREzGBjOv/vOOGGbOPs18gvI
	 homU4tPHeC4scgg62FUyujG6BfXCvXx1hgYRdKX8kefEfh8kRbpl+cdxmKtHWRhAsbogu
	 iAIicqQj0y4bya7mRmfVEWDJyravYubxS0q0Cwf3Vp/GnCvrpmaaMHx0CuGLVbB7KUYfX
	 IJdafv4+MCWLMJbtyNDRI81ZT9LBLm/tprOnLK5KJgLucF5jBw+Wh8yH4WYFcvBj6Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BV8ccHbR;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06538606A31A;
	Mon, 26 Oct 2026 19:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06538606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BV8ccHbR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793044438; x=1824580438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FV51n/PiZWx6bvBfOkBqCKkoCYD8qfwCN0puYCkV0os=;
  b=BV8ccHbRqwgaFyUocxyvAjpqzZrPmEwHD6I8Z6RBt6JY0DIN0HLvIfCJ
   Yjn4p8WOFrvTGSLMLPGdSHt2QtOzFdxsFoiPLyU8SKwXj578RwvCaLH76
   sILx7HHDKEOw1DZ42U56csEnXiT/zJw8YNON5m9Vy1ZcyAAoxd2OH3poG
   a7grcUPyIKGBEsRTnJT6eBLYL3hjMNbFKUBuepp5zkNZnFd+gPeWDgLH1
   kN4E+ARRmCkHwTATrussERPCtcmmPxVyHm7IzY38KTrNIHlsDc17uwdiu
   ylfFUkJxlUsh5iaTFMSxsSVrku5XKWSbdk+WAgHmrPwysCTFNY4S1H+PZ
   Q==;
X-CSE-ConnectionGUID: BQmHi8vgSDqF/dyYjIwy6w==
X-CSE-MsgGUID: xP+kcgw7TuKodOBYNYu3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1615437"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1615437"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:53:55 -0700
X-CSE-ConnectionGUID: Dj09to7/Sbe2r8g4P5Lwuw==
X-CSE-MsgGUID: qCd0O6T5QDOWwhS++gg2Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4710651"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:53:48 -0700
Date: Mon, 26 Oct 2026 21:53:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <at-vyZ1sDhYPu0W5@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local>
 <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local>
 <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
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
In-Reply-To: <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> On Mon, Oct 26, 2026 at 3:33 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > On Sun, Oct 25, 2026 at 2:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:

...

> > > > Some people might want to test the stuff. And sending too often you actually
> > > > will get the opposite results, people will be tired to even start reviewing
> > > > and/or testing your code as it's changed way too quickly.
> > >
> > > My thought process was that people wouldn't want to be testing code that
> > > had known bugs flagged in Sashiko reviews.
> >
> > Sashiko reviews are not visible in my or any other mailbox. To see them I have
> > to go to some URL and so on, meaning to waste time to see why on the earth the
> > new version has been sent.
> 
> Maybe the Sashiko reviews are getting caught in spam filtering or something?
> They are showing up for me and on the mailing list[0] so I'm a bit confused why
> you aren't seeing them. You shouldn't have to go to the web interface[1] to look
> up the reviews.
> 
> [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> 
> [1] https://sashiko.dev/
> 
> > It's better before addressing Sashiko comments,
> > reply to all people involved and to Sashiko's original email, so it will be
> > visible in the previous version why you issued (actually about to issue) the
> > next version.
> 
> Hmm, maybe it makes sense to enable recipients in the reply_to config[2]?

It's up to the list owners / subsystem maintainers.

> [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/mailing_lists.toml#L290
> 
> > And before even issuing it, wait for a while, people might
> > disagree with Sashiko judgement or your replies on how to address that.
> 
> I was assuming everyone was seeing the Sashiko reviews getting posted to
> the mailing list already. The are ending up in lore so unless someone isn't
> subscribed to the list I'm not sure why they wouldn't be seeing those reviews
> already.

I assume you already answered your Q. mailing list in this sense doesn't mean
recipients. I think it simply goes to the mailing list without forwarding.

You can ask at helpdesk@ how this is configured on the kernel.org side.

> > TL;DR: this mailing list is *not* a playground with you and Sashiko, the whole
> > community is behind it.

> > > > Settle down first
> > > > with something, put on the cover letter the answer why not all Sashiko's
> > > > comments are being addressed (for example, due to amount of patches or the
> > > > series being focused on a certain issue).
> > >
> > > So, in general I've been always attempting to resolve known Sashiko issues
> > > in every subsequent re-spin, so that would be a bit tricky since I wouldn't be
> > > aware of the Sashiko issues until after the series has already been sent.
> > >
> > > Usually the subsequent issues that get flagged are new issues only discovered
> > > after each new re-spin.
> > >
> > > I do have a bunch of UART/DMA related patches that don't have flagged Sashiko
> > > issues so it probably makes sense to try and review those first while the larger
> > > series that have Sashiko flagged issues are still stabilizing.
> >
> > Yes.
> >
> > > > > [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko


