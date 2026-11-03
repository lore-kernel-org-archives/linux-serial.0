Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746470;
	b=1LwZkjCD1OCbY7NGbhWORbQixwBuXXjOjuKWf4KHZ24uGgonAA3rioTS5VtuBRK4m+nP
	 7Lenn3WoCHHFmN/lsEBWqzT9IVZ2rxH+xM4ryUG/zH55q0PED8ARhpAPbtYPKQnP8SSOp
	 /pW2dmQN91jqemGb4S6CJBKGuTwDULm/gePOiKbPu4YUoRrimU7+RMLDvnnBYMpGPEIJY
	 6LzOW5JwhoCaZTlivhF+Jp6dx8vqmZ3dCTfPLpiPabtlavRe8JWIksrEGnsqKsWZQDcxH
	 1Q2BInq+0rCtjAbg0bDQtnTvaayTUMvk+HRL4eXQr+WyPyl3vG6uDcOLRDeVkjoVAgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746470;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=w3oiCq1SMVsjy0c0EBauveDiKsugH8sreTHeU8+sTtc=;
	b=qm/VH/Lq5m4gm4ATj3Ljmj/Ml44FTJSkE3q7WZUHPtzXhm+IuVyCw1+9Zthb4hSxd4mE
	 aIIwVc1daznEzPSvYCUIbN3IsfYV4z7CAuDwQintlpw50dWHGqFEYWDRnKrciPxGkcDuu
	 Y39yqd8/8rXThfLiB1QxJiHp4AJ7hnt9rUQLtVmIJbvG9YrSaNEAeDbhebgiLUUn2NzvM
	 GvJwbkcA6QPsHE/qKrWHcc/eXcWm57+c9r3PGCb8QCZoHu9miFgbcsTZiS3TBAMLCkGmY
	 7tBHkdiCA7YQxn0BsvOy0LDhP/fpg6Y9NPEYw0GE7yFG5EIY/Y37BtH5wtSpAAZQqnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WwFee3lz;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADF606A326;
	Tue,  3 Nov 2026 22:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FADF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WwFee3lz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793746470; x=1825282470;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nDnp/Y+a8TCuPERecuvexpWS6HE8WyH+EY6mbwysYp4=;
  b=WwFee3lzgkQoL6NRYY31ofD/QM0t18b3HR/ieS412ePFFG1kut3PZE+r
   mO9h/fE/j2HDcLlOmB9ZpgS2+oUFmsIuSI7jT6RbB+9ETLFvqUPap9J+Z
   sSznszk/2Y2BYuWurlTTsW/hzWD7ZhGr6htPtgbPLgpCxitHYTCi86QJF
   cdbQcYqWHTZz0AxtANfhyJkqoPQ6yPeWBVajbzYuc1zZNWtU3uROjrWHa
   DSrO+/ccLN4tJejGcpIZOpMQX6792xpuUP9gthM+GsuoWeceVogd8u5Kd
   eDHA+3LtPI/yGU4cx7cl0cJyXT3zMBMYv0rzRCeq+Wo/92JfB86SF78nQ
   w==;
X-CSE-ConnectionGUID: PNIxtAV1Ruqc/TVtyl02ig==
X-CSE-MsgGUID: gvVAxyfbSJuWCxWk6V8QcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2502800"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2502800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 14:54:29 -0800
X-CSE-ConnectionGUID: mZVonL2WRzidEAnxKAtNbA==
X-CSE-MsgGUID: bWBGoSvYR7KRBrNVQ8whbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6877328"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 14:54:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Nov 2026 00:54:21 +0200 (EET)
To: Frank.Li@oss.nxp.com
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
    Haoxiang Li <haoxiang_li2024@163.com>, Zhaoyang Yu <2426767509@qq.com>, 
    John Ogness <john.ogness@linutronix.de>, 
    "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
    "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
    "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>, 
    imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH 1/1] tty: replace chan->device->dev with
 dmaengine_get_provider_device()
In-Reply-To: <20261103215949.1827937-1-Frank.Li@oss.nxp.com>
Message-ID: <4bf08ed3-724f-794a-93a5-87a20569768f@linux.intel.com>
References: <20261103215949.1827937-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Nov 2026, Frank.Li@oss.nxp.com wrote:

> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c   | 2 +-
>  drivers/tty/serial/8250/8250_lpss.c | 2 +-
>  drivers/tty/serial/8250/8250_mid.c  | 2 +-
>  drivers/tty/serial/pch_uart.c       | 2 +-

Please split to 8250 and pch_uart.

>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index eca02e8bd6d13..9adaf5b5fbd56 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -530,7 +530,7 @@ static bool dw8250_fallback_dma_filter(struct dma_chan *chan, void *param)
>  
>  static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
>  {
> -	return param == chan->device->dev;
> +	return param == dmaengine_get_provider_device(chan);
>  }
>  
>  static void dw8250_setup_dma_filter(struct uart_port *p, struct dw8250_data *data)
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 7e88f2b793b5a..eed37e8b3e831 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -269,7 +269,7 @@ static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
>  {
>  	struct dw_dma_slave *dws = param;
>  
> -	if (dws->dma_dev != chan->device->dev)
> +	if (dws->dma_dev != dmaengine_get_provider_device(chan))
>  		return false;
>  
>  	chan->private = dws;
> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
> index 44b43163df511..dfd2460983fab 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c
> @@ -252,7 +252,7 @@ static bool mid8250_dma_filter(struct dma_chan *chan, void *param)
>  {
>  	struct hsu_dma_slave *s = param;
>  
> -	if (s->dma_dev != chan->device->dev || s->chan_id != chan->chan_id)
> +	if (s->dma_dev != dmaengine_get_provider_device(chan) || s->chan_id != chan->chan_id)
>  		return false;
>  
>  	chan->private = s;
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 9505d255f09c5..6d9a88149b407 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -656,7 +656,7 @@ static bool filter(struct dma_chan *chan, void *slave)
>  	struct pch_dma_slave *param = slave;
>  
>  	if ((chan->chan_id == param->chan_id) && (param->dma_dev ==
> -						  chan->device->dev)) {
> +						  dmaengine_get_provider_device(chan))) {

Did you even read this patch yourself? Probably not... :-(

The line should be (very obviously) split at &&

-- 
 i.

