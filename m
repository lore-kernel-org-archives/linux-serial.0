Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5E2DCF55;
	Mon, 20 Jul 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574550; cv=none; b=eKPBlNa4a06a4N2mT8JIbRbGatvQEKhFuB1nUuGhd4/8MzjlmA7JVqiOOOI6ReI3CPZWc3yakYKTiFOCVxrLzuVE4tvX/k8lB67Qi3DqG4QiUICXQPhjOZqrR3J5HSlnpjCyojs6WFBDlZpaURHPAorPYQWQBdNnRso4F60O7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574550; c=relaxed/simple;
	bh=Jja7J22Oe3tdzLK3YHi7EfqKgfRAZxMrBjI6mK3+RqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTV2IjeH+et39NfBbTDCt07i+J1wDOqu7YjERsaDg03QQrU2DT9iyGNGoH58Z8GTCGT6EU0eICD/uHtaQ8Xy6jVRPtoWycD7QREQmmLRy2X0PrUIJ+MGgwtpYdkgr75dV4JvD4FY396ohNgiCTf8e/AGih4qI0g3hk9OMNmsA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXHvG5Ef; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXHvG5Ef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784574547; x=1816110547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jja7J22Oe3tdzLK3YHi7EfqKgfRAZxMrBjI6mK3+RqI=;
  b=PXHvG5EfG6Q5kUjM9uah55sKbV9o0w0w18fFhlTTamR8ZQ/PuDKLZeHw
   NT3VW0O5+KAfWOX4//NPfJlqH+MkRAahhAoWwmT+V7JrEq5jriJ61Ls31
   E3ayWDDG2TQS/QYyq+9bcg83CuocUPV8ZFNXaoONans3qpRTTXkBYY+yU
   ox2pv8sTbYWFHrDmXKscv7PpYNYUdhq3pUuQHzkruWE2JsTxGL+kYpfiD
   ob/uKLyDxEXeEe0Fwzlz+O7jeBORm30T89YMMfZobnIyKalKBKsjokvAj
   v4O4hvTirTaBFBITboSZFMO+jTttI7542RJlALvYQhR3O/iWliKfW8oa2
   w==;
X-CSE-ConnectionGUID: 60r6rkZaSLOViMkn5qEehQ==
X-CSE-MsgGUID: XVU/lz4eS9mAIVYiv34vHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96677059"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96677059"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:09:06 -0700
X-CSE-ConnectionGUID: JhjXkZhgQVS0jT4CJjqEzw==
X-CSE-MsgGUID: WNNhpQKKSdWnMVsKVRfPnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="280815833"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jul 2026 12:09:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CA94995; Mon, 20 Jul 2026 21:09:03 +0200 (CEST)
Date: Mon, 20 Jul 2026 21:09:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix compile error with hub6_match_port()
 when compiled as a module
Message-ID: <al5yTxizfIGibYZa@black.igk.intel.com>
References: <20260715153707.4181828-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715153707.4181828-1-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jul 15, 2026 at 11:37:05AM -0400, Hugo Villeneuve wrote:

> With CONFIG_SERIAL_8250_HUB6=m, we have the following compile error:
> 
>   ../drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of
>        'hub6_match_port'
> 
> Fix hub6_match_port() prototype definition by using IS_REACHABLE() to
> support both built-in and module values, and substitute empty prototype
> otherwise.

...

> +#include <linux/kconfig.h>

It's special header. It is always-included one, and hence here is a dup, please
drop this line.

-- 
With Best Regards,
Andy Shevchenko


