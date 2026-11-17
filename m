Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906930;
	b=INr+EcMy5srIIrs5JGaR7B6Ss7xsqcLqn3KnasuYTc/U4srBMJKKuX1cEbhBIjAaGFw5
	 +0v1DeQu0uHc86I0wptw/l38DrMJkDHLJPBYQXsELTWz5wbV7yqZZbizas/2mC0QTv8im
	 SPOstlgDbV89FFutdXLx2U2BEpICQMz8Fncdx6SVOo7sahSAK5UBCENJZvffdfyvo6Fh+
	 uZJgTUv38JRUBBJ+YN/VwHvskcLBj5cvaZacNtmxVSBpkDPdVH4tyCF1Of+dU2eieZfXF
	 glwrRbLVzCS2w/miO2UjIdYBxHrElvaCZCOx/S82uqfaDSn2h6BNjjFhmwvhrK3H/gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8rqrvlp1VtnfanfN27e+v4g7dQ+VxANxTYyNNctB79s=;
	b=gn8T+ZDQU0v7RPCUmaIN+9W2OQw3Wo8TM2M82tPlOqhDsqqdCkj1wyOne4ovHeW3pvoY
	 xQ64iH0c8JlkO+R29CYNGLythCtygYhYaNWewYzOkx0JDCScOYAMb9wZzSU5MoY1j1E9P
	 bwCVFIJsJImcbdicIEn2K3yL/D/duFlu+RD1mRUbXnZr+Oykt1yqzt51Mj8iVH8AM50MM
	 dO3jR+/10wF52dgUed0jBFei39R4y8etz+ym/ADBOLiO19wsjTFC81n3k5FIrQ4CNMAqf
	 9UYCpRClvBH4MUN/BchrFTkM67YvjRTWuLa9dN0s37ABZOHkxw5xfCx6ywJlRd6hCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlRXeLeA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A9606A333
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlRXeLeA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCA01F000C4;
	Tue, 17 Nov 2026 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906929;
	bh=8rqrvlp1VtnfanfN27e+v4g7dQ+VxANxTYyNNctB79s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlRXeLeAjBkErBrZ8LqIkAA4dEHDh2Kn6L+QEl0MbBnCao+ex0J8Br2r5BzIecWEw
	 Pw9STAQ9pbQ8RQYeiEwf1rBLoeO1JOd10aoJsa5xjNPw9fL08bXTKVQn39rilsuQcR
	 ImeYwc6FUFsfo+S+BWn8ec6RMcfybr5W/k+dw+Za+KspmA661ABOqZx/SBfyOzp3VK
	 dwO/MqxCEWcGWXgVXI0YWexTQDJw582jTNHnwhpfuPBQXc0sEOhZhp1PtEseHQhk2Y
	 UD7iF0tuwjIvIikNTdKgbVP4pkROnQzVhYXMtJdjjOzRP9CfuI872cwEk+NxTdMvtK
	 /q+tsF8GIAP0g==
Message-ID: <sashiko-outbox-218465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] watchdog: mediatek: Add MT6833
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-mt6833-base-v2-3-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-3-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:15:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Match MT6833's watchdog. It works as MT6589's, but its TOPRGU reset
> layout isn't known well enough to describe, so it gets no match data
> and the driver registers no reset controller for it.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-mt6833-bas=
e-v2-0-058a0685c40c@udp0.com?part=3D3

