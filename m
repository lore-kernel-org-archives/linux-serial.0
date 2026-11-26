Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697183;
	b=ZHXR7rbQrIBieOfHczHqMrawC6IrmCGsOvF5r8NAld0dxPY+sdniHNxYBjcgxaWDFpY2
	 +CbKgpARk11ONnfsSEaLoet6eM+lX8yJ2eouIPUx8Jtt6PTZqf4abc/vXK12vJoye+CNQ
	 0DxWVi5qe48LMcRJqmz59hOMqckS+l4TVmdSqwfCIa1FyA3/V04GB52XjHDcULqEhx2Eg
	 PPV0cHoYcvmp8h/FKDOWq3kf88Hu6+U3sSlhtb3jFWFk+sOJX7Q3KgsLTVAMcWgtCWWTf
	 eAUz+1rXlnwECB1G2cfyMojvfclNgIVcOgLGLTcMGQaquIyuCPgyTVi5k1AVzU5CQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vV4bmgLdaGI4pm3ivrCzoBz4+4TpWEPE+1DoUqMQ4ns=;
	b=1Tyv6cHZB12pEouO3h9c+ssW88Ls6/eEUBUNBWZmNYFy+i625wigurraKc3hM+5+bsip
	 j79uTW1s4H50hS/SAF2fpy7e1QcPt6l2ZOtvQbGmU2PG3HNHDvPQz+Fo1wNLUlPPV0VC8
	 DiTnAJbfYX/20S5ikYzVv3DlG/U0WNcHi16Xr6pZsT3p8+B8BMDfR8ii10/gvJ9fhJ+Ue
	 GFJQ1R4gvLKZygNGS9oWcmqadGv3Mj9TecVQOE6SfG5Om3OOCmLNwfDL4QKl+M4AA0JP2
	 MN72uvx6Ekbq4hxhdrOuO0ByZydtEl6G7svUMrQrazpUVfqqxsb64WGUimjFiCM+hnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZK/gCN5O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06803606A31C
	for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK/gCN5O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E811F000D1;
	Thu, 26 Nov 2026 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697182;
	bh=vV4bmgLdaGI4pm3ivrCzoBz4+4TpWEPE+1DoUqMQ4ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZK/gCN5Oi3Av8wh6Ib1kFrYgA9DN87MX9I4QeAxPtrr2qu6IwXERj9+KNc6AjFLT3
	 cvEIQhm9302QTGGTUT4WnaS3luLmZjlzf5xYdplgmxbzehW94t/NVRvl2Ze34yGxUc
	 X1FnllOWReOdv4fT3boYKuWrOlhd4sMPNxn2IwXhAuDw7m9W6s1GlRMS9nH1YlFzSK
	 kT8Nbf0JYt40CCahtRrxqWUhrhmQFS92wSOzMfyOEm+GUJdRS5NtjsmhjH82AR9pVv
	 McN1E0zjesnO/RtwfAHsr86iB2p+LGmoWNlLRBQGGGtj372uSpQWmvSgvYNjr2lCDM
	 7jUHF7ZYM+qzw==
Message-ID: <sashiko-outbox-235523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/8] arm64: mediatek: initial support for mt6768
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Vivchar" <rva333@protonmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:46:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 8-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-6768-init-=
v1-0-abc364a2447e@protonmail.com
