Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685605;
	b=ImmvoPK5UxTKMV2j3qX/epD+CFnUOwEthjyuZcSX0d2MUNxO7tRQbyDZ7ZqZNsYEVbas
	 Mj/suw9NfLB3/A2qZ1oVZwNjeGMmI7xaaGFdj6YwWrxgkQYUaHQ+frssUCqrlHtmQ69Uf
	 2fM5gSjnQivW6zokVnwyWdfIzNcQhgA4Ob4tuP7xtlkgoT6fbxNIHy/Msl84IPlO5lLn0
	 Ud0TKbfvKaG4Ab/BfWJBljnJP2XLuRHS92T9c+0LuWhNl4lxEF/ZT2APGsU+vc0ydLjqr
	 AN2SJT7/YRRQMpoyZtKZmpOKud9SNOCpdBsbLdwSav79PRsvTCNYZ+wjyeo8d8YwMww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AEAOo3xcmqaHazgmdHb7+uZNW7o0J675QNeSBSgsZjU=;
	b=K6YeeZwNjNFiHPAg7p8UOAnwzchjhro9AcXqDjKmCB57FZI4m4VUePTiPhcG+2jzl4vn
	 UssSGSg1f4Ablk3mvW1SdlDTljQVtayUiH4zyZYcYi69F9TGCFSt5EbxPzQhX8D+D56G1
	 ixzNiDmtGRQKMTb3vsvdTu55SVU2sA8/pcgFptNM0n5fbWd5t1k4YWzFjOxd5TLOtmU9I
	 yHfHCzegAPk5fZfX2llpMtq+nqEGLRGWLObz5ZQ+76xmt/jhiDMKA9wy/uLDWFUMi9ets
	 gWI9R5h1tbtqyU4vQn/j3goILYfOYt4QNqmqSckkrcxcbbfpnZR0GoSWjiS4cT5hEmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUKbDIl+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25F60A2620;
	Thu, 22 Oct 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUKbDIl+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6240A1F01825;
	Thu, 22 Oct 2026 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685604;
	bh=AEAOo3xcmqaHazgmdHb7+uZNW7o0J675QNeSBSgsZjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUKbDIl+EXF4+/tYVAGlnZXmpuTYOgntYWxFNsQFT6aPbH23lNyTjm2xUSHpQj035
	 M2MOayGlmu8r1t7fTiCKF34j6JTmf2YAdcyTc1+CUZ5gbdnw/majPUqvLtVCyjPX00
	 gEw5X84aSnNgzQp4J/MxVjvG2B2ULEyiHbkGmfxny0g0kirZ/2dmTTMi+EvgNusHFZ
	 NhA6eAJJaCUCm5oiue1g+93qPfcP1tpmxymboKlfEaq0Ro2JCQC7KkbfbbQsxviQ77
	 qpkE3YHcKdnxIbKMQTHisX203Z7zcwDjYva4Fl+INVRtISb5DPqYjKDI43IoB6S7KK
	 6fjpk/Ic4QC+Q==
Message-ID: <sashiko-outbox-181789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/27] dt-bindings: arm: rockchip: Add Forlinx OK3572-C
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-25-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-25-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:23 +0000
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
> The board uses the FET3572-C system-on-module and falls back to the
> RK3572 SoC compatible.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D25

