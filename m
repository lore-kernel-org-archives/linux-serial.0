Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C71468C26;
	Wed, 16 Sep 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556866; cv=none; b=Yx/m58eE2+GLLj0A5FywolhP4yEG0SGwOnFYvQjQH+Lyztk2rKhKBckU4IVkqkEZXy/01mFXyYJKaTYjeb5Ayvaf5DBWer/xFm09dPjW0bTfuIdnCzZ8JUte3W/U8SYDZnWEO94bbRxYNe5ZkROV8HhbNTmFnLww7CjOWpthYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556866; c=relaxed/simple;
	bh=6MyMFTYyqXiVc+zeIiupA0xmhMyyGJOE11wnLVfHtjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORa7Ae1Ewknvvbmkwb1k+lSUH+qgYXax/FFZhP6a3NgmZB494m2ShT4yRXGI/W929znW4Gj6fgCGufyhFRfTybpE1pL5MTRJYwnz+RCNNH6z9mtzb4Wty3KFo32ohhfCi4owlXfw8OBfdDFnN6gdDQuN9lz2TYd0i1utCdjy2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8roCR8v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8roCR8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789556852; x=1821092852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6MyMFTYyqXiVc+zeIiupA0xmhMyyGJOE11wnLVfHtjw=;
  b=a8roCR8vumsxiVyGzmsY+1JsAioMYMbFGyARDI7qXyelAXwRZXtckuT7
   H12HApsSEAVw3OdQZJ0efMdcEhiZwYWEf90BLC+Ph7vy+wNTDJGAvVUjw
   FjXKamNTWXUoYdC89pXA2HY/zcqkc4giV3am519yv2wKMG1LmibEcR8t1
   g+l7O11JAd8NlYxzMyt+Eu67LdhunnaXpFPWP9HsjwFXstXrLP0BZ/N2B
   8wlF9E+I2MKa7IzuvpkWQOQULWYLAnv/3Iy4bPjzFP9KOT9ZZMkslLlnM
   OIAGn4LF725UGHxQ0zVhvzh1VWgSW9jkKRmzmhwcrsb2TOGViaeHfkSuf
   g==;
X-CSE-ConnectionGUID: oi9K7smlTR2/ecEnc/MAjw==
X-CSE-MsgGUID: iGjbhy21TN2/YrWxWXHqog==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92437157"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92437157"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:07:28 -0700
X-CSE-ConnectionGUID: yma97Ag8RTmey/OQha+7TQ==
X-CSE-MsgGUID: dZZW5ZDQRvaQEgVXOGIE3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1709838"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:07:26 -0700
Date: Wed, 16 Sep 2026 14:07:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Malathi A <malathi.a2000@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: 8250_uniphier: Disable clock on probe error path
Message-ID: <aqp4a5YmwC1Lt1TL@ashevche-desk.local>
References: <20260916095438.20837-1-malathi.a2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916095438.20837-1-malathi.a2000@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 09:54:36AM +0000, Malathi A wrote:
> uniphier_uart_probe() calls clk_prepare_enable() on priv->clk before it
> reads the port properties, but returns directly when
> uart_read_port_properties() fails, leaving the clock prepared and
> enabled.
> 
> The intent is clear from the surrounding code: the next error path, when
> serial8250_register_8250_port() fails, calls clk_disable_unprepare(), as
> does uniphier_uart_remove(). Add the missing call so the early failure
> behaves the same way.
> 
> Found by smatch:
> 
>   drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 205.

Why not using devm_clk_get_enabled() instead?

-- 
With Best Regards,
Andy Shevchenko


