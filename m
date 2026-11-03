Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746102;
	b=NKhxnkQxN1AOhAs8usUZ4A1W6LjSt88JAOyOZSUSjTdRQDGF2am8c6u4RFYsinpFnMlL
	 m5DrnSK1+KIrrgZk6oeU7DCb62OQ2u3LE/q9VyRchszl8Qh2/AoM2lVZKDRH/rC2lBr2L
	 GU2hK3uAEzKUMZ44uYSaSNpO6SWMZ/YSv3BHqRKsr2OfaVl5FeHG29GQnFvzR5ifMflzk
	 oJ8xAIk1gcoovraEmUFsbcldBC1BFlRARhM2N3as3kUgiv0uZQnVAhAr5WHLHMlWlL2rU
	 jNVjSQ/nqIdsCtezzqqIv+O8nXUpTKr9s+6CWHwoAVbwOyhViG18flL5cJ50Dv8vhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CkK2gKYJG48mC6nRcUeUr/AfmEq0eyYhpuYIwKlyyvw=;
	b=X7t/LLPdqPxauN+UzIuK8R5DxjsmEoP3GU1sCabxRH5A8Jfh/athJt2SqE09BI+bkaC5
	 8+5HXsTA6rvn7o6DM6RuutFk/Su3IGyPzROmOB61YMJSAa83F7lM6VXarrykb4CfIh4zm
	 OKY7xPN8IxtnK1vhMxuZEyXBQti0jIIb2+2eCqJk1iIkMLVc5UkqRNAnfG5RGd/OLe8m+
	 yoRn5ikxmj130uLMrZQvJEzPIk7UfwsSCo3FFwnLbFWoUgB0Ejhl40Ni93HyPY5eAAI1d
	 8/Cifx5zBgf2lmB97xVa2tajpzTzNQGJTjOZ4Oj6q3ZClDZh1ImHXNfPBfyMikiEt6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDqdxXDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FB606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDqdxXDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546EB1F00919;
	Tue,  3 Nov 2026 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793746101;
	bh=CkK2gKYJG48mC6nRcUeUr/AfmEq0eyYhpuYIwKlyyvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDqdxXDTXNf35PWETHBUOkCzoMUkq58SEtGwjQu527C1EbGaKPWkybvm6vmR7Megk
	 mshdeJnfrqWV8mXfHHJZUb/d8Af+TvP59Zz59GuKwvDz1jjcdv1v0/VqpFcEciFDeL
	 TmQGnn33D13oK8qfAFI+fLQIKFq5rGQLKreOazxnHdWLMvtp0anMKbSEV8zMYgEiBK
	 iYeB7naxd6cz6ijCmdOJak57FtnIByoCUbeOKf33Jynv0Ejpqc7TIJle/FTdZ9PbAK
	 K6+rri53ybzZ1o+irF31k9kGRA6meU9fS604+Tw1SBvUHm9tITVOcpvSj03Utqiovq
	 5vL5UuPa3kq6w==
Message-ID: <sashiko-outbox-196156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Allow unconnected interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103224409.865130-1-robh@kernel.org>
References: <20261103224409.865130-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:48:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> 8250-compatible UARTs can operate without a connected interrupt, using
> polling. Requiring interrupts rejects valid descriptions such as the
> HIP06 LPC UART.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103224409.8651=
30-1-robh@kernel.org?part=3D1

