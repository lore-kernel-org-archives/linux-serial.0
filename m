Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99B3D7D8B;
	Thu,  5 Feb 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299312; cv=none; b=JvZ5vybml2CqKms1snmpohxJ9rx1qUrSM5A7TOr94dN+e5Tdwvfk8tP4Wn3PRYsQYy+qjMZjZdIUHre4SRvrIrHc4k/NGVTvLuxhKPdj30uuPDgXj5438MhA8s0XDT01q8vbPOC9Q3riZHqs9K5acO7QIOSrHqdRBAvbAWddhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299312; c=relaxed/simple;
	bh=mpye6M0w12Zxd61wXX0YNHNqnAZ334IbwiSE40CJkjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAsNews8HlzaOoly93G7HqX3lpyVte9BbhNvodxcqa+Cw92LxulW5OCut0khUdqIhNJ+hhoymd2dDN61WQ8+VqHF+zsAnVUaT4XtdsWcAdbEJYuQh6o1d3bLYTLcwlSOj3ZtTaXhxApx4uqlZ8zhHZ3DB0N3p1+Dubbvi//Wz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvwFF0ov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvwFF0ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B2CC4CEF7;
	Thu,  5 Feb 2026 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770299311;
	bh=mpye6M0w12Zxd61wXX0YNHNqnAZ334IbwiSE40CJkjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvwFF0ov+HW1nMUWej1i7pfISvaZGlqZea6z7zqtd8buzSZ20VFdT8Vt6uUJUkHtw
	 2/XA28b0r0eXIFWzkUgf0gmCi7RDaiFG+Tkc8SxXleim18t0J13+PBHzfD09ekbcXw
	 L5ELra2RYrSwrtqH/ONrDh6DcftxOR+bqBi8kUjDCa44Pst1fsw1huALGyngUmJ5Dd
	 8VCWBdoUkHU6UfLTv0wGNdbOA6JePalz65i+SHVJfp35n5KG8Jw+j4W19Mcg6d5AGW
	 PXIhESri7WeIQEoF7A/vsmTbWwGy5JydCnXI7uyE1198c14I6n3Y+8n0oeNH6FiLBm
	 5Hi2qXSvjl17w==
Date: Thu, 5 Feb 2026 14:48:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A9
Message-ID: <20260205-wooden-invaluable-wildcat-cf93c6@quoll>
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
 <20260205-a9-baisc-dts-v1-2-1212b46f95a7@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-a9-baisc-dts-v1-2-1212b46f95a7@amlogic.com>

On Thu, Feb 05, 2026 at 06:04:03AM +0000, Xianwei Zhao wrote:
> Amlogic A9 SoCs uses the same UART controller as S4 SoCs.
> There is no need for an extra compatible line in the driver,
> but add A9 compatible line for documentation.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

