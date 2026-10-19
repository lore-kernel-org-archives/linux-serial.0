Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441458;
	b=XKSv7A6Lcz9Q0G/rHwt7HWXMaPIHqAN70FKOLcUPP92Ms/cdviajCOiqRFt9SnRWm1Gm
	 zwbpwSd9+7FdM0nJ/wKuWZ7N3fzAGZYz5c3c0T8/SCueZ09tJVkWH1DCf/Jzn6WsIXP2L
	 Bw1e9upo/pw8UEFrr5PB1xlMcSj6kIiECeUPPTfqfp0sYkewKBLKDDa6NtmOUxusaNe8c
	 rYghQU35aN0NzlMav799kU21lOHI/xmO/inRoPuj7ppOH77ZSu20bXjuTPEH/UlzON2oy
	 3/pugnnRPZG54KZRzmIEg3SLGUPu1j8ZGm9WWPtdHGGd1pzJfS/VDRfOBFtuBpFFGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441458;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K4TKjF+R8nLYT6oz3Wmq6uGunOANwnhooYB+hHoGUJc=;
	b=VGre0GnGwLj5Vz5KpE+ESuyGa4iomjZh2SkDrQPfc0sItlu/M0ZsvUnFyprd8uILjBQJ
	 +R4kUYwVd18XnGTNLR1VvFLeJZwfwop6SRftjn4nRiUz0nVruTGGPnxp431QM9kD+TJIW
	 UHBy+daQWNEoX9AQ0u61tenZjDnLOnyM5TIdKhVFfTYFC/sWir7QW7dubYkSHV5cyHnI/
	 daTC/Q9MifPXq6gP3aqYIWipifUyehhNtjIBOqw0eNpd95ZExMex4AszIPxIJuSKWNE7M
	 nITBWqqbIfMqudSDtPnTW+9csvs3pxMC78CNifvnOvYKdGWR67KE019PUn3o3ENT/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiv52Dec;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C879606A31E
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hiv52Dec
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3241F000C4;
	Mon, 19 Oct 2026 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441458;
	bh=K4TKjF+R8nLYT6oz3Wmq6uGunOANwnhooYB+hHoGUJc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hiv52Decl6Mkto2FHNRGCAEvZWsAo2t3zmKFy6ZBwJarLxviaqL9iklD2GlkasRev
	 knsSXCObsMni4Ek96NYoHS4/i+B5JM9SSlz+bVR5vRTYq71P5zMkJ00puZAhMrguNY
	 cBnQCB5CpzlJvf1+Xssdw6YOVe5sUOGKrL16NdOoI+YoClnqhFdQnHcu4usAzKWO+S
	 fPvVsFeITxq0aRj9M3ukP/Ks3/r90DdvS3w7YYFx9oIbIY5l+7G7378F4I0106fbMV
	 p/xzxB7u2M6igtKMaH5pAulWYZFStS3aHynJNp1VcwSkW4pQTC9422u2Me1ooWudZ5
	 0yNQu10vesluw==
Message-ID: <sashiko-outbox-178167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] serial: 8250_dw: Add Allwinner A733 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <a3505ad8e74a08faa270881f0efbfe0d0d82d6e0.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <a3505ad8e74a08faa270881f0efbfe0d0d82d6e0.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:24:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> On the A733, dw8250_set_termios() stops the UART clock around
> clk_set_rate() on every termios change that reaches the driver. If TX is
> active at that moment, the character being shifted out is corrupted.
>=20
> No baud rate change is required to trigger the problem. Toggling only
> CLOCAL or CSTOPB 300 times during continuous console output corrupted
> bytes in every run without the quirk and in none with it.
>=20
> Use the existing SKIP_SET_RATE quirk, as the JH7100 and SG2044 UARTs do.
>=20
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792439398.gi=
t.vinicius.eduardo.pedrosa@gmail.com?part=3D4

