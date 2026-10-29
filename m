Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250765;
	b=3lqtlOVcKikAOtPsOa+HXjWfZA/QJHBygzCRfeAp+A2XXQ198XrxJ1cEDnpi85RKvDXI
	 gDhO32K+nt+SmnMN2sNEh9aktxWzLAi4KvE0bQ1cB1+BwMz+wmqPmjyQLm1kavxbdWAY2
	 2Zq0i17/+Of2crH52GLCBwUOOtEoiilB7RGxk2SXDDnfjy2bcegoebtscj/Gw3S0KCNXG
	 jA/EEMHmSft9LERJD8kCuxydmEsVDS7YxlL6bfy/wX/AebdEKunsFEpdJArKN0YmmJivF
	 9wMELySoMiqzFlMbFGNh71x+kza7bFdwZxK736/kEphp7mPXXrgAM9Bn+XhHU9Ptwsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=el+IZBJQQ3Xf3MjIHaTJAnuXNl11CSf/RAkTIrS65hU=;
	b=DN/8pRGzlEmiim5nUq7uslCqo9pEfz5a/ywwmu1MViE5aU+GZSNllSPqNDzUGQBB62pZ
	 G0KIaXzQh3107nhcZpUbGTjzCfWRt4S9RKaaIG4JekZlZG327ytC6+VMKAcSTJDSum9Sd
	 lEKsQrdhOzP0scjbD1igS7vCPU1AuXp4oxCaAWb98M7hHK3TU6Zognrhn5rTXmcxB/+mO
	 h/tEuGns8vA0hp6q7ccY95ZQ+J597CuszOURVlycfTHLCoIsgv5yBpCNfYnQjCl2mdNdI
	 Ry1w+PwzJuxFOaGahFvhb+OTE1anV8vmXTA8NPQU++gEHSKcm6bWD+89/eJ3TWoVGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTM0uM09;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0764606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTM0uM09
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7341F01825;
	Thu, 29 Oct 2026 05:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250764;
	bh=el+IZBJQQ3Xf3MjIHaTJAnuXNl11CSf/RAkTIrS65hU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTM0uM09HhQpUf0t1vcel65ULaMDLFt86wOCdiMTQYxlFOgK9f7f/iEiFWt41qjEm
	 XMIsyjTRFKkvxDN8VjfuatkoNjAHirDeEn2Ccruq6k91w4iaGayxB0x9Tl4D1grruh
	 SjCxuMUvTW/E2wjWNeUML+0FtYhq5AdXmRpiFNGWCne80PTsRp64Q/eVwEdRXskA5T
	 e6SWxcoVnJ0xDTMG7PzxrpIFRPCkAfchGh4Ney48lpdRqcfXAOvLwhYySmN17jcYCA
	 a+Qh1XqZTolK4bVpd0ZpEtzbm2gJ8eXQTvqV3s1TcTGLVNhkDTu6DtzFua+/38Myyl
	 oju2zcuIVaMJA==
Message-ID: <sashiko-outbox-188740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/12] riscv: dts: bouffalolab: Add BL808 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-9-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-9-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:12:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the BL808 D0 CPU, PLIC, CLINT and UART3. Leave UART3 disabled for
> boards to enable. UART3 connects directly to PLIC source 20; firmware
> sets up UART clocks and pins.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D9

