Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EF140E3C;
	Mon, 20 Jan 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737359335; cv=none; b=ffhlFlZTPUBkC+tCKEoOCaDvNj5R4VgxSGrO42AVGJAnnCz1r/qXS/PXfv+cwMqAWVJwWzDI3k/6oX6C8vqDddbQevE4CbKZa3YjjruA1hSr4GlCvmxFt/JIDkFrU1HotQ507+MtvFNVhDM+6wqgJoepvHvonBpz/dkN7tcVbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737359335; c=relaxed/simple;
	bh=AVe0TpUsodNDUwpn/VFfru4zZGcQsfzhz2oRw5R/tos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0p8J1OE6gklHaeya1O6AzmlEBcygN2g8TFoZ7r4QOJlTTpUU+1KYAX8qhXx3/2tRroRCVb0nr4Stm6l2m2tYY74aJaE8wJMKTwrpbF+EJtAPP8ZCiA7A/l5qUvivz4aUWwSpO5XvQnrIXJz+KBcB25qVg/k0vowAT2xWwtB4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty5YJTLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty5YJTLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BF7C4CEDD;
	Mon, 20 Jan 2025 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737359334;
	bh=AVe0TpUsodNDUwpn/VFfru4zZGcQsfzhz2oRw5R/tos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ty5YJTLiwFuQpFvJ2BNhKTsda9rOhQm2uRBUmUBv7d4IO/EhN4+39f7uJNMPaMetW
	 4PXwq1tidj/spyUWQEMns9fcO8jkpAyfnaY1LjhtzS92Uvio8KvkHwJ+Ep3mXXY33j
	 ylhiPsXjxxBLZEk0sGuYhSHru6+oT8EqWND+Ab5uZock/F5Crna7j/s2NbAlqb08FK
	 8HG5SB4/BbfD+iJDJ2RTYM0dHdwOnWNHM614fdFAqACv/ipqPec1V2y5OTI8VHhWhl
	 mZmHOfZ8YI2X+2ACj3J0svYT02JCQTqKBSksDiL4FKphTWnn/r2/5V/qm8rwmCfALm
	 nA4oCEWq4IsoQ==
Date: Mon, 20 Jan 2025 08:48:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	wenhua lin <wenhua.lin1994@gmail.com>, Xiongpeng Wu <xiongpeng.wu@unisoc.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: Re: [PATCH V2] dt-bindings: serial: Add a new compatible string for
 UMS9632
Message-ID: <20250120-talented-octopus-of-serendipity-aa8a58@krzk-bin>
References: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com>

On Mon, Jan 20, 2025 at 11:22:12AM +0800, Wenhua Lin wrote:
> The sc9632-uart is incompatible
> with sc9836-uart, Add sc9632-uart dedicated compatible

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Missing full stop.

Your commit msg should explain briefly why sc9632-uart is incompatible
with sc9836-uart.

> for representing uart of the new project UMS9632 SoC.
> 
> Change in V2:
> -Change commit message in PATCH 2/2.
> -Modify the compatible string of enum in PATCH 2/2.

Changelog goes to changelog place, under ---.

> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> index a2a5056eba04..83582aa6c750 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> @@ -17,13 +17,17 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - sprd,sc9632-uart
>                - sprd,sc9860-uart
>                - sprd,sc9863a-uart
>                - sprd,ums512-uart
>                - sprd,ums9620-uart
>            - const: sprd,sc9836-uart
>        - const: sprd,sc9836-uart
> +      - items:
> +          - enum:
> +              - sprd,ums9632-uart
> +          - const: sprd,sc9632-uart

Lists are ordered by fallback, so this goes before list ending
sprd,sc9836-uart. Do not break orders by putting everything always at
the end.

> +      - const: sprd,sc9632-uart

Combine two such const items into enum:
  - enum
      - sprd,sc9632-uart
      - sprd,sc9836-uart

Best regards,
Krzysztof

