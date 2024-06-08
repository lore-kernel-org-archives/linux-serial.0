Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2C12BE91
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840378; cv=none; b=sFbQkImqIVx0o6eYTvlw5M1fOBCLSsTS1ttomPmmoH+Z8PMgTFpmSRtk/l7Xu56vFXKG5ssoqyzTPgfwWPbl1pUmhJKbjo4ZO6Jl7OmHevP/cc5uJSrT963RNUqY9ExtyADYXqC55Lbbdz66uYAIF5cRzJAvJnexC54kGMvOgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840378; c=relaxed/simple;
	bh=D8ZIj/eV20FhrYBTFwuW62hjokTeLoG8epgirecWT4A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy5uzqBOwnVUym9+oPXi747bN57cJchXj1ZwbwVHm+PdBhqSpB2F8NpxgEnh11UBCHH0mA46HwFeeT8q2+A6RM8WI05JnIM+/r9wL6lgT9NfSXB+fgsq7r/E6XCnTuAJjLxNO629sw2EUVtvjoHC6pSuyPrt6J1YLa6ch3u9skQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id dfdcce6b-257c-11ef-8d59-005056bd6ce9;
	Sat, 08 Jun 2024 12:52:54 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:52:53 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/6] tty: serial: 8250: Add support for MUEX50 UART
Message-ID: <ZmQp9QYG620nGjqx@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-7-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-7-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:36PM +0800, Crescent Hsieh kirjoitti:
> The MUEX50 UART does not directly match to PORT_16550A or other generic
> UART configurations.

Does it match any non-generic configuration?

> This patch adds an UART configuration to capture the hardware
> capabilities of MUEX50 UART and apply to Moxa PCI serial boards.

...

> +/* Moxa PCIe UART */
> +#define PORT_MUEX50	124

Please find a gap in the previous numbers, I believe we have a few.

-- 
With Best Regards,
Andy Shevchenko


