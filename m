Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C22E7F0D;
	Mon, 22 Sep 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555293; cv=none; b=lIAigHCmck2N63cMVdyhYGEVxdbZIqXTer+pbTs2s++WhpGKpHzYYEXNH4F3b9ND8H9NkKZTxzZXuxGmYKUKXQKctadmkAc/XlH0s+pm8JfjDCEypQTNFtXpgbkE1HNxG6Ulfwm3cqU32NGtftMEPZG1+Yar4YB/qaSLwGyHqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555293; c=relaxed/simple;
	bh=9HGSjB3r5dniqSgwxmcE42ehkPwt/ZrU3TU596OdGSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY+RYgzhHOD2qBGGsumsKLFylIaOLNKg0LlqW6/YK6XGWJ3q8iUfqmUezR3V9CTLeFb8CPFXO2EXWESCTDa0cScKRkq2hIf6NyEHInAFzc4a3ybtQhce2uELNuF22RW5ZkDqkK7LRHiGhmCZrYDy3PC36Caf02qVbMugLKEnE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm0blVSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm0blVSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5791C4CEF0;
	Mon, 22 Sep 2025 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555293;
	bh=9HGSjB3r5dniqSgwxmcE42ehkPwt/ZrU3TU596OdGSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm0blVSlaSiqGsTnpobe23kzg1bJY5b87rq0IKksHw8ZqimpMUQGNklkkjo+A0tRi
	 wU/2BmWZriav9VtPXul9T2P+hQCkXQQb1F+aTTyu9/rdJWTSwRzHaO332ToqKjJf/k
	 WjXhkDnoqRLZWWAQGJfmMoCAeU/xVm7dzS8nFn3j76okS8kzQt6P1a0nxYeUS3fB5G
	 QyQedonYX9kaw+MO+3YjuzT4vTF0T7JBGz2nuehg9l4tAi9ykHVmxjUmvThjR/WvDY
	 0Dd+J9mf9PflW2yAUM1j3yKAijypHRelJOcHoh+xQwmLcH8MlM4o8gpM1gt9G5JAp3
	 SCwdzu6BP5Q+Q==
Date: Mon, 22 Sep 2025 10:34:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: serial: samsung: add
 samsung,exynos8890-uart compatible
Message-ID: <175855529033.4177731.4812595067760499826.robh@kernel.org>
References: <20250914132201.2622955-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914132201.2622955-1-ivo.ivanov.ivanov1@gmail.com>


On Sun, 14 Sep 2025 16:22:01 +0300, Ivaylo Ivanov wrote:
> Add dedicated samsung,exynos8890-uart compatible to the dt-schema for
> representing uart of the exynos8890.
> 
> Like exynos8895, it has a required DT property samsung,uart-fifosize,
> so reuse support for it.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

