Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97A4E9C3D
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898839; cv=none; b=gSclo6++CG1qMiRH8q0+VAGtcLX69q7sYelcPdaoqrYAee+Kx5Nh63do7Ui7X68VV9qecuayGc8y18P/+GOz0mfdvy4TF68YC5AOniZEKTQ4bVfz/aqzYmwR//XvpSLXFx/6rH2LNzLlFwUyS4ln+pn5vVTsOqL6OKMqd2l9xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898839; c=relaxed/simple;
	bh=YwStlFo2JsmyvEqi2jvCIXsQZ0KNR5xC1a3i+5MRnF0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gC/0nM954n2H79006Qv5wuChfExlBCoJOzv7b/X/5vumVvQxrCt1/WxD/77jEJkYOTXLbzjRgn/IGSjrB4FzuvQCbNzZKLl2rqEC/kPwYLTW7MfI7GONlHXUgN1sbViYXkLjJJzXXTrrVChhaAIusVUo6wp05h5FfCvoYlyVthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV1OMDpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV1OMDpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AD31F000FF;
	Tue, 13 Oct 2026 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898838;
	bh=YwStlFo2JsmyvEqi2jvCIXsQZ0KNR5xC1a3i+5MRnF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mV1OMDpvGtPYej/WfArgiURqPutDdpKsd463+bNS/v/E51GU0u4b6fvTn5bP01CsX
	 LhQJRJRYWMyo5G5Rp4jNuwldqWu6nh/QwyshtcqwodMpDvk/wFitpPizH/nAU4sDEn
	 k1KfuYGPZVSJwqRlGLD1qWgcAG7yte+4MU2klwZW/JQ6I9nHmbQjWii3MWTN5fMg0d
	 PDltZGrRohYtJZhvcwSZ0yV2g60RqAMclW3VlFzHODfl9wPQ7zcnYpIDIYgLDhrMuX
	 T/uvDGtP4vK4TfKZ+eNX6s2rxpiCK2+3Aimzz5x3qNmMe0xvy6XNa5GIkkmqKZAFE4
	 FT5LNgQXkGBMg==
Message-ID: <sashiko-outbox-169846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: drive the bus during break in
 RS485 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-devel-pl011-rs485-break-v2-1-31c9f80d3e3d@tipi-net.de>
References: <20261013-devel-pl011-rs485-break-v2-1-31c9f80d3e3d@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:40:37 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In RS485 mode the transceiver is enabled only while data is sent. A
> break set with TIOCSBRK therefore never reaches the bus, and protocols
> that start each frame with a break, like DMX512, do not work.
>=20
> Handle an active break like a transmission. Enable the transceiver
> before setting the break, after delay_rts_before_send if one is
> configured. When the break ends, stop transmitting unless the TX path
> is still sending data.
>=20
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-devel-pl01=
1-rs485-break-v2-1-31c9f80d3e3d@tipi-net.de?part=3D1

