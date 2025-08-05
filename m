Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150735959;
	Tue,  5 Aug 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432274; cv=none; b=BR7g6qb/tOk2+XoHPum+fZ4pziUwJKihibjWKQeGICUnrb5UDAg4O01qY7folisHN0tkkKuumNZcbyoN+MZ53eaZ06817wd/6GULieTe8at9C/+U9aDzQ5VfAbjtJYrN6eMo3g8dK7QrpETXhJoRoxsFM1lYuh8BzIDVn4HQNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432274; c=relaxed/simple;
	bh=JSNYl2q2aTB8tw37ueJi2WRO5B5U21Q8UtO3vzeWmEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQMKiClfR9tFjrg0k9oF5nHlMwFWsW7pwxxAcGYOxaZCDe0ucW1SRUiVqAj1afJ4rjb58LutppRkJ7zSKKc1kp3uH7DGylbBmn6ewJSn3Eia3Jr89kHRpjbJbZmxW42FWR72lAVuZStNx6Ie910MVgOJHvpD5n4Y6yYZjEPtNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3vlbc8a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3vlbc8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754432273; x=1785968273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JSNYl2q2aTB8tw37ueJi2WRO5B5U21Q8UtO3vzeWmEo=;
  b=Q3vlbc8aJmc31jYhhWj/e9FO1GUveRnRbcqoeExDmkB6o2EHCEyolbK5
   G697cGGCNYaL6tWMnRUMPWCk824m/ovGmZea0I9YMq2jhNs+HTWI1GmY9
   z22uyIVDFd2v0oXsjWLz1I4MDLN3+uofJYIZaUoBXj/P7yqI8unQMk7Hm
   QH6WZQDIgnsnVlYUs5VYo4J97TuLzXDdt5U6r10BVlTL8kqiV3lJTRnEH
   Ja5C7/oesHyx+Oac9sElz+lojXLLLNjwMFF+bYnQVnV+1w/yPQa8wgXyR
   IdcQsGgdvB/dChbNTQ800/YOPYBqPLIqppNWUENNxqUoI8u0ZTwGRIWz8
   g==;
X-CSE-ConnectionGUID: dTFPxnAHQ0ygPX1vcVqeyQ==
X-CSE-MsgGUID: 5K7+zzbTTvS8bQ5z6pFDvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67333355"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67333355"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:17:52 -0700
X-CSE-ConnectionGUID: TkEinqeNQva1No+t2fus9Q==
X-CSE-MsgGUID: O75CdWr+S6a0YfmRnEAz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165371456"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:17:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujPyc-00000003ro3-3g03;
	Wed, 06 Aug 2025 01:17:46 +0300
Date: Wed, 6 Aug 2025 01:17:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	sunilvl@ventanamicro.com, arnd@arndb.de,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in
 serial8250_probe_acpi()
Message-ID: <aJKDCjFyei1lRYxk@smile.fi.intel.com>
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 01:21:54AM +0530, Abinash Singh wrote:
> The function serial8250_probe_acpi() in 8250_platform.c triggered a
>     frame size warning:
> drivers/tty/serial/8250/8250_platform.c: In function ‘serial8250_probe_acpi’:
> drivers/tty/serial/8250/8250_platform.c:152:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This patch reduces the stack usage by dynamically allocating the
>     `uart` structure using kmalloc(), rather than placing it on
>     the stack. This eliminates the overflow warning and improves kernel
>     robustness.

...

>  #include <linux/platform_device.h>
> -

Stray change.

> +#include <linux/cleanup.h>

Please, keep it ordered.

>  #include <linux/serial_8250.h>

...

>  	struct device *dev = &pdev->dev;
> -	struct uart_8250_port uart = { };
> +	struct uart_8250_port *uart __free(kfree) = NULL;
>  	struct resource *regs;
>  	int ret, line;
>  
> +	uart = kmalloc(sizeof(*uart), GFP_KERNEL);

Just declare variable here, as the NULL assignment may lead to subtle issues.

> +	if (!uart)
> +		return -ENOMEM;

> +	memset(uart, 0, sizeof(*uart));

We have kzalloc() for this.


-- 
With Best Regards,
Andy Shevchenko


