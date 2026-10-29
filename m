Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250650;
	b=rqLOYqXGj7GfyWvFvqyNsOwia2+P1UNKO4KZQq6Sf7KxXWPZd69GtzGukZIe5Hbntm8a
	 r0wnlhArsk838o4q376lb/88eDxvQOGEvhoVA4SHprFGTz3HC9lL/fCeD6+p27VqfUXID
	 gF1M2QiDsWyG85RaGTka4woFjfmggXOtzcX4/eI1nmAIOKZulE+71Vc7Kq8jnxCHTNPgg
	 0lhMzUYVxuQ9btFa86FA143He3lkpZuXr9T6OCbww2bizTWxjZtaUhB5yMsvcTCJjvMFa
	 qrkFYg+jWSMauqb2MGYbJSdWmNf+/o1wmYhkb7VUYoCIABDn71LVwlZTRDDlkFHMC9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T078Ag74Tyh8SnNk4vbQNu1RFFn93H2ehBcFfyNsuF8=;
	b=wypC37A+tHXhuliKZapglZJkvqWoyaOn+t0LgxBxvTQluqvRZtRaZ+QLaeTqYAXxIkV7
	 PyqvmpoRoeZMa74xI7JzfWDWSB+geBpFiA+0s9LmxO2+soGLzz/wXNNdRsL8CE7VEFpMA
	 OzjDPEU84IjIusl0qPPATFrn20AcXhhZsbWE/AHIAkB5jEafgUwG3fBiz2WKG3swYnAS2
	 ZHt3ZxgKNHTcYJCEBzNhhgVf5Xwbff71vD7kfVQ5N5Xb+zMcVWjP7hg9RNwT00TMskVKj
	 g/kwu153pRdEhNR47ql/hD80yi7j2nfYcUOV8Af41K71Ut78NFbCKrBP5WQTl5mlYdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGlSkaOW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D1606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGlSkaOW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA51F01828;
	Thu, 29 Oct 2026 05:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250649;
	bh=T078Ag74Tyh8SnNk4vbQNu1RFFn93H2ehBcFfyNsuF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGlSkaOWyNH8963VZBsftMqqTzaSNZ4BQhMYymKuMNmZDZuMYAF5008Nqs6ki+O3y
	 X9yDgeFRmgzaUCo/zQwP79QJpK0oAgt5OLLMLu+BbMjatgAoa/RvbRo8Fv4PSs98ep
	 6Y0qEAdQSmV8o25Gp3OFv+P6E7aZmlzNqhlBpiVIP2y2jw6bD2KvEHVrPkkI3B8FbF
	 LtkALJHOam/gx9UWDyPiTrjN33bFwaDSeZeoGaS75OZgAueR1RfZRizFQgiJSHngTe
	 4c2eAvO2K2cjEbGqaD6SAWVg8vbb9rn7mrfSMZ3V+VaI4g92yFSEbkBoZXTESsSUdp
	 2FGaM+GEGeoTg==
Message-ID: <sashiko-outbox-188734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/12] dt-bindings: vendor-prefixes: Add Bouffalo
 Lab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-1-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-1-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:10:49 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Register bflb for Bouffalo Lab Technology (Nanjing) Co., Ltd. Reuse the
> prefix already deployed by Zephyr, including its bflb,uart binding.
>=20
> Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial=
/bflb,uart.html
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D1

