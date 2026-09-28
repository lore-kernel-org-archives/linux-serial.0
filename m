Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3D48C41A;
	Mon, 28 Sep 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585510; cv=none; b=V6mtUz9SCdMIlc9jTZmlI+ntfpYQm+LB2iO1VsndpuQy/QGfphP//iTabDLjmEh3P+ZUUafRlW1IsbQN24+iInqoN1WBjJv7YG+oX9GYk3KvWoLbO+kriRqyubzuSiA/mOkB4lp5DvplUiD82ZHttezf0dNDhokExgA6hf3KUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585510; c=relaxed/simple;
	bh=3vZcqVmSQEMWNm/6wA8Q5+WJp4wzHqrnz/xnjrdBwVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJpwdHuk0UfzCGtV5th5BWWV0BAPvq+F6K2qqXehgH5OVZAa+hhDNJROwisKL8QL/fZCJJiUVVsA3xglCe9jifwgQ6WOzMi6yuz4EHiYdQoC3rctXbqoWNqKKqDcD7JKbSec69lm4HcT2QcutBC6xGR1CrF5tkl4gKQdgjQUJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMEynwQy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMEynwQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790585508; x=1822121508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vZcqVmSQEMWNm/6wA8Q5+WJp4wzHqrnz/xnjrdBwVI=;
  b=QMEynwQyTtzcaiRIlAhRfZYc/pTF1W/Aa4dzt+ZC5HNA917T+jOavITE
   3KBC3c+cfSvR3yGUUGWdN0Gyf/TF5IhvSOhkmkPkEkNsd4fMqYdTWHrNJ
   kfc8Lk94Sg0rR8+g8TLEfJFqgFy8SFTI2QlNEOkhC4JNK3B2zFyUFwQ+J
   LxWCim3GgpwgxKmIaYyX6EZqlPRCKvHj/CEAoLH8RNz976l2rywFTIhqP
   tbFs8Xd+wPrZtqxTmXn5q8yICKMEdyvvhc16i/nDWK5kAbiRE2iBXvJi5
   b6Xf+DAQgOlSs3E9PMWBoRU4NWh88ZhcpudN4iznzzlf08pmTuBLkC3AF
   w==;
X-CSE-ConnectionGUID: 6n6ZwcuqTL6Q4U1tN9TxtA==
X-CSE-MsgGUID: iii3wMnYQUKMdoXx28XDdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90406437"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90406437"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:51:47 -0700
X-CSE-ConnectionGUID: /8MRxcd/TbC4s+EB6M7Flw==
X-CSE-MsgGUID: lQNZ3QzeRLW2dSSQDoL8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301275483"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:51:39 -0700
Date: Mon, 28 Sep 2026 11:51:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Cunhao Lu <1579567540@qq.com>, Frank Li <Frank.Li@nxp.com>,
	Raul E Rangel <rrangel@chromium.org>, Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>, Dhruva Gole <d-gole@ti.com>,
	Matthias Feser <mfe@kbsgmbhfr.onmicrosoft.com>,
	Kartik Rajput <kkartik@nvidia.com>, Fan Wu <fanwu01@zju.edu.cn>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger@gmail.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Zhaoyang Yu <2426767509@qq.com>, Kees Cook <kees@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>,
	vkoul@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] serial: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <aroqmVWSPd9YVDjM@ashevche-desk.local>
References: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 04:08:30PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API
> 
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
> 
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.

...

>  	/* RX buffer */
>  	if (!dma->rx_size)
>  		dma->rx_size = PAGE_SIZE;
>  
> -	dma->rx_buf = dma_alloc_coherent(dma->rxchan->device->dev, dma->rx_size,
> +	dma->rx_buf = dma_alloc_coherent(rx_dev, dma->rx_size,
>  					&dma->rx_addr, GFP_KERNEL);

Now one parameter can be moved up and positive outcome the split becomes logical
(on a logic boundaries).

>  	if (!dma->rx_buf) {
>  		ret = -ENOMEM;

...

>  	/* TX buffer */
> -	dma->tx_addr = dma_map_single(dma->txchan->device->dev,
> +	dma->tx_addr = dma_map_single(tx_dev,
>  					p->port.state->port.xmit_buf,
>  					UART_XMIT_SIZE,
>  					DMA_TO_DEVICE);

You can fix indentation while at it.

> -	if (dma_mapping_error(dma->txchan->device->dev, dma->tx_addr)) {
> -		dma_free_coherent(dma->rxchan->device->dev, dma->rx_size,
> +	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
> +		dma_free_coherent(rx_dev, dma->rx_size,
>  				  dma->rx_buf, dma->rx_addr);
>  		ret = -ENOMEM;

...

>  	/* Release RX resources */
>  	dmaengine_terminate_sync(dma->rxchan);
>  	dma->rx_running = 0;
> -	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
> +	dma_free_coherent(dmaengine_get_dma_device(dma->rxchan), dma->rx_size, dma->rx_buf,
>  			  dma->rx_addr);

And here the last parameter of the previous line can be moved to the next line.

...

> +	db->buf = dma_alloc_coherent(dmaengine_get_dma_device(chan), PL011_DMA_BUFFER_SIZE,
>  				     &db->dma, GFP_KERNEL);

^^^ (1)

>  	if (!db->buf)
>  		return -ENOMEM;

...

>  {
>  	if (db->buf) {
> -		dma_free_coherent(chan->device->dev,
> +		dma_free_coherent(dmaengine_get_dma_device(chan),
>  				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);

Perhaps you want both (1) and this be consistent, either (1) be rewrapped,
or this one

		dma_free_coherent(dmaengine_get_dma_device(chan), PL011_DMA_BUFFER_SIZE,
				  db->buf, db->dma);

>  	}

...

>  	struct pch_dma_slave *param = slave;
>  
>  	if ((chan->chan_id == param->chan_id) && (param->dma_dev ==
> -						  chan->device->dev)) {
> +						  dmaengine_get_dma_device(chan))) {

Even original code has broken indentation. What about rewrapping it?

	if ((chan->chan_id == param->chan_id) &&
	    (param->dma_dev == dmaengine_get_dma_device(chan))) {

>  		chan->private = param;
>  		return true;

-- 
With Best Regards,
Andy Shevchenko


