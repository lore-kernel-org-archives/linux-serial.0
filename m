Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650041;
	b=oXNjgfrmW5KgqAAHAzRxqskvyJSDj3pcTT4bEN9Bkk0HBMXjgk8mQR6GSxg9hwuJRbEs
	 8WbdShSmqAANPcriQVnZJinXbLUbmBfyy4UBZSZQLaeCZYQ/8kuF9of8lefQ3uMQi9WOy
	 cWwRyfy+05D9s+9KnXSYpimc7BEcbgNXfnSc+IfD9MxbshjcKTRVPL6ULh2TfjJpjdWIc
	 F9G4hVqEK3dJ9qKpqo5NfEhYJgGQvCHAB6w7IdKI3QUrLcl9G6tK45EQasAH1eOFhpkAR
	 Dg0sFVQyonE4qDvah3SygGvutEJ95YV+IoO39nF6npnV/ToGqCfkdFouj6joQKI8Zzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3EsD2Fiv+rcPN4PTsRVE/IRYxSXswOju23bxocfgRH4=;
	b=fo7TettPMK5/rza4yqG22PCRg9u8muOLD3fuUU8Gbg6n83LDCUokJW4eenYWX3KyM1ke
	 3zs4WxF33P7CK/2odgSbHfMVe0utQTU5foHbtk5MYz2kemQfxwAxkk+swo1sqDLUr4Jye
	 06DyLt9a/IwbfRBU3z80Vynr2CHYeK2okAY8zfQLuqLGrsyePyzBwApSuCq7cDDof828w
	 VvcYmb5/l9E3CqyTjSwTu3ndgEsqMXIXp2KgdTouFhJxv4myEH0Zk8jpllVNUOdTEJuXi
	 ICkKyQFBkM9kiMxN3INO7cnLqB2hwg0KQEh6sCMAN+Tfr9QAfm8Jy36Js5g8qVT0apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIVDF5Jd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A32606A32D
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIVDF5Jd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654B51F00A16;
	Mon,  2 Nov 2026 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650040;
	bh=3EsD2Fiv+rcPN4PTsRVE/IRYxSXswOju23bxocfgRH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIVDF5JdSwIFfgtZ07r4Yrn2CrulxEojIuLbeayFCAyvKnsCWBxNYnm1TJcdctXzv
	 IVr6n8ENM4DhgRLVwz2ONTGhTcUjYaJzyIKUhOn4pbfMkQGaJIvTXdrBzMOHzWq5Fv
	 faiP7yCNf821+g+AxWL676GrixzpNBcvkjCm7QvGIXeeuypC9GcqMa8A0LwiXKKP5u
	 ucjH31TkfJqfmraIC7uQmPkN69Ep2IbpvhcCY4dLYyIZlglsiEHL1fuBTWgYXLIaVA
	 /Z48WcKcF7cIDNFRj04wRfudiwyzdkg2OImnDC3gIoY3PlmIu/Fa8UeieN6Ws2UVdY
	 IETgRdA9vg9pA==
Message-ID: <sashiko-outbox-194063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-2-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-2-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:07:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Drivers can supply receive-trigger thresholds through the RX trigger
> callbacks without adding a legacy port type to uart_config[]. Extract the
> threshold search into serial8250_bytes_to_fcr() so those drivers can use
> the same conversion as the generic 8250 implementation.
>=20
> Keep the implementation in 8250_port.c and export it in the SERIAL_8250
> namespace. Include the unsupported-table check and preserve the existing
> nearest-lower selection and highest-encoding fallback.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D2

