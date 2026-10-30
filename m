Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380717;
	b=Kg3gLXaQaL/Zj1Z5+TwVffVSWkGJPmslrTIRur5p/ZhKCj7B7Qdgb0s4xRzg+OHKkAfm
	 FvzPaAd3RiePvFT0UZa1/H5nHf0wRSCzz0UmlLto05KkNnyso5SCZ1JJfGQo2OGKDi8V6
	 eNHG7G8ti9bQUUpTE6HwU2WbqwMe82EZKvUsP57yA7sfZ3fqK4psX1bqHW6cDhfVwva2e
	 OFHslALuNLYqc73VpZuhDjdiQKSdujZKwQs8jvfHL8mH94NwoiRlzXeg8K73IRXb8DoFL
	 GTob7MaJpm2uPM2esZqhcISI+/yfSZYY25btH1uQrCfweXRw/ieQ7dnY8u51opbpuxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380717;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f0J1NexokFrsbt6L2QLM1JqYkGp3ZtPOpWlDKM8B44E=;
	b=h9gNs5AH23fr5b9hCyw8s1X83R6XDmyDSEhcQTDwDUL4mTJpdSBbZ33eBMKCTyZ9vs1f
	 UNuzJDcY/b+2lsNOe6bfWNui6lzpMNZuwNvoaKTp+dCuGSQu+t+8fL3XICcCdRphuS+g9
	 ZkqKP4uMrhl8O/NaDVxuKFUIi9sB2Jg+7uouGEugyvYxrojv3vvYpj+uCGFfFJ3EM1Q20
	 71eI7M2iVDChzTV9o4xBwS8IiJjsH2RXDzVmqbQGVAAbcFlyFaP9V0YisEZ4OjnF4pe/h
	 wcBm9UHaPVF9IdXMYdEIdl+yxn5RYvzORakFl9eIeV9YNKycxssXbj6bf6lYYsA0tXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuIMhy4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4A606A31A;
	Fri, 30 Oct 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuIMhy4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511871F000C1;
	Fri, 30 Oct 2026 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380716;
	bh=f0J1NexokFrsbt6L2QLM1JqYkGp3ZtPOpWlDKM8B44E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CuIMhy4GI7rovRb0LKJ/w0uvcgQGG31/MtOwSXy+CF156tTmXRYiGmxQJWm5cXAK6
	 dvqjM+MVjw/9yv3nqAW3A2CxVa38UAuUy4J8TTZMQjYuzHV03b7t56HYI5SFPyiAQc
	 joaAV47H7q2MCyis5ZSPJ20YFnMSHOOaJSEaQxvh9zpdL2ycrQvSPSFRdb+qOn7OKb
	 cmYYCDflFkQhB9MyJh+BdBExVXQhElxIP2tYa6/BLZJ0Q6Bg4wGJ0kk2pz3AwkU+x8
	 t+ypeHDzLKXDHDq3Ow0XNfnawK42/x42M8Sq/I4Y4eThuc1ZN/GU79SoAUF6nDkNcM
	 GbqA76Ut57HYg==
Date: Fri, 30 Oct 2026 12:18:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-serial@vger.kernel.org,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: Add transceiver
 interface select GPIO
Message-ID: <179338071267.753668.5885694159550862563.robh@kernel.org>
References: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
 <20261021-serial-rs485-mode-gpio-v1-1-80d7b0903d93@vaisala.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-serial-rs485-mode-gpio-v1-1-80d7b0903d93@vaisala.com>


On Wed, 21 Oct 2026 05:19:38 +0000, Tapio Reijonen wrote:
> Multiprotocol transceivers such as the LTC2873 provide both an RS232
> and an RS485 interface on the same bus pins and choose between them
> with an interface select input: on the LTC2873 a logic low on the
> 485/232 pin enables RS232 mode and a high enables RS485 mode.
> 
> Add an optional rs485-select-gpios property for that input, next to
> the existing rs485-term-gpios and rs485-rx-during-tx-gpios. The active
> state selects the RS485 interface, the inactive state selects the
> transceiver's alternative interface, RS232 on the LTC2873.
> 
> Assisted-by: LLM
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

