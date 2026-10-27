Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115679;
	b=ccKtufCDAZkIl3hQXpL9o7UWugH5SfhEsZTmHqzFOqcH1XbBIb0b1Z94EnU6CMDAuSnH
	 JoalBXvt8fH6iT5I+NrG1bnFxM6zjTFSzC+SRcR98R6gm/sRpXCb/B0iemZMTWK+5x1kx
	 s4GP85l+zWxOZ5tdNjXwqKcT+NfBs5kGHtfoUghojUndEZtYsrzJT01P7hy9kSmV3sNTb
	 2pQTHG6hGmaRo4AKCFitci1mBIkKRqiefRWXJ4MdTClhassuiIfCAtnoQ43SxhBHo5lFQ
	 Wh4LmZBDsZCqZTao5cBNgfhT/7ILI8N04jINaAYUoOtGkX/ckeW53u5qGXQ8W7iLkLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7xQEwqDQarxqVV7dXHUHXvkbz1l8A1nxeGxKNsPAKZk=;
	b=vOCYpwFHDYyEbvc3id+OcOXiNVqltKaEB1AtJwTnJjJs7WcVT20nNX0PDaMUAP2/uQKd
	 D29SiA1ArRYNJsUr2aooYyt2RiSAeHOqGKubCIfWH5qdUxm0k0P1o6YzOcFdaveWAvTsN
	 MyT/M+wv6C67h/YRH1WOVeMyVsoOCsoi3d7XyyjG7AbDxzGuLPCCbSP5P58p92C5B57yh
	 sEMWSqK40rTZ3FFL+MX1jc4+wBiJlfWAdt7ZX5B4j7xLoVTOKUeVZKMDU/MMfp32+0LDB
	 kfSSouRfH+NzR3cFB/giGQmpM3JtwY0NhXgZ6MaFzLDJNiW0+LROUKA+/am38kyl/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPsoksOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFB606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPsoksOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3321F01825;
	Tue, 27 Oct 2026 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115679;
	bh=7xQEwqDQarxqVV7dXHUHXvkbz1l8A1nxeGxKNsPAKZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPsoksOIR21x0N6cslOp2KxG6gbBcPS/pnUuRVH+vfMeQFNOEf8UKsSQrBOqwNOcr
	 JE3Cswj9tWehIXmLXGVNadpUro5LY22wavHzrMZ/hNrCZ6Cy6yuZSAi2A/zDMZbF5W
	 1WweL+Cu93ERrxAeoPMkP1bV7/Tf3zfONagF36+32NTeSGbPp1FTMRGGNcTOy3aFPW
	 AtCTG8BP7aFqpNuisVUOOFZGk0UAdAB+d3lrjSclWtHpYlr7hee+cQsh8F7MlmSSO3
	 w31WPpcEauzdWsu+4BtZHujRjRhiYbk8H2o53eit3ZyiSwEQQDE0JUotTWEid9obEO
	 2bO+fMXG+2aQw==
Message-ID: <sashiko-outbox-186860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/18] riscv: dts: zhihe: add A210 UARTs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-14-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-14-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:41:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Describe the ten DW APB UARTs with SCMI clocks and their separate APB
> and serial resets.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D14

