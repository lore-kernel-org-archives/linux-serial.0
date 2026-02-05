Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722792D6E4B;
	Thu,  5 Feb 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299249; cv=none; b=NRnqJhHCKBInBPG8QcJS8AA85FxgstiKKK9yve1FBUVcjhp5jPFYtUtEFxo32Xzcl8ezz532UNgGtE6UdyU6NHqQhdGXYXLiV7iFxtm5aAGb1chN9Gg8pd5N6A849cHXOXQQqsw503kHGQGpvF3eoJ9QAP2FtFR7BaO1NR+s9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299249; c=relaxed/simple;
	bh=f1VmjMIB7snwfl7qkcG4KNiuu0lWm3fFNIf4487CBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duOlbqodMPocOUV6MeVoCtQrc3Iz0QgMw45rUxzcNnncS/YIlHUwk3d8jttHlRGpQ209fcNyQc7CWO1VMro6ro693oOR+CqjOfA7UiQtMUn0EiRTlJDfp3dSTi+XO1SzgTPHQ7ieeGRIWD6Ya+3kehwxyppHuFxdOu9fK8PiGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Vd3hPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Vd3hPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED1C4CEF7;
	Thu,  5 Feb 2026 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770299249;
	bh=f1VmjMIB7snwfl7qkcG4KNiuu0lWm3fFNIf4487CBqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5Vd3hPmoa/aDR70XoioB2qXWJ08CjYHZrIhL88ALfeiZHhQomBJ+M8yZ+DWNyTq7
	 FjY7OnCZExAfpd1L5MU6R+rkYUx6nM1/oNRCf5WKNDuoX8TLGmL+DDp6GgswijwBjP
	 Va1aBJxxLeHv5AyuimWWW+/Tscs6MGNPIgoEi9jt3I8UEhm9D8pbWWeB4QOOV6Vdm9
	 Pl2RghhjaSkOwbFHquNQgeOoq6OVX4YTNNNgp5utBTM9hs77ASEBBpqDiqXmQPcdSe
	 Z94TVYHqsn69c94TPBTwP7TeMcEBE+alhcHt2gyIH8I6v1zuwXQGeKndXvWO232lSn
	 tC1DY1YTV+jHQ==
Date: Thu, 5 Feb 2026 14:47:26 +0100
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
Message-ID: <20260205-bouncy-squid-of-acceptance-ee9f80@quoll>
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

Don't combine independent subsystems which prefer to receive separate
patchsets. There is no reason why this serial patch should be included here...

Best regards,
Krzysztof

