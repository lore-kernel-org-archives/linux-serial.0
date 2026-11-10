Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280647;
	b=4ze6J+whpNf7o16VTPIRva9G/zdNHTnGbfzhO4HEI+wpoBqG8XPO9cFGLrCa4ItpeYpG
	 Gj6u2zeBt0F7FwGlkc17Q9FH/D5zAxeOImrIOBnvm0im+mLQuxZHre5cso++BkIoroEws
	 vZhp0WWnQEpdblxDseMcN3imV9cXN9NAGKq+H6CXEJHGXCrRoZxzls5XJZEfwxBj+SFZE
	 urB+0qQh0ay8Qv1oA0IOiv+AkLKS2uQE1WAw6/TO3+O07yTq6I0HTNtNNtMyDuf+jAt7t
	 4PuJ6ku91jN3y7Sjt0XCSBkBk4cYmcnt3O1ZoFcLn4mLWKR/j0oSHhCT64Agmr4owTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=thQPzWbjKQuUvZjORi+sr51FzakrcT1P3wND8EOMMmY=;
	b=hrrNJVmGRNfRO3bMS9iI7tcl8gkXIEx0AHSX2PDDSlSTPZmEtFF5Okz6/LG8ew0buxjQ
	 4eQHtJllTWuzTYFiHAKB1eMPxu0VZCcvrx3XSw4tVfHdRQOxRBos85uxYaQstU6R9nJfa
	 HhoMVkt3z+5Yhf5VWyAJT3avAmJOCOfY2iZ1JwUph71L5laVYlPGNzrCvZbfp8oS77QBF
	 xntzojvVBJEXLF/wMQl2rhw76p4X4hxZPZV7z7GyZaNORA0XIiTe/gfOiPVVi5lEhPull
	 r3KoWp41YM4xE5zeafp+/oGHdbRebiYyTmdxIj8aYWgVPMYcL9ptF2l+fdI27BKJwYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aY8ppzE2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9C606A32A
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aY8ppzE2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658191F0089F;
	Tue, 10 Nov 2026 03:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280646;
	bh=thQPzWbjKQuUvZjORi+sr51FzakrcT1P3wND8EOMMmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aY8ppzE2NRmdvTitgMNq8izpOv48qB1l6vQzd6R6hVk6Q3yxf5AMYg1lDCgj/8b6Z
	 Bgf4QlIEUnd4nlitWdofVS2X4909t8+XVJhUtJHRwx6UnYUSRa0kb9VnA3BCVI2Jc9
	 i38vTfU7ouIADEWnTSVqX/WuBv/Suv77pd20AGJXi/VKFt0rhZymboPnAitQxW9km+
	 I55DhdjJUgIqTkCVZUlMfv+Euj6IfGG7BOhxr0BjxveJjZzU0Afp69OtTiJsBYX64u
	 aIPjQMWhJPUzjKUDFC1ce2vfHzrE5U+FvVIEYesNPqfTdC4/FEg9GwZr+UKnMiebNQ
	 98r0nsO/ijAHQ==
Message-ID: <sashiko-outbox-206101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/11] serial: 8250: widen RX trigger byte counts to
 16 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-3-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-3-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:17:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
> large as 2046 bytes. The byte-sized threshold tables, setter argument and
> sysfs parser cannot represent these values.
>=20
> Use u16 for the threshold tables and byte counts throughout the 8250
> conversion and sysfs paths, including the uart_port callback interface.
> Keep the FCR encoding byte-sized and preserve the existing threshold
> selection. The Moxa setter continues to validate against its 128-byte
> FIFO before writing the byte-sized trigger register.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D3

