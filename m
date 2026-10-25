Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961074;
	b=Blhj/Xl41kKatBxsxjSJx63GnnQWJiwni5dKtmvo/ZBMd75imJz/uGesN+iafp/R3qtE
	 EnB9VjzWIaHXuruRvY1aVQmhvJ9/qEOtrvFyxMKo6VpYFyQ2UCZE/fQz3s7QXEz9zWm9N
	 Y8CYgNHoBKXMwpIfFZy4vZOqlNw6qttZbcYWU6iNr/+B2zXH5oHz2VM1YRT6tKxYOjMVD
	 gA06iOfIpj7nhEUpepW69xdUPSpeMMjEVhLVJcLSGOdkXElBpEXhohwPpbJbrv5LcYwnp
	 0m4YeOWw8EXsnlbXoTjS5adaOKC+uGNQGdOedxtQHLEaggxCIaw5/aqjGc6mSpswR9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961074;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Y1K0RTnG4l4ygM2F8GtIx4eTiSY/f4ozYtbSxngz744=;
	b=Hy/q07MlCO9ijdqsLaqyqc+ufyi5wvIVznYxQFTZSoPREc0OyqM482aBB1Z3SFI2spMp
	 3FS1usf3uFxBgTIG+ZeZLVJIHieGUEiBSrrK71xsix3seDoO3XJNr6Ll1476+KzovsTEg
	 UhrUawzXRUgWDDfZuk99lqMtTiqrVUV34NMEr1N4nQhIOefgReAANtux8P4O5JVuDarce
	 0vIjiXaqDKsfHy5Ju+kCO1vyjk/nErlimYi54mroBusjM671JBwNXRbM+ExTmt5WeH318
	 NNa9NnS4wmxwpxTs9U0JjSWamJgop4lK4qyTe4tgRHp2YPw2BeZIwr11d0G6auIz7vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPb6KUJE;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFA6606A31D;
	Sun, 25 Oct 2026 20:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AFA6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPb6KUJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792961074; x=1824497074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eXznDtSLHr+NGm3eF9RB5EGJ3G5yfhG0QIJwsysSxZw=;
  b=OPb6KUJEBdQuGScpmMy8CLzQvqlGLvARkBtgndEb0HC93AYzLKMIo+CD
   WNHnHV7rSS77wcNS95AGm+/HJY/fBw1tpnFfue840ymOfD6HihsF9MSWz
   2FnqvAKHDkUhoXo4ouLxIMP5MLeD/LPSgZSwqM2lSfyv2VhmsGWtGr83+
   /BOVZrSnXUF2FOLVclWPR41mE5mVRPZiyzZm4VHqG8Qmpz+U0g6cZa0GJ
   /Kv2i//m2cnrm1Oprj0CjY5XPYYvM7bu1V1UXDLHQLYmd8AJXjVSOJtAT
   /eSnq/EEA9i41LmONz87wBh2kAcHfaExFLE74FkJCQ4wMJnDFayLZkP4g
   Q==;
X-CSE-ConnectionGUID: aC5HBaBqSKK47cnC4uAgEw==
X-CSE-MsgGUID: +7MeE1NdTtGHPybCIHhySw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1527856"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1527856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:44:33 -0700
X-CSE-ConnectionGUID: EMIh884NTLyiP+HifSGEoA==
X-CSE-MsgGUID: K9IknHoWQhyv10Qz/UdTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4080612"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:44:27 -0700
Date: Sun, 25 Oct 2026 22:44:25 +0200
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
Message-ID: <at5qKehogAjTa-fA@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
 <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
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
In-Reply-To: <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
> On Sun, Oct 25, 2026 at 9:10 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > > On Sat, 24 Oct 2026, James Hilliard wrote:
> > >
> > > > uart_write_wakeup() expects the UART port lock to be held. Several worker,
> > > > DMA completion and interrupt paths call it without that lock, including
> > > > indirect calls from uart_handle_cts_change() and the transmit helpers.
> > >
> > >  Fair enough, and thank you for the cleanup and spotting the issue in the
> > > first place, however...
> >
> > He already issues a v6. I think the tactics against AI contributions should be
> > to not answer for a week or so until there will be a quiescent week.
> 
> At least with the workflow I've been using, a good signal for quiescence is
> simply whether or not the Sashiko reviewer found issues.
> 
> I am feeding the Sashiko prompts into my local agent but it seems to
> sometimes miss issues that get flagged by the public Sashiko reviewer
> still.
> 
> I've been attempting to peel off independently reviewable fixes where
> feasible as well to minimize the amount of patches/code during respins
> as well.
> 
> > At least that's what I learn from this patch storm.
> 
> Whenever my local branch accumulates significant refactoring/changes
> due to Sashiko or manual reviews I generally try and send out the new
> revision fairly quickly in an attempt to avoid reviewers wasting time
> reviewing code that is obsoleted by the new fixes/changes in my local
> branch.
> 
> Locally I actually have far more UART related patches in an integration
> tree that I've held off on sending for now since they are dependent upon
> the prerequisite fixes I have already sent. My unposted patches actually
> have an even larger amount of code changes than all the UART related
> patches that I've posted so far, at least when measured in terms of total
> lines of code changed.
> 
> The large amount of patches I ended up with seems to have mostly come
> about due to the AI agent identifying most of these bugs while iterating on
> and debugging new features(most of which are still largely unsent so far).
> 
> The strategy I've been using is to send small isolated fixes separately and
> then reference them as needed in the larger series that depend on them.
> I figure this should make the changes easier to review than having them
> all in a larger series. I contributed the changes[0] to make this compatible
> with the Sashiko reviewer actually.
> 
> I also use a custom AI agent controlled hardware in the loop test harness
> which makes iterating/testing changes much faster since the AI agent can
> autonomously test and iterate on changes far faster than is possible to do
> manually. This test setup also allows much more thorough testing as a lot
> of error handling or uncommonly hit code paths can then be tested using
> AI generated fault injection tests on real hardware tailored to the specific
> fix being validated. I manually review the final changes before sending as
> well of course.
> 
> I'm constantly refining these patch development/review workflows as well
> so feel free to give me any suggestions for anything I should change to
> make review easier.

I already gave one: slow down. Better think than loop through AI and keep
Sashiko busy. Your patches are valuable, no questions, but they are way
too complicated to catch on withing an hours or a couple of days time frame.

Some people might want to test the stuff. And sending too often you actually
will get the opposite results, people will be tired to even start reviewing
and/or testing your code as it's changed way too quickly. Settle down first
with something, put on the cover letter the answer why not all Sashiko's
comments are being addressed (for example, due to amount of patches or the
series being focused on a certain issue).

> [0] https://github.com/sashiko-dev/sashiko/pull/389

-- 
With Best Regards,
Andy Shevchenko


