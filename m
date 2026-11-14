Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698140;
	b=Jwk30HZZkPSXQE99bRSfDEuewfDYmVOfV1QpwMV8+Vpx3QLBqwHpNZb0dd8wVNk2cmQB
	 EQrlYrQMw1ZZ9kDvWV2t/ErVQhJ8GfJ/WqTEluiijQYDK4rrx9N+0O3BJtuiZZt/6x9vh
	 klrrY6XYGkwoSpUtwHm7DB9FE1Gjj+pCOZVK2EtwLHxz7tJxG82l1yDJhkMPMK2VbDo02
	 STSrEFqz25/q92r1r67YANGQ6fhgxFJLLh5mZFiDdrtDesDfPu0a6gjqVh4zJuRyHePS+
	 sg0n/mrod+clJw9on/4caTyPsfoxlErLFw1J0BMPm1SzBK8FC233AqC3jIC5/p13VHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BoQ9Ek93WF5YC+zcuLj66LEiAW/4pHelm49BKCAg3Vo=;
	b=MgwZzU17NPstW9q5DBcfv6JF+Uef72igqbfnia5YCO4an52x8JSkZpznIjERAjdLmbqV
	 dZ8kaMWKdzj1pmg4ovFFU2nVj0rSDqObqKTOBCD7Dznep+yCEWivHJ5nHcEnndE2RPV1n
	 15zkreUSNJylI4wixhgRw6bifQRO6eg0SW2f/xh0VPLILKCw3+OzkyznIvbWbBkQJe1Fz
	 tY/PK4NjWl8gjXg5U7bN9q62shzXfghX9qFBKldt8Vav5CNxMa31cKs4a0XuRsaN/f2TF
	 EWx6WjzqgD1LNfCmfpC1mvYBJqof+qvwpULBDBjWLUPABfnKwyMLaliE+S+g1M05XNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNKmobyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0B606A32D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNKmobyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC531F000C4;
	Sat, 14 Nov 2026 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698140;
	bh=BoQ9Ek93WF5YC+zcuLj66LEiAW/4pHelm49BKCAg3Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNKmobyIJC0/kQBipVxEcZI5q5hffcAJDcg4Q4/eS2h9tmxT+Ml9ueiYQZPQvxbu6
	 pz0tbvUX4XMYYK+M70l67N+L04gvEF8VkXTlvUsqawb0TUDiUU0uKUztbyelrvGumM
	 V69I7BK980cnK0XD73JnX2Cy9N3jgwyopY2LQQL28prl6gNFmL8QfjIcjjnajRC1KH
	 IYmO2yiuFz5SWf1MxQnMcgNWGuXWyCImNk4NBZZmJm40uAGVRLKXghtfeCXn8hq+ou
	 0To2fw2UTaaRp5iEzLq7u2lW8ogsElvlpETOM7Fm073y3wrga2P4xJL8mYgbF4BIls
	 9TLVI88P8lF4A==
Message-ID: <sashiko-outbox-215093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] HID: ft260: i2c: reject an I2C clock outside
 the supported range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-14-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-14-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:15:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The clock sysfs attribute passes any 16-bit value to the chip. The chip
> accepts it, reports it back in the I2C status report that clock_show
> reads, and runs the bus at the 100 kHz default. A read of 2048 bytes
> takes the same 0.298 s after writing 50, 3500 or 65535 as it does after
> writing 100, while 60 and 3400 give 0.387 s and 0.058 s. Userspace has
> no way to see that the value was not applied.
>=20
> Refuse a value outside the 60-3400 kHz range named in the datasheet
> section 4.4.16. ft260_uart_change_speed() checks the baud rate against
> FT260_UART_CFG_BAUD_MIN and FT260_UART_CFG_BAUD_MAX, but termios has no
> error return, so it falls back to 9600. A sysfs store can return an
> error, so the clock store refuses the value.
>=20
> FT260_WORD_ATTR_STORE() takes the parse function as a parameter now, so
> a word attribute with no range of its own keeps passing kstrtou16.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D13

