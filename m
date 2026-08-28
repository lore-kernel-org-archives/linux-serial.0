Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCC1E260C;
	Fri, 28 Aug 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930259; cv=none; b=IKgJBBeEKUTqnK16rSV6uGRmlEC3O97+DPhs3RFs1XTrVpGHv2u/I6m6NdYbMF+lQa5X6YVkVXAUn2J7L0FsMZfeZe+FCMXxtM30USH6NglIeIiH4/7QdPFYMMitrPanCzWoZ1YsgUL6mzQBTXWo3ddNXqmEL80vT/GakNa0SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930259; c=relaxed/simple;
	bh=4Tsg4nBL3cNDbLzOsha59Dx6f0EWDHxcbmMBHq2lDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0c2RpEIHniTIh5wusZETK0BPGEJt5Vq+Unk/doug51wEVH252rU+NecV2b63su1iREW9SIx4n6opfWM0lY+Iaw51BIs0avNs5wJiROEmAJhCzJ7xL8GX5C20PXXPGU7nZUQqp15YEf3oFfUhJBZhWI4k9s5TTdF1nUqTpfwX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJNPVoNC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJNPVoNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787930257; x=1819466257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Tsg4nBL3cNDbLzOsha59Dx6f0EWDHxcbmMBHq2lDd4=;
  b=WJNPVoNCrpx/8wW5o+5Gerh9663sKaa+tXTYOV+AoekJtyNO2cL61+zm
   07d6lGFYc795LHvaJY5w03FPTme79wZonJoeHrrwsKP+2COTilXGlj8C/
   wBYJa8o3t3ajMNAS93R5r5SDNe/cS/dS2kEhH9J+XMe8Ul5k5vVp/sqrI
   EOvt3S0KYBFfxcv3R/EMWKCj+b/WZ3JsSkXgblmITLgm8MSNU8NI1KUBY
   eg5zeJW8zjtzifFYgM++aYF8QlgSW0q0ModkxT+6jJcg+iP7+bGVkustc
   0eqWbs3+AxOFILG0eKzk91GPSPyfZyXJ8MsyikM/rhl6NBLjcozqRKlBX
   w==;
X-CSE-ConnectionGUID: Z+263V6hQ4el+35uGVUwOg==
X-CSE-MsgGUID: ScV3GHHxT8u6M4Uw2oDvDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="75985291"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75985291"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:17:36 -0700
X-CSE-ConnectionGUID: w3WzaHSBTSWVZ/po54DB4w==
X-CSE-MsgGUID: rZX5M+9rQh2iICE04Q7HRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="268225523"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.167])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:17:35 -0700
Date: Fri, 28 Aug 2026 18:17:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting
 termios
Message-ID: <apGmjOOI6K5wkhu3@ashevche-desk.local>
References: <20260828144617.1210599-2-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828144617.1210599-2-whiteberg@arista.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 02:45:17PM +0000, Tate Whiteberg wrote:
> If mid8250_set_termios is called while data is still in transmission,

mid8250_set_termios()

> the corresponding register updates will corrupt the transmission.
> 
> Fix this by locking the port and and waiting for the transmitter to
> empty before performing updates. It is necessary to wait for both
> UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

Fixes tag?

...

> static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,

>  {
>  	unsigned int baud = tty_termios_baud_rate(termios);
>  	struct mid8250 *mid = p->private_data;
> +	struct uart_8250_port *up = up_to_u8250p(p);

Move it one line up.

>  	unsigned short ps = 16;
>  	unsigned long fuart = baud * ps;
>  	unsigned long w = BIT(24) - 1;

>  	/* Gracefully handle the B0 case: fall back to B9600 */
>  	fuart = fuart ? fuart : 9600 * 16;
>  
> +	uart_port_lock_irq(p);

+ blank line.

Do we need to protect the preliminary calculations?

>  	if (mid->board->freq < fuart) {
>  		/* Find prescaler value that satisfies Fuart < Fref */
>  		if (mid->board->freq > baud)
> @@ -231,11 +233,14 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  	}
>  
>  	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);

> +	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);

Can't it be done one line after? Somewhere...

>  	p->uartclk = fuart * 16 / ps;		/* core uses ps = 16 always */

...here?

>  	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
>  	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
>  	writel(div, p->membase + INTEL_MID_UART_DIV);

+ blank line.

> +	uart_port_unlock_irq(p);
>  
>  	serial8250_do_set_termios(p, termios, old);

...

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 38fa45e74a37..4eaf417f1fd7 100644

All below better to split to another prerequisite patch.

-- 
With Best Regards,
Andy Shevchenko


