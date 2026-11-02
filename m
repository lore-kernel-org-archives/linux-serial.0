Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643016;
	b=m2EeazvPwy9AIyM4y6nBXbF77xUPNsFr6bLI1geTFu65zQSq1JWOWnnkiRQ3O3KYraI7
	 7irGAKO71F42fnxBnNCqg8sedWOZtIAj7YPitiu9/8VT3pb9ZeIxZ+TcRW2GTIPsuJ6g2
	 zJvy6XzU5xL6UZ9bIrwYFxxV5HsxFTLa4VgdDm1pjNmOAe5MJOSvjQE0C0o5URXLIhYeU
	 p/Fy9Jh/HARiEE/1/OrBAr1yURYeN1MRk3s8hCco8xORNiLvqQfxTBqcFClnMDfbSGYxJ
	 R4/bTEMiKbvRB+brAPvxv6UR+1hn9LoSEG9QY3M6bduELgnYSUan4247BAil0izV3pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7gjBUFrxT9fUPLVGEI35QT3+X1zr0bAatXUgkYg4fT4=;
	b=htTaodAz67M8jiAI2vk+72iaUyrGjG0zi78loLk3FlApRJtr5gLt0Ftvy6/y5RV9F3jN
	 mIwasZXAFfBVBNeUdqEUoC86IPANT+GmfEDk6+q6L54DNbwZhgdxiWKi3IhAOezoa0TWa
	 Lvac6+FtL4tFRSwW+wjXY8Xmt95PtXwwKrpAp6R7jymD6DY5w6FfHb4b7i9Dlzyk8jKrW
	 x3ZdEFRQoqbHNM+mOEFHGKMk+THTZ0k2l5a9ELGvaqOqU3kZ8z8+jtIP5ttuBj/TZWs/s
	 4xe1UEfTdDLjvJ4TdjAEPpWx+tWdtabuJxAQKePdHvfFnpjPCmban59OPzVVaXs8yCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKh35vWH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0B606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKh35vWH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7371F00A17;
	Mon,  2 Nov 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643016;
	bh=7gjBUFrxT9fUPLVGEI35QT3+X1zr0bAatXUgkYg4fT4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RKh35vWH7HCCrkmZ1HGiw/0UbFq+CFzD+U2u4+liqf0Wn74G/b+0HJcs9UGwVVr85
	 UVkEgonkFbh/M6ZdPHG3rmY8bZrNJjlCS+n3jqZyGh3TGqU+bMuHdngv9NGfCjTggh
	 35o5MX+QfktXDwbjgLYvuT5Xu0xS8kbfLved4+2Ii9NEiaX1FRG1Oz6ehxBaByGKeB
	 9G9DmcpW7S94DQrsVecoFbngr6E3rPIqLgiq1vGhOU+cXZbWk/tedWPIyl5A97HNod
	 BrNd6ZZfbhUG8cFw0Of+IuN53qcbXADR4Fd9jEEQCJCtb+vdHXZ6PbLoyhP3rEDWvd
	 FJOSHUgxSDkHg==
Message-ID: <sashiko-outbox-193913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlRUWSBMQVlFUiBBTkQgU0VS?=
 =?utf-8?b?SUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
References: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:10:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across serial drivers.
>=20
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102175527.3957=
740-1-Frank.Li@oss.nxp.com?part=3D1

