Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641C1C5F1A;
	Tue, 11 Feb 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267170; cv=none; b=m4RpSYhNPT+h/C84iCaP+O7q74h1nFooNbXLPs2CD4fcDTzFBomBi65MJDgfFc+gA1mJPHg2mNG/dfV1Dt+nCvOTSRrs0DrUp4+J7iHcK6JVa/MTgVwRljIHwxVqqjgaiTVl5YgNn3wARfqRQO5ndvtaGh+gO/4WryaZ3bidP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267170; c=relaxed/simple;
	bh=DLO3gAdQi9xbWTxavU80M4WLyMiGbkYfp6WmM/z8y+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FusMhO+tu3x1RbcFTKokFzAp3qcmRPdfgsjm75WSsR9TPeqJdqYz9FN1+xb8nks1X+HYowUBADq/SM0RuJ05cLsZEl2NmeHf+Bsfedg7UNp4jdTLgJEgjq7pWdfI5QQLhJxcKpgCUDLhvWkZfMhCt9WEQRoZvWeYwXU/3haQiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVEvtsg/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVEvtsg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739267169; x=1770803169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DLO3gAdQi9xbWTxavU80M4WLyMiGbkYfp6WmM/z8y+0=;
  b=NVEvtsg/ELIaHQcM6SNYj4Hp+tVXSZefpT+KM5JsEypyqW41xNouCosK
   78f+JSe+Mjrk937mNKZAsMVJz8qh1fTpx3kksZiWvX+4r4iwBvMVWPF9y
   HXFRAR7qUye3Pr7lOF10ZKCOGD4Q2eROef6fBchTyehhWiIrNHv7iabQK
   MHNyAkqff6ulTlvp0RlB1uoaRucd2gadl9Kt8ZZ4VzOSzlglY3gAGQHCG
   XSp10NU8BzvSTvB9RM0mvimBHDUlUV8zBu591O/LS1RWSmqIhnsdthl4y
   kfFIEuJ+kE/T/06sOv/Ve79xSdABifItKfSLf8yGScmTBpJ1Fty2ffazS
   A==;
X-CSE-ConnectionGUID: mbPHkfCYQ86cpsVPx9KyNw==
X-CSE-MsgGUID: +7YshAXQRV2D/Uqw4Yln3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40022210"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="40022210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:46:08 -0800
X-CSE-ConnectionGUID: s3i1o9lDSh+bvBecqAyJzA==
X-CSE-MsgGUID: 4i2gnADwQ56/aAvEv8T6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117071668"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:46:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thmq9-0000000ASde-2ZV8;
	Tue, 11 Feb 2025 11:46:01 +0200
Date: Tue, 11 Feb 2025 11:46:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kartik Rajput <kkartik@nvidia.com>, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hvilleneuve@dimonoff.com, arnd@kernel.org, geert+renesas@glider.be,
	robert.marko@sartura.hr, schnelle@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z6scWdm-vghMPy5S@smile.fi.intel.com>
References: <20250211061945.18836-1-kkartik@nvidia.com>
 <20250211061945.18836-3-kkartik@nvidia.com>
 <974ae61f-6883-40fb-b5b1-27139c0f07df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974ae61f-6883-40fb-b5b1-27139c0f07df@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 08:23:47AM +0100, Jiri Slaby wrote:
> On 11. 02. 25, 7:19, Kartik Rajput wrote:

...

> > +static irqreturn_t tegra_utc_isr(int irq, void *dev_id)
> > +{
> > +	struct tegra_utc_port *tup = dev_id;
> > +	unsigned long flags;
> > +	u32 status;
> > +
> > +	uart_port_lock_irqsave(&tup->port, &flags);
> > +
> > +	/* Process RX_REQ and RX_TIMEOUT interrupts. */
> > +	do {
> > +		status = tegra_utc_rx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->rx_irqmask;
> > +		if (status) {
> > +			tegra_utc_rx_writel(tup, tup->rx_irqmask, TEGRA_UTC_INTR_CLEAR);
> > +			tegra_utc_rx_chars(tup);
> > +		}
> > +	} while (status);
> > +
> > +	/* Process TX_REQ interrupt. */
> > +	do {
> > +		status = tegra_utc_tx_readl(tup, TEGRA_UTC_INTR_STATUS) & tup->tx_irqmask;
> > +		if (status) {
> > +			tegra_utc_tx_writel(tup, tup->tx_irqmask, TEGRA_UTC_INTR_CLEAR);
> > +			tegra_utc_tx_chars(tup);
> > +		}
> > +	} while (status);
> > +
> > +	uart_port_unlock_irqrestore(&tup->port, flags);
> > +
> > +	return IRQ_HANDLED;
> 
> You do not let the irq subsystem to kill this IRQ if you do not handle it
> above (in case HW gets mad, triggers IRQ, but does not set rx/tx flags).
> That is, return IRQ_HANDLED only when you really handled it (some status
> above was nonzero).
> 
> > +}

I am also wondering why _irqsave / _irqrestore? Don't you have interrupts
already being disabled at this point?

-- 
With Best Regards,
Andy Shevchenko


