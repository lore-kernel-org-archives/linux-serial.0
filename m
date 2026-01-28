Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A556350A3B;
	Wed, 28 Jan 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608099; cv=none; b=mlE3SzxNmFCRSDs27ae72e8qxrojQS7T7Heb8Z2gtnJoTqt1vUCBocZdDRTtZxkOXTQItG4JJ1c3jjli+GFOc137RC/U4ic81cZfrVTeN1YdcarJwPMY+UE8oTbkfyXZAfZIN7rsbuB9cV5RPYXPgsMZV/7RUKcBDbHkqplB9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608099; c=relaxed/simple;
	bh=FTvsB5NGt2ZWSYyU0/IXfVomX+AZ5gSkMwu8t9YWhgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QswdulhyHkmqmTD1yxO2mTQS5ZEI3c7kSl9j0c2ZrYV87WgWPE03WhiiG0+4PH4SKIrNXojsHL3glmuzCBL3ILrZluJluLaPgB7uNQXK+5Kjb1L0hDMEoKGv+5ek90UNpW57LsIM6TJg3DI+Kss22rE11Hn3TltqyZqy+aBF3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyQOV6Ao; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyQOV6Ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769608098; x=1801144098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FTvsB5NGt2ZWSYyU0/IXfVomX+AZ5gSkMwu8t9YWhgo=;
  b=PyQOV6Ao4fTSTxxH3SAYL0+glH6RpZ+MrjeJDBFkM8K1afoAOeDe31cr
   X8XIos6J1cp9ErJRgC8PjQIlqjdWXFc2mJAuGWBiUSLCS33aGRrVzpCT8
   9RASlWyR9ts+eCalRRsqVoS2E8ur8ZKKG7n4kOFP+sdsr1BNZt/ZcDEiJ
   qUW4mAsi0AT/+tP4S6qaTCTdUWJf4kHSmdwuD2P7VqKzAvEIC1PBrVdyT
   dvjO6urty50mXO8UskjHT22hQ8EuUfD2epx2gTwspAfCir3kQDq1L/Qw9
   QcHIY3eStiOZTrtKUoL31BQiF/LTFhblw4pU5IdxCSjJ3mWSyx0dzI5d0
   Q==;
X-CSE-ConnectionGUID: HUqDsWPqR+q4kz8AjonFSw==
X-CSE-MsgGUID: IWZBjviHQbSJ3UVP0IZDEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81450262"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81450262"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:48:17 -0800
X-CSE-ConnectionGUID: AmwV0GqTQJOAVIrVPJ3BCQ==
X-CSE-MsgGUID: 3Kf1cWSzTze8AEi7D4WEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207510686"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:48:14 -0800
Date: Wed, 28 Jan 2026 15:48:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] serial: 8250_dw: Rework dw8250_handle_irq()
 locking and IIR handling
Message-ID: <aXoTnKJjwO5_GMoL@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 12:52:58PM +0200, Ilpo Järvinen wrote:
> dw8250_handle_irq() takes port's lock multiple times with no good
> reason to release it in between and calls serial8250_handle_irq()
> that also takes port's lock.
> 
> Take port's lock only once in dw8250_handle_irq() and use
> serial8250_handle_irq_locked() to avoid releasing port's lock in
> between.
> 
> As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
> lock, it has to be done already in dw8250_handle_irq().
> 
> DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
> collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
> (because & is used instead of ==) meaning that no other work is done by
> serial8250_handle_irq() during an BUSY_DETECT interrupt.
> 
> This allows reorganizing code in dw8250_handle_irq() to do both
> IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
> the logic.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	if (!up->dma && rx_timeout) {
>  		status = serial_lsr_in(up);
>  
>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>  			serial_port_in(p, UART_RX);
>  	}
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>  	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
>  		status = serial_lsr_in(up);
>  
>  		if (status & (UART_LSR_DR | UART_LSR_BI)) {
>  			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
			...
>  		}
>  	}

Looks like now (perhaps in a separate change) this may be refactored even more.

	if (rx_timeout) {
		status = serial_lsr_in(up);

// Although not sure about moving the above read out from the specific conditions.

		if (up->dma && (status & (UART_LSR_DR | UART_LSR_BI))) {
			/* Manually stop the Rx DMA transfer when acting as flow controller */
			if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma->rx_running) {
				dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
				dw8250_writel_ext(p, DW_UART_DMASA, 1);
		} else if (!up->dma && !(status & (UART_LSR_DR | UART_LSR_BI)))
			/* ... */
			serial_port_in(p, UART_RX);
		}
	}

-- 
With Best Regards,
Andy Shevchenko


