Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698421;
	b=2vqVX27bbqdKPoRnC0TFjwNPEGx4Yg/L3oVuQjQu0TrsqsTK3fcbcKhKQkFvHTvjOTdh
	 aSrlZnS6u4vHIwXxAbl6Xin/sW3ihH5kWwY9SAIwfaKYYrABuDmiMA3dTT/0dGWyRfWn9
	 0o+2uodtPktyJ3L6GOjXW+ax6d7B1P4ei498UHSrC9qw7kpp/RDRFzUifR1cU2WVg3K0l
	 qMcc330dWXQFw2hYLCL2p8g2jUvyEHItsLo6qwDuFuX+tDtHGXpaigk2pUdTXky7t5Pf2
	 LDmNP679EcSyO8l/k7XAA96I4z21Zq+QFGbJLJfhmTQY30wcom6YwA7BuZgFqur9tOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rOojiymOXssWJHlavPcUTqrwWFYPOLI+M8Hwk3ZAUIY=;
	b=G1Gy2vk0PaxKU07i90eow/hzmwiFdQS7tynqn8x2gACW0PpLQesAYBuxSwfei9x4Sze/
	 zsuAgYRCQtK95v8ExK5eSXJh8Tbq0rNYkYPEKwFZ/vd/xC6bpYt73JKWpxsAD7yM9BAUr
	 6cmJbinPQvF/sv7IeSgIAfh7tCUaMfcPVcw0nvW/wUkcf+mU9HYT3va2NpR7CUkVVPlYy
	 ob54Vkivmb2R5Uim/xX98zuiyFwFFKdZY3jKkUI18lp3qYmBKIloTSshke8P5zui2yViG
	 0mi8fShGOAvaXRSR61RaEW/vK8WTTudFNtRjYxq10w7ZOghOund+a8mcAxh71lm2Pfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXMR0zCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07966606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXMR0zCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B23E1F000CC;
	Sat, 14 Nov 2026 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698420;
	bh=rOojiymOXssWJHlavPcUTqrwWFYPOLI+M8Hwk3ZAUIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXMR0zCHq4oHfG44aPSwIuULWt/LAiJkVWrClh90ygdelalT0vScQ1mUrEuY3aKGg
	 Vl+Ok2RNiOV1dHxHC9fDi5JE2v7dw8eywr92i9sy49o1REiSsyIsFpjggrpgWAJ65Y
	 8m8KOj+HwTyXBOnYGLTznmPm2lU7CVCaeLxlVz60HNYaGW2RfR9OZaTnVhXdzk39Jn
	 ZtDG+Q5UoKXBqHDknjpx7E6l5xqZVwALHWpy0I0BXv5/rSw4a1fKKRQe1VeiQ6312K
	 Ob8KG+21fsphJaNkKH6mELfmqmp1lYu0sII/DCTC/jfwizWSimA4lJN76EI59e6pET
	 4mo3PYWiQMEEw==
Message-ID: <sashiko-outbox-215100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-9-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-9-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:20:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
> can drive DTR/RTS when the modem pins are in GPIO mode. This enables
> programming an ESP32 over the FT260 with esptool, which resets the chip
> via those lines.
>=20
> Set up the gpiochip and the sysfs attributes on the UART interface when
> the chip mode has UART, and on the I2C interface only in the I2C-only
> mode. Before, the choice depended on USB interface number 0, which is
> the I2C interface in mode 3, but TIOCMGET and TIOCMSET run on the UART
> interface and need the GPIO state there. Add DCD and RI (GPIO4 and
> GPIO5) to the GPIO set of UART modes 3 and 4, so the mask that TIOCMGET
> and TIOCMSET check covers the two lines that TIOCMGET reports.
>=20
> The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
> sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
> [ ... ]
> instead of using hdev after hid_hw_stop().
>=20
> Co-developed-by: Rio Liu <rio@r26.me>
> Signed-off-by: Rio Liu <rio@r26.me>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D8

