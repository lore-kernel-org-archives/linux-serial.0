Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280683;
	b=zAQZRb0+0ATNrHppAplI8YJdkXueATmCKKyag3a6Wj46jWCTQRtv4geuMFS4EfEbO5tv
	 ZyfkG2fIpspIFuQHJsxsr6E4ZsxC2nWJOq7rMbDcp3HXUAwh+BJ6SnTvJOhq4Z1nW/gS6
	 NQ6Zs7bCq5ju44CdJYZiV/Cq5SNplQ3+eMRwvbBLL7MX20WrT9/hI86Fs0uu/4hsK6YDB
	 C8Emmc7rA61nrVvakxFpqmfdcGN2DYfa9cxXB6fryrJ/uvNCcJwLvthSCF1/F631GEsc1
	 HrGZstokKLu3R3v82jU2Kall5oAsSKObukgjK+UAGM1cLxaET4Dehggx0VUr0kL+pcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FDKQct39+cVcoIKYsEyvFGmRph3I4d+hX+1UlEEN3bQ=;
	b=a+NPVQ4CJJd+5iKikG+yvdqxnWPiAxTIlW0fz7KD1hQiGGraLlzB6cumkb2EMT9GGaSW
	 g2uyseQI5pCIvGq6dS2BYHpq4DIsJQFxlwp3mmt16IOZr6worrdY9FqipT4aPuBYfP/uu
	 VIPKXWz5n/ApKHBK2jBD9e1LhZ3MRrROy/CxLbD0VPznImHUkSxBYd1KyJwhD0vaa5poH
	 TdIKSHPyPkVGIG5NtezsKzlleiqyiaeTepupXv6reokNqaqL1xg6+cVXGh7c0deaBZhNh
	 yHnCsh27vDesufu5+VlsNnUecSNX2H6dYRPiz5xYijVBC3fywCu94imF73mMuV4wmmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElpzeAVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F717606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElpzeAVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD2E1F0089F;
	Tue, 10 Nov 2026 03:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280682;
	bh=FDKQct39+cVcoIKYsEyvFGmRph3I4d+hX+1UlEEN3bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElpzeAVnpN5PqFjQRrmr1Y/E+HNREyakmZxp9cQ7cM2WRg5zy1IkAHa7b6TQG7ZRp
	 JZWURSX6Z1GZnyYn7O7PwD6/D7W0SfFGCwsrXBF3OKHbNVzsTWnF6rLwLcrh5oVVWW
	 ZupgMGPGJhKIt53VpW008ccFCDtgbpzmKPODRH0p2ed6dVVo6Nbw2x3bxBN7X0LGkR
	 G8bssHxkgeIhz246l+ckTpCqM2ECSZCqlPTgw9gxLx0IHhnU4XnNHmSAPxqyRMiikS
	 OGc367XlSbC9PhgafLOH6t5DMkqbE+w6DKIr42S11T7EFDynn7FAmLXceO14Br8Oy5
	 y428uXrZOQGCA==
Message-ID: <sashiko-outbox-206103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-9-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-9-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:18:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration has different FIFO depths across its controllers
> and reports each controller's depth in the FIFO Clock Control register.
> The receive thresholds follow the standard DesignWare FIFO-relative
> mapping, while the optional-register layout differs from the generic
> DesignWare integration.
>=20
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D9

