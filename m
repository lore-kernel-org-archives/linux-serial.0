Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889055;
	b=C/q4Ulu0D8DXVLc4Pdg30I32I5CrbON2orw7LlXqI4Ga/7t0MewWcQ0gemM35ihuNqHb
	 3Dvu5l3/PhshlCXn9M99kd1b7v1E8t6M3nlEfl6PxCiXj3OhoJvfCOW0TJBxlROF4KA9E
	 KH0Q8VybPcBMYrAbW3g8h/kPbcaRmk+gywZrGbPl2lWRkPxOHpYyyP9VcJw3XaVMw+13P
	 dA3kF5LddVV4gO05PkU7u6nnEfKVLLsXNmBSXVwBuV/cuIf4pmeV/ryoo9KXUQ4ON4A6E
	 K42arebsoTrMi7z+NKoScU/fieyy5glkiL/+mQz8lHsK+LWMdQ2XKM+DvTDquhZduBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yj8ybSF30vnTLSeJAWs9uvF7Wk7Mg+NVkowwvNN4MW0=;
	b=Kqjn5q/MAiyujDcZlXbposfbjlaZvWLBwwfzNMELBvyEjow76VhjhvmDryfGUqvvhar8
	 CyRNQ94jDuT+AdTpA4F12g1sU4eb1czEx5mrsezxn7/NA5jAV3eFCAireaKUilyvz3azB
	 +SbVx6oVrO/IoTLnoTrkPgp8W/X3CEyOTRaGPEnhRWkT9QZE+MplzMS7JpqPg9LY7jRLq
	 s3l1yK8MMv0+6FVFZdOo8zauRFKYI4oQ6TAU1SfiElHw37yQkKCeMyFbOKy5yJuFRIE+4
	 zlE/X5ZjMjRJ3rdu9acwyTabMuJYzZ90yEQfgaFqQ4UP5j4Jauamx+1iAZ26YbG6T2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b10Ldb8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CB606A328
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b10Ldb8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B211F000C1;
	Thu,  5 Nov 2026 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889055;
	bh=Yj8ybSF30vnTLSeJAWs9uvF7Wk7Mg+NVkowwvNN4MW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b10Ldb8niLIC2zVbI+OszY7IRSncBGmO7OEeJWs7ySz7EoBjrbTNlHxAZUuFrTAhm
	 zAduMNF+0VK/HWTcblZBZdJAAAgHsY8LkFMkzjnELfD5HjqqPa3LJakaRl0S2QWgtU
	 l8dwRgCpEyRkRTOx3qxmp5rHtKAcSG1zRV1AnTLIRMWsBpUo5/jX7Puh7PnlzAHjsE
	 vR5GGmujYKv1c25mssYgEGabOvJEp6f1XX1/OOJa+1bvwBlA2a+C78vpdapdc8UWHm
	 qDRvyNRVJ3zWDunGa+NB5KZSeH6WDjbyvhU6S3kOi6kcASO2m0GzkOkf91QOtE7cUD
	 nJ5ssZatylIEg==
Message-ID: <sashiko-outbox-199244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-2-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-2-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:30:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the SYSIRQ interrupt polarity controller on
> the MediaTek MT8163 SoC, which is compatible with the MT6577 SYSIRQ.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D2

