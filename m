Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E61D61A1;
	Mon,  6 Jan 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147772; cv=none; b=UdtTfWAERWyH02E9m+EDyfFbMIAC9dlznu6hX99ioLmhUEoEbuVkmFUtPQdrSHjzkN1/MgDw5ToItyHCQEnOZyUilxwBEzCwOTD5VauDMJpcozhRYYcgHoarflZkngvhXUuN5UQiXx57ctfltiyz/WrkDqH12hgsZwL0cQQY92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147772; c=relaxed/simple;
	bh=GeZvhOPBXgXLebkUGPaVv1wGq4ToZki1NP9Gw2AIWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ/LFD43OLfNHDEEwWgA2DVg2YngvUZszr8iHZs1qc3onh3ji+6aWRACi3sKDhuEV5Tala+H3d2ktz/KUEOBJdlzjO2jXOpWU1AP8sOAjqrm2JE7NyHK8A+DuEcy72gFYlbw4m0o5mVN/6B5kmpI0CJlCWioOU0liD1JpvI1Ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5PXBRKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5PXBRKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E43C4CED2;
	Mon,  6 Jan 2025 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736147771;
	bh=GeZvhOPBXgXLebkUGPaVv1wGq4ToZki1NP9Gw2AIWeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5PXBRKHe6vx1kCdu1msSMmZoixl9EK0L0CcemTRvJgA6gw5dI9c3O1bfkjrOm5Vl
	 WKWocS2+0c0uUHCWdG//mN8R1BE3p5jDPbdZqtqAu5VjgTyMk4NLME+EfWEX8JMA+C
	 0NvXQniugBSxfkFpsfJA30hR43ema2lJipTf3SxGDjtfDLZPhL07+zKf1gpxz+LUK5
	 zxTn+J20xH8ohXy8DVIPhYGNex0lrcO3osilEEwYsKp/cI75Bx+nu1v1na+3i4+gA1
	 AsU6jon5TKTk0vwm73Rrr4fhagpEChzg7/sEsCEBKhFvL02wvUKsQyu/hxHDkcnRKo
	 JG93BxyfqXpmA==
Date: Mon, 6 Jan 2025 08:16:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	ansuelsmth@gmail.com, lorenzo@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Message-ID: <5niv7kglxrxs2pdwsqpi64jzn3v7fpjnoyhfy3adzufumjqpi2@7n4zako7u6yi>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-2-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105131147.2290237-2-benjamin.larsson@genexis.eu>

On Sun, Jan 05, 2025 at 02:11:46PM +0100, Benjamin Larsson wrote:
> The Airoha SoC family have a mostly 16550-compatible UART
> hardware with the exception of custom baud rate settings
> register. Specifying one of the following compatibles
> will enable routines for calculating the baud rate.
> 
> For the regular UART use:
> compatible = "airoha,airoha-uart";
> 
> For the high speed HSUART use:
> compatible = "airoha,airoha-hsuart";

Drop the compatibles explanation, obvious. Rather say:
"... a mostly 16550-compatible UART and High-Speed UART hardware ..."
or whatever HS is shortcut of.

> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 692aa05500fd..2fbb972e5460 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -63,6 +63,8 @@ properties:
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
> +      - const: airoha,airoha-uart
> +      - const: airoha,airoha-hsuart

Devices are not compatible?

Best regards,
Krzysztof

