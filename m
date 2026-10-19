Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227C21D5AF
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370511; cv=none; b=ajRIBYaoDO0EaSN6/bkw3vXQ7wDDaopAFJoeJZV9bpt0RZj0erBHAZVQQ+4zG86lConWeF2RUEZNVEfjRW4AHdXH4PGaVAHQLAn/BEKkNH7SMt65/4DAhU1XRAOteSbnOYUVchBpS8bDevtqEMYU1RzRSovO3x/oIMQ2B5Jaiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370511; c=relaxed/simple;
	bh=i7RsiCNeSEJ9NHzA/vY8/nZiGRqsrdQozIu1UA9kwh8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HqhC0c2HFAoH1mINXTbBhlBbr23a55DFgXDIRSjiMYaHsMslsFEJpPL+N5p5WAHFtZ58eGcPS1hRgSuiOXN1nm4++EvMh1uu93YPJt2222hIYyy6RBEKZS0kaum14Jta0upQloScrhyfQAF3ZZ+FkNNlp/F88kW5EyZFXT2HQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtTod4VR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtTod4VR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C50C1F000C4;
	Mon, 19 Oct 2026 00:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370509;
	bh=i7RsiCNeSEJ9NHzA/vY8/nZiGRqsrdQozIu1UA9kwh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtTod4VRc/TP5CZqTHVfQBHQaUAMnJmyHeX67iYZyLj4mylFRcN8IQrFRSUK81Kig
	 HkRHzFyOThmovCV6GhwaJNmMwPinsVZoWMy23XOU5owSAL/nQqkd1KDuqo5+AzHQGX
	 RwhL8KTbPKhs3dzJAaMBP5PIhjJT/Tfz58GtCc58lrJbSMHg0S+2QT+z1DhxCU3vNk
	 fGrhOC7CIcuX38wjd8b2KoPyo4AYMKKk67XE1wwMU7vzNK/dl8qreZJak4KRFDwmcq
	 CJrS1jD87FtlTYDkuC/hseBG1pZO4m+C9pTA2GX3Hl370bvmSAEvT1L8WoBZ/97F/T
	 1CB6xZ5HUcI5g==
Message-ID: <sashiko-outbox-176467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-2-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-2-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:41:49 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the SYSIRQ interrupt polarity controller on
> the MediaTek MT8163 SoC, which is compatible with the MT6577 SYSIRQ.
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D2

