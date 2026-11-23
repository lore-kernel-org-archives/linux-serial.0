Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421107;
	b=yFGqk9meXmtS86UFo+/ZMeteAnbJp/wXaC139Xxgs0vhjyY03bwAmnB0JtEsiAo7dMu8
	 RnHYXZw0aW43UkfWmkgkgsmONoXxBIugz8pvZh1a4xLD0DaRCF04tA+cForo3w614onP5
	 vL93Ukf7xZAHQElmHnlT96ryey47e2VcEwtN9BX/hGe3N3kC8tOigQ56K588bTPXEmvbo
	 mzCUPIptYnyfWI08F3+NAvhkgPNkwR2lMvghX34yDi2TXq9h5ewPqndy8g4OPIZDXZKU5
	 jdlEy86izLdlyrFHMlOnzPax437QPty6r0Q9qkQeqo37RPu/oEc8y3S41qlHY1+z3QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421107;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o4peE0p1m9ymdcEvc6zRqR5rP046CaZWbOSOX4usTmY=;
	b=mG6+trvth7ERF4oRp6s902VvT0l+LpGjUn3NRaBcmyHdMxpba8SyhyB/Dc495wt57IXa
	 frohctV3W35gMafUu1Iw5q5Lw1hYRnYCyCp2+WFERBNfC124CoBYs3GGmZlPP8Q27aRga
	 A5QqseGT2tAkMS7WJ2vcJgCw1n/UG2b4sAsbTpkFZl6xIP15abQzuVkNhxf/yr6Jl63vg
	 M8ng8pgWziQCdAOmI9gtHdGM+OCSSbXfpV/wle2hh8r2T22qGtqyv+yvpfs9A2EoS3RqC
	 y9ZIotDzTJZPHqiM/bu35WqtwdBucu2tC0lwE3AKHqe/A6mssC9n3mUQfRQMLmzushQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbDxrkhD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418B60A261D;
	Mon, 23 Nov 2026 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbDxrkhD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E3F1F000C6;
	Mon, 23 Nov 2026 08:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421106;
	bh=o4peE0p1m9ymdcEvc6zRqR5rP046CaZWbOSOX4usTmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbDxrkhDXnWCBo86dRP9pksaLaORPwt1MsBxZTE1ZjYvTFIfIZskTOUV/eJWXoLjQ
	 m7uo/s6BmqVD5mwoq7Zie6OKj39W2LDmsnVxcIIHiVuUppey+6nKkhA7Q2tfKTeHgq
	 mBOsIdx+XLO+flTLZfH+DieZky5rNpP+bLFqQnzJoo9ENcrgU+UGoHrf5eIINRvxTc
	 1TVd1Tc0+b28XW2xe8MXBQ0sLX1kMTcwyH7vAk35LBcHOFX2qULpKGWjaKv9oFFnmf
	 kVIEjKLjcN4UBkPYKSS7QxamA+/zQXw2n1mEQJVsID+ZDJJdP5PswvBrXd385cRGpt
	 vPU5b08TuNNEQ==
Date: Mon, 23 Nov 2026 09:05:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Christoph Niedermaier <cniedermaier@dh-electronics.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Lino Sanfilippo <l.sanfilippo@kunbus.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 6/7] dt-bindings: serial: max310x: Add
 maxim,tristate-when-closed
Message-ID: <20261123-tacky-hospitable-wasp-ff6ac6@quoll>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>
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
In-Reply-To: <20261111-serial-transceiver-supply-v1-6-40bad0f912f2@vaisala.com>

On Wed, Nov 11, 2026 at 12:28:05PM +0000, Tapio Reijonen wrote:
> The MAX310x UARTs can three-state TX and RTS per channel. Add a
> per-channel flag asking for that whenever the port is not open, for
> boards where the outputs must stay undriven then: a driven output
> would back-feed an unpowered part behind the pins, or fight another
> device driving the line.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  .../devicetree/bindings/serial/maxim,max310x.yaml        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
> index e598dda4d13f514820ed8012f2fb2fc2aba3e669..f54296f6b6c85e3a6246e210af9ea8ee6af5118b 100644
> --- a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
> +++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
> @@ -54,6 +54,16 @@ required:
>    - clocks
>    - clock-names
>  
> +$defs:
> +  maxim,tristate-when-closed:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Three-state the channel's TX and RTS outputs whenever the port is
> +      not open, from probe until the first open and after each close.
> +      For boards where a driven output would back-feed an unpowered part
> +      behind the pins, or where another device drives the line while the
> +      port is closed. The board defines the levels the outputs float to.

Property name and description should reflect hardware characteristic,
not what OS should do.

Best regards,
Krzysztof

