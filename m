Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC64176FDB
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840647; cv=none; b=mr9vNQRLN6nNdHP4KuzHkAITa2QNsc3lA/nQmkijd98dgKo6RJI6DPNW+sEeMZAGQgZUNLSc+vRyJRNkAaRywA9etWKF4YIKjo4IQ0SsL9dURxpjqj825yAyQitfLebVvKBfq8liEV0dwFiv32hvXg4hZYLEOzJidwP/7QmN6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840647; c=relaxed/simple;
	bh=QNr6XepZLJ1OumPJEZ6zp/XETbX9Dlf4CaIzjYktUqY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTLNJFYV9UY0C/ePvmQ7muScnASuwyggzeLJN/39Zw9erTovx7U8R9r1SM03SXO0TIOSq3aSHg0zBlij5/fS/T7mrqDAfo2OAhBJXMFP8Iab7WgXtYvB6Y7NqVAghHk6sVWpPnMUdZoJiz5nVGFCXrxMvF7uKu10QKwzZhiiD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 811b72ce-257d-11ef-ab0c-005056bdd08f;
	Sat, 08 Jun 2024 12:57:24 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:57:23 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] tty: serial: 8250: Add check for setting default
 serial interface
Message-ID: <ZmQrA2_TjgK33uhn@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-5-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-5-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:34PM +0800, Crescent Hsieh kirjoitti:
> Moxa PCIe and Mini-PCIe boards are capable of switching the serial
> interface through software control, while other PCI boards switch the
> serial interface through hardware DIP switches.
> 
> This patch adds a check while setting the default serial interface.

...

> +static bool pci_moxa_is_pcie(unsigned short device)

Please, avoid potential collisions in the namespace, i.e.
start your function names with moxa, and not with pci.

This can be amended once you split out 8250_moxa.

> +{
> +	if (device == PCI_DEVICE_ID_MOXA_CP102E     ||
> +	    device == PCI_DEVICE_ID_MOXA_CP102EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP104EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP114EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
> +	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B ||
> +	    device == PCI_DEVICE_ID_MOXA_CP118EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
> +	    device == PCI_DEVICE_ID_MOXA_CP132EL    ||
> +	    device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
> +	    device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
> +	    device == PCI_DEVICE_ID_MOXA_CP168EL_A)
> +		return true;
> +
> +	return false;

Hmm... First of all, can this be done by using pci_is_pcie()?
Second, if the above is not sufficient, this can be read from driver data, no?

> +}

-- 
With Best Regards,
Andy Shevchenko


