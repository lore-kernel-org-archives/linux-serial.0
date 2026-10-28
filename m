Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174823;
	b=0S3Fyn0DxnB+g0KOESXwr8UfA0y9pmsq/ynxms7zeyUsv92n8aDpCgB49sIll1U2/bhP
	 eSHHLD/i63c7JDGswZ7g7t2NXnbzyPOa3kXvtihNSokFCHAB9zAD1Oo1mIi5Xaqr8JnxJ
	 jXlCg4pBaXqi/4QOrM3tIrYwNxmhRN8IO9EghdcXGuP0UeQ+MakcwMxBd1ZzcrYf7SWBl
	 gXh7MaNFMRAReTuTU4PPCizxfne/tS21gvNvMoHpM/2HOJSPuZkQGrLE6fpcoDr4YqJNh
	 EZ3f/kzT97rHFGbI1fERobY0U0ysOwo5NZc0QY9lZRx87lJWzqYtIMxBfsK2WWfuN6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=airiPRPpuqyAkl18ksOwT7H/2GRUZL6k3C4fmXWBz90=;
	b=TgShj9MWebtA3sLRaWyxSb2/zTVtAYodfWBMO2OcUeDiSA1tuXiA3FhMdpK9FgmAFhMh
	 fDS3dUEnv1K2mP1n90N0dL1Eekr8OVhG/9Hs3qjlWRbrL+MGR20n2oEi38nnf24+KLL1v
	 L2FG3b98O9w6AxW55+1+eZBBE2/cEi73CcXQ2Upg9s6dyx/B8ZA0pjpnlIuxAK5U4p8tE
	 nMkBhrnR8A0cn6oBuXB1dcvdc9huT9nERSsQUXY6kRnQIFi7cLq20TBPdBnQXRLKed38O
	 ueVL1fG3H0aiyIDB/NVIae5s7D8P4+MUppXEImyBZLrrdR1Lswk6NK/LWRkdajlEXWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYA5luYs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B7606A331;
	Wed, 28 Oct 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYA5luYs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACDD1F031E0;
	Wed, 28 Oct 2026 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793174822;
	bh=airiPRPpuqyAkl18ksOwT7H/2GRUZL6k3C4fmXWBz90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYA5luYsWX5COUjONr/9aduLv234Wnz8XwLP3+qiIf5Bzc+E3dV26Px0QSluE9VeI
	 ooIb5mlRz6iOWo3SULHaNXYArpAvJsz/ddEhmzbSTkwWv6gvffJT2pqKsQrxyOxuVO
	 OFkw+1gGSEjFLrcKup2C5ELqqb1xR4MaUxXPdM549SKW/1Q3YwI3dUNqlVwn6mRrWm
	 4IwAiw+HhH8jZfnharzZ5og3XhsKOS2CF2C0l59lcXxZJJYJn2umkngWToLE5LrX28
	 6Rh5mCw/mCe9DG8kIH0WtNZCe4HZQ9qEgo1DMOhuhnsq0gCE9WIW5YimmfX9/xrEoc
	 Yw2x4aWUXkCYA==
Date: Wed, 28 Oct 2026 09:06:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 3/5] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Message-ID: <20261028-durable-merciful-caribou-1f3da7@quoll>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-3-d37e018fd0a6@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-3-d37e018fd0a6@gmail.com>

On Tue, Oct 27, 2026 at 05:05:31PM -0600, James Hilliard wrote:
> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
> 
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

