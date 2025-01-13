Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94D22F16E;
	Mon, 13 Jan 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772678; cv=none; b=eJWr8CyqNwREryTLLiwGZK7VMj+rr9HrQyDTF2B/4anwMY78aUihf+x6EK+v2Y8VC5R+g29ys1MxAhS+YePTjdqP5T6Lersf2PBI7x5VaA3xfhnJNBFlMAT7ZY8mZUYgR6AhbzDP8T35eCiZlsnxKl6O5zO1HWHWEVzOa40n6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772678; c=relaxed/simple;
	bh=3XJxJH8SHU3yEfZPfWDkKeJ0zJoqvKnHeUvTiEjB58E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gomDxBZs25XdX9163EfCy2JvL4GgJbIAWbasMPwiVACiDHJKO9rBFhESC2waD0GsF1we7ntfbdFPSjUJ3pIFNr76uEz75HdzqPcbcO9iP8mr+gVYaBmiBcPwsFuHF+i1NTHmczp11NiC7M1JoiHIl+SNZ+nun7ExFps5PhuZEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: StjtsS2DQOKrjH2y6WStng==
X-CSE-MsgGUID: W7QKwxaWSKOYStZZLC8fRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36246587"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36246587"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:51:16 -0800
X-CSE-ConnectionGUID: vCwjopi/SXqnR11YVw0e/A==
X-CSE-MsgGUID: adibO7cMS/aOZM2T7a0Umw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104642530"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:51:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tXJuR-00000000SnY-2DT0;
	Mon, 13 Jan 2025 14:51:11 +0200
Date: Mon, 13 Jan 2025 14:51:11 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v6 2/2] serial: sc16is7xx: Add polling mode if no IRQ pin
 is available
Message-ID: <Z4UMP1-0x25g1fX2@smile.fi.intel.com>
References: <20250113073030.15970-1-andre.werner@systec-electronic.com>
 <20250113073030.15970-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113073030.15970-2-andre.werner@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 08:30:30AM +0100, Andre Werner wrote:
> Fall back to polling mode if no interrupt is configured because there
> is no possibility to connect the interrupt pin.
> If "interrupts" property is missing in devicetree the driver
> uses a delayed worker to pull the state of interrupt status registers.

pull ? Hmm...

...

> V6:
> - Use polling mode for IRQ numbers <= 0 which encounter no valid IRQ
>   were found/defined.

Thanks, this part looks better now.

...

> +static void sc16is7xx_poll_proc(struct kthread_work *ws)
> +{
> +	struct sc16is7xx_port *s = container_of(ws, struct sc16is7xx_port, poll_work.work);
> +
> +	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. */

Period.

> +	sc16is7xx_irq(0, s);
> +
> +	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */

No period.

> +	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> +				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
> +}

Please, go through the comments you added in the patch and use the style that
is mostly used in the driver for the similar (one-line comment) situations.

...

> +		/* Initialize kernel thread for polling */

Again, no period.

-- 
With Best Regards,
Andy Shevchenko


