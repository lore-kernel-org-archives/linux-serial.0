Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3373E314A;
	Fri, 17 Jul 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277061; cv=none; b=msjvzNfu/we+BIXuG8ah9T6kGEwPSYC5Jaw3Z7lvfWKV8KKnnOsJJG2Qi3lQvyW6iCV4i1J27BhuWQ8iZpkEkK8SRoGspl/FUG/J/C8W1xTv1KrWUVKWyEaCjTvPfl1bIW9tJTxpv2ceEE46xk8FDsLIUq+ELe3jSE1pKqUufog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277061; c=relaxed/simple;
	bh=ioRrTHyMuMIcxVT5kZ4m04/zu+tk6n2KaBSlio+l1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWiscqyOllhWFicusumjKN0GissX+vLzmBEk0QQ0QLwp0BrAO/J6iAMlWAkkOMrwPlsKbhG6aIKGPvxtsG5+IRgw+zMpEb3bFJJ+IPSg6urxlAYww7R7+lRaG/X/dQkT9Nm0kupHDTnZMXVd+visYpGiB2TqCiqTpucE4NBJG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hewpKFFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hewpKFFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B271F000E9;
	Fri, 17 Jul 2026 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277059;
	bh=XBHypJZk2uYdJaFmd+txdG5YONd9gTShXS4Tg+ehzk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hewpKFFSRbPg0iaYLiMXv58ynWaI/VpzCaiQZeIBWuWFJ82xgE73vugtEXW1/ZYKJ
	 jnFkj3v83EVPig6mG3FfIIb7DKIxuaW4Ft4MmoHLfmqFLoDYM5MAGG8AO/dY4I1YwZ
	 ZAbuXIGyAgk0Gxzj17TJtzKPhqvVhl85NEsicCfaDNCho5AD3eRUq3fOWxlgPdf6iZ
	 JOXQSKnGQxvuFOUEuk1w0eZmxx/6o7cMpSeVpC2W0Du9LVrB9tmQhm9d6TlKN8mZel
	 mYbMnIz+d76lmeYpFFEbLAzR5TKLlpnefleb+9stynneT+Sx1nf+ahztE9F5UA+VFj
	 tLGrMLwLg4RXA==
Date: Fri, 17 Jul 2026 10:30:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>, 
	Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: gpio: cdns: add Axiado AX3005 GPIO
 variant
Message-ID: <20260717-singing-nifty-guan-c73efe@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-2-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-2-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:09PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 GPIO controller. So far, no changes
> are known, so it can fall back to the cdns,gpio-r1p02 compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/gpio/cdns,gpio.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

