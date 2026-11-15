Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727427;
	b=H3KfTcF3Rki7x8bL1i32g+4yasrBlp7o7UksIgLQuKRJWGz32Z2uFaAkZsqQrW7V4NNs
	 9DsaDIfqhVp8u5v7HpASf32dXefBNcuIu872ZnwneMguAjPT7dhOjFP3Z7hB/XphEujz6
	 2O+w+nq1b1je0BLGPJRyaZrG4MGfT2SIkd4a4a44rUJw86HpFSkSmjC+pQ/Aq/AwjS/tR
	 IRVQWwdwOu6RCT5Ifz/rRR4bSxbdF0s030obDFIkUE79dwlo5FYcZX6UYgDIJq27CeMha
	 wPnDtL7m0rlmUB4B3fvBf98q2nIkyuHlYZNdnkUxsB0owO3rquUd6lY09G9IeESSfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ytYyWPElHj8laBsIVuB3TJSLojzXDvxkI5mH7K5LIdQ=;
	b=a0Tqd7fu9T+I407b/rSw8bYFIJcn4pgL3wPsY74KsOrRwzkLWhdEMeSCTXP3Vv/x0RKO
	 IfQBcZ0ZkWukSb6L4s4pIItUDmWErGAmAFgcQoUDvvLZ3EkH8dBnyJB/14BNXBEp+5fsD
	 15wgOPdiEv2qGsJqweCdaXTUsU0kKm/Eiiy+BI69lo9ewTeEjQKYwMskPdMpY91STfXra
	 Mcqw7AiBGQaH2zmU63OBm6w8g4fhBCv+H2lZRXKcBDwahAbNi07l+jxx5llWopqot8NI7
	 r71BJW+PryCviUcxQYQzWol3JPUMFD+8MwCltg515yJae6NC4f8xzusm4OAVuDc2FNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5S6FLBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98F606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5S6FLBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E3C1F000C4;
	Sun, 15 Nov 2026 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727426;
	bh=ytYyWPElHj8laBsIVuB3TJSLojzXDvxkI5mH7K5LIdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5S6FLBBi6JHTYp4/D8MNWLfASwHeJ5/mIZma70ye+HrRIbjZ60k1tCdR3XhwPSaH
	 2aDLUWAO9oENB067cXrakYekUd+6yuDP9PmuI0XhNrS83UwbkpYSQnYxHDf/B1idvm
	 S0fq691ZzTnwqu9K8/B23n7ZMaDjja0OKSazXh1vOTSElen9Wk0eF8CIllfJ6NPHr1
	 a1DHvz+my/CdaQaXIOcaob4tbEItYfxU7M95ZISnsGhIKFarHnB0YaJpT7qXEZIx3b
	 qKUo3wgo4bWK0xudcInzbYECwYfh01ztEY+eulnssIpAOnmCvRVZvnc8pe1/MWS+Ug
	 veVoEwUzBe+rA==
Message-ID: <sashiko-outbox-215256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] dmaengine: dw: simplify transfer-complete
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-6-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-6-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:23:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> With hardware-LLP residue handled by the status getter, the descriptor
> scanner only needs to process transfer-complete events. Return through a
> common unlock path when no event or active descriptor remains, and flatten
> the completion handling.
>=20
> Only one transaction is active on a channel. Detach that descriptor before
> starting the next queued transfer, keeping cookie completion under the
> channel lock and client notification outside it. Preserve software-LLP
> block advancement before completing the transaction.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D6

