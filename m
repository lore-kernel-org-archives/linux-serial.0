Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250734;
	b=0Gt2dZhS3b147MrftA3PJcsGETMLS55bfJqVXDeGE1jXuZMlG5Tz21WYXBSIIKGFs2s/
	 TJ7V3aBK0x58NTBBHYe4ogT2SrzK81lMM+DzDt9VNmMcHw7c8gXufQbzuo2Oge1yVmnnK
	 47Z8UNkrus8TyeEnyGveyKSnVxSbyQc2qrOD7QXW55KkcUoD09TtetNjgCHXeZA844l4k
	 FjLHpcPIgVr5AImTf3gkPLNmjS0THFnIbOaA7Qw74rF6HdXnwIoDaGN5rIwOGq7UWsthn
	 WPPLOwzvVeLLaGGrumHOpxebbPP/dVDDm9ouOousjeOjD4D86olJdv2RjoplQPwCyCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250734;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MNXwWYDqxgDR44R16sIUkDdxaB9tTjg219I/Y3aGJyc=;
	b=pfRshL3T2rB7OqHrw8I+B/z+Is9ydFv+vzOlmJaUu0qWn9na9t8EsBnjnPD6OfCzHZn5
	 fKOPkAJaf12a2Z/9aEusLJ/8SUj3pjNNbErubswjkQJQVlnBrcOWBpH6CG3c0NyVoMKy9
	 R2fNiwr4ePv8alSeRl9ACdjEL4t/51PUQKqD5g1W5V/jSGGQxmJMP2FmpQBke5tHlwuLs
	 a0SDm7Eb+d17m4Dp2a2+5tE2ZfMmat1/APXMm5a8POWMSbBJVAyJ+3fgfThrJfzztqeeg
	 5/nPcQ0EvbHheflTH+P655ieHRkQzs3xeNxYlBMag7xZEh4D8Y0QgA+lntN6nOC0+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJabexoO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BD606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJabexoO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3351F01828;
	Thu, 29 Oct 2026 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250733;
	bh=MNXwWYDqxgDR44R16sIUkDdxaB9tTjg219I/Y3aGJyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJabexoO0ZJMmyNWQKzj0OjqnVyA8hwcHOAFTJJJQdYswAmu87ouMks0zODBl5HAd
	 Wz+SEOcvRhPo5wQ3m9ANrWPQC9gt4tc2Xmp26jDiOkkf/TOPRE3IuuwheosAvn7oV8
	 1mfFewcL9A7+hKmek5eDsaXey0cThi4b9pguYjiaMzBpyoaSibraApPBhzYrGBpaEi
	 cgQnDwctsSHuI0IbvFGhIGgORahE+iZSEeOsx2WFAdB77So0ozkXokC/IY49+NNxLD
	 KL7/lTed/Ykm4BSe3Ts8EUkDrWYmZcjhy9ZAq5T4ZCTCS8bm+fty4FX5DxRCsDl39M
	 fWOmw8mxIdypA==
Message-ID: <sashiko-outbox-188739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/12] dt-bindings: timer: Add BL808 CLINT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-3-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-3-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:12:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The BL808 D0 processor uses the T-HEAD C900 local interruptor. Add its
> SoC-specific compatible with the existing thead,c900-clint fallback,
> which accounts for the lack of a memory-mapped MTIME register.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D3

