Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685608;
	b=K9ZBh0JykWmF9VzBTy8wddMmB8CiwuNacQW06j29XWhhTHkEhED2m2sCWAbN6tUw+hLo
	 bFYMWy12s1+OhKbuMthhZXOBESS524IhseHKS9R4y2tnP8JjyWZOE62Zoab7aAed/QX1z
	 JDd9Ku4WxtTjyuakuYjt374Q25TeoHpwega7o6S87C/NFOr3DeamhNrPhLaSwK4BY+mOr
	 gpp32MisAjdiybI37jCHskOiSJXpX4PJfnbcdvAli2zULmbpx0d5y2ApGw87xEq4L7as8
	 PaS9PTj/xd1HVxDwsBhJW1fCJwAgeZvlDPZLUxgr1R3vnhkzGW7goUqkCR6zPb7hbXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oH4b0ZeSypmggHVhN0K9PBizuWvC5Dm2QKKWJlgxz74=;
	b=uFDJ/t//YpLJTHgqAXZMJntnCIippI/VmBCqGyYDI3z19UY4DZG+DEOFigOY4HyS4EIw
	 2MEpN5uXm1oemgx/nqSNxoQu2gyU3UR0Fvid5mMlRJzQpKG6Y6KQW6BMA2porKRUWXEty
	 0QYeHwrgaQgds5kq0iEujE92eNgHQz9XjUEbAtyPro+DpgOhVEgCW5PyNyWlDjEQIBH5D
	 ktDZLkQFGBRkWfLhDMTBJuSoFxmhz1uY6c0FF32EpPnnkWKl2BkvAVQ95MfIbRrAzDJdY
	 pLWxFUdI9CYiP+YIEDPehUAgwJmsuY20J4BKHa/RtvQFMaaorwZOzcwhCuTH19BlNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GOmdfq/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0730606A32C;
	Thu, 22 Oct 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOmdfq/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729D71F01828;
	Thu, 22 Oct 2026 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685602;
	bh=oH4b0ZeSypmggHVhN0K9PBizuWvC5Dm2QKKWJlgxz74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOmdfq/eHcoY7Tp6CZg+VGxVsxWzzHYmAVidotEZpiPrceYf43HOqzP43Fzowi5Ve
	 0rd/uxJxtQBnclU7ZFXSDI4SgT+ylRHxgqPX6qEpIkqgUFJdrVKM4q/VPBqZITXRhy
	 tR5sCwxRQ2j+FFpqZZXbO1SQsO4tKaDhDx0/tPKLbFaJaRPtwJGKe9IAAmK2kkbdiB
	 /pYwU308mituXMi2vCcNIjMDWYCB7Q+Pb8gUbOvQVdWgPcyrKE1k66mDp5kD4r0fAP
	 4ip5M9mYvOvUrXgOQHNgmuGT2puyFa+sBlZ4fGprp6nk+5ozGOx72wvlvphwudV4JZ
	 dK/arj9rFIRPw==
Message-ID: <sashiko-outbox-181787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/27] usb: dwc3: Configure RK3572 PIPE port before
 discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-23-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-23-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:22 +0000
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
> Firmware may leave the USB3 PIPE port disabled, causing DWC3 to discover
> only USB2. Configure the port before reading controller capabilities.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D23

