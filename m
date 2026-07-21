Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54964386C1C;
	Tue, 21 Jul 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665970; cv=none; b=UP3C+Z7eNGFumdnyt5HYbajozv82JRlPSTtT6+E1aTqEwSqLiJDMGpqvwRkXdOFFR/NUofD9R1OS99uaufnqs2Y53K6/lHmteZvGelGN/BA5e2SI5+gFQm4Zs2uR37gB7tpV0XcRqU73WQxdcA4gNDKla/il2H9vkqfTg75rUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665970; c=relaxed/simple;
	bh=flQs7G0LDEXAroqqvBqOqtYdohyf02fQan/Rk4iAmj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhMaI+8Yr/wJ0enUSsUfI3qsK5lurv/3zXFex1Y5WXgbU+cscttQIBS+zI0O+4LnSsPKPS2Yj/BtxtAN7vczsPWqGD4CVXG/C4Xbn+J3QoXFx/NL+dmtYuaDfhFcLjtCp6vOHpuNrRL85rAPebQCIK8eaEym8WV9KtJRb2ZqS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ED/mJm85; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ED/mJm85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784665969; x=1816201969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=flQs7G0LDEXAroqqvBqOqtYdohyf02fQan/Rk4iAmj4=;
  b=ED/mJm85k2K54NknReMR9ALh1tGpB1P9JmjQ343hvgIH5JNKwWwLCWGY
   wzFedqsbhWnAFOrnM1fDA6Im/YDMp3QKABZ6su8Fq3Ud2WAhDgjR2xXN2
   JfNoCQPZZdywSYSDVNqzlQIKa87O1tInAwKBlRzKwTOvI7E9Q/tEfjptJ
   Jl8+sm454uVKXkmVH7MB4TlGxmfFIL7qFL8/70g8B7FtURVUPuEQ8faY9
   cZIS955xO0n/jSwgCXRCSKXJLZbJbtWGgV9+qF9yWlDPRlEG5re1yiDji
   3AUfiWW3kaqjBm8tzluutJDgmSbIjbgBN0vJpz582UnqQ0ayQ2+ii8Wyz
   Q==;
X-CSE-ConnectionGUID: FCbVT03BSGic1G7Mg+/dbA==
X-CSE-MsgGUID: I+K4SKUXT/a569zILYEr5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85482004"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85482004"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:32:48 -0700
X-CSE-ConnectionGUID: jxsnS0/TR4i7xbOeG0tkTw==
X-CSE-MsgGUID: DPTH11LHTbW9gOahyKqJTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257334518"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:32:45 -0700
Date: Tue, 21 Jul 2026 23:32:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: remove always included kconfig.h
Message-ID: <al_XalNETju4z81_@ashevche-desk.local>
References: <20260721144847.3728422-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721144847.3728422-1-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 10:48:32AM -0400, Hugo Villeneuve wrote:

> The inclusion of <linux/kconfig.h> in commit 7ab80d1e72431 ("serial: 8250:
> fix compile error with hub6_match_port() when compiled as a module") is
> unneeded as it's guaranteed by the build starting from commit 2a11c8ea20bf
> ("kconfig: Introduce IS_ENABLED(), IS_BUILTIN() and IS_MODULE()").
> Remove it here.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


