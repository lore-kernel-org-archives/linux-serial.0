Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3983431E6;
	Thu,  3 Sep 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439999; cv=none; b=fnbdzd1DAs8JoPyRE/9HCgcJt5PUOaJICUI6vp+sGHXFdfnvLAB75IEKlDb1TqcVgNBIyA5yd1lAvcK4HrlXUCIOISHWqeTCA+We5V4nOjMxIZu23Eu8HlxpXrxxI1fbvBswoXsHIt5WbKdKA7P9C3gMdg+eNYcfzSd+T6exhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439999; c=relaxed/simple;
	bh=tG43r3ybKL5uUT1O97RFbvlWYx+uuXHDv+04GQeYfAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8beYgGZvfYfV2Yp9Genx8kwV70nCUN+GB7z+Bbwh7j9Y8T2U1nOHHnWlkCHSNQKbqodn8JJI0/15snFBghaTahn33ipbo6xWSp+sCPs3gTsIDt3b5aKEaGRtm7BK+3DGeB8zcM0ah5MSoCCcvyxw2uQ5wCJ/3n1Gn738EpJRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGemzVTj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGemzVTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788439998; x=1819975998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tG43r3ybKL5uUT1O97RFbvlWYx+uuXHDv+04GQeYfAI=;
  b=cGemzVTjhDdm/eKK4bNao3ZNAGnj6P2DnGgCd509ZXfEg/zhh7expQDY
   aesXNjBG3S1Q0VKb/uRKUdcZxOPi3XRDMvB4ZVbikia/zSiZDklNICZ1E
   3OGMTrrwZvEPO3KAu+sD8OWGP50UitVu4AfEwJln9ADF515UkGZs3VDUv
   SQGbzQH6Mkdz0O8sIsoV5oDZRI6zrzOQe0FVr6kayPylqTRYBhl8zPcT+
   tgUVEozUXzwtdLOxHDDImYtsElbYA0+zMmZWVgP+TMgTbHsd9I6BvHJ9V
   2fKrrPGK1bFNt6fTxJVxHOS74AS9aztv+85tC20gBsGXNZOMxWr1ewQC0
   Q==;
X-CSE-ConnectionGUID: YL9PaXPcQViTXGaVv7CkqA==
X-CSE-MsgGUID: 2JX6UsMcQ2GFouX/phKIBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100079188"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100079188"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 05:53:17 -0700
X-CSE-ConnectionGUID: EG6UkGFQT6G/iLYPpVG6aQ==
X-CSE-MsgGUID: Fv19EkL4QhedtceXVGp5ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="265372033"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 05:53:11 -0700
Date: Thu, 3 Sep 2026 15:53:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: zl020895 <zl020895@163.com>
Cc: longzhao <longzhao@ambarella.com>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc <soc@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	linux-gpio <linux-gpio@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>,
	mfd <mfd@lists.linux.dev>
Subject: Re: Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
Message-ID: <aplttDenvZHvn0mF@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
 <aplcxoINt0YAjvxL@ashevche-desk.local>
 <709278f9.9699.1a067207b4c.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709278f9.9699.1a067207b4c.Coremail.zl020895@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 07:56:17PM +0800, zl020895 wrote:
> 
> Thanks for the confirmation. 
> I will keep 8250_ambarella and update the commit message as you
> suggested.

No, I mean to go back to the version that modifies 8250_dw.

> At 2026-09-03 19:40:54, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:
> >On Wed, Aug 19, 2026 at 02:31:59PM +0800, zl020895 wrote:
> >> 
> >> Thanks for the review.
> >
> >> This is Ambarella 8250-compatible IP, not Synopsys DesignWare. We
> >> first tried 8250_dw after Linus asked us to move to the 8250 library;
> >> you then told us not to touch 8250_dw and to use 8250_ambarella
> >> instead. That is what this patch is.
> >> Background:
> >> https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/
> >> https://lore.kernel.org/linux-serial/an8KvvHWX0naH3Xw@ashevche-desk.local/
> >> https://lore.kernel.org/linux-serial/7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com/
> >> I will also switch to uart_read_port_properties() and trim the
> >> 8250_dw-derived boilerplate.
> >
> >Thanks for the register descriptions, it was helpful. After going through them
> >it seems the v3 as you made it is good enough (sorry for going back and forth).
> >What it needs is better commit message explaining that while it's not a Synopsys
> >DW IP, it was made to be quite compatible with that (on register level) and hence
> >no new driver is required, just a small quirk.

-- 
With Best Regards,
Andy Shevchenko


