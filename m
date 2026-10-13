Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774F2E2840;
	Tue, 13 Oct 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876805; cv=none; b=FapMFY4COrPsZluxXBD5WvUGKfJ56KHnqw/wZ6ktl2n9pC8kwODsdI5DnDrUcDZfE6fRftdL1KRPUxS7WHoBpFloKUVgIixvbrQgmSCvEv6sS0AolnDTncPlsiyzB/CkAEmfA2ecklCvj7Bu1tFdfQVG+SnJaN4qUEQnvyftUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876805; c=relaxed/simple;
	bh=NzspRS2hDrJsjAe8AK0YYi1dL16p14T9VINuEY50WDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guQOTuYPF2XXlDbzvsSzi66z+A8/R8OkOp68jy33FdqQayoHnM2MHQEwGaQLxAncVovwGnpw0y848TZI9fVMtmixx3R+ZcRyxd4iMBN2FGncGf0vfp1/szOjSfA7wHjG1KYQxP2nkC37dWV9wb/eAXzR6XFZ5ghqirRrllvPFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFRfs8gF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFRfs8gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791876802; x=1823412802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NzspRS2hDrJsjAe8AK0YYi1dL16p14T9VINuEY50WDA=;
  b=bFRfs8gFtJYPRvsEwQnkjIiT6kZygTHZrKXXIbugGiOQQnYj3Sep/8+l
   s99BKD7zOaivQFrXhQ6N9zm0o9uS/u6i9E84L/uZ+Dc+VAfCxUOUCpOSY
   DFIT4XEYsVSHdoVJO+1A3HRKDs618nMZKQdSkZYOwmnPEE8dhQ/kDCBEv
   zSuyuIOmDB73AULfA9AvKUeNxIQ1j2swOeD5JHCEvx+m/2/02TfSgGpEp
   oRmLmw3nnEnhVRv3UpHlievPG/4ujN9mmPLTh9W9HJfhLMB8Uh7H2wl/A
   xTBEyw41v2vuINTqixuzSJirhZSuOAb1W22TDuXczU8O2n9POxroZuYMr
   A==;
X-CSE-ConnectionGUID: hwEWDvBWRJSi02AGJCO0Sw==
X-CSE-MsgGUID: 9lZRQQh5S7GeTT4VtmO1yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="466071"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="466071"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:33:21 -0700
X-CSE-ConnectionGUID: xXh+qmemSsK620RE9vOEtA==
X-CSE-MsgGUID: vIyL18cTQ/SYvrImMz4a5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1193790"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:33:13 -0700
Date: Tue, 13 Oct 2026 10:33:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as3etnbZatn4sbfx@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:
> serial8250_register_8250_port() returns a line number and the other
> port operations (serial8250_unregister_port(), serial8250_suspend_port(),
> serial8250_resume_port()) accept it. Many drivers then convert the line
> back to the port using serial8250_get_port() anyway.
> 
> Switch the interface to struct uart_8250_port:
> * serial8250_register_8250_port() now returns the registered port, or
> an ERR_PTR() on failure.
> * serial8250_unregister_port(), serial8250_suspend_port() and
> serial8250_resume_port() accept the port.
> 
> Convert all users accordingly. Drivers store the port pointer instead
> of the line number. Several drivers kept a private struct only to hold
> the line (airoha, dfl, em, fsl, ioc3); these are dropped and the port
> is stored as drvdata directly.
> 
> This also fixes two latent issues:
> * For a CIR port, serial8250_register_8250_port() used to return 0.
> Callers stored this as the line, so a later unregister/suspend/resume
> operated on ttyS0. Now the CIR port itself is returned.
> * 8250_acorn checked ports[i] > 0 on removal, so a port registered as
> line 0 was never unregistered.
> 
> There are no more users of serial8250_get_port() outside of the 8250
> core, so drop its EXPORT.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>

Why not having Ilpo's Cc in the below list?

> Assisted-by: LLM
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Cc: Thierry Reding <thierry.reding@kernel.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org

> [v2] include err.h (Ilpo)
> ---

...

>  	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
>  	for (i = 0; i < __PORT_COUNT; i++) {

What about

		struct uart_8250_port *uport = bp->port[i].uport;

here and use it accordingly in the below code?

> -		if (bp->port[i].line != -1)
> +		if (bp->port[i].uport)
>  			seq_printf(s, "%7s: /dev/ttyS%d\n", ptp_ocp_tty_port_name(i),
> -				   bp->port[i].line);
> +				   bp->port[i].uport->port.line);
>  	}

...

>  	for (i = 0; i < __PORT_COUNT; i++)
> -		if (bp->port[i].line != -1)
> -			serial8250_unregister_port(bp->port[i].line);
> +		if (bp->port[i].uport)
> +			serial8250_unregister_port(bp->port[i].uport);

Since it takes a pointer now, make it error pointer and NULL-aware

	if (IS_ERR_OR_NULL(...))
		return;

there. With that being done, all this redundant NULL-checks will gone.

...

> static void serial_card_remove(struct expansion_card *ec)

>  	ecard_set_drvdata(ec, NULL);
>  
>  	for (i = 0; i < info->num_ports; i++)
> -		if (info->ports[i] > 0)
> +		if (!IS_ERR_OR_NULL(info->ports[i]))
>  			serial8250_unregister_port(info->ports[i]);

See my point?

...

> static int aspeed_vuart_probe(struct platform_device *pdev)

>  	if (of_property_read_bool(np, "auto-flow-control"))
>  		port.capabilities |= UART_CAP_AFE;
>  
> -	rc = serial8250_register_8250_port(&port);
> -	if (rc < 0)
> +	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
> +	if (IS_ERR(uport)) {
> +		rc = PTR_ERR(uport);
>  		goto err_sysfs_remove;
> +	}

You can get rid of these {} by using PTR_ERR_OR_ZERO(). Also do not define
variables in the middle of the code (it's only allowed for auto cleanup
variables and for-loop iterators).

...

I stopped here, I believe there are many similar cases which may be amended in
the same way as pointed out above.

-- 
With Best Regards,
Andy Shevchenko


