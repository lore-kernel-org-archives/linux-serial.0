Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAF31F99C
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434665; cv=none; b=MWB2Mq5kr61eQT6H25aZ9URpcB5Uh0vNJxvuVuhhXL3m7ep24o6i93iSIIFtrKcczEvZcgcgsfRW72tLoYVxRoq5FC8QdeFZlc75YRQRQNuuwaXiAAZcU7itTua37pEcqnwDBuOIdfF1cyUbed9IFnSklyjwEho8jC/jDdxLMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434665; c=relaxed/simple;
	bh=SjwwInNi/r5ar6+egTl1g7ZA/YSfcTNAzmNY3Xi7464=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0nY7k+Ym8jHCvkbon8VrapymNEgOa2vLIlh00FyPRahj6fTnooqInLfWsq4lcytEsv6M/LcJThqaMfBEhRYSlxR5orTQpyQo8mh9LJ1LAA3GpDEqw4+SkmbkzPgELQlp05ZVYZcveyhOqkXUyKsktZAHFjEoqAK/LXRw+FogYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grrnIPbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grrnIPbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AE41F000FF;
	Tue, 15 Sep 2026 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434664;
	bh=SjwwInNi/r5ar6+egTl1g7ZA/YSfcTNAzmNY3Xi7464=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grrnIPbGLgh9uLUi1lA3fQEWK39lAljhQhdA6SMYgbtviwrJwFUTtQOeeI0O5GsEw
	 w9sXG216MPEZxtQsLfbex6C+tKXBfnH8tTgoMMDv48kfxnil0ccQuvfELnUrJimhKn
	 M8CASkGrdrkPjrdfqOZfQ98aTN2n3uaSNB1grnA/ZSFWIzZLSVbqa8smmOAv3ZXKmd
	 hNLgAjmNdcNJmcsHPH7etu+CZRuKaMUDHgD3uj8MXdRIv0gxfsLOOruxZpDH1BZLmH
	 8IGMP8ssRsvAppeNAzDCe7GbOiTAbYkYFVmUNOsnAvAxhq1FllwudVY6kp6RSJNWWt
	 K5kF89x4XSnkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: icom: Disable the PCI device on final adapter
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260915010000.52974-1-mhun512@gmail.com>
References: <20260915010000.52974-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 01:11:03 +0000
Message-Id: <20260915011104.66AE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> icom_probe() enables the PCI device, but the final adapter release
> never disables it. Balance the enable after releasing the IRQ, mapping
> and PCI regions, while the adapter's PCI device pointer is still valid.
>=20
> The imbalance is already present in the initial Git import.
>=20
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915010000.5297=
4-1-mhun512@gmail.com?part=3D1

