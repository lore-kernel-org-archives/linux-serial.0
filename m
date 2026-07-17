Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE114A4CC;
	Fri, 17 Jul 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277304; cv=none; b=OHUgx+8WIALU7rZmrrRo3AnFd+0p8xsKMIT1t8FWDr//jVGfY4Het+HybKzxIuIzVbbf+sXhqEH1esCuNLO36SpmJY1adMGx8i/Q2JPMOuNiLGy11UtV8yKHojCpBu5onRwEAKVKSYQKIyWNmQJagE5Qj4U7EPzvul0SWD7aEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277304; c=relaxed/simple;
	bh=HTqVnu9Kqs+w34Lrrmzme2SvEYMUqsXPKzmYnFCXCYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS0zgG39Aj4bXFIdaTgYkqFdFFHd0EivBzWc0U7iWSRq46zSFHn6swya7GY+YZLi8fMkOQapbJc3KJ5E7WakBh+zPQWS6wupH5Hg+5CVBESfOfUw0gRtTvsH+PCKeEVophn6nEmhhSScx+wqw81WQCx0KEsJ9sq5ogiEyxEK/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmUcmphv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmUcmphv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322251F000E9;
	Fri, 17 Jul 2026 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277303;
	bh=63aCLAenr8WeJxjEBK4GeDaPD8Vm1UzrQNPs6BAaFUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QmUcmphvyTev+tyhUnKnKF4pnUGio0/8tkVjKj4SrF0FmwpjD/pyvdYPDADdn3rOz
	 /kajA4XHq2PdGW+ZGZZS59vwBiChthDNTMt7ZwQx37zVqdvWH31NMOU8gbhxW8CM5p
	 03wgP7AVkFVUY2utMXQhcyoiYB5GW3rjSgOsl6VW+Q1OPrdW/2JzqSbzaoqxQpXrm/
	 M8lK2zAgrEb7bNw3IOUUNtnYdi4loQpMpGn8QNyYTkAucUfwF/NgzDw2/hJV2M5CH4
	 ZFYT/ruGvs2KSk+NZ5CRGobTg+wo/Gv3T6VqeVzmZ9aV6+ls6b6RwwamYSz08GY1fV
	 l7kozIek5JXAg==
Date: Fri, 17 Jul 2026 10:34:58 +0200
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
Subject: Re: [PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi: add Axiado AX3005
 SPI variant
Message-ID: <20260717-admirable-robust-adder-7aad70@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:13PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 SPI controller. So far, no changes
> are known, so it can fall back to the snps,dwc-ssi-1.01a compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 8ebebcebca16..7b16053d2244 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -41,6 +41,10 @@ properties:
>          enum:
>            - snps,dw-apb-ssi
>            - snps,dwc-ssi-1.01a
> +      - description: Axiado AX3005 SPI Controller

Rather: Vendor controllers compatible with v1.01a

and then place it after the group with "description: Vendor controllers which
use snps,dw-apb-ssi as fallback".

Best regards,
Krzysztof

