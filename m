Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313287;
	b=vafYr6FEmM2GpCcYyQsXAKWfiXLT+O3kNsNVEI6SB6uOW5HmImboJuxmrOdOuLFq2koQ
	 ppM8/8D9nATK+vehg9uwrWAqOowooDp2aPXJrnNRw8pwDZZjVNmMFAfgGmoRBukkopnx1
	 q5MEA814PRB2tBtadQsrbM4oKCxcPvXbDWhaKVZlxDifs9TxycSLSkGKEE0U2WE6JoXZa
	 eKGaGCModShWmrRa/7mmeIsO/fw4eaEfyaYSP9MIjkfhQpfuzQkqUdH3t3RGb4dGpE3Nm
	 HHmDv2nzkbK1ZOn+mGR9WWNnduTxb4fdlTLX64af0f2PtrIsDPm4Uhg9v4nlOvn93KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kc7YD/TTH1tVZwPt/imj9ODDN0gyG1NaVK8MnuOUJ2A=;
	b=h3shhl4unPPY7FzabAponRn+7CrQv9Ii5HyUKVCTvNct+lMOptaYMqx+El5O35s0IUQz
	 shoAPkRVcUoW8LTL933Tp95yGomKfDTY/5ZtBEO/MWRkbH70/jaSWahf/TGeImfc97Qtd
	 FjQChuO2b7pEDl27NaesI7fzVfXKMn2WUmnu9kZFAzKocBawNqa1UbS2ERo0ryNPszvWU
	 +BHVXEcukTChiOd5LGOHb/z0R7uboSX25F1pcMp6ryTp/DEJP8RwuxiYiB1wGnbvc0r5b
	 cnvXOModkaErFwiSY0M3FI6jGQYVRShXl/TvPfzxPYsfxnAuafi1p7zt9tTDJJlSerg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcFm4h8N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F6606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcFm4h8N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F81F01816;
	Thu, 29 Oct 2026 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313287;
	bh=Kc7YD/TTH1tVZwPt/imj9ODDN0gyG1NaVK8MnuOUJ2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcFm4h8Nm7PZ5Tu+Ib6G7UmV5Osw5xgMhzRjhnWMYRQzHA/tn/VnOl5TxmhEKD+Og
	 Z0kbvMNyXm8mp2PlXweXPVnfwCLbDXwFTiJ84hzDWTvegOXCsqIFdDJGKSkYOjxV2M
	 dtnOBXTV6HhkbIDrN8zErVPnJ1YjzW1g4cYqTq1WwvYlg68mbrKg08/64px/3+XnQq
	 fvudu51UqC5QTKJ9YNapmScinysoUx7vEM2e1IhX3DsFdT1aJ/q0qDXYWbbRn3UIdW
	 C/65DNpc0xKkafCOSkNNwRGBuJcJKUtgQLhXYoU159OlWMnkx3xAs8ZeHsS8sxvB5F
	 0vfZ45ZOtczAg==
Message-ID: <sashiko-outbox-190080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] dmaengine: dw: calculate residue separately from
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-4-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-4-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:34:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> The descriptor scanner mixes transfer-complete handling with hardware-LLP
> residue calculation. A status query needs the latter for the requested
> cookie even when no transfer-complete event is pending.
>=20
> Move hardware-LLP residue calculation into its own helper and call it from
> the status getter under the channel lock. Keep software-LLP progress in
> the scanner and subtract the current block's progress when reporting its
> residue. The scanner now handles transfer-complete events only, retaining
> the distinction between zero source residue and destination completion.
>=20
> Also search the queued descriptors so a transfer waiting to start reports
> its full length instead of zero residue.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and report queued residue]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D4

