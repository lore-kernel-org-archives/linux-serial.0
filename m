Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563922;
	b=HRFd20p07spB9OFKI9rgSNfKrlMWcHDJ8UawYoAe+v4bIL5GqgSFxg5gDVxoBUTTqONl
	 lUt5+2kirZ7v4AGGYWqBuQbBa5y/idYw2kawWj/+jRcgL9Om+9/JpcPPiN47IDV7uHQH+
	 peQ2nEEmn1XO3A82FLZ7Fhh6aw0E78o6YHTHUh9Di2zzA3x/mnWZGT1KVHoBmXwNJsl6F
	 p8Qz3bRoD/hUgVQmV+YiOB9bzCTOD2+4IiLlpidBW97gAF6+4sS7Q3NHsvSB/Fp6EaIYQ
	 jX59xadZil7MHx1ofiZ3OqrKoDkgsQw5snzH28wq3laa88v5RMRQggBF2hFPBO4ftVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ldVACqzS/iswcx7ajROqtrt50ujb79vLuCYnVUIpApk=;
	b=xB7phYw0dINJTvGeBDPobKFHa4jx/ln1hdRBd3XpFLM1LDDNybrcusYlaB+ZbWc2i5Ir
	 fip16kts5mILW+ZJ1KkgMrovp97h3WkboUxby/F8miCkj20295MZEKaDCciSOgQJ+tQ3N
	 9z+4VJBr1qwgEBKeAeaQqI5yziCoKJuAb3LDB+8gFT1nfvgOHShzo+Dd4zQQrRunzoCu1
	 yqt/yzKnTGkrsFRfz7hmYPkB8ya1hqh1CPFY56AlvQ5Xl2NxrmbgteToy9/3dd+wuF4J7
	 /NIDxUrd7XvpIWK4olK8NI74eHlaLjEYEgQGOyY8L1QlgCUyz4bPg3yG0eGexWlP6Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QipCylRI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E071606A31C
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QipCylRI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124501F000C4;
	Fri, 13 Nov 2026 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563922;
	bh=ldVACqzS/iswcx7ajROqtrt50ujb79vLuCYnVUIpApk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QipCylRIvcyiU9dEIpGFnaMENRidUULUWz4RiWiPGh8net9T/8rJT55WqN85/ILyg
	 v+mFua2X8+m/XwCzInll86a4YfKyNJoOAp3d8mZlunZl7yfSehZoidQ+P1Ptut9Q+3
	 TXWs/ZiKyyn9oVkzp4pYAjnwD7LZ0t/wuNzAWuOm62qFz85fMlPrLDdy65sSeyr+TY
	 MccjUuITIK7ZJG4CoihIs24kgPj86Pr2qCj4PsETwuk8kO9wkDXaxsifH16RS0Mu1J
	 R1DgDZnMJ7r3HjFgr9KPavX6QEQm2ELIWNQkoszQONAoff5NfpQEIWqSILXALf+ozf
	 8wmgyv4HVyEyg==
Message-ID: <sashiko-outbox-212591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-1-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-1-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:58:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D1

