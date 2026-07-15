Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BF33DEE5;
	Wed, 15 Jul 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095830; cv=none; b=u8hfpab8oUBvarSAWAvxE1Cg0A+Q0dSYKmPG4rgDivI0Jl+11mhRniHDswi6Zcgq9rY0vVdsUzXWtONSwTojGxFg197iVaXksw7oUpndIgyg8m15Z9+Q2SCmqo2cwncjbZqBbASA868ePXbhpcqZyJZHV94uDiyqufsIPV5OyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095830; c=relaxed/simple;
	bh=r+LyLQnT+HkAihr1peF3MlBwSZ9bD0l73Zfz3IacvRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua7IIZBsQ+8jRfqOq5oYdGg4y1U5ldBhv4wmbdU+2YjbcSjNpywz9nNCSNyqfpXdQxf7/J37et9dxfV3Bs7ncV3/p3oEPpO7WSygZYbY01dRzJouu+UGuTnf85jYkgMj4z6NQNQm9YxLANpkA/NwQl7DsjKK0bqytNNgSUmtYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l79PhPDj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l79PhPDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784095828; x=1815631828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+LyLQnT+HkAihr1peF3MlBwSZ9bD0l73Zfz3IacvRI=;
  b=l79PhPDjr/3/yRs3w9J3yn3UcmQOxFeRRfXn4v9jQVy63IrIleIY8N7e
   w/uI8vX96GKEB5uSKzsel8hJi3/iN7OJhd/4M2Aco+BmVQoiUa1pFAjb6
   5BsX3BKNRDIbs4TXdgjQavGHaxR516bTAPNUOLqatrhhf4jb0VNQvPW89
   lsBP5c+W7uf6MP81GMy5u90NlTjpnqlybCVpST8zCT/Km5gaMKomkvGSR
   +fogMYe/XueN8WPpHLclD3brCTZ+THt1Zd8ppIpJT9XJz7MMQtOPUk+fg
   Id61A3B0Zlw2wsNKBWXHcCsOQ+oGsq8yfHiHu4QX86tel4bHlNeLm65AA
   g==;
X-CSE-ConnectionGUID: HS43QJ4fQeCuuwxs9epp9A==
X-CSE-MsgGUID: dIRmiQBGSJSv0tmkKExIxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95368024"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95368024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:10:27 -0700
X-CSE-ConnectionGUID: BM9PVe3eRXiQtL+PNoGs6A==
X-CSE-MsgGUID: JdHce72CRc+wZ4l1/+sMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="286147735"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:10:25 -0700
Date: Wed, 15 Jul 2026 09:10:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com, stable@kernel.org
Subject: Re: [PATCH] serial: 8250_mid: Fix NULL function pointer dereference
 on DNV/ICX-D/SNR platforms
Message-ID: <alckT06ko8sfvfMV@ashevche-desk.local>
References: <20260715030336.1512861-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715030336.1512861-1-yijiangshan@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 11:03:36AM +0800, Jiangshan Yi wrote:
> Commit b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected
> platforms") replaced the dnv_board setup and exit callbacks with
> PTR_IF(false, ...), which evaluates to NULL. However, the three call
> sites in mid8250_probe() and mid8250_remove() unconditionally dereference
> these function pointers without NULL checks, causing a NULL pointer
> dereference (kernel oops) on any Denverton (DNV), Ice Lake Xeon D
> (ICX-D/CDF), or Snowridge (SNR) platform.
> 
> Fix this by adding the missing NULL checks before calling the setup
> and exit callbacks.

Oh, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
but I have a nit-pick below.

> Fixes: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
> Cc: stable@kernel.org

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

These two Cc may be moved either to --to option of `git format-patch` or after
the cutter '---' line to avoid unneeded noise in the commit message.

...

> -	ret = mid->board->setup(mid, &uart.port);
> +	ret = mid->board->setup ? mid->board->setup(mid, &uart.port) : 0;
>  	if (ret)
>  		return ret;

Likewise the rest, this can be also wrapped to the if-condition:

	if (mid->board->setup) {
		ret = mid->board->setup(mid, &uart.port);
		if (ret)
			return ret;
	}

-- 
With Best Regards,
Andy Shevchenko


