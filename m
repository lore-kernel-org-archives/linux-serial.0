Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6D3905E7;
	Wed, 24 Jun 2026 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285471; cv=none; b=jkRKKgtjfECtnT7ox/1s67ah57Edhj4Nko4gqXzOvUkVQoLwt+fIqZhvCnN9jJqSEYjs4pE5Gz2dm7IQmHLz+JV/CPlx/oSZh/V7QIx0azNWySoo/SYJbldfjSlDcL6gc+bEbxpyXs6Ojpznf2dmzNJHSSwLvaLGMmsjvWp5vYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285471; c=relaxed/simple;
	bh=z+sEhF0UpzA4ZQKD4WEiejTvVm0Ax2B0p+6K38YNGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsnc85Z/PR8fNnw70qsSj8eb/68a3Csb6sLYPn374rKv0A1r7lb2zCo/uGuchhMHhBh5+4WfNCtAnDl1BzBf+g1mioucYKa5dxmJdwBmAjTlXUkaW89VVK3bVs7ROcecNwJ0NehBLoKOQTjMCJsAilhb4NkaoMoBRdwDJi2m3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtuAD2as; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtuAD2as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B20D1F000E9;
	Wed, 24 Jun 2026 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782285470;
	bh=dP2bxkYNQAeUz5jXWdGEqjkG4n1wBe44kDAAGlvauTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LtuAD2asFoZDWxbMQVUtn9sTSbYKT59fb9iCV0goDWLpHd+yi/m7h/0gdHtW0eeDX
	 x4pZx/3/GwA9Q3xCVpNSB1QAEcqXvLK3JzACoc0Py0HZvjGupZq+7GRNGwsnGq3buW
	 hiyDbgF/jxMd0P9heVz3ZbV26O/y8VgN3KWIlyUSVpCXFTw7T0ML1vsUXWe7T799Is
	 T36sCSg0bsqR+d3e+2ipyN3NX+p1Mtx4P2HHEq3huzLy4KxoyXK5zYdWSz77P/nyK5
	 +hEFV3Ye5xpU3GzN0cLZkVIJS+3m6X+eYEO/9K1zgrcM8SdyVe5wsrVyYlCA6vlW2i
	 5a18kkJlgUqMQ==
Date: Wed, 24 Jun 2026 09:17:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
Message-ID: <20260624-original-vigorous-mayfly-dfceac@quoll>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>

On Tue, Jun 23, 2026 at 02:25:40PM +0000, Gr=C3=A9goire Layet wrote:
> The ASPEED AST2600 has 2 VUART accessible over PCI.

What does that mean? How UART can be accessible over PCI bus?


> This boolean can be set to specify if the VUART is used over PCI.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 3cbd0f532e15..b03797f4674d 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -26,6 +26,14 @@ allOf:
>            anyOf:
>              - const: aspeed,ast2500-vuart
>              - const: aspeed,ast2600-vuart
> +  - if:
> +      anyOf:
> +        - required:
> +            - aspeed,vuart-over-pci
> +    then:
> +      properties:
> +        compatible:
> +          const: aspeed,ast2600-vuart
>    - if:
>        properties:
>          compatible:
> @@ -312,6 +320,13 @@ properties:
>        polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
>        applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
> =20
> +  aspeed,vuart-over-pci:
> +    type: boolean
> +    default: false

There is no such syntax. Please do not introduce own style. Instead,
look at other files how this is done.

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Enable the VUART over the BMC PCI device. Only applicable to
> +      aspeed,ast2600-vuart.

Best regards,
Krzysztof

