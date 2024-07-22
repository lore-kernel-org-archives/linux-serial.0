Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0B56477;
	Mon, 22 Jul 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690618; cv=none; b=qMz0iP2Ys+Xg1Vo0HX1N9aPAXyHI8RWPULENdBBabLMRBjh9fNtZGf8wbBY+4pcB/SgMFjsWiilzxgA4soSxxbLfzCic6QCJNAunYmBuIeduSnE/8nprr29RiF369YbqE+y65SdFCt83J2gYEf8KeUWYPV9sx9/JrJPTgGeNq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690618; c=relaxed/simple;
	bh=I5QQcB+IVKFxhVdZEGPdhNG6yw4EYUCFeA5b78A2NvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHBb7uZfH7U1umwnVNi9hGVdJXXPV07lDPCbNWNSvjLh+zaiM48LvpO+jIcgsRgwNzMOcUOejjv4R+w7laf418DKaVlFJeQ+nn/zxf7Bu3O4s1DeUyCCTNKH/z/oPKPo8kPlfhkHeuJzNB9/t+ngiUWcc26lzc+WmjHtVwB9w0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjQB6qu/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjQB6qu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F9DC4AF0D;
	Mon, 22 Jul 2024 23:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721690618;
	bh=I5QQcB+IVKFxhVdZEGPdhNG6yw4EYUCFeA5b78A2NvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjQB6qu/ZHfS7HhsPNOKguDSz7Ud9U/HTLvktSWepqsmJsaCMYHXSpl5+JydTFlFf
	 SENFFBPuTU9D1WFpAQC4D9/B72JYkAX1DaBdtIdFRqav/0eu8GHdLyC90q6pDdWzMa
	 G8xIGJ81g8KhhhgGHTk9D1Tw7jIhDuJqaJnKf6AHh4dGnphwaIEodNCyHJwofiEQQv
	 C90I2GNqwCsJzmFuScHYUmObrZIz4MS3zgnGOeIZDIA32qQRtpw9KOFu50z63kH7PV
	 pxFrWz1LC9E4IVl7geOCV491UoHTJ/8Iyfmj8crs3pbdjYk+4LXPW1128bOcoYoEjm
	 gtBCQnuQJRdpQ==
Date: Mon, 22 Jul 2024 17:23:31 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: samsung: avoid duplicating
 permitted clock-names
Message-ID: <20240722232331.GA237402-robh@kernel.org>
References: <20240712-gs101-uart-binding-v4-0-24e9f8d4bdcb@linaro.org>
 <20240712-gs101-uart-binding-v4-1-24e9f8d4bdcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712-gs101-uart-binding-v4-1-24e9f8d4bdcb@linaro.org>

On Fri, Jul 12, 2024 at 03:51:17PM +0100, André Draszik wrote:
> This binding currently duplicates the permitted clock-names in various
> places, and when adding more compatibles, clock-names will have to be
> duplicated even more.
> 
> The reason is:
> 1) subschemas (-if: ...), still have to match the top-level:
>        pattern: '^clk_uart_baud[0-3]$'
> 2) there is one compatible that doesn't follow sequential numbering for
>    the clock names (samsung,s3c6400-uart)
> 3) when limiting the number of clock-names, we also want to enforce
>    sequential names
> Because of 1) and 2), the patterns can not simply be changed to
> constant strings, and later overridden in a different subschema (for
> samsung,s3c6400-uart only).
> 
> Since we can't populate the top-level clock-names based on the
> compatible, and because when limiting the number of items we generally
> want sequential numbers and not a pattern, move the permitted strings
> into a subschema of its own and populate it based on the compatible:
>     * 'uart clk_uart_baud2 clk_uart_baud3' for the one outlier
>     * 'uart clk_uart_baud0..3' for everything else
> 
> This way we can avoid having to duplicate the permitted names
> everywhere.
> 
> While at it, add blank lines as per the universal style, which is to
> have blank lines between properties, except where they are booleans.
> 
> Also add another example using a compatible that uses the default
> clock-names scheme, as opposed to the existing example that uses
> samsung,s3c6400-uart's non-default clock-names. This allows testing
> both versions of the clock-names property when running
> dt_binding_check.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../devicetree/bindings/serial/samsung_uart.yaml   | 63 +++++++++++++++++-----
>  1 file changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 0f0131026911..cfa1c0de946f 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -58,12 +58,7 @@ properties:
>    clock-names:
>      description: N = 0 is allowed for SoCs without internal baud clock mux.

The description doesn't really make sense on its own. I'd drop it.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

>      minItems: 2
> -    items:
> -      - const: uart
> -      - pattern: '^clk_uart_baud[0-3]$'
> -      - pattern: '^clk_uart_baud[0-3]$'
> -      - pattern: '^clk_uart_baud[0-3]$'
> -      - pattern: '^clk_uart_baud[0-3]$'
> +    maxItems: 5
