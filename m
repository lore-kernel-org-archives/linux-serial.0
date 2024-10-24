Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997B18BB9B;
	Thu, 24 Oct 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754825; cv=none; b=CDWXGhxg8v2+9etnl9yLZImrlla6hr3sLjwgPVxRm+xaS66baOohNTVujTrP6sOwuTTNEu5ceitztqBubY2U47hUfkqwhNVXm2+I2vF42LgS1Zv9i/cmR2xmNvuERQR5EjxldPFj7Lx9usT3shNF/4l+QtPdErA+e/qc6TiNx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754825; c=relaxed/simple;
	bh=dm+M/P4NK/WpteoV6oB24kvkqvdyHw/jnfh7uzPyRMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpklGgfJv5SUUyNIELLU4JGc9Ze8YlLkwuP4kUt5EIn1nXO5E90lxs3ly9L7nrQT59GnTmTLCYWu2NYYkQf3Kz8MoGaLvPskg+VKT+Fy8ZBnUV5qsL2VC+BvOwbGTsS3xjcTCe4YOX13XxUznynktulDzEmuMXKvSkaIirsgV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q09TGzVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q09TGzVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F971C4CECC;
	Thu, 24 Oct 2024 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729754825;
	bh=dm+M/P4NK/WpteoV6oB24kvkqvdyHw/jnfh7uzPyRMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q09TGzVTI/tJtefI50bhpQ9G/FdeaWNS2eT1/YNRgnzN8EkDfAdfbZYyeZF8mXjba
	 e1bhgOCLl6oVdwkgr0KbGfcr56RheAC6MQELCeC+OXd81RNopNmrPgbMUX65gOO0ns
	 Bjo6jw7wHRT2Q0ML1PK9PrfMghVc8TtGBMQwNRP7WqMV3/GrQpgeknyUC4QqL9sWzT
	 Gu0T6QO/G2+cO+alsPYZ/cCbXcuhVy/LiQYejILbzB6CJXBvhnSisElvRiVbVV5xHa
	 kvkto2YbjZOiHote9KbM5+0reKiD6PDn2Yza3Nc8EHDX5N72PWx9+Ltt6ESS7AKcFu
	 9nRMRa65CxWNg==
Date: Thu, 24 Oct 2024 09:27:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: samsung: Add
 samsung,exynos8895-uart compatible
Message-ID: <2kjgpsms7b2sdxny4s4s5ukg5j2ncaizg2kiqbvgk4rposrpuv@ijthdmntpbfb>
References: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
 <20241023090902.538040-2-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023090902.538040-2-ivo.ivanov.ivanov1@gmail.com>

On Wed, Oct 23, 2024 at 12:09:01PM +0300, Ivaylo Ivanov wrote:
> Add dedicated samsung,exynos8895-uart compatible to the dt-schema for
> representing uart of the Exynos8895 SoC.
> 
> Like GS101, it has a required DT property samsung,uart-fifosize, but
> it does not exhibit the 32 bit register access limit.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../devicetree/bindings/serial/samsung_uart.yaml   | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

