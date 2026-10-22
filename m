Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685592;
	b=p5hmPbv358Ijx6/I31p/cjGboVZH+aeHQwdG32Lp/TedcCbzol8CSGCdmFdhmsOv+ZvR
	 BKYdBiMBm40rAAI790dDQsztxKLu999sGlSt7L0h7dv/VIe2fSB5FhIKXtHktT5Ewrkwv
	 /cJV/K6qVF14ZcAXJpaQcbHrkAb7CwJzIxxIvrqrMnfap5/Ti38MonZP5c871K/z1EkN+
	 LHTfS/mGCIrnePFDzHAtRDRB3lGsG4lfNfE5kSS2AD5bNvs/EjzS43+AOx04wGuFbz1dM
	 USEjKCUNjF5cVA/thoD8Od1FnWk+tMqyH5E6Y+r4e1qjtilxSVoHvn7TCb4oG+sl5RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CnQRTCfYgBL17lhf56UZlm9AOYbkbTyTyIW7RqdDT6E=;
	b=C2rYf1vWtPFlz2mAyeujKuvHRGC7Kc1LHbM2iHMmCeZV893PR5+8mB8ISyiMGL94w/Y9
	 Sozjx8reJIaYmNV51Dc/qh8JNaBKWccq4QZxaSHjWdh4y4SwpX4CkSv3RUIWY98i/JhD0
	 s/NRkIMz0doblGB35vDwCLQZLFSjNZTDlYkNDnVgqTm5hHDlzLp34ZwQh6z6pE3dO/xiA
	 2Lzx1Lzx/rfvHLFjUn22ae2+wNBMh3Xtc+iF9y6BNybJ/Od7AeJnohicLKUl5rhi5SeEc
	 fwLmTzeBpaCMQ+1J+mmHqb4gz3eQNcUcH6moT3cPAY9syBCkE9bYzeZpo9RsPRoJ0LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqmYbUpj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54382606A31E;
	Thu, 22 Oct 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqmYbUpj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D9A1F01828;
	Thu, 22 Oct 2026 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685591;
	bh=CnQRTCfYgBL17lhf56UZlm9AOYbkbTyTyIW7RqdDT6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqmYbUpjVrluSqmpi1TfIf4fXY9ke6Gc9gyYDlx6v8q/Dg+q/XumgnWm9MdFguh4c
	 IWVGEsQyhzpqaBBiIzOCdAKYzv2qIKRW9Ly1jYH8e4f5H0gsQLF1Itlf3083RUdbjQ
	 /p5+eBPgUAp0xo2KmifNGdhMdX5dTnUtb8XArBmbfPrwgD5kIjt+2O2X5Ejs6wruGk
	 +JYsx0RhI6dAjxuv682kTPJNAUiRgDeHaKv0S2Uc/a4aZOV2CLsv0cdAmx8e7wXt/A
	 LEK9F4P5zKuhaJUCW0lZMWGTYkQr+2I7sJ7+2cLYo+9jBh3SJNelRYfIjUxiabOQ5Y
	 KQ5V5Hdp1QVAQ==
Message-ID: <sashiko-outbox-181777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/27] dt-bindings: mmc: rockchip: Add RK3572
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-13-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-13-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add the RK3572 SD and eMMC compatibles using the RK3576 fallbacks.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D13

