Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554092DEA95;
	Tue, 11 Aug 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432964; cv=none; b=ShVyujWWzqp5TUGK8enhGdMZx0zpcfCk7kTwbLJyeRVCk7dk0MDZWYqvqvrFBjTWeOotcbz9Gzr8z+frMnkhekJd5dJE1XxW+awJjWxG3eygUspC9NYL/xRnOVq4In3SnSzjMgmnHgMdr2kF5NA8K8unwwwD9khtzaPn4qDLibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432964; c=relaxed/simple;
	bh=/GYbZ0CTkqrqTtKelCSfB8Ql+Pi5EO4ektmjFg3WFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhIqWoUlzKI1UrC/32QRlESZgvF/ipDNXEL8WHxDi0oCNGtNtK/GhWxtjzn1yXDgpKE0l0phyQaclbq2C7fWSwVwRrPku9BsxMWM4n3nWciLzTUDdwBfOfPOkFsaa2rcs26oTkPSptRLpcOVX896qngMAxX0vYlDJd2yHwCbXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOEl3kjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOEl3kjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE42D1F000E9;
	Tue, 11 Aug 2026 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786432962;
	bh=TshhUeKm9yEd8Fnl5f3az2GRY+PfQHs2aCH6vivSu+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOEl3kjBYakJmeK9p0LRuCv2/EHQ07wiaaLQHP/EvQGkUuEHz1aFbTEQIE0qj8q6+
	 OTkSxG2hRn94u1ysWdtAo0HwRp05qJkNQb1H+tBXYDvjXynKK6eiRAMcCnxPi3g/32
	 6CIjgyXATQ7lpDsxfMCUGKUQxD6Q1b5/F9WrgLzh+rwDRGJlypEULBEnppiLi4Zglh
	 QRL7Pxiv21uWaOYPr7HY8B7C0grBLbed6HUU2jzaU4Rxe3sE0/VSENhO+e0Jp/25ga
	 BJqf167wXRghH5ZIa8Wqfd0toCUaT/zGxJLikc+WOhLVevcGIqnAFzjkG60+DtXDBn
	 YZjl3fRaVkBbw==
Date: Tue, 11 Aug 2026 09:22:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, John Ogness <john.ogness@linutronix.de>, 
	Jacques Nilo <jnilo@free.fr>, Randy Dunlap <rdunlap@infradead.org>, 
	Rong Zhang <rongrong@oss.cipunited.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Gerhard Engleder <eg@keba.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: serial: 8250: Add Airoha compatibles
Message-ID: <20260811-funky-wyvern-of-dew-3bf322@quoll>
References: <20260810152636.658955-1-ansuelsmth@gmail.com>
 <20260810152636.658955-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810152636.658955-3-ansuelsmth@gmail.com>

On Mon, Aug 10, 2026 at 05:26:34PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> The Airoha SoC family have a mostly 16550-compatible UART
> and High-Speed UART hardware with the exception of custom
> baud rate settings register.

Looks wrongly wrapped.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

