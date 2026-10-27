Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115661;
	b=llm6rpK1+Bkap8j7hF3QuRnnXGv+wWTHSNJP5P8CevV5UElPV4/R3lj/u5+KTK8B8xxE
	 VFJ5z9iuipsP53HukzyEjptBP3oiHwS2nnKjx1DDpBoqJYnxFw8PsC70aROmbaJhx5eSr
	 si20BeF6UAY+jL/Qcz1ZUiuS1FPuubq9Xl/gtRCjTcrwe8uSIfR2lfETQlpT1EZ2Zsgl+
	 IN5vPjX76Wxw/CFaM3maxt4RPqbnsfaYCYi+RXXC/wosYuk4Z5SdzvJ9TLgnDwK8Xfcw7
	 oEO+T7zX/zGyhF3F3ZfN9T0jgjMTOCpTkNO/a8AfGdOBOFF2pEPQFJO0PlIZpdI/++A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sXTR63VVADnlfUQAH4pGdny/nefRdt7Kn+imqa3vLB0=;
	b=qB/z77Pfj840VnEICLXB//G8eCgcRKyCf9sYFj6hyoKCYyEe9LNpWk/MSfHeBx2ab263
	 9lr61trwZsmrxsWZx+WF59TLm9J8GoEzIhugzf04J9r3rIS9lyqDgy5WOoHDca0G45Dsx
	 ypU60zxP3IBSKD5K0s/K16sceP0A+9pvGs6sdJ48Mm1ktj40YGbgrTSrCny1GwOjwbWsH
	 T+tLJyk6i1avRdCrF+CBb2gftimg68or3gI9qOQqT1N1K37qsuze4HoPw78gmxHSYe2Mz
	 iQ4WDQOuN+f053VC1TA/BtDu+Z0afu1mHCuggN3crg6/LLHvHeUcWMLNy1AWb7yy/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3ZZ125r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32778606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3ZZ125r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC481F01825;
	Tue, 27 Oct 2026 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115661;
	bh=sXTR63VVADnlfUQAH4pGdny/nefRdt7Kn+imqa3vLB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3ZZ125rl6hBrdvd0nT0VjVttka3CgfVOxtRdI8lAXjxdLFWPj/HwPKW6hDorDxUi
	 b9fjkOWsHhEKaWVOhvO3eIiVPaplKWkGbzkrszlghPqfoHgrvQk7on4DhDD61eRvUH
	 GfYouZybr7d+5Y7IcnKJ+o70VYo/dqYs9r7RVD990XHUQW74w+qGNpQacdt0AK/BeP
	 mkY5rN5uKi4NyGnN1Qnhb5pSeeLC0MIEIQRTKVaAE7WPeDVh/VhBJrcc+fCw8HW4Ae
	 VX6Kami22kDlVpI4ND1/EnWUXat/sMbKPCASTP5xCpt5o2igOOS0iwWuOiSINgNWMn
	 gtpYWkaIIVSZw==
Message-ID: <sashiko-outbox-186857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/18] riscv: defconfig: enable A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-17-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-17-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:41:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Enable A210 pinctrl, mailbox and standard SCMI clock/reset drivers.
>=20
> The A210 has ten UARTs, and Melon Pi numbers them through serial0..9
> aliases with the console on serial4. With the default four 8250 ports,
> the ports beyond serial3 fall back to other line numbers and no longer
> match their aliases. Reserve ten ports.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D17

