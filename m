Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35981306B3B;
	Mon, 10 Aug 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385564; cv=none; b=fKRDZcYCWpLdsBgW54fOr1m6tRK59uejmzNyjxuPR7DWIWeySzJErn5odmH8PgxttgPybfmdOtu+dmxLE3t2/XOyHYp7A40jOhafGMZ9PWjMiNpbNMd/sNm/wfWUukoVAOaKVLTzi33Bu2az8zvT5O11XqA5rnYbpW7xvJ2/Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385564; c=relaxed/simple;
	bh=F11Xrj4bvY7dI4efnBVSrqv60Jk9i126GoZXVbVr7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOfTYePkhNjyF6Lg5KLytQ5ngPC8rP25hL9lbGrhbl3FnPa0IRnvfjc5wPb0aFIhwwtrEtkYGNb7WBDCxVlDXVFftQOoSHi1cLVT0txYTh9MqMSwUvd7PpaKU62fdQqQWTL5HJNHfrc+bk6qJi+CnoHYGqDyxoSsNXxRV7RRzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpRDHnB7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpRDHnB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786385562; x=1817921562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F11Xrj4bvY7dI4efnBVSrqv60Jk9i126GoZXVbVr7TE=;
  b=mpRDHnB7WrukaXMmYeqR9asvP6gRpmzdTxQsRFhSaIKqAT9zc15LL7yI
   ui4Ru3hyNIzmRLaT+RSu+MxHkWvPvpM5PXNYBa6+XHeMUmzxIm5CJkHBi
   B4P7d/6BpA+gNbvLD6Gb9a2G13dPLVKaKFspKTKt9Q/YlwKAtCucpfS/9
   Sn211kByRSiYVp0LeftLwvUcxmdoORrA+fRlc6WOMoezHyGmzoLc1sAoy
   hynEvrzvrtLuTB6LbQcACYXcztY5kkzAkKhvnILVAQTavxMcjYo1XCbZP
   IEaMemwQgam3Z1E1XEX/T3dnaGxDSpltDE6+00dGivJhXkQ2RAqLEeFn7
   g==;
X-CSE-ConnectionGUID: tgJ65a80TOGABF8ThSOIMA==
X-CSE-MsgGUID: zC8WwD7VSZ2RvWd8CqF8RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89434534"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89434534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:12:41 -0700
X-CSE-ConnectionGUID: YoyAPRtpS2Ks2iknPIl8Tw==
X-CSE-MsgGUID: ojnvnHCQT7G2qrvIfLQpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="256887570"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:12:38 -0700
Date: Mon, 10 Aug 2026 21:12:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: core: Allow drivers to keep "init"
 pinctrl state after probe
Message-ID: <anoUlD3ep6t0WkHw@ashevche-desk.local>
References: <20260810130635.1166626-1-mkmkl@google.com>
 <20260810130635.1166626-2-mkmkl@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810130635.1166626-2-mkmkl@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:06:34PM +0000, Michał Kardaś wrote:
> During device probe, pinctrl_bind_pins() binds pins to their "init" state
> if specified in Device Tree. When probe finishes, pinctrl_init_done()
> automatically transitions the pins from "init" to "default" state.
> 
> While this auto-transition works well for devices that are immediately
> active upon driver binding, certain peripherals (such as power-sequenced
> devices connected over UART, SPI, or other buses) remain unpowered until
> userspace explicitly opens the device node or attaches a protocol driver.
> 
> On board designs where the connected peripheral is kept unpowered during
> boot, auto-selecting "default" or "sleep" pin states (where signals such
> as TXD or RTS may be driven high or pulled up) can cause parasitic
> back-powering into the unpowered peripheral through its ESD protection
> diodes.
> 
> Allow drivers to explicitly opt out of the automatic "init" -> "default"
> transition by calling pinctrl_keep_init_state(dev) during probe. When this
> helper is called, pinctrl_init_done() leaves the pins in their "init"
> state upon probe completion. The driver can then transition to the
> "default" state when the device is first opened by calling
> pinctrl_pm_select_default_state(dev).

...

> +/**
> + * pinctrl_keep_init_state() - mark pinctrl handle to stay in init state after probe
> + * @dev: device to keep init state for
> + *
> + * Return: true if the device has a valid init state and keep_init flag was set,
> + *         false otherwise.
> + */
> +bool pinctrl_keep_init_state(struct device *dev)
> +{
> +	if (!dev->pins || IS_ERR(dev->pins->init_state))
> +		return false;

The above keeps_init in the initial state which may or may not be wrong.
I would avoid the ambiguity by rewriting this as

> +	dev->pins->keep_init = true;
> +	return true;

	dev->pins->keep_init = dev->pins && !IS_ERR(dev->pins->init_state);

	return dev->pins->keep_init;

But please, check if that is what you want.

> +}

...

> +	bool keep_init:1;

What is ':1' supposed to mean (for boolean)? I understand that for say
unsigned int.

-- 
With Best Regards,
Andy Shevchenko


