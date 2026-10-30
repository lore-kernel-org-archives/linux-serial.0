Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356131;
	b=UD9gFtalaeha5XzWhHvAECZZGZEvWA2Jl+WcQYnvK0QBXZOPIhw8Bh26lOMgRPwTqQYY
	 s0j6hxJLIOrUA1ye6r0BXL6/khzys6TKVPRvGvPHEKza3az8BZynS0g+7ijV7s60pMU5O
	 Uo/HTHg/kxciYTzF76aKYSNHdlxJxSg4ZXCflPHGx1T8LXlJSJxljtMwRNyDkRKMlPf9Y
	 HvuF8WejLzYqQIDympSkIewwK1xgHf5yZ5lnUEuF0TCouC2ZlxaWP8iPJoBxDhFbk1cdL
	 289z5ajW7zv/pfmNtBp0tikGusQZTBiw2M4vsCjREmP2esU24Pql5je+PG6vhHUg9cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356131;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mGS4GI/jAb9ZPIqUcHBrz7HIHg2WVEdgOBXskoS5LME=;
	b=qgzy85JQ8XB9dYZQQPWUwtA65+cpl5IQoOhf0OE+G2GYWOgGVbpUzy3HZCBmPqdNzzeR
	 AJKwYaWqS71KOiLbegmggjGe5diQAJcF9JfQlYstFag6AedwxL7SANdNuLrJACQIHrpHO
	 c8teMuAMNfCkaglhqrYEDivBEz4SYV8S02aKkE+kglda3vF+OxhEalZgFRl/4i40y6HHI
	 xYXjC6bf+dGhTlgQYRpo9bGOHSAvHYpDQGXwJrxnyJRNmC1CnZhAyn54vIFOrZlQZhmQF
	 925CBGNOBizUaj21mQPanrRd1Cu5f9PHAd1HO1+SJNUb7ERLK7zcxTKBa+v8dewQYSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c51QBABz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D860A261A;
	Fri, 30 Oct 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c51QBABz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680811F00A16;
	Fri, 30 Oct 2026 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356131;
	bh=mGS4GI/jAb9ZPIqUcHBrz7HIHg2WVEdgOBXskoS5LME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c51QBABzlB1Z0L7tkhHFjdXxIEvBUzlTIrGg5pqBlRLYGH3ZtTsTHI1pnjKlD8zVT
	 bJqu78k8kaH4rA6Cz1BgopPQ79CxJbvHU+zpDEQJXASmYM+enIwCgWGR+JfXrqzjZh
	 XUPlLgwMvM/Fm3FVPxcHeXZEHpczGVGJYSFSX9GTkKgsZ5m0sM6pbkj29sZhsYBIYZ
	 EyTHGZs9IVXf7t1A81a5dp5BvLnG8B9yU7JNrYJJFguN5UVXsNWayOr0X6UKB5ouLk
	 TmOOxU7AjBRkngMFvKt6YSgpIHodyu9DhDM0+ih6ys21rd8mC0Oq3H9Bi3emo+AAkY
	 OBO4HUZzXLUww==
Date: Fri, 30 Oct 2026 11:28:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 6/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Message-ID: <20261030-chital-of-pragmatic-enthusiasm-837a0e@quoll>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-6-53b433aebbf8@gmail.com>
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
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-6-53b433aebbf8@gmail.com>

On Thu, Oct 29, 2026 at 12:47:27PM -0600, James Hilliard wrote:
> The A523 UART integration has different FIFO depths across its controllers
> and reports each controller's depth in the FIFO Clock Control register.
> Its receive thresholds are fractions of that depth, and its optional
> register layout differs from the generic DesignWare integration.
> 
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

