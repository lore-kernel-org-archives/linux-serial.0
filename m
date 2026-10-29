Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254699;
	b=GMmTmW3X0hBSz/YTuyf1wEFDtuJ9rqxp7TmmcFmv8PURZtm+rNKJab0STofaNJ+p/m2u
	 q4So/jY7i8IonD1yohZH5VcpwSsfgwxq7i8C1ly2FbgqDF/Pldm/g4YgcSinhsQ4mbl8/
	 DfRxV5VH+FY1WkW8B2JwQt5W/8wk/0ZXTfJxI/PZ1cE5kXg6wmuDOThFapL4gP5USNPeK
	 NNPMMvwiWi76Xjf1oK+LCGyt8MQMQZBuPBudlxz6uoEn1qt9Ss504rrXbaAD7jPkqIqXD
	 SpSlVIYQjtkGhCCU4VoEoWPA88wzEnQlB1K5kQKrjlOEtwHwXLOqNICzHFkT5AyXrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0bdpK2ng9Xz7O7r0jBp5zT2zHP/1VCt/D9UZnXVv56Y=;
	b=g3FqoNV2FcYunikw+ageyK1VvIzpV5XSi/JkPh/KNuSeKB7XhQXM+ae8LOyLSTTv8hjf
	 C+oD0vnrBwWU8bgyRBmlNFA/0+9MPbwyps4OeAtgpFzWIrqw3HS8kncyBAEf9rTiBfVcx
	 L6w1YDQ3JX459mh3mTvennwKVmIjhyQz2xqVa9K9uWNFxjqxN9A26axRIDcC8stDvTjYj
	 8I6E/YuHZ02+Ve7gdJl2CdCoZJYpiNYNjllvOv3fLF4q0rVLbn8LfDoMv/kx/sDn0UiyB
	 A7PBuhikAH25L0CHKtwuv2ZnQuIWerxSSHGHh2sXZbS2d4vMc4fpuYd8qih4tzOhtqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+6FkzaI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870F606A324
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+6FkzaI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7011F031E0;
	Thu, 29 Oct 2026 06:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254698;
	bh=0bdpK2ng9Xz7O7r0jBp5zT2zHP/1VCt/D9UZnXVv56Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+6FkzaIW6FBH2rVNnIhgczfBQ4tKVnbHDYZyC8TZOc1feCaknP1qKH5jCS2275zz
	 pJYohOxxoQ5eykois2k5AyN5iWAVHOcEPygnh7S3F6+lUpbOHmqE4YlwYwYmhMmFIn
	 tFFKZOWv0xzz1N+oIOH4pFsdNVtlmQ6NjkEzykqRkCBB6d/6URb/0xKGjR6MxlxqE2
	 ZfUdsQyTchPuAQ4elrYz97wrxzJVvPnty3QMOUnnS4UsSJnbXb37NRHq2EXdAd8iTY
	 /NCHlyC1XbYxZBry+4BeO1RRumHJNa2fGVsdtn2QndxHL4r4pZDl4OnXMV7AOtC18K
	 1ArlavXA0u43Q==
Message-ID: <sashiko-outbox-188804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y] serial: tegra: Add missing
 clk_disable_unprepare() in tegra_uart_hw_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029061427.27973-1-kmehltretter@gmail.com>
References: <20261029061427.27973-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:18:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Yi Yang <yiyang13@huawei.com>
>=20
> commit 38f28cfe9d08e3a47ef008798b275fef8118fc20 upstream.
>=20
> Add the missing clk_disable_unprepare() before return from
> tegra_uart_hw_init() in the error handling path.
> When request_irq() fails in tegra_uart_startup(), 'tup->uart_clk'
> has been enabled, fix it by adding clk_disable_unprepare().
>=20
> Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when a=
n error occurs")
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> Link: https://lore.kernel.org/r/20221126020852.113378-1-yiyang13@huawei.c=
om
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029061427.2797=
3-1-kmehltretter@gmail.com?part=3D1

