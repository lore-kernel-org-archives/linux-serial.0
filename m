Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685595;
	b=FgE8CQvCK6Jmju0LPUGNf8dtvTyRJ+3QOMk/V4ctG2nbT+41/zuQpzjep6wNd9Fa1KdL
	 GYR2iBRjEqJi9/JwYWTpQpfCu09cVeIFUI82r6vDs/SsMAdyomCMDjQVued+ZboDofnpj
	 AwBWuF68T21DOjJAC1Vb2t0cD95DcW8CxDvex9uOOWQK4e0u5mGLxrEP5IiMSO04YiAvJ
	 /J7b2ltxn9Tkx9j9e7jRlrFR9UBFPREB/MCN6TJTjtGm3OWCdnOfU5nZ0yDiMli91sT73
	 D2n7nOYmfU3Vr3pxzJIGBtLW/Ab2rpoFkh2X8U3sVss2b4nLeLSCNU2IjyTLEImzTFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EDB4hR/xPIU7rhzXLefFKFZDydGD0qGb2dUaO8VQhVc=;
	b=KbPYBxpfQsCOSen8j8+xmZHrMAME4IPPlRyWE3r9ISFuzsgxVmFxwa062vABFjCOFPaW
	 y4FUKuKJ0GRnQx0rm6+sEKxOndsUDQg2+o9BablqcemmDtj0Klkj5F7s1AQvDbEXBAl6t
	 B26t4r3J69w3WtXDxKnz3uXHzaW4qsy6HAUVET2kRkgeDsYX1yqYAIt67v9GNCffxtsmk
	 N9evjS59dJwLoTaSrsYH12XPzVtoLWD6DAHRWKwNU6HSS89jXBe2wW53Yy8N12neG9/xA
	 3MalWPzLCVoHTWtea2IB6hn135tfeard4bjSYFNtxjuXLDwSxhSdluLLej69VNEdljA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkMPvOBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE2606A327;
	Thu, 22 Oct 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkMPvOBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB2E1F01829;
	Thu, 22 Oct 2026 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685595;
	bh=EDB4hR/xPIU7rhzXLefFKFZDydGD0qGb2dUaO8VQhVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AkMPvOBWYIgygrhPwiTZPC44XCuJCXwURToRZ0NCNsqY8y+p7Td4ft6EJzFgL7KSQ
	 D8+saTg+n4vtlwPKWvBrLCx3dF/9ytWQA95fKUa1knn1fX68Vm1RdeF0YF5QMvGwrl
	 TlMoqh9wpc9yd1Gq86I0iousJYZKRPN1P7I60vVw6ErMtN6L9IthP8QZSSt+giiLJr
	 edT13H1GanTwsDMtCYw+sQI+/qi+yGi3IVhrW2WSwr/FpSgd5VWVJLF2oGYs8DuWRl
	 t49kN2Wkgwqh0MatXHdUeywWyMREgv80z3WFZr5PuOY6Cg7P/JU0pX7a21jUWT/0/l
	 DJB7Z8nrvhMTA==
Message-ID: <sashiko-outbox-181780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/27] net: stmmac: dwmac-rk: Add RK3572 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:14 +0000
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
> Configure RGMII delays and clocks for both RK3572 GMAC controllers,
> using GMAC-specific GRF registers.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D16

