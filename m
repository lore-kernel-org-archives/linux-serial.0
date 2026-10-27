Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099436;
	b=DI59vptgcURJEPyeQOVVup5XgOEZj3aJJdtkxi/G7n1Za3u7dpo/hFIkjDgOiLY6GO06
	 M7OY030K8+RjAW3womyVG1F4bLKd7z6H5b5TR9LCmvfxyq/IlSVEeqL1Y5eJ/XH45baJV
	 ptXmtiQRdKubwo5dFUvJCjASbnaWO5J9D43yvFu2uQCrGBdtAUZdJVhEENFy4aC3XBxyk
	 EmLf+EMzFyxqGM21le4PmtBjHHxmbN+HE+8NmNO5yn+KwaJczm8BQTTUdNjjqcCcj7T6n
	 kfD5MW6nGkqO7e8sXUS31DXC38ImHYwW0OWD2FMrrZ/bNsB9L6PrU/Z3z5Jlzi84l/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xNggA4q+TpD/ZeSmFeFebi6vf/sK19VL0PRq6EaS6K0=;
	b=A2BHDdsAhJfTGg8+W42bqkTzixePqNJF9OG0wgPGW81wkJZwuhwdJEPTb9i1Lp+zB7D2
	 t1kfwbhBj1D/KXHLvJnBEXMFZWfnJTs5bC2DZowWEZosROCjgSxwaIXA46elaYiI6yigF
	 UmMK3klPti2iaqTTIGzgvFs68Ko5S1zNIxSajCYyV+gbvhGn/VCPn6rF3MX8FBDNGxRoD
	 9LcgTgaLHIWTHw7MfwW3IOoLoeTI5E9J3h1IiBGLLHn3A11GgI94YHs3HuLmFOkfwRogz
	 uXbC0zh9XWL5qkC2YtAqi2/lhqT61jQL9TzPgdwKxU6GsCKzLIdirCeCkwIA3r9x13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3pIfyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB6606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3pIfyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0821F01828;
	Tue, 27 Oct 2026 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099436;
	bh=xNggA4q+TpD/ZeSmFeFebi6vf/sK19VL0PRq6EaS6K0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oi3pIfydi2YsS1/Nlw/WcBN38yEbO8Ykakx9k6mUoBeD90jGNoGjF2VkbmOZueLCB
	 2gRCRHezfi4hgdcmhlGj5DyiojvbXbW1fSWKQAEOG4s4wQ5UVTfrh0/y8RpI3xS/Ri
	 Ml02v0dv+R2Z+6OO+vh8jrNZRqJfjkgACTCUkcC5I+D+MDs4j2idh76gk19mbAmyNs
	 LgkNUtP4lyLxBfVsZd8CozBf299GtVpq2F4XHW041sRJmkYxDPfzkVSQc4uVUEFdBb
	 lqE2Gd2s1V3uNoNyGlo1h+wUg7oj+nU5qKK8q6LIPLYg9UqjR0DmUzTFvv9SSuQrkh
	 zq114ii4U2guQ==
Message-ID: <sashiko-outbox-186413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/24] serial: rda: free the interrupt on shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:10:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> rda_uart_startup() requests the interrupt, and nothing ever frees it.
> It is not shared, so once the port has been closed, the next startup
> fails with -EBUSY and the port cannot be opened any more.
>=20
> Free it in rda_uart_shutdown().
>=20
> Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
> Cc: stable <stable@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D20

