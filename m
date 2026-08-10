Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A75436BF4;
	Mon, 10 Aug 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385880; cv=none; b=RTuIWrEaIpB+xQcmeBQChpu1SvoPyrDH1fmu0lFaSem9tc5JmYwjVxEAZgmjGi9ZF16OG9P40JVSv1HyMfy+4KO/f8+Bqn+U2Xm7sZx7RBArC8yB2RSmCNPjSAkEUbu4PnXvL/l4I0KmbW7cJ0JDsWBzxIG8n9Rflf1D8dKiJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385880; c=relaxed/simple;
	bh=VgAeIZXSeTAkar+huAlc0BALXMGa3XOG9jpCQ0QA2e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5dQT9MUFCBam2uu+4UPwoDM1C4YWcJWb4mSPaXeYt9CIgq+CvDZ5/0IrhTYhcpTMoIKj3aNiOeA/c6IvIalmwJV9zJAZxP64bAov2GoWYPQ+l/muzqyqHkrb4RcqZZriJDDmcG5Z/tv42aDrJTuhliIoJNoZisuJJ/2tlRsdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtorT4kn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtorT4kn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786385878; x=1817921878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VgAeIZXSeTAkar+huAlc0BALXMGa3XOG9jpCQ0QA2e0=;
  b=OtorT4kn1UC4W9Dw3lOXjXXZWMmJSh2DpEN0/0Rvf8xALXtlfKuU9iVp
   hrgpmqx5YfHRKnR7x/abnDO+OTXg02p2MvQ90RYzOHE43NtLbSjAYQQTJ
   7GyV4pQjdbdnUJ+jOE62rKFA0uFsGwW/S+gJ+CsV77DGgVdd5ZZeZeYVj
   jsl52tI/m6YyXejDd3yjmLdKlCItbT1IbNp8aQLj7jDNGq9vDBoGMbFDi
   B4RSwEch7dCGOG4OAO9I+xrlWjet8dBiI2NpgMedPj/0op/jbshTY8Ovh
   L+2FtwEfyX+3OWaaEW9JiFyNTsL12hkxJ1ApdjQ+CfhSANRm0P9iIieOQ
   Q==;
X-CSE-ConnectionGUID: WqnTpMOER5WSiDyveqn/2w==
X-CSE-MsgGUID: 4CR9zk5PSJq9dlEOypLCaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98426795"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98426795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:17:58 -0700
X-CSE-ConnectionGUID: dOjiaqGZTCqMx2WPIE/ARw==
X-CSE-MsgGUID: /iamwLxURdaq63aE9PNxgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="263161748"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:17:55 -0700
Date: Mon, 10 Aug 2026 21:17:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?utf-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tty: serial: 8250_dw: Keep init pinctrl state
 until first open
Message-ID: <anoV0K_Xk19DsDlI@ashevche-desk.local>
References: <20260810130635.1166626-1-mkmkl@google.com>
 <20260810130635.1166626-3-mkmkl@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810130635.1166626-3-mkmkl@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:06:35PM +0000, Michał Kardaś wrote:
> When a UART port is connected to an external peripheral whose power
> domain is kept powered off until first use, transitioning the UART
> pins from the "init" state to the "default" state prematurely at probe
> completion can cause parasitic back-powering into the unpowered
> peripheral.
> 
> Ensure that on boards specifying an "init" pinctrl state for the port,
> the "init" state is preserved until the port is first opened:
> 
> 1. In dw8250_probe(), call pinctrl_keep_init_state(dev) to opt out of the
>    automatic "init" -> "default" transition at probe completion and record
>    this in data->in_init_state.
> 2. In dw8250_do_pm(), when the port is opened (state == 0), transition
>    pins from "init" to "default" if data->in_init_state is set, and clear
>    the flag.

...

>  dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
>  {
> -	if (!state)
> +	struct dw8250_data *d = to_dw8250_data(port->private_data);
> +
> +	if (!state) {
>  		pm_runtime_get_sync(port->dev);
> +		if (d->in_init_state) {
> +			d->in_init_state = false;

Mistyped assignee. Should be 0.

> +			pinctrl_pm_select_default_state(port->dev);
> +		}
> +	}

Obviously the above needs a good comment in the code explaining why it is doing
that.

...

>  	if (data->data.line < 0)
>  		return data->data.line;

And a good comment explaining what you put in the commit message.

> +	data->in_init_state = pinctrl_keep_init_state(dev);

>  	platform_set_drvdata(pdev, data);
>  
>  	pm_runtime_enable(dev);

...

Wondering if this anyhow affects the future idea of the OOB wakeup for the UART
using its Rx as GPIO wake source in the suspend.

-- 
With Best Regards,
Andy Shevchenko


