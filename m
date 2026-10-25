Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966447;
	b=EUKt+hJGza0Oifi+AbaPI1ba94Rw55gdrKA//hF6S/kwxRO9wkcVNJA0UloKJrPu/+i+
	 EyL4AnZmyP8utNeBhpq4b1gXeQ2fv5Ux+VVhTRHYwmfOrtvOI05e9pz5GgBl0l7LGjRus
	 Cci08mqp7uUraWvNQauraGejIY/RH7YcOOQpspugV1Au+MbBgC87rWZ1urDAbxM+4VjHh
	 TLetxdHyLBLhhaMrZnOBv3P1G10joh3Emr1waLsXHLjsAzkPQePkNNsbmg6j7SQS8Ajjd
	 rvEKRY50O/X+v7yNEcYfMve6zW+AGQaXlOrEkqgnOQfh3j/ftkVeon9bX1e3UrOpJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966447;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=z+OGvBaqXC2+1NVfUpcRsQ1hy6WHpkZO2inZyh4ifHs=;
	b=dgeneKDphB8HzTFh7x/vQRyFrojCo/YsKcpa8jjyrLZeaXt0/MpjJ+Jmw/NEZqSMcw3E
	 Vl3CrQF+dGTxrzzuCbCXZ5NOSDY70qhHkOL1DdlfIrscTMdK0Ejcez7trJ7wV+SG3jZnx
	 bkhASYsP4crbxCkWOcM2cRNV+5jr0M5Pq98hTEYhkUp5Lh8cPN6l3pt0YyTU2xbkA7cgz
	 ilAV0KXYjWeDjSt5HT8DJHgOiw4uXiXIiwX0Jhs/oBtgg62CkTK7pDREXd0H0quQGDShZ
	 zgGDpZ4h6i64C4C3+QN2JfS2EBqJpt50dRJrTJEbMRdr5N5GqnGlhWrEs29lV0E75ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8242606A31A;
	Sun, 25 Oct 2026 22:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8242606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <c930c184b1bcac3cfd76ecb329a8c478482d819d.camel@crapouillou.net>
Subject: Re: [PATCH v2 2/2] serial: 8250_ingenic: Set UMR and UACR at probe
From: Paul Cercueil <paul@crapouillou.net>
To: Olivier Louvignes <olivier@mgcrea.io>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 23:13:59 +0100
In-Reply-To: <20261024220712.23250-3-olivier@mgcrea.io>
References: <20261024220712.23250-1-olivier@mgcrea.io>
	 <20261024220712.23250-3-olivier@mgcrea.io>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Olivier,

Le dimanche 25 octobre 2026 =C3=A0 00:07 +0200, Olivier Louvignes a =C3=A9c=
rit=C2=A0:
> Ingenic UARTs have two registers beyond the 16550's: UMR, the number
> of
> clocks a bit takes, and UACR, which adds one clock to chosen bits of
> a
> frame, for fractional baud rates. The JZ4725, JZ4740, JZ4755, JZ4760,
> X1000, X1830, X2000 and X1600 programming manuals all have them at
> 0x24
> and 0x28. The divisor the 8250 core computes assumes 16 clocks a bit
> and
> none added.
>=20
> The driver never writes them, so a UART keeps whatever was there
> before.
> On a HiBy R1 (X1600) the vendor boot loader sets UMR to 8 on its
> console
> UART, and the vendor kernel had left 8 on UART0, which carries the
> Bluetooth chip: every rate came out doubled, and the chip never
> answered
> ("command 0xfc18 tx timeout" from hci_bcm). Their reset value, 0,
> which
> the X1000 and X1600 manuals call normal mode, does not work on the
> X1600
> either: with UMR at 0 the same command times out.
>=20
> Set UMR to 16 and UACR to 0 at probe.
>=20
> Tested on a HiBy R1: with UMR at 0 or 8 the BCM43430A1 on UART0 fails
> to
> set up; with this patch it comes up at 1.5 Mbaud and streams A2DP
> audio.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> =C2=A0drivers/tty/serial/8250/8250_ingenic.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c
> b/drivers/tty/serial/8250/8250_ingenic.c
> index 0cdadacd7019..ca45e74b999b 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -40,6 +40,10 @@ static const struct of_device_id of_match[];
> =C2=A0#define UART_MCR_MDCE	BIT(7)
> =C2=A0#define UART_MCR_FCM	BIT(6)
> =C2=A0
> +/* Clocks a bit, and an extra clock for chosen bits */
> +#define UART_UMR	9
> +#define UART_UACR	10
> +
> =C2=A0static struct earlycon_device *early_device;
> =C2=A0
> =C2=A0static uint8_t early_in(struct uart_port *port, int offset)
> @@ -298,6 +302,14 @@ static int ingenic_uart_probe(struct
> platform_device *pdev)
> =C2=A0	}
> =C2=A0	uart.port.uartclk =3D clk_get_rate(data->clk_baud);
> =C2=A0
> +	/*
> +	 * The 8250 core's divisor assumes 16 clocks a bit. Whatever
> ran before
> +	 * may have left another count, and on the X1600 even the
> reset value,
> +	 * 0, does not give 16.
> +	 */
> +	writel(16, uart.port.membase + (UART_UMR <<
> uart.port.regshift));
> +	writel(0, uart.port.membase + (UART_UACR <<
> uart.port.regshift));
> +
> =C2=A0	data->uport =3D serial8250_register_8250_port(&uart);
> =C2=A0	if (IS_ERR(data->uport)) {
> =C2=A0		err =3D PTR_ERR(data->uport);


This assumes that these registers are available on all Ingenic SoCs,
which is not the case. Looking at the PM it looks like they were added
in the JZ4725B.

Cheers,
-Paul
