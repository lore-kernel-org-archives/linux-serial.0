Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1A40926C;
	Wed,  8 Jul 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529230; cv=none; b=nIdr2vjOGYA7dXsIHwmyZTSuCXTl1zIVGgrLfxW0VOgwTywt4O9jZ/613qIQFeKwPaU5PIuT6FnuED1BTZLyBKDtYntPAdWyDmLuIpKKJqvneoitEUepv7ZFIjC9JPrn8fc1tc71ZFZvTKO43T1iBjzsz6mkxHcOwlROl4Obu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529230; c=relaxed/simple;
	bh=D2USU5rG6fP7EzkSZeAstt6Hk8cLDjYuu7gqWr4U5Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLuqX2fg+E6O4vadTtzpC0wiEaOcQfAPoqGLyF/Z8AtEWumgWZeNjykJo7WQeuls0ewVhe9wB0vjG1d4e2+7oRhl9hvGlP2DJu6K9s7zRE2n8+EC8PNIdqOOPp+7s+sPTY/pGRJDve7Pwu2Q2zFXWV55tGy20+N24Zh9hHbilTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wwRud+pN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wwRud+pN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y96gfCnZ28npS8MYymCLzvmBAFbrMX4D89vuwa0iaks=; b=wwRud+pNiUjMFw2nFYsQhA9lUG
	Sc8PGjb1TVym9+IDgG+iJSxJqhOVfDPJl8yd9kq7wNgxNyX4fMbLPF3GXcMBs/Tp+6RYwJ4tX6GGM
	gbmimnd9sNh5iub/OgWU0EK6S/vkVzfJAFrE0z8je6PrBVeyrZg/ew2hN3owEJbD2+8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whVQC-00BM2v-3I; Wed, 08 Jul 2026 18:46:52 +0200
Date: Wed, 8 Jul 2026 18:46:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Message-ID: <694c7c37-fb42-4994-93eb-04ed4ae299cf@lunn.ch>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>

> +	if (silicon_revision_id == AST2600A3_REVISION_ID)
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> +	else
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					/**
> +					 * The bit 14 is reserved in the Datasheet.
> +					 */
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);

checkpatch should be warning about these long lines. Traditionally,
the limit is 80 character lines, but recently 100 has been accepted by
some subsystems. The exception is when wrapping the lines will make
them less readable, but i don't think that applies here.

	Andrew
