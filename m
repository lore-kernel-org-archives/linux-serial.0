Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105545;
	b=uPSEticeoVNm6Mg/9bXoCLyFvSWDIgZU4prhgjhk4uxI0sdmLanRl4T8ILu0t2euYvtx
	 d1QS1GdB+wHukGyihEOjcQzsbbqtSMOGbnQKvtCOBAo2tF8UbbMCwgw86y2clIB54YKmh
	 9mhHfJ7IRjZwlUwn7JcrixGjc8IArISlsorOecawtjpIzg+wrXod/q66FO/A9A/frPeDe
	 Yb8gGsvv/qAswIB3lUPEKN4byEBv88vspqgZGajLQmMN1OePq5aAKVN7HEDRREdu8FOl1
	 xQmBjrmosbx7J8mb+VH1P2h4dMtEYJQw8/N+EgpqQvWXPkdFEzvT/0U/U5u3Qa6mQ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105545;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=ynl4kyi4smNKu4WVF4RhIfR5dAfqlhGGue2tI306jGE=;
	b=TRCOLUlAM5rbbpI+FKS9vJoq+pGJeW9VobbyZJMzvR0sQ1VVrg6v/YuxGHwmxCH1JRcF
	 m3kHSasR6bTGvYWSlu467ZLlPY4Oy1le8PJ6WezCiB+T4GRQmIixU53mWdnv/Ddqry2Z+
	 lxzHh8kzdc838WeXLUSbswN9+x+fBc+GLBB9inwn6L59wZAshx7x9fuxCZeG0oRTFsqhX
	 jxNsoCh6U8s9OgECX1Xen3mVULRvwWHKSpJCjU+yIstApce9QK2oMBR+7TLqthfyrBIjP
	 +7fNqmSmvz419KZkqwR77y+4pFrsOFG0fG/QToo2sgwnXfbzs87JJvSsErhXPuMm6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jx2Bbg1+;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740F606A31A;
	Tue, 27 Oct 2026 12:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2740F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jx2Bbg1+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793105544; x=1824641544;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BIzV3OYv0D2CnjwPNDXm6UrunwFITB8qninSmEMQYOs=;
  b=jx2Bbg1+zvzJD4IcaJffJlUBmEliaWSD+dbggNFCQPhOrF7hp0rNBmDM
   OaZLZDlPfDFBZw2HrBkaQZmJcRSEtcyKB1ZpW+9YL21HHwEvJxI4n2Jag
   mOLCtx/k6lvEt5BOkc8mW8L6MCXCDwyjLCX5oqre+q31mCRF4Znm0Gozq
   h/wWk3yK2+uztTIjpZ2/TUq2gxTcN1vwdHwcIc0yuMx/DTuKIcYkeROX9
   CoF6Wti3fwIEYO2Zdkb5oDFhooaM4thDN0JanjqEQaxliOxoFIidSbiYS
   qJ7OawxhnD+/BsjwQTF+vrXpLjmukZIIBaop1LgBYRdIM5vwjQysBGEO5
   Q==;
X-CSE-ConnectionGUID: fFIxBpp6TNSqR2tmAkAXzQ==
X-CSE-MsgGUID: MPNw0JSpQBCQ/t9DAJBKBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1687537"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1687537"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:52:23 -0700
X-CSE-ConnectionGUID: K00W0eX6RlS216XLS/KgQg==
X-CSE-MsgGUID: m+9uZ6GYSrqDFqMYOHeI4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4538266"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:52:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:52:10 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    James Hilliard <james.hilliard1@gmail.com>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, Moteen Shah <m-shah@ti.com>, 
    Kendall Willis <k-willis@ti.com>, stable <stable@kernel.org>
Subject: Re: [PATCH 15/24] serial: 8250: omap: acquire rx_dma_lock in DMA
 completion callback
In-Reply-To: <20261027-tty-llm-v1-15-99b0202ae546@linuxfoundation.org>
Message-ID: <dbd0a484-7e1f-154b-fafe-acffd3bc4d4f@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-15-99b0202ae546@linuxfoundation.org>
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

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
> 
> The __dma_rx_do_complete() helper requires priv->rx_dma_lock to be held,
> but the DMA completion callback __dma_rx_complete() calls it without
> that lock, only holding the UART port lock. This allows a race between
> the callback and omap_8250_rx_dma_flush() which properly holds
> rx_dma_lock, leading to concurrent tty_insert_flip_string() calls that
> can corrupt flip-buffer state.

When the commit message mentions flush and buffer corruption, I 
immediately ask why James Hilliard needs so many lines to fix the flush 
issues [1] while this change just wraps one call with a lock?? I'd tend to 
think this change lacks most of the understanding for the relevant problem 
space.

I think this should be deferred to be part of James' series.

[1] https://lore.kernel.org/linux-serial/20261024-submit-serial-8250-dma-cancel-v1-v6-5-6f366591f566@gmail.com/

> Acquire rx_dma_lock around the call,
> matching the established lock ordering (port lock then rx_dma_lock).
>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Moteen Shah <m-shah@ti.com>
> Cc: Kendall Willis <k-willis@ti.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 07ebed6ac6c9..0afd648733da 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -975,7 +975,9 @@ static void __dma_rx_complete(void *param)
>  	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
>  		return;
>  
> +	spin_lock(&priv->rx_dma_lock);
>  	__dma_rx_do_complete(p);
> +	spin_unlock(&priv->rx_dma_lock);
>  	if (priv->throttled)
>  		return;



-- 
 i.

