Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8532E151;
	Fri, 17 Jul 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277190; cv=none; b=EolCt33fPeoyiA673NLacrwRMpnZFqv39aeuHy7mbQTY2PPW/n/zUXGUL890HZebcpJAmi8Y/1L2xgUdusORnaTUyF6Q+Vhy5By/K4DsPS9h7PTTScefvwEHDw+XFfBqwvdTjryMxwQYvmL1wKnvnoZsILZKqHZgoKUquWV6LSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277190; c=relaxed/simple;
	bh=idhp5R6D7rxQvoxipxETE4jM30ZWH6Wp1KS8L0iHxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT15RYGrMHKBErg1z7OwU5VaYQzevN2R3Q50ORzuv0BodgybrrFjoO8NQZ/lfLZ55p8XVLxzLUYTdHmmeg+T7NT6WICxU2waQqNp0KVyVqCpLPd3Y+F1xjy8vfXqYaTrJW8/z9HNotB4QnREBtR0V5IRFYaYr6ZyWRVuP3ByAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLF5yoPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLF5yoPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA71F000E9;
	Fri, 17 Jul 2026 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277189;
	bh=1/vXpkNy3cOqlWapaK3O7CEzY3os4he4uAXH6NOiATU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KLF5yoPqydipFqeq8BtY4outpqLJ+2cNkNOIxCagm/G6UaxMtvukMovZPuSlxY1N2
	 txnUltNAw1nQDIIEus7CxEXxm6aix4k1uLo/BXdFj3yrQ9Ef0vowYe528eozK7f4aO
	 kWZhE3VYyusw2Nz/rdoWafYYDw2PHQPqVuah62Y4E/jXeDHospmit6rHS4J1z2jsTA
	 0E38wK2F9iKFeBqddio9b/Ps7u04RTnyBaBT5WdGRdPcVf29FQzpOCHAP1vwfPVC9z
	 EUe4D+DbAMiejBV2IZ+TwSfWJawIjxP/+Z4s+SRaN5UPQY7XoIHsU1e47SqgqqynlI
	 3DWxEmxCShihg==
Date: Fri, 17 Jul 2026 10:33:06 +0200
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
Message-ID: <20260717-prudent-indefinable-labradoodle-fcaa9e@quoll>
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
> 
> diff --git a/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml b/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
> index a84d60b39459..7eacf5af6554 100644
> --- a/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
> @@ -14,8 +14,11 @@ properties:
>      oneOf:
>        - const: cdns,gpio-r1p02
>        - items:
> -          - enum:

This should stay enum which would also make your diff easier to read.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

