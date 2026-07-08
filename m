Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831E1C84A6;
	Wed,  8 Jul 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528736; cv=none; b=GvT3yWceg2KLyBPs1vR6BGnx/8iS747u6HK8+zrb6MxNZ3dEBKhq2gFhA4Q27fVsw8RpSDGAjR5f9gQfdiXGGe3dPdFCrOq2ObEk6sD2w1+WKpqXX85Xpig5VNBTrhVCXh7sYO4nqvgWiVCKhsCme+OvCognmvOPyMfwqXoJaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528736; c=relaxed/simple;
	bh=F44/8vBktdR3VEbpkib/ziyPuQyylRJwZNPzkTCUFug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpLXVGepYIB5qZMDoLICe0SoRvi4FoQ3JFrA9rBT+PCOW5SM86eNm+zbWQhFYNnUqbFTBozZTWS4odxMUWpWPMgUsBGj6GV8tR+b6ou8Ne2pwG/xpf+s2m7b4O9rEjGJDBRNc2ZGcXSizeMz81Wi1872qmrmkLJAiT789KrHfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wkgdns+7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wkgdns+7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2E/foWG+GBw4iT2amZe5GTPBRmywetPiSoahCrwoJo4=; b=Wkgdns+7FKN/7OvfARMas0Wy62
	BvrLXWVMBmU0pX3RgmMx+CIrySrPxjAhlJTpjKvRqN4VqxaZ3pSqJrpWE+SdXHb+WWjovvCKlZ5m6
	po+/T3o6oV75Xw7XRrhHUev+RcQV0bIi7A3fAkBrlT2yLT5kr5ZLS2yfr5yVyG6tx5cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whVHq-00BLyX-N9; Wed, 08 Jul 2026 18:38:14 +0200
Date: Wed, 8 Jul 2026 18:38:14 +0200
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
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
Message-ID: <8eb54ff0-b8ce-44e6-8251-c19e0b6773cc@lunn.ch>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>

> -      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
> -      applicable to aspeed,ast2500-vuart.
> +      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
> +      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.

nitpick, if you need to respin. Don't change to two spaces to
one.

Whitespace changes distract from real changes. So it is normal to put
them in a patch of their own. In this case, i don't think it needs to
change at all. Two spaces after a . is a common style.

      Andrew
