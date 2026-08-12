Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E439A07B;
	Wed, 12 Aug 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518023; cv=none; b=GAJwRV2uDizRYM5y5N1+csKp7h+c+ZoG+RPDb5HDFSAE3pFHsNYNVNhgoeGQ7PwEBUUkqBkyW7vU617CH5TI1Vs6f/EIw0iZMXvdEFPWCpUbziwc7BiKQ3xlACnM56dMNN57FbMHbV8dkhmOtAGbtRUR5ODV8fEc27XUnk75Z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518023; c=relaxed/simple;
	bh=rbw6X78XbIjsHlTKCag2rU4aHjstR2LruI3rFnmmRss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY57qhIGpmHsAGQBxb59cM54X8Lv/sFZ2yOrC9KtkZB7fSWc8OQmaQxaj3oFYmTwo3iYtu7zmk0/gbMCGSP+0pXgbicYBXhUv4VX1gZiTkqTvjwJZ/iwU9mtqExBTywercTVV6tLwn87s3FJCFBEZgz8cDFr5qMRbUjbqx5kXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYur3VOJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYur3VOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786518020; x=1818054020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rbw6X78XbIjsHlTKCag2rU4aHjstR2LruI3rFnmmRss=;
  b=HYur3VOJ3cDi9FvkGOjogz0seIqk53uttE/kaLvTAbodL0bg2blQl3yh
   yKAtUFNQkhyoS1iIBzOZN+W8K0jJLF8mE3qjz8ttSB1fo69F0OerbdxPX
   8La1ngbphaFXZgt9wObG5yNQ50fOO4ylkVhp3Kaxh+jVPkQJh7guYLXdD
   EI2ARM+QzOIsdgFFJ5iyz9jAUCi8JHN/1Mq+qW3vfYjc0tfbyXh3UHfvs
   83G+tpL51EN1f3hkFTZl3XBBabYxbXDi97cG5e6oZTKKoX+CCot3EAAHU
   8P4hx8ARvjYsahefnQnweNGwUNFL+INzHcR853FUw+pC3VWhIPP96GlH8
   A==;
X-CSE-ConnectionGUID: oXTUq9YPS5KBv5pJNyHi1Q==
X-CSE-MsgGUID: ZD0NAWO0SUWsLcitJC6cew==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97651020"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97651020"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:00:19 -0700
X-CSE-ConnectionGUID: tWvW1C/ASFKc0XbpY0+niw==
X-CSE-MsgGUID: AWUJ9dkfQ16kaKlYGSfJZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="293501132"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:00:17 -0700
Date: Wed, 12 Aug 2026 10:00:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Linus Walleij <linusw@kernel.org>,
	=?utf-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Vic Huang <vich@google.com>,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
Message-ID: <anwZ_h5ySXuGpM3B@ashevche-desk.local>
References: <20260810130635.1166626-1-mkmkl@google.com>
 <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
 <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
 <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
 <CAD=FV=UMBrgiRNP7y=KaAcq9a0f4UvJn5HOK=JoYveRS6c8mRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UMBrgiRNP7y=KaAcq9a0f4UvJn5HOK=JoYveRS6c8mRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 06:26:53PM -0700, Doug Anderson wrote:
> On Tue, Aug 11, 2026 at 1:15 PM Doug Anderson <dianders@chromium.org> wrote:

...

> FWIW, we are in basically the same situation for SPI on the same
> board. Specifically, this happens:
> 
> 1. Remote side starts unpowered.
> 
> 2. SPI bus driver probes and pinctrl sets SPI pins to their default
> state. Importantly, the SPI chip select (CS_N) is high, which
> backpowers the device (illegal).
> 
> What we need is we need to _assert_ chip select (make CS_N low) until
> we know that the other side is powered.

Isn't this dangerous? Some noise on the bus for whatever reason might produce
undesired "communication".

> ...we can try to use the "init" state that exists today, but by the
> time the SPI's probe function finishes, there is no guarantee that the
> SPI client's probe function has run. The module might not have been
> loaded yet. This means that "init" state (as currently defined)
> doesn't help.
> 
> ...we can't use the "opened" we've been talking about in UART because
> there's no real idea of "open"ing a SPI bus. It's transaction
> oriented.

But any SPI message that is queued is basically an "open" stage. So, it sounds
like SPI core should change pin control states when message is queued and when
it's done. Like be coupled with runtime PM?

> ...we can't use the normal "runtime pm" concept in SPI and start the
> SPI bus in suspended state because the "runtime suspended" state of
> the bus would want the chip select deasserted (CS_N high).

Sounds like a PCB / electrical level of design issue. I would solve this
by gating CS signal using power of the peripheral connected. Have you talked
to your HW engineers about this problem?

> Using an extended "init" state (as in Michał's patch) and
> transitioning to "default" upon the first SPI transfer would work,
> since we'd know that the client is powered by then. After that point
> in time, if the client wanted to power the device off it could
> manually assert "chip select" before powering off.
> 
> Of course, I'll admit that using the extended "init" state like this
> is still a bit ugly, whether doing it like Michał's patch does or by
> doing something like the "unopened" solution that I talked about.
> 
> Other options for SPI could be:
> 
> 1. Hack something into the SPI bus driver to turn on the regulator for
> the device. This is pretty ugly, but would work. Probably not
> upstreamable.
> 
> 2. Invent a "pwrseq" solution for SPI where we run a sequence of steps
> (turning the regulator on) before probing the SPI bus, like other
> "pwrseq" drivers. Of course, most of those are for "discoverable"
> busses, but the idea of powering up a peripheral before probing the
> bus it's on is similar. This seems an extreme amount of work.

Btw, isn't there some development for the undiscoverable buses?

> 3. Hack the "CS GPIO" to be controlled by the client. It looks like we
> could fully move the GPIO (including the pinctrl in the DT) to the
> client. Then the client could call spi_set_csgpiod() after it's turned
> on the regulator. The client could have an "init" state for the GPIO
> that keeps it low and then transition to "default" right before
> calling spi_set_csgpiod().

> Of everything, solution #3 doesn't seem terrible. I also still don't
> totally hate the idea of extending the "init" state... Of course,
> there's also some chance we can figure out other ways to get this
> regulator turned on sooner.

Yes, #3 seems okay, but wouldn't be even better to have some flag in
SPI core or pin control on per message basis (see also above)?

-- 
With Best Regards,
Andy Shevchenko


