Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926125;
	b=pdsr1EItzLBCcx7IkNnyR5B1/gKTyBU4azdZsS2me1Ouzg6z3eyc7VjTh6QaX1IAbBiN
	 65AxwOsCSRNgHgq7U16+YLFhu5FORVfXcPTbeMXU8GEVAD1YGv/vqXMQHmjcx+mF1O+iL
	 3p/JC1pklhTpzhtvH37KINaO1kQ2MxWgMjwNF9tgPbfRPv1YriXEUhGEHpuYZIFGDc+eW
	 PHKmBvVU7hxmTnBknskmgsz4i13J4XrJB7ty7mG4lkMUiChSoAxHkby6rBPcr9tom+s31
	 0h2V4WwSeokxHHRl8LfGsVcBlg3BZ30eZCMaqGJT1GjoTFO+9qroVJh43h8ucmKrMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b+fenH5BmPULvLKq7YoyufOI1RWjxWX1rFuVb8Gfnk4=;
	b=24jS8MssfFAhnNcZC7pTO8+l9AraIkibrEscFA9lgt0jA9qNypqTWAzFap1ikSHgo6dw
	 lnHeBg+UTI+YrTMefp5ujwgZA+fumGg9jTsmHOLsFY/eeOQcidNWvjmNSz2iW3d53uEsk
	 nF1k4tdVMIXjhlhIHu4vof5h9l3Kg3uUPjpjHrC6iUz0Nx9eZ9klHDSP1ZnbuXyC6XDpM
	 dssEctrRz9/sxGywVy6iWEVrkQn1EoAnHrJWcLNjEpeqECBGhIKl+2EWU1TH2MJyEXd5+
	 AmvPkUNlsiNepm7T4ZJJrkfPI+0Te3cN/anPzxtEFyT1qRZNyeOJ1YyUUn1hd5fj6Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jK36v8O8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D91606AF41
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jK36v8O8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08E1F000C6;
	Tue, 17 Nov 2026 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926124;
	bh=b+fenH5BmPULvLKq7YoyufOI1RWjxWX1rFuVb8Gfnk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jK36v8O8GRkjnn9Pz8SaXVJvGfkN6+0hJezQEz35Iaq0J/piFvrQyzLZe1OGeijws
	 HUkcbxjC6xZQjPQPMuIOfA/e0Kkp4LNe/A5NtS9D9DaNGasd7FYgfFBjOvoKNnXXte
	 wQ7zouAN8/p4cq2LljmL5/F0vccY1Wgbn+cEQwxb2P+Q7btDS9JFbwFNzDmDV4Kz/u
	 hxtfstnVEtc9Z5nQYKkCjdAD/UIYx8P32aDBE9jJKwBGZogCW0CueERMIOXFgaj0NS
	 pHXEQW3PvnrVYqVLFHxiH4srTCQy3Ts42zFO61+N45dDv9dNjBPtA5urXwvPP0DR/m
	 fXRdzB2IGDXrw==
Message-ID: <sashiko-outbox-218970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: mvebu-uart: drop of_match_ptr for ID table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramuel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117142115.18402-1-bramwelbarack89@gmail.com>
References: <20261117142115.18402-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:35:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> mvebu_uart_of_match[] is always compiled in and already referenced
> directly in mvebu_uart_probe(). Wrapping it in of_match_ptr() in
> mvebu_uart_platform_driver is redundant and prevents ACPI PRP0001
> matching when CONFIG_OF is disabled.
>=20
> Switch mvebu_uart_probe() from of_match_device() to
> device_get_match_data() and check for NULL so both Device Tree and
> ACPI PRP0001 bindings resolve match data safely. Also drop the
> now-unused forward declaration and <linux/of_device.h> include.
>=20
> Signed-off-by: Bramuel Barack <bramwelbarack89@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117142115.1840=
2-1-bramwelbarack89@gmail.com?part=3D1

