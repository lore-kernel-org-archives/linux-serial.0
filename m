Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9A73445;
	Mon, 27 May 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827699; cv=none; b=EbReUTweh3lATSapZ9BcFqyfxcdTsiHWnOkb6aQvOA78yUAPmxQMW+QWYfNnQmVU8ReHFdjI3GSjxSpTQj27pJQKGVtCi9YID9snaOsc7keXVmrMNmCV0oMGXxFKwEylKgYfZVusqxnc7xqo1L9LjraDgkbS9O2BXWrDmZu5spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827699; c=relaxed/simple;
	bh=ihoIInyQ1nQiDRSMqX8qvdNjwykHb3a5VANVzbNeL2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zep60jjfD6IQK9e1JfONnYRN51nMlYSUZ2rykY4TplZ0hZ1hrgaSBstnp1YMXeHbYH6yEvuq6WsrE+zJcHSvENfSD8bjMQFfgdT2kFCH8+821RZLOX7c36PKWERLbBBvPp0LgbLgB2+u/6PuiM3CebJezxlASvzajnpolXS70DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIBZlm1g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIBZlm1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716827697; x=1748363697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihoIInyQ1nQiDRSMqX8qvdNjwykHb3a5VANVzbNeL2s=;
  b=KIBZlm1glDmVfLqocYrkpBc58Z/RGYX2e0H12pchJC7UJ6Qz3NAj7maA
   ShRpITJrpemgAOorEsaNcjwO0QBYxNoJDEFHoagSkOhlm7Z1qLtFpofxX
   KCCKYdAOzhrcrtr/tUlRL2QbcgC3kn2oHmDqyHtC3ZJLoFBcjF4uV6pDN
   0ncN5XrgzpiosWSYsjxQybOd7GQdT2E6I7cBJMEPJpQOi0wHh0EgPTGKT
   7y4uf9RztlI8Y+uKi2CowFOolpmlVv4Hn/h/iwfy/RV32UeGcvAvdCXqA
   iCEW/SFP11MPrC7MmrvUqzW0rjCjW6kvDSoc7tGCnL/K3DRJxhdYAOCgA
   A==;
X-CSE-ConnectionGUID: dpJul9EJSEOKtLFFAMMHzQ==
X-CSE-MsgGUID: cREq3zU+Q5yw1g6BHZ35uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38539789"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="38539789"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:34:57 -0700
X-CSE-ConnectionGUID: sy1SRhdXScqp6CFkYpsWWA==
X-CSE-MsgGUID: YCKghfLgR6Sw7Xfp8z9PKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="39213195"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:34:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sBdJA-0000000BK1x-46rD;
	Mon, 27 May 2024 19:34:48 +0300
Date: Mon, 27 May 2024 19:34:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] serial: 8250: omap: Support wakeup pinctrl state
Message-ID: <ZlS2KBTvhizdmow-@smile.fi.intel.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523075819.1285554-5-msp@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 23, 2024 at 09:58:18AM +0200, Markus Schneider-Pargmann wrote:
> UART can be used as a wakeup source for am62 from a powered-off SoC
> state. To enable wakeup from UART am62 requires a wakeup flag being set
> in the pinctrl.
> 
> If the device is marked as wakeup enabled, select the 'wakeup' pinctrl
> state on sys_off.

...

>  #include <linux/pm_qos.h>
>  #include <linux/pm_wakeirq.h>
>  #include <linux/dma-mapping.h>

> +#include <linux/reboot.h>

See below.

>  #include <linux/sys_soc.h>
>  #include <linux/pm_domain.h>

> +#include <linux/pinctrl/consumer.h>

Can we make some order here and put this before above pm_*.h or even earlier
according to the alphabet?

...

> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR_OR_NULL(priv->pinctrl))

Shouldn't we report an error to the user? I assume that NULL is for optional
pin control, otherwise it's an error state which at bare minimum has to be
reported.

> +		priv->pinctrl_wakeup = pinctrl_lookup_state(priv->pinctrl, "wakeup");

> +	devm_register_sys_off_handler(&pdev->dev,

No error check?

> +				      SYS_OFF_MODE_POWER_OFF_PREPARE,
> +				      SYS_OFF_PRIO_DEFAULT,
> +				      omap8250_sysoff_handler, NULL);
> +

-- 
With Best Regards,
Andy Shevchenko


