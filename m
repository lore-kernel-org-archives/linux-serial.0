Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454573955F5;
	Tue,  2 Jun 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425471; cv=none; b=mqx8f0i6mHUpFK88X7vS/E1ji4rI9ghX6FUr67KKCHjsShJb7QDFP0EFQUuYc95O1CgoVls0bNZTGfZGnne47HufxhML4fVZB+K5WRYhi5FH4B/p3y0iyEXUh0myuWKokT2hqpDUMrDow2BC99yL0xm4oPFkditbqdUZiPwR658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425471; c=relaxed/simple;
	bh=oSlzuNRxLCw96L0gRiYu/TEh/Dvys+uVFiJOCzOE3II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Hz1DKZitsx4sDQkk3rNipAfNuvCYNbAssBRtSZMp+0sczfvHAhaSAPQIuxDjKZLITWKn+7sAqA9ozbVQgl5VmdS/1gSVmtN/TpsjIxAxVFCNUxPNP6ldHtJcs3NWmvdTR1cBsQgNFoqTDY4V9U3gJzTQkwVQScwPe7isi+q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efsznNMi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efsznNMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780425470; x=1811961470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSlzuNRxLCw96L0gRiYu/TEh/Dvys+uVFiJOCzOE3II=;
  b=efsznNMitQFE5HE7izzZufTWzhGmUfPUQ89/jhO9blvB+AkJvak2TIyo
   wYC3LHc8McpRi+sl/Vj8g87GylSICZl1bJgQOX8m8SsZ6X8zYoTn5ga9q
   f03ddE1S8R3zFBTDbPKVCJGsvkguvPYqiQ2DOVw9rRALtQw++W/jcvboo
   wgPl/yxyKIfNeRPSoSQ5F340+QyiFsOu5S+SHax6RFlp2bvsfHWY1RqRn
   NKqRrNh4RxsEqegw61sGhTVJpjPGztbuvFEzFFVr1xCR7GDxee1mqUyay
   34oow1j9U8K4mvYIVFEsAu8i9luq4eWtzQlgzyx3T9ZMQupNdQH7rlkUN
   Q==;
X-CSE-ConnectionGUID: 6doq9cfyS3W+Dn4tFEQhIg==
X-CSE-MsgGUID: lRp8uf68RmyjoespQ5Uj+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98642167"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="98642167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:37:50 -0700
X-CSE-ConnectionGUID: GAMrsk+BSx66MvFLuDcHvg==
X-CSE-MsgGUID: spRxZUHVSF6S+BoMGd0RJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="249058482"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:37:47 -0700
Date: Tue, 2 Jun 2026 21:37:45 +0300
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Matthias Feser <mfe@kbsgmbhfr.onmicrosoft.com>
Cc: Moteen Shah <m-shah@ti.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>,
	"msp@baylibre.com" <msp@baylibre.com>
Subject: Re: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Message-ID: <ah8i-aGuHTKcRpaA@ashevche-desk.local>
References: <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
 <BE3P281MB55155F2F5795E411F5A65282EE0B2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE3P281MB55155F2F5795E411F5A65282EE0B2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 26, 2026 at 07:35:09AM +0000, Matthias Feser wrote:
> On AM33xx RX DMA only triggers when the FIFO reaches the
> configured threshold (typically 48 bytes). For smaller bursts
> no DMA request is issued and the FIFO is drained by RX timeout.
> 
> In this case __dma_rx_do_complete() can legitimately see count == 0.
> 
> The current code exits early in this case and does not clear
> dma->rx_running, leaving the DMA state inconsistent. This can
> prevent RX DMA from restarting and may cause
> omap_8250_rx_dma_flush() to fail, marking DMA as broken.
> 
> Fix this by clearing dma->rx_running once the DMA transfer has
> completed or been terminated, even if no data was transferred.

...

> +	dma->rx_running = 0;
>  	if (!count)
>  		goto out;
>  	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
>  
> -	dma->rx_running = 0;

I'm wondering if this opens a window when dma->rx_buf may be rewritten (or
unmapped or something else) before tty layer has a chance to insert bytes to
its ring buffer. I.o.w. is this change synchronous to other threads?

-- 
With Best Regards,
Andy Shevchenko


