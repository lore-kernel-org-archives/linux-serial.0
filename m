Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA671FF5F2;
	Tue, 12 Nov 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422315; cv=none; b=U84T/Awsi1QXpUXWpNETBnSBD4EhwIOYfLubecStZwrj1Z7mOAW+n80H7yVtDb/J/6ecW8H3kTffJAd3evXf7D7ztP0VeXIEdf3gmUynDJGJtxpy4vI8+k9V14H+Bd/QH1hpKrgX2ET3LH7OY/71imK1ocuNUJY1lQToSJudvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422315; c=relaxed/simple;
	bh=bQHPCChlbA6zZpzQ0DUgpdk9N3mG6RMBiqNtq7IUJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwBIztYVGEf5whHbAzRCQHOEabF+vzG/f/mktI0HdBFBJee+C4d/3fD+UbZccJUTybL90fKco3WvnsK3HPnPRodPb65NJVGGZz/fZg4p3QPuCoGR7NmC6/ra7ij10afJDBTp1Cd+EYdHe9sw4q0Wv5X6SlLdgYbxf2h5qixDHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSeaigY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSeaigY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0220C4CED5;
	Tue, 12 Nov 2024 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422314;
	bh=bQHPCChlbA6zZpzQ0DUgpdk9N3mG6RMBiqNtq7IUJVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSeaigY8WbxmaJTmya7XuZFX9a7Rw3gv9oZPpkqHTR7qaFr1YXXQc37dZfYgiJ2yl
	 xTgxngPCA7kazzxAWi9pzQ0Ymre3MrbGbcFIzVuJUA3LNGitq7a6ta6AJd6q0Fwiqw
	 iCA68OKa19ii4GYldqO3uH53Xgam7t0Tue7DkUmLBsRENXoJvQdsImFGyU9/9JKQPS
	 F6ZM2crG43RW0PavL2frvLzlyfTwkq69u8nrwDxpd0ipFK7p60SMmC4UTO7kZIQm/S
	 +i/mmay2D226seqYIa7uf5BIRxj1mKMfekDDVSpBcfJjXPzrwaPOnhn3D4ugbHRhyS
	 u6mbHKFnqpo0w==
Date: Tue, 12 Nov 2024 14:38:28 +0000
From: Lee Jones <lee@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
	luka.perkov@sartura.hr, Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 3/4] mfd: at91-usart: make it selectable for
 ARCH_LAN969X
Message-ID: <20241112143828.GH8552@google.com>
References: <20241108135855.129116-1-robert.marko@sartura.hr>
 <20241108135855.129116-3-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108135855.129116-3-robert.marko@sartura.hr>

On Fri, 08 Nov 2024, Robert Marko wrote:

> LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changes in v2:
> * Pickup Acked-by from Nicolas
> 
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae23b317a64e..f280ba28d618 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
>  config MFD_AT91_USART
>  	tristate "AT91 USART Driver"
>  	select MFD_CORE
> -	depends on ARCH_AT91 || COMPILE_TEST
> +	depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
>  	help
>  	  Select this to get support for AT91 USART IP. This is a wrapper
>  	  over at91-usart-serial driver and usart-spi-driver. Only one function
> -- 
> 2.47.0
> 

-- 
Lee Jones [李琼斯]
