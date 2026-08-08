Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EA2EB5A6;
	Sat,  8 Aug 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786212630; cv=none; b=N7O8keEW2vjCjKV6I04ExLbjZhEkFoW6yxQ9hCmXqdwOF1x1r7AeGgBubDfN872MXlWEHoKHIrVrd+TK+jmaxTmhHKTBAwJ8OPeKmlVQyrDUNhO8ct9wi4Qgj0Eyd+VRn6glSUGTvMIufsN4r0p07EbEkzljhq3dr1iEOZGuTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786212630; c=relaxed/simple;
	bh=Gi1mm92Gjw0M1OFlah9/JVPSuvSP4JCcxQCKi1FId8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/VmDUp7MODYrSczkjlSah5SPr9MUViDmDiQGXjvG014d0Qa9yFNxUiuLy47G7/24X2HTssOeAPY+opUpSfR6bVg7kuvGQ1jVFdmmUkAyj/p9MlJuBmQXNPrJ/JVRAahauTnsQZQXgyC0jVi20eUmdP/QUuVSYlFNdvZA0AlmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch/GQbkr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch/GQbkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786212628; x=1817748628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gi1mm92Gjw0M1OFlah9/JVPSuvSP4JCcxQCKi1FId8A=;
  b=ch/GQbkrpRJ6hE4Zq/mF1BT0O5LK4j4VdQZvMFqxwHPxxH7jocgQ+f1y
   tr/I/XJzYB05/ZCW2fuJlIzIbLVQNTeikyCpSTvwPMH5JhPkda05slAKZ
   jUYPLmIIU9tRunpanQUQY3KvgsL3OFaz6ulBA4gJW7aFvUGJ6jinwKrzd
   JxEhrN4pr5LXGhs/vY0iTocRMs4D3m+yazgdE2P7RwvZNecByKOJvTtfx
   uWHhUG8lf/6iJgK2GMGAbyLwqjENP2twhDmLVfmboW/1y4EzlXlUqFVSe
   UZbHZMDWLg7ZsPkhxYu3VOSUmezfEMJIiwTlQLBsws/7SjMI3JZH/mYW8
   Q==;
X-CSE-ConnectionGUID: 7uWI61vUTciXkKoZmpF06Q==
X-CSE-MsgGUID: aAkzu82XS0qzoDHuAm6Q8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="98303005"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="98303005"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 11:10:27 -0700
X-CSE-ConnectionGUID: LS/3dPUwRHGgDlcUUDROkg==
X-CSE-MsgGUID: 1qc3dcN0S8yLYIGOG0HZbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="286059691"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 11:10:22 -0700
Date: Sat, 8 Aug 2026 21:10:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Gerhard Engleder <eg@keba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250: Add Airoha SoC UART and HSUART
 support
Message-ID: <andxDI4Xc-h5cJbd@ashevche-desk.local>
References: <20260807222044.208056-1-ansuelsmth@gmail.com>
 <20260807222044.208056-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807222044.208056-3-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 12:20:40AM +0200, Christian Marangi wrote:
> Add support for Airoha AN7523 UART and AN7581 HSUART.
> 
> These implement a standard 16550 UART with only some custom logic
> for baud rate handling.

Some cosmetic issues below.
With that being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...


> +++ b/drivers/tty/serial/8250/8250_airoha.c


> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + *	   Christian Marangi <ansuelsmth@gmail.com>

Authors:

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>

+ errno.h

> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_8250.h>

> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>

These two are kinda guaranteed by serial_8250.h. At least IIRC some other 8250
drivers rely on this and it sounds logical.

+ types.h // uXX

> +#include <linux/units.h>

...

> +#define UART_BRD_20M		0x1

Perhaps 0x0001 to show that this is 16-bit value?

...

> +static unsigned int airoha_get_divisor(struct uart_port *port,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	/* Hardware always uses BRDIV = 1. */
> +	*frac = 0;
> +
> +	return 1;

Shouldn't this be the same as UART_BRD_20M? I mean return a defined constant.

> +}

...

> +static void airoha_set_divisor(struct uart_port *port, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u32 xindiv_clk;
> +	u64 xyd_x, nom;
> +	int div_bit;
> +
> +	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */

Inner parentheses are not needed.

> +	serial8250_do_set_divisor(port, baud, UART_BRD_20M);
> +
> +	/*
> +	 * Calculate XYD_x and XINCLKDR register by searching
> +	 * through a table of crystal_clock divisors.
> +	 */
> +	nom = (u64)baud * XYD_Y;

> +	for (div_bit = ARRAY_SIZE(airoha_clk_divs) - 1;
> +	     div_bit >= 0; div_bit--) {

It's okay to place these on a single line.

> +		unsigned int div = airoha_clk_divs[div_bit];
> +
> +		xindiv_clk = XINDIV_CLOCK / div;
> +		xyd_x = div_u64(nom * 16, xindiv_clk);
> +
> +		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
> +		if (port->type == UART_PORT_AIROHA_HS)
> +			xyd_x /= 2;
> +
> +		if (xyd_x < XYD_Y)
> +			break;
> +	}
> +
> +	/* Couldn't find a valid xyd_x */
> +	if (div_bit < 0) {
> +		dev_err(port->dev, "failed to find suitable clock divisor for baud %u\n",
> +			baud);
> +		return;
> +	}
> +
> +	serial_port_out(port, UART_AIROHA_XINCLKDR, BIT(div_bit));
> +	serial_port_out(port, UART_AIROHA_XYD,
> +			FIELD_PREP(UART_AIROHA_XYD_X, xyd_x) |
> +			FIELD_PREP(UART_AIROHA_XYD_Y, XYD_Y));
> +
> +	/* Restore normal register access. */
> +	serial_port_out(port, UART_LCR, up->lcr);
> +}

-- 
With Best Regards,
Andy Shevchenko


