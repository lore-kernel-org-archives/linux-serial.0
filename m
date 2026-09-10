Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD964AEBE5;
	Thu, 10 Sep 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054794; cv=none; b=nOBcyaBn+Qa8s6p3vbqbQpxUXWX9NgxKzQ9Zu5Tsxd0OwYPTkGgUwV845oIqZvzQL0FsrUQvBSH5CS229im9E/IeSHUZBw76Qr62kr42pYpeohuXnaHOeqAXwQaEZp5SLmUxGfuMrMz591dehrNpQnjXSp2IA6W8sA99B22MRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054794; c=relaxed/simple;
	bh=UpL9Fn4FfEESsjV6cdJwzM2nTUnP2+hidnKRviHWIBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbmXPPv+ojieJFXrX1gpVVaKBMbF+Z8iuT+V6Vk8hICQfnSILjlUyxJlD9Gfd7kXcwxoqxIAkwU04TmUTwaql4L32L5cj+Tz9Po6jhGFS1rJBBfaUzjBao/dSrePioUsgT24yCauGW092QSMeK0oB7mnVzRRrB+KLFhjIbi60Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhSBJmbS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhSBJmbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789054793; x=1820590793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UpL9Fn4FfEESsjV6cdJwzM2nTUnP2+hidnKRviHWIBQ=;
  b=KhSBJmbS7SkjbNjq59aRBDNkPtFWNcETFnRllKVx81Df8QsfNtQ4n8xV
   bBMjF44hGZgOtyq+ezgWwqmxaa0BN/Zu9Wmam3UFn2R3q/+lMFh0NbNCJ
   gNmhbjqLESPxd0HrUHbmfTA331uaDf0YNRLQPiQy6P7F7lwVNhe359wfL
   Ne8JbJ3oEH799lqMubfbEyVc+xU1tvHjysHg0BcV2czXDvo3ADoFFXMV4
   cGZlZ9k7J8JX4xy3HZ692ZRjsQLDWFOUp3b+D7VOlTBA2Yy5ZvFFqF1ve
   BQd7fKKw8VCE8NqhUpiWun92PfRTMmDewJuiX4XWjCpU1nKo+HaO7wGES
   g==;
X-CSE-ConnectionGUID: QAS0qjU9R3634Fc0zoK4mQ==
X-CSE-MsgGUID: hDi5uOIuS5ao2TyMce/iSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89271661"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89271661"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:39:52 -0700
X-CSE-ConnectionGUID: pwE6b1uxSfylZKhdjLrIUQ==
X-CSE-MsgGUID: o7PHWUCcTUm2vIiLKEoEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="267395256"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:39:46 -0700
Date: Thu, 10 Sep 2026 18:39:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75
 quirks
Message-ID: <aqLPP35Y7zmDuyP5@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
 <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
 <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com>
 <aqJ35vMBiBZo2iUE@ashevche-desk.local>
 <b199eb38-b1a2-4db6-81d8-37bab09a75b7@linux.intel.com>
 <55b27872.8ed9.1a08ab55a52.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b27872.8ed9.1a08ab55a52.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 05:45:36PM +0800, zl020895 wrote:
> Hi Ilpo, Andy,
> 
> I'll go with the simple comment:
> 	/*
> 	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> 	 * timeout behaviour.
> 	 */
> 	up->ier |= d->pdata->ier_mask;


Works for me.

> At 2026-09-10 17:33:38, "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> wrote:
> >On Thu, 10 Sep 2026, Andy Shevchenko wrote:
> >> On Thu, Sep 10, 2026 at 05:12:52PM +0800, zl020895 wrote:
> >> 
> >> > > Wondering if we should undo this in the port's .shutdown() callback.
> >> > I saw the shutdown path already covers it: dw8250_shutdown() calls
> >> > serial8250_do_shutdown(), which does
> >> > 	up->ier = 0;
> >> > 	serial_port_out(port, UART_IER, 0);
> >> > so both the IER shadow and hardware IER are cleared, including ETOI.
> >> 
> >> Depending on the answer to Ilpo the enabling may need an updated comment
> >> summarising the above.
> >
> >I'd prefer removing the entire "Force them ..." sentence, it feels really 
> >basic detail about how ->ier works. I believe that would resolve your 
> >concern if relates to what shutdown does for the flag (clears it while 
> >the comment as is says nothing is supposed to clear it).
> >
> >> > At 2026-09-10 16:33:14, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> >> > >On Fri, Sep 04, 2026 at 02:38:18PM +0800, Long Zhao via B4 Relay wrote:

...

> >> > >> +	/*
> >> > >> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> >> > >> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> >> > >> +	 * generic IER updates do not clear them.
> >> > >> +	 */
> >> > >
> >> > >Wondering if we should undo this in the port's .shutdown() callback.

-- 
With Best Regards,
Andy Shevchenko


