Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A69482D3
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840267; cv=none; b=lAfX1PilyeHFlk2mfzbm6ccJh4IO6PIzhB2fHz1UYfZ83rwcAcwtN+Lfv09ge4s30fzQ+XMNDekIM1RKYU7CPW9CDldsxruVr9TY0/kkfDUBpOnO3/L57DnEEweNG9coO7Pud8Gko9KBLibXhqf83XfNlwEMvRTUi/+Z2EEcft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840267; c=relaxed/simple;
	bh=D/jB0XgeuTal8IdtuQ9W6D7Q5suMcgKwNYSpOc0QwWg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugmw0xtONofTUQc93b/YiSP2/kb4HVxpg786SYuYi44Qn1d/h0wugz0S/kNuJCLFho2JGBDcXs3R1Lw2h719jDc4CDDjSxFLKwdx6KST5Cgr7wvhyjL6Mdww1fObHV4dI1y9zKhoYDOIUX03XgTY7/cH/MvQ1c4t1BLKbZBcYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 9e1bbe5b-257c-11ef-8d59-005056bd6ce9;
	Sat, 08 Jun 2024 12:51:03 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:51:02 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/6] tty: serial: 8250: Add support for Moxa PCIe boards
 to switch interface
Message-ID: <ZmQphhYQi7tSjBIM@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-6-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-6-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:35PM +0800, Crescent Hsieh kirjoitti:
> This patch adds support for Moxa PCIe serial boards to switch the serial
> interface by using ioctl() command "TIOCSRS485" with the flags of struct
> "serial_rs485":
> 
>     - RS232                  = (no flags are set)
>     - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
>     - RS485_2W (half-duplex) = SER_RS485_ENABLED
>     - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> 

...

> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_MODE_RS422)
> +			mode = MOXA_RS422;
> +		else if (rs485->flags & SER_RS485_RX_DURING_TX)
> +			mode = MOXA_RS485_4W;
> +		else
> +			mode = MOXA_RS485_2W;

> +	} else {
> +		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))

	} else if ... {

> +			return -ENODEV;
> +	}

...

> +	if (pci_moxa_is_pcie(dev->device) || pci_moxa_is_mini_pcie(dev->device)) {
> +		if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485) {

Two if:s can be replaced with if (foo && bar), but it's up to you.

> +			port->port.rs485_config = pci_moxa_rs485_config;
> +			port->port.rs485_supported = pci_moxa_rs485_supported;
> +
> +			if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
> +				port->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


