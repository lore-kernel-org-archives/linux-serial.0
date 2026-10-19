Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429701;
	b=XYvamri7YzhjMI2OaFpW12oDHMOydfVQugXhmSCiHHv2Kb21c4ql5B6zkBsEdnhKAxwt
	 4npdp9i3KbMnOIGPbR9YNUeixT3weaWqnrHHlywdPEdmICHjktKFTB2XHEIrQ58E4NG2f
	 pwTWlMjMexNRQeeifiGgVmeTmM1WgfN+t2kfstCSGRiYDIwhRez4PDp9XPYhb2HUAbyjO
	 UzM+kUbFIabPexTi7mxJePyVqXO/C5A8XN0hAe7A/VF86XPQNZyE3R+bCfQSlnqgQ/Adl
	 lw7I1JNoCheC99svrBu7SimgORP3IYP0LuiTFOb87xiWpliv4bcKwwy4KuLa8ZMnBYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A8naO/tXKG3IPwGPGBMQH2rn/Ky0M+djBZjiGbXklEA=;
	b=NcXtZcJUYaXc4o3TN6WO7HRqf7Ou/etibztDvV4FWzMQ5ls0ZIqok9bX4rH+kjnQN+Rb
	 j3ndJ63QzNLK9GTWZIQNy5SJVTvASuXHlbxAe+e/KZyYH/nQ/oTRB9W1ajYJgBVixAhbK
	 HJIvc2e1M26s5sXuYCqJVp+QUrhrUaL0tHqKd0Lw4KJWWcbA8TB/Wiv8hrObTNlvZS6yh
	 ZEKnEI1B0NWVQdcz1Ei1CvaBg5pbEDj40znXUmO2ECGLn5yXFBO0PzMpiavaBfDU4Crj+
	 ChZcLAnCAegjq0G+fplGvepqxs1JWb3H4yiSHK4Io6edLqr/qrg66X9974X33BavT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbXvYxIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D33606A31C
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbXvYxIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB76F1F000C4;
	Mon, 19 Oct 2026 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429700;
	bh=A8naO/tXKG3IPwGPGBMQH2rn/Ky0M+djBZjiGbXklEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NbXvYxITPYai3qBXWnjDBVk8nD49tf58Ic/bMkf1UGr1xxEK0hofQ1t2tZa/sDT7K
	 JpQaZhiTwn332Ky5KZBrs1SWxaL8mVDadprf05Km0Llk4C0ziKiRBeCYP+5fvnDqhb
	 L+Uck42xrnxsTQ93vX/qWKo883q3s3Xf/iDntk/o5kl9xWMZDYX7FQJ/FardemQ0AI
	 IZOw1peO0d+jw936VYmEgQt/z/AJdJ01StgpnywbBoZbBf4mwVecUr4IJVQKZAMgrF
	 xdlakgZSM1w6EH6pP8er9tbQ6ZMaFmt6TlZwjhHDTjFdkHvnsJbXm7wM0kQlz8lj4I
	 eGMClGHRtC36w==
Message-ID: <sashiko-outbox-177999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] serial: sh-sci: Toggle TE when restoring SCSCR in
 console write on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019170139.473808-5-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:08:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Au Dang <au.dang.jx@renesas.com>
>=20
> When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
> hang at the serial console output stage during boot.
>=20
> ftrace shows the following sequence:
>=20
> 1. sci_transmit_chars() is draining the TX kfifo through TXI
>    interrupts with SCSCR=3D0xf0 (TE=3D1, TIE=3D1, RE=3D1, RIE=3D1).
>=20
> 2. serial_console_write() runs in the middle of that drain. It saves
>    SCSCR=3D0xf0, switches to polling by writing SCSCR=3D0x30 (TE=3D1, TIE=
=3D0)
>    and outputs the characters with sci_poll_put_char().
>=20
> 3. It then restores SCSCR=3D0xf0 in a single write. TE is 1 both before
> [ ... ]
> TIE is being re-enabled, so TXI fires and the interrupted drain
> resumes.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170139.4738=
08-1-biju.das.jz@bp.renesas.com?part=3D4

