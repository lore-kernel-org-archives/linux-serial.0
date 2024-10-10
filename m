Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2F3A268;
	Thu, 10 Oct 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540766; cv=none; b=lLoe9OYfKIE5Fnss3OIBIaFY1hzzVtFO4b6f3jBiYenPbSiBEiSd8U1WnLHKnb89RftWX5ds3h3PnVz/jTuF/RBw4XHl0MAVuoUBlBBL0bM7Ln7eJGNi3qNLtCshURM6l4QqYTb2KmThAOMpGFp5/Wwmw0P6XlXhUYhUZNHSWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540766; c=relaxed/simple;
	bh=RSlw7l0cabl6wOx55r750YjZqE2kSodlcvE52712u28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHbzmol7bXaGfajGBhQqP7UNWROJKcAQoGWFEoeHfcRZ5c/o8zYHBlIK3RR4OnB13SE2S9MHykYpJTTEP4ONqujOFS8Vtl1bEpUo1vW9Q4gUmTF1ro9G+RZOWFrkhr9v5FtWGnIR3dalX72AnbxomU9UQvZwMpsqh7I8+FL3UDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvHEwupo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvHEwupo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2074DC4CEC6;
	Thu, 10 Oct 2024 06:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728540766;
	bh=RSlw7l0cabl6wOx55r750YjZqE2kSodlcvE52712u28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvHEwupoOFlkFA68blGTmEGN9C3ieIL7cXJpRAw/wiNTPuE9CGVqfJkoAJYuiH+AV
	 dWqXFnLrvM1do3roPxoAJKdAbFYXoTSiK/bTVNFkGfkF5CQd5QibZfYHZB7LbUhpEq
	 YxsZ8a4tOk9KnP7lYnaf6Kf95QWgxkp6+FjvZ3ILGIeAm3mND/3NFwFMlj+tfTlLrh
	 eKeUjc0bs6WV4icQyYco+cM7XrBASA3gEv92Nv8au4q+DN4L2+nXooH7DrNJdWVkzh
	 nU7eTKZmh+E4rnqD2Ai1hmvZxez6RbAfqlLgU4rGEM6ZrfmdxbQ8tArq4k+FnnfS3k
	 rEaI4/y/Mx9sg==
Date: Thu, 10 Oct 2024 08:12:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <oyvqsywyznanpx5oflnemcsrk7r7nnhvxl6ly7b55oan2boi5d@kobrtldqbj6m>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009233908.153188-2-inochiama@gmail.com>

On Thu, Oct 10, 2024 at 07:39:05AM +0800, Inochi Amaoto wrote:
> Add compatibles string for the Sophgo SG2044 uarts.

This we see from the diff, say something about hardware.

> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 4cdb0dcaccf3..6963f89a1848 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -58,6 +58,10 @@ properties:
>                - brcm,bcm11351-dw-apb-uart
>                - brcm,bcm21664-dw-apb-uart
>            - const: snps,dw-apb-uart
> +      - items:
> +          - enum:
> +              - sophgo,sg2044-uart

I would just add it to starfive enum, but this is fine as well.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

