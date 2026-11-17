Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947657;
	b=w9nPU64en7wIg3PWRJl4WiO2gJtNioaq0t6IwhWL9nDrWIakEb+lxbpQVXpIlB/nMYaP
	 iqhNQtL7taQWTwpyBQH3yhZn534qujsa6io3HPAEZ4ZoDzYQcGAgf21TNNjnDcO1jH+XD
	 Iz06oEMEI9wKlIteTUkwYEKCxc3xKk6zBz1Pb3JjzVWc++W/Rjm4OhZ21Y/wXdpoytoNi
	 Q47f4R/296954Hw5ZYaLH4Q3t+7MNnJZ1TOS6o7t5L8+AGDQGkVmtFky3PRzj/O6RHdvi
	 /7/i6GonvWfMnBuNmyWmR5dcAhuePF/qIGq9NUakdF/dadPkBhiRcC3cNlgoBO7NX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nRy/f/Glwbl9wOENpwdSTj0c98Db6m1fGpFPIoB5VrQ=;
	b=FlEj1pD4qNcZXL6BfUEfmU2Ci4DG60ItK5SEpJsqegHUEqra8sFftiCdjD7SocXq3foq
	 KLKjAtVym29LcWOlRqqeeI/oABXaARVuxBX4gBAzss1imd2Z6Q3gIARSXgKSJ+9xfLK4p
	 X7cTyk5Rtbof/um5Ldr5zVTuJBFKj5Nu/5D/JpWlsYIiJuyhGoZxUMhvb/D93uofMHSCW
	 S4jPStpRJRxRGYiHz6ab/u1/P0bqZu6qZj7nJqLqr3/jLfpzy5WN57rgD+FHdo40tMUy3
	 7iN86vIwT6/fRov1YMOeUHs5GvlK1zfCSqXExbfnHsjlBixRLc16Q9p13TU7Jdg8AsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoWgbsFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA5606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoWgbsFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A48E1F000C4;
	Tue, 17 Nov 2026 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947657;
	bh=nRy/f/Glwbl9wOENpwdSTj0c98Db6m1fGpFPIoB5VrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoWgbsFVj5jpAH+0c9+vTTgZq3TN51rsuii+kCDHCwCssbmkUrh+KLlooa0qF42kW
	 xgoweBONkSHIY7JNYyoTBK2Q4tixnGFTk5GSfGkZYkWb36GulCvgD/BaqYXQqA79sW
	 DGXZTC0JAdbtriBjtApbQZcFoBv2SRTsw+e0KPOldDQ3NeomBwwncc1Q4skX7G2w7D
	 C5vAV48byUqvweAMLELPwGg0uLB2WgNoDvLtFGKorsluLP691n7E629Gp5M6GkxW7a
	 uVwPc52GoBFVH9VJdi9PJ8nav1ua5UtUcPC2eSoBBSyK4Y5v6DmX0Ghlb/QADDy2tw
	 LYorh0iRPdenQ==
Message-ID: <sashiko-outbox-219625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/16] HID: ft260: i2c: reject an I2C clock outside
 the supported range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-14-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-14-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:34:16 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D13

