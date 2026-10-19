Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CD2F12AC
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370560; cv=none; b=p83RKtgUS2F+xjfwBrY5DKaF3bNm5pZbxw7nSKX9vswxk5ljXgx9K1gg+R8ZE9sQYnbP4Xw135RIjbkCkLQ/WpH20lczSPOG5WEhAUj6E9oDnozWaf7F90DudyDdls1JtOAdmyznlb4RByqiMcBik8t5LRw5mF1F29qcyo/Ciyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370560; c=relaxed/simple;
	bh=Untql00EWUdK5BmfR94KFFDKVLGgSKW8/U4d+8IF+0w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SNjAil0smyr7/9RWjpdzNdE8IpUDBo0WAIkgdc+17I9VTEE3/aIvTmNXFNpTj1dAK1b98OOFL66Kxft6U/MRq9IEnCePD0UTOF9xECmarq9lBJR/7n8D/Jwy+uHnN+otSC1j7O9wtHXN2ogI72kQ0GdxSkOa5oZM9+7HuqIB+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVBOTfMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVBOTfMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3811F000C5;
	Mon, 19 Oct 2026 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370557;
	bh=Untql00EWUdK5BmfR94KFFDKVLGgSKW8/U4d+8IF+0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVBOTfMIG6piCpBWUICjjgaVr1mAfTfgsh0Wkce/KFzzME6tN2qhAlNJnRYrIQiBw
	 nTiO38dQgqUiq9Uas9IQZwxKxvyZ/5GG0aaBsBflpEl1wN4JpwqLSBhlBDtPEpTVvf
	 aATeQd16RvQl8Ug83HMOqqTttoRprDyIW8PNx84M4w49s5WJ8ZUkQnhCBgYdFp6qBR
	 WUdZA/4cEh4okbibFUn92ec4IsL8leww6ffJsezFuyuAZ7JQiC2K9VUlRzE0o1UJxR
	 IGX7lCU61ZS2Pg/rhQ44EQxfyPKe94Xizs3TH+GxUa1420t8eSGRXEyO+P5ZeZz2f4
	 bpCDGXec4P14g==
Message-ID: <sashiko-outbox-176471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:42:36 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the Top Reset Generation Unit (TOPRGU) and
> watchdog timer on the MediaTek MT8163 SoC, along with a header defining
> the reset IDs it provides.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D5

