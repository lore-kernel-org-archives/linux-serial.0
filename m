Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFECE57B;
	Mon,  3 Jun 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420733; cv=none; b=esC3Y3hRq8x757FwCPhhX9Qv9tlLVzrTqGmQViUkdaky6ithSeDzKlgc/0YhTyF9LyJWMO/QsrfnVxmbyBOdnHekYOz/9DTM+Aq/5deDxwFTbeCZouRx/OjKlZW4R3utk7G8Vrz3dzB9T2ZptUNKUSHKkuOyVsWi8305yIdth8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420733; c=relaxed/simple;
	bh=LgL/MmSAZeLxCV+OpLpwFCLxjkw3tEWshcGOE6SuJMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE1tEA8S6yW+WBGsGxQNUtOMCIxzj6z566kuXE8xBsk0nIu8h5X5DbwHPBMrrs3ZIYRnkfXrtKoFFV+s5Rvdee1GCNMixIPkNnzS1KepkUvgAtmy9ITM8dRn90tYtCu5yL1tuSEwnSo/48hLVD181ABKd8EhhElaJ3wmurlYLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V96NyI0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V96NyI0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EF9C2BD10;
	Mon,  3 Jun 2024 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717420733;
	bh=LgL/MmSAZeLxCV+OpLpwFCLxjkw3tEWshcGOE6SuJMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V96NyI0Sb7svQf1lh3W8DIKv7BOjMHAsU9ywIzZa0s8NzCZaMgO8k94GmP097WuRK
	 PTxjc7xXlDQ+Jlu9y9EXBjrhtxdiOOOyKKcqoblhnZlJxvQ1lDNAuMEhPK5MeqPTyL
	 hgfl2bV8QHNV98YnxbozrBO86Dr6f17Dymuy3eORGt++4do3IHemYIDcZB25JMvfP1
	 Xzr/8IVGzEIEfZ5lh9yshjK5PTJph1YNqPlj++AThhCuulqA85WyD97SeKkDwVhv1k
	 dyRmlxJTwQvgsEsks2y2QCxHLA0VyYewYujgrYxJvRB4YyUdb5g8a+Ux2u0mRykjwP
	 8kxHC1HsuJcfg==
Date: Mon, 3 Jun 2024 08:18:50 -0500
From: Rob Herring <robh@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Message-ID: <20240603131850.GA148307-robh@kernel.org>
References: <20240603123710.649549-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603123710.649549-1-hui.wang@canonical.com>

On Mon, Jun 03, 2024 at 08:37:09PM +0800, Hui Wang wrote:
> In some designs, the chip reset pin is connected to a gpio, this
> gpio needs to be set correctly before probing the driver, so adding
> a reset-gpios in the device tree.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> index 5dec15b7e7c3..62aff6e034cb 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -28,6 +28,9 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  reset-gpios:
> +    maxItems: 1
> +
>    clock-frequency:
>      description:
>        When there is no clock provider visible to the platform, this
> @@ -120,6 +123,7 @@ examples:
>              compatible = "nxp,sc16is752";
>              reg = <0x54>;
>              clocks = <&clk20m>;
> +            reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;

Missing the header for the define.

Test your bindings before sending.

>              interrupt-parent = <&gpio3>;
>              interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>              nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
> -- 
> 2.34.1
> 
