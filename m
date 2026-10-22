Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685607;
	b=Qe2sMCHXm4+Pr4xwwaqfhRHeqrQH0OfmcmE8VFcQ1AbKn4/TmeJq1f7csAjtrO43fQWz
	 UN22gyydaVlsPNkZxipBPj7cohwn5WJv3IVyN3TycyV5hR2SGbaw7ONAvSf3/j9QZP2wm
	 etmVYRCZJ2PoQJREvH8AaPPGRFPulVCsCHQeJfHpyqIHloEQyyNE2+7J/zbe8FH4/zoMK
	 fiOFXIvB5NWgXd+pH8X+cVo5obNFk8vvbsGWW6ZBNBOS503j9j5IvxGESgYvEUePOKzO6
	 djDQmmbp/7Dix0V9jWShBrid/sCIFpU7hwTh9H2qNdIvHQhw37+Gs5vke3WPRA9dXPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IzlF3/+/X2k7QjE3goA+q0Yj2pdVsTUb3hK24C9CkGw=;
	b=eX6n434Gi4AXEIONs3oZh4CuFV75ms2VmhXrSRlvq1qirZ+rxab4S0NXun1YjcJNdA/D
	 hcQR2fHjFeFsgockTqyf+5LkLRMgYbzxKtBQC881+PMyPXoBxYzDzFNPmwx3bbBLwc7su
	 UkCOTgc1Dq1OXjwcF6cdjYffxv2Ehxk4rIk4BawLzxNHTL6vqG26bAuuMlMei8PbYlN2I
	 ykdGpqAw8nC/24Mm2zqhtt+D1fNYQ4bWvegGyOzUxvZDeDXyxyfPo3vcdb2E7ngye6poq
	 dfyOqdudG7oOq7qF2oloRPv+Kk6C/s22d+MHBPzofYDoYHieVSFRtd8p10Xf6CR53uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/ApKhiO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3D606A329;
	Thu, 22 Oct 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/ApKhiO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A3A1F01825;
	Thu, 22 Oct 2026 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685607;
	bh=IzlF3/+/X2k7QjE3goA+q0Yj2pdVsTUb3hK24C9CkGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/ApKhiOBFaIlHhtaRodP+lmx6G3oTRG6HMzvvy/yHkv4YAJHnUnG3s95yC31rX0p
	 BSH4AQBU26irytLVjiw4Tfgx88EXn9XldV67fkcUZR2mKfGEaXNcVFobVH472jiZXu
	 uWdBR90hXXm0CldVAExX+3mpkKXa0Z/Wm2fnRI+SnA2HgIT8zJad89lndSUtcezJlR
	 Fd64h83CTe1ZZwgcZBWGWqRxzCJi+TzmzgGjmt1VeQmn5vnCm4PTA2Dr39C/IEMiH0
	 JefaVEJsweAYzVUiZieBpL8dVxLNMeEPJcP30cIT1lgBjhaC3PkECmOY0Bic1GMhea
	 +73JX/iE/7Yyw==
Message-ID: <sashiko-outbox-181791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/27] arm64: dts: rockchip: Add initial support for
 Forlinx OK3572-C
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-27-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-27-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Describe the OK3572-C carrier board and FET3572-C system-on-module.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D27

