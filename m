Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02D482D3
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840066; cv=none; b=iIowczapseZbYjQNIT68esxZIRh0O4JRhpE4/MiwwNP7bqYU3pXT36E0MOSbEffymY45t1zclzp1odAPOxH2AIQY68aMquHX5rAfAwrcsSCQ1UzhTXULjzG4dNfJstrUr9lKZL9lyIGHBE0DC0qwhR/ertnwD52OsjiyEI4cwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840066; c=relaxed/simple;
	bh=JqOtTvqw7uV/u0K6rQtsNQAPJjZEb7jqnR2ekLIN1YA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5aBp9YD+B87qS0wLpYWKt4TY3YscRxpBsJFELDhL5wni4fkXLEY3pdYsCCOzdJEzPLXHcxSso0Pgi7zcBqE8ygyuKUXnLnpqD87SS99OdmtrnqC5uaUFLT8iEttI8be3JLC6tXcOWUhRrTDucKTl8SyBYYxFCOA1DI8Tjlt0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 25790f07-257c-11ef-8d59-005056bd6ce9;
	Sat, 08 Jun 2024 12:47:41 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:47:40 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/6] Adjustments and Enhancements for MOXA PCI Serial
 Boards
Message-ID: <ZmQovC6TbDpTb3c8@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:30PM +0800, Crescent Hsieh kirjoitti:
> There are 6 patches within this patch series to make some adjustments
> and enhancements for MOXA PCI serial boards, a briefly description is
> written below:
> 
> - The first patch is an independent bug fix patch.
> - The second and third patches migrate some MOXA PCI devices from
>   `mxser.c` to `8250_pci.c`.
> - The fourth and fifth patches address improvements and adjustments in
>   handling the serial interface.
> - The sixth patch adds a UART configuration that aligns with the
>   hardware capabilities of MOXA PCI serial boards.

Everything is fine except one issue. Can we avoid polluting 8250_pci?
What I would expect as a patch 2 is a separation of 8250_moxa from
8250_pci (see examples how it was done in the past: 8250_exar, 8250_lpss,
8250_mid, ...) and then updating code there. Can it be achievable?

-- 
With Best Regards,
Andy Shevchenko


