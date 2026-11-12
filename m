Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500918;
	b=np7pZTEN1rM7LluNBCQmjzM2dEu69AA1FsjhhrV/eY0GsXdaWDu2O9ALIH8kD2Zyh/oC
	 nkqi4JizEG8o9rLPiALs/41UWG7vTIPYd9JjzO2/L5pMyEQAxcZnpw55aQXznzXPVhS4K
	 sDZXzVWdx0Kx1Wc8lFEAsF6Xjo9a7vGIOeXsW4w7jBkCMWXiZYC2bARK9jbPe0XjjFwQl
	 oyv8lvXzw/fy1pzNp1Md14raT3LsKsa6sK+LUruz3WCJ+iSwtRWdkaBVO+5INOVHcl8j9
	 CAmno6uxdg8UNUp0NZirDE44aHiN70TeNHXXD7nE4jRI8NXGGLH+3AWbMNSneoWJtIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500918;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pRpWiPIA4DrUOnjtuQAu5NcMUWFxkdWpzhrlxObt3ug=;
	b=aMuv48Kl0GXhEr2/7ig9sxhJIWaT4pAMOLfCrY2KfyPKV+fm0B7iQCAn3O+2pq0UB9xe
	 WyNFOgoBYyEm/hUl5pMlzTxW27FEcpMgXzQOjH5PHBNKMh1YCs2UR+ndbMB9mEXwGuKtq
	 l1y6NQAM49qaaKFwmoyQKRatyDJ/MiQuAgzKFmLN5iXUgoI+0zwlzZxh38sPeozfgE99j
	 4eeGS91fbaLiirTgiKbvxEzmuRq6cRhX2KBgqb2Y22JakYYYUw1iN+MHjQI/0bi331jyN
	 rg7ii8cslVUJVDCl4MeonKat7YgbTKlEjGVO4Bk9241mYaFLyu4sYXurp812C+WvQ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qqlp4DLQ;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C1606A338;
	Thu, 12 Nov 2026 16:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D7C1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qqlp4DLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794500918; x=1826036918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sslNQ9t4xM278pmgtdvt48t5+fW2uzyCfGO3Z4539zQ=;
  b=Qqlp4DLQVlapsQ1N4Az79SimbuizhLR43Lpct95Mx0xggqv/8FYaQc8m
   95SOXLwXcxYt1sf7wNbl9Ml0h6bbuMj/r61aws2vG1gOK3H2LnAA7ZMUl
   ahDg/EBwkJNzklI8Ll2ruFvPBQ9HMJgaZ34mnUMzCDubXJOmuFjqp/Xnd
   1n4fBas5PlCMazX8aPD0VAplEZklu0ey1XIBP0aEx6vrOYmj+91Oj0/Q5
   7l72h3R2BirqZTRbH7FET1EMM96Tgkwapv2rOKHj6nBr4Gm0EUnaSR0mK
   /HuYzeOdoc2YQY0Xzz1GYhkkFbLb7L6M0VNm7yJCeb/YZi+E3KLhG7Gr3
   w==;
X-CSE-ConnectionGUID: 9NiDF47tSVKBCgeIf7rmVg==
X-CSE-MsgGUID: rNzkPZRpT46twDoKUeScfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3328549"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3328549"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:28:37 -0800
X-CSE-ConnectionGUID: QwynKHKvQhyg7yRdcyHipg==
X-CSE-MsgGUID: wXpMW8M6QPu66Rlr12+fkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8613701"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:28:30 -0800
Date: Thu, 12 Nov 2026 18:28:27 +0200
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
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 8/8] serial: 8250: retain DMA resources when
 termination fails
Message-ID: <avXpK70Fh7kkJGOg@ashevche-desk.local>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-8-9e3456bc2555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 03:16:33PM -0700, James Hilliard wrote:
> serial8250_release_dma() ignores the return from dmaengine_terminate_sync()
> before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
> the channels. If the provider fails to stop a channel, the DMAengine
> wrapper returns the error without synchronizing its callbacks. Hardware
> or a detached callback can then access the released storage and state.
> 
> Checking the error and returning early would not preserve their lifetime:
> serial core frees the TX FIFO after the driver's shutdown callback returns,
> and port removal can then release the callback context as well.
> 
> Require successful synchronous termination of both channels before
> releasing any DMA resources. Retry failed channels after a sleep outside
> the port lock, leaving channels that have already stopped and drained
> alone. Keep the shutdown gate and storage reservation in place throughout
> the retries.
> 
> Start retries with a 1 ms sleep and double it up to one second. This
> makes short-lived failures responsive while bounding sustained retry
> activity; neither delay is a hardware timeout. Report the initial failure
> and ongoing failures with the elapsed time and current RX/TX error codes.
> Track the five-second progress-report interval separately for each
> teardown, so failures on different ports are reported independently.
> Report recovery once both channels have stopped and drained.
> 
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.

...

> +static void serial8250_terminate_dma(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +	unsigned int delay_us = 1 * USEC_PER_MSEC;
> +	ktime_t start, last_report;
> +	int rx_ret, tx_ret;

> +	rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +	tx_ret = dmaengine_terminate_sync(dma->txchan);
> +	if (!rx_ret && !tx_ret)
> +		return;

Why not check these already in the loop? See below.

> +	start = ktime_get();
> +	last_report = start;
> +	dev_err(p->port.dev,
> +		"DMA termination failed: RX %d, TX %d; teardown blocked\n",
> +		rx_ret, tx_ret);
> +
> +	/*
> +	 * Shutdown cannot return while DMA owns storage or callback state:
> +	 * serial core frees the TX FIFO afterwards, and removal frees the port.
> +	 * Retain both channels and retry outside the port lock. A permanently
> +	 * failed DMA engine therefore prevents teardown from completing.
> +	 */
> +	while (rx_ret || tx_ret) {

I believe with refactoring this to do {} while () we may deduplicate
the dmaengine_terminate_sync() calls.

> +		fsleep(delay_us);
> +		/* Retry promptly at first, then limit sustained retry activity. */
> +		delay_us = min(delay_us * 2, 1 * USEC_PER_SEC);
> +		if (rx_ret)
> +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> +		if (tx_ret)
> +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> +		if (rx_ret || tx_ret) {
> +			ktime_t now = ktime_get();
> +
> +			if (ktime_ms_delta(now, last_report) < 5 * MSEC_PER_SEC)
> +				continue;
> +			dev_err(p->port.dev,
> +				"DMA termination still failing after %lld ms: RX %d, TX %d\n",
> +				ktime_ms_delta(now, start), rx_ret, tx_ret);
> +			last_report = now;
> +		}
> +	}
> +	dev_info(p->port.dev, "DMA termination recovered after %lld ms\n",
> +		 ktime_ms_delta(ktime_get(), start));
> +}

-- 
With Best Regards,
Andy Shevchenko


