Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8812E62AC
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370543; cv=none; b=aLTAemDBiNCR0wBVAXac1z4PeSTJvGT0CzjbIUx6iTFnyvBuKtDjsjgFT3OlrCD/TkrfDJ6Ue0WFmZZoY/Cd00HD60DIjEV7xmngjEbMTYXZBLr8pYOzS8iF/ZbKHRPkePH9/6xI8EyuUuXNQrpXb1iTsvIwveckH7+fJNGmh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370543; c=relaxed/simple;
	bh=ayJplCvdm6bcoGFRdT91FW1oyRFsplvnyXEaOPiWnYM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qkIoPgdiVUuFNBQ4wop8DfUI6T/g8ZbVew7K2v/OnF/wNU3hfQi3onkcCkVlD1cLcpgTlbk0Da1y5j57d9AzvWodMMDnzx1IzCk6PY3oyU0DY1aRUIkJD0zZRL037yI2IJJf3wKr4a0p1UGk0QQ/SPvitaDaRzbU9+igLCfnj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCy3QM6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCy3QM6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFE51F000C4;
	Mon, 19 Oct 2026 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370541;
	bh=ayJplCvdm6bcoGFRdT91FW1oyRFsplvnyXEaOPiWnYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCy3QM6rcGQEjjshJM6QiYquSn+Z+TyIDzdy1KtKM4mRMRgPF6B6RsbPmuiWdOtYw
	 06q/slP89+n8I/WLYCrfAXExEVo4tZpbjT6gSKjT6BAR8cp7NnCWNfCuuWktofQ838
	 5MrB3gsZYuTlO+7QUIMtGGIdGOCSwzL59RDHa1u1diKevjiylELPMYR1Z1/zwfhiq+
	 ynEloAR6my1Rxq4gZMEaBZTVqtC8dDyKzcGc0HcRoq+mVKonuDD2ONjhhF2jN7donr
	 BGlE68Mrd4jsv51oc2IxDKI6hoOHvw1Fzl7MGAbLec0w64lAOe7unixcAHtnkGKggH
	 jVbU7HdO9M0NQ==
Message-ID: <sashiko-outbox-176469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: mediatek: Add Amazon Echo Dot (2016)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-8-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-8-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:42:20 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a device tree for the Amazon Echo Dot (2nd generation, 2016),
> codenamed "biscuit", which is based on the MediaTek MT8163 SoC.
>=20
> This is enough to boot to a shell over UART0. The UART pins are assumed
> to be configured by the bootloader, as there is no pinctrl support yet.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D8

