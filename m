Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8C18C900
	for <linux-serial@vger.kernel.org>; Sat, 22 Mar 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679750; cv=none; b=NgVPOKIUKVDp8sswcqhOsgMuKaYtzCwVBWbX/+954xvsMeROhcJ1UznEn21oNnHja7S0DSJxhxRJhpODbBLpZHlLWWNrY9nPQYoPN5MtdLPEHB5r7WPptjCZPAxuM7OU3zClshAqz1KGfyMTUjOM7ZeXCFROcvn6NTSfJxbeOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679750; c=relaxed/simple;
	bh=4mlURLbxYr++QPQiQtZCSsv6IeqehFcFfHzr30595W8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr0o1cL1kerzU2seTdZdv+k7WlQD04T4IDccPrkGsfuUpizZZCLdu4uu4tx3ph9oPBHQtgi6D940Ooebz9drm6ZEUSpa1o/bJXA5vV6YM/KjkldIEHgenCpKoJSeB++sCNTigIFENGscmbi8+Ydek8GbHsJWW/HCB0swHgHpTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 87275768-0766-11f0-8ddf-005056bdfda7;
	Sat, 22 Mar 2025 23:42:18 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Mar 2025 23:42:18 +0200
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	ansuelsmth@gmail.com, lorenzo@kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <Z98uumXXqj_opuTT@surfacebook.localdomain>
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <20250209210241.2622309-3-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209210241.2622309-3-benjamin.larsson@genexis.eu>

Sun, Feb 09, 2025 at 10:02:41PM +0100, Benjamin Larsson kirjoitti:
> Support for Airoha AN7581 SoC UART and HSUART baud rate
> calculation routine.

...

>  drivers/tty/serial/8250/8250_port.c   | 26 +++++++++

> +	/*
> +	 * Airoha SoCs have custom registers for baud rate settings
> +	 */
> +	if (port->type == PORT_AIROHA)
> +		airoha8250_set_baud_rate(port, baud, 0);
> +	if (port->type == PORT_AIROHA_HS)
> +		airoha8250_set_baud_rate(port, baud, 1);

Why is this here? Please, make it stay in your module.

...

> +config SERIAL_8250_AIROHA
> +	bool "Airoha UART support"

Why bool?

> +	depends on ARCH_AIROHA && OF && SERIAL_8250

What is the purpose of the OF dependency?

-- 
With Best Regards,
Andy Shevchenko


