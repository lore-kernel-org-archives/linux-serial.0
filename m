Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906849;
	b=E9aNxzCyOvzr/WfMBV/sWg4RuOA+Wmui7PUeNxXJ0ICZENOT9orGzndFAUs2ouBYNXPc
	 bxcILL6ku2tAM30OfxhfB1nQYoDQuCfeN8ud6O5ZPHC2Q1958GOJnxiPwXeB4JIP+i/5V
	 eUHU+S5xYJI6Yn1EfXWh94NAVabYiEl3V0Tn10ZNM6rG2x/F5re27GoLUuP/ZjJVk8IpI
	 luRhObP3WdtkhbkNVUgdIXhf/rvZngfFyooRc+m/hz5iLC6Jk3cTjlrYysMAIvz1r8QXz
	 jFTnBqcSWTcsdiO6SEptjkGaqJX1ocLrzLCwvAUV3LX7zsxaqfTYE6p815FHSi//55w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gpg7hYYIp1qHf6A3JBEn6v2K1DHM1oGVnrh3i5xHhPw=;
	b=d/mGhQ4d3OMDfeAjewDH7RlsFkfYB2cjR2+F7GEFdrGWt+Lo89zNH6mZ+p7dl7uQua8q
	 AWfdx3pyOj6sXadgj1ulC4ScwS3Dbr008H7x8Fl9pgrulsW3e+f1PSRoDTbi9g+7S9hgk
	 D6G6MFS1b1zXboh13gvaDaEHfzQt/1DMTwk1eeMYcejD23ipRFx9eLoUx5ncf47QU59oJ
	 bCsE8GHFRTJvV3aKEZh+grtlDeeXyJDAQBeSTduxfbzGXXYlTiCUSRI96cwDYb2s0ly1b
	 Q5miLbKzP8cYlxDnT85MkKIRZBcJebX68we1E1XjzdD6OGcdQHJIAVGI6ITiVi0VPXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMH3z2OE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DD606A32C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMH3z2OE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751F31F000C5;
	Tue, 17 Nov 2026 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906848;
	bh=gpg7hYYIp1qHf6A3JBEn6v2K1DHM1oGVnrh3i5xHhPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMH3z2OEn5c7HQXyTg1/gFf2wBBcDPJqMQf5bv+e7zt7FIKqTggRFvsp4fLHMIyCX
	 MrSapIZhB9pu0cWFhjTxiuLUpoYtGcLr/Yn22rzKY+p/31PHZsLCHMaofS9ID7faAA
	 uwm2tAf+r6bDs7IvN2YtnJPCbdUXDkA50dH5n11cEGdxkNOsQZNOU3K3qovDVc2RvO
	 8LAmbUq5nLRxSYfmHFpPhOKFLVvzQUTUaBUPEwuvCD50A4qGTnz4QNKTAx37wrpNRZ
	 sSpNYDYiJxHICCyGpiHzXThLy7/HhLRd0s0yMwJ2QSPguoODXX5uOwBejeJhNKAhJx
	 gK0SEXifdCS0Q==
Message-ID: <sashiko-outbox-218462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: mediatek,uart: Add MT6833
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-mt6833-base-v2-4-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-4-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:14:08 +0000
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
> Add MediaTek's MT6833 (Dimensity 700). Its UARTs are MT6577-compatible:
> MediaTek's MT6833 device tree gives them "mediatek,mt6577-uart" alone.
>=20
> Reviewed-by: Roman Vivchar <rva333@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-mt6833-bas=
e-v2-0-058a0685c40c@udp0.com?part=3D4

