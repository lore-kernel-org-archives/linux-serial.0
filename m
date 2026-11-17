Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906838;
	b=AATumX3xlCdCcOHz688I/yhy7aA2zrOQlrexvEWWv6K2QfiuwiHLgnBRAsYBLOZ+CdFs
	 E3lDYQ5o24aeQyxNX8yPR5BMWZO0SUEi5MgJNjcLtleMH50NRN4XBt4PN7InkOepxfPm9
	 95NLBWLpi/HxM7nHMPvdmDGM5LcAG+sz8MhGgW0bqLtU0lcZflossN/QoOGDklphL12+Z
	 qWKc0eHLvnxNzJ2oxq8R1urdEfBnM9ewTFA7j+x7ZOZaBznHwJ6pQJRV30BxXjdjY4Dtp
	 GNnrzSUGy+w1SL7uwFKMc9msJzN+cAagoM4VHRd7h3e6T9DygiOTA1z9vMwjhkfUk/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906838;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UnCSLL5ACsSGnVy8mPkraFOw/Kw3dO4cG+CM9Nscn18=;
	b=uQHQe4Mzt+Y/SnBYUacLmm1ALhSDqpO5vGJDaUAJmzsuF4Q8nB5G/tSN8f1udcpSGJiK
	 ndTzGAiSnXb3mxcuUxL47aPNF3X58Pl6lFolLsh+rL1thB2kxAsjFYm1sJk8omj+KHoko
	 xivgne2nCyz4czmtFnhnMTHlltEV0c/+40v74d5hZH6eBfiMSJXB27Iw4/0ssEmzCVW2Q
	 iOfrFP+RP36oLMuol+77tXKjPcpiRwuiba+doHcssRLxXch8fnyYufjZTVcHrBhFN8VOw
	 LAyzcP4HH/LvbUHJvXRoRAkM+Cp0qRMz2er8V6TnWgFo/K5dFz7GNJaD6oI2cVaK+aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CATxXL/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47190606A339
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CATxXL/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B021F000C5;
	Tue, 17 Nov 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906838;
	bh=UnCSLL5ACsSGnVy8mPkraFOw/Kw3dO4cG+CM9Nscn18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CATxXL/DQnOgyERCpbf53aYKwfuHiWotrDZ80ppfhdwQwCSXvjnTMQV12B7RJop//
	 nvy7Xrrv8XRlHjnzGE1Gt9UEgnleKuNZX1xX12LMXbtdjdsTY5Nf/inMECObyuO5wQ
	 0zyWUf41TZsuAbnbjqdRhoHCjKxBLjrYLf3xxiKArqX9b/RPyW1SLTKLuZANOawfS4
	 mJRINWtqI9D4ANs/fGAtYD5L5vK9m0MjGGsyqTiB1hsb7lQXiD4MMpkyC9oX1wXvR3
	 zG11BlPYs88QPikGOLQdfNYRKwyVt8Brhdj5nduKIN119C8hG4iwUug68N8cOrrDB/
	 2dMm8kc19hXcQ==
Message-ID: <sashiko-outbox-218461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: mediatek: Add MT6833 and the
 Xiaomi Redmi Note 13 5G
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-mt6833-base-v2-1-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-1-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:13:57 +0000
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
> Add MediaTek's MT6833 (Dimensity 700) and the Xiaomi Redmi Note 13 5G,
> codenamed gold, which is built on it.
>=20
> Reviewed-by: Roman Vivchar <rva333@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-mt6833-bas=
e-v2-0-058a0685c40c@udp0.com?part=3D1

