Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800822;
	b=nqv7hpNWNruo89q4ULVx6N3VM+gkeY3EEDxFYpwZ664kLON3upZf4HRnCoB34i1ZKieW
	 eoiaLW7/pL8s4iDImCCwF6BznUM020cUZUNW6vuAp03V/LSLwtmb01pVzdVnnee4uo6uD
	 ICs2gl1hPmiz1eTJ2peW+OShohyMfVO3Ff901iNLHep7bWG8fgCRGORhlFmQU/o51eNM8
	 Ub90GeUM1HPxDj3Y1bzL5+gIO9TYA9dq4JHFK3Kt00n/GdynWkpEK6c3RLA3ECy2WfpZR
	 i8XBKLx4grpxoY4eXGHAttlYZp4dfAX31iboiFW15Q8LqQCPLZIUwrk1EOcS6qXEvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800822;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=61CuUOeHDW8dDdZR37JhqmhzQl6NXTpYOfa9wSiD3V0=;
	b=r9SLdqYXYM+tPqHs6LDjiVgjvcqSJXrUVQDy2GWxTGHN/MdoMQjJ6ma06Q3Avy4wBAN4
	 zGtBqvbxfJsuajoVPnyKdaHE83XWsdvKq+4UD8tWuJTn9OFrHifFbl9Twp+SDuqeIRwx+
	 1g+aV/OgBTolYQAHFJWyzVHiDBO3w7/ZyigtCDeg584B3fF7hgW4C6ps3NG5RsZNUqjZ0
	 /1Y4PGHrLcXQuugCgWTN2kKRlkFyrlEXSlifPj3Jd1FNOwP01ZdW78pkfThM0c8MewyHz
	 cEQ5kiYZJYmhhngg/gPXIrjgEIO8F0IBu9vopSSLivQtc0grLVom8PLmvfuCWx9QfYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfUrMjjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680C606A32C;
	Wed,  4 Nov 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfUrMjjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7430A1F000C1;
	Wed,  4 Nov 2026 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800821;
	bh=61CuUOeHDW8dDdZR37JhqmhzQl6NXTpYOfa9wSiD3V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bfUrMjjrWZdBgEiT5H+7eDonbfj0+aibeilCxJGiZw+btAdoqH9r6707tcbhdgR9h
	 dPIyL+LlG5Stm96YWtU8WoQk/OCyO5kY4VcDlzgT9UzJMmCapKo/rmYnzhM2+NoT6G
	 ErrCGYcqcC9W2H8yd42FT9sAmyA3XqhmnTTxPm29kCBgNx0xA8T1JI06U/XfLs31wa
	 b6Q5WKu1azP9fIcXsjlbZ4b6YaBXIXA7rxdK489VpquWwyxo0OSvBVpW2jyosOlpgD
	 dLlEiG3IqRFf387Ip6YJd9Vs+FiBDgOrY1i4uJfZtqSahZVopn9xKd5jk4L/hfWX8P
	 oX9FsCsuwM97A==
Date: Wed, 4 Nov 2026 15:00:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kohei Otsuka <kohei@spacemachines.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
Message-ID: <20261104-gregarious-zealous-stork-94efbe@quoll>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
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
In-Reply-To: <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>

On Tue, Nov 03, 2026 at 11:11:31AM +1100, Kohei Otsuka wrote:
> Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> including the fabric of PolarFire SoC. Its registers follow the 16550A,
> so ns16550a stays the fallback, but it raises no interrupt on TEMT,
> which the driver has to know about to support RS-485 on it.
> 
> Add microchip,core16550 with ns16550a as the fallback.
> 
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

