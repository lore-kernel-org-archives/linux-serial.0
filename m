Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685590;
	b=DzFtogb+Q5SLamETvFUHQJIPO+qrHwNSLe6YaRaKqHyLZk1behVqVttU80IaifBURr3O
	 8OGl6o1RIIg67FEas431x1VK1hr0zxi6N2mpgXKzm7ysNABOgds89iQeePMMDsWW2qS/E
	 X2oP521e/c115aLrMTkXVB8G+NFbA9skDJYe9DJv3ivqYhtygAHxALA6BD1yNsSXytE+P
	 +Gun7OmaeA4KDqSOZHIAGdg6XKodmipyIAhmFZ3PxszEKOT9tDrISll4hJEp5Adhc4gea
	 bRnGCD4xUOek2sl3Rdsk9h3xefd1eCl9VF2WFLmBb5ZI5/yl3/aSnvvletsTwLGwG9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=azoMIcJ3x4Fvz+6dWWV9H6mgNGUvVkZFe5SNxZfs6NU=;
	b=5lyjoQJagHOrFzL+NOdnzjaArF1CYW/Cz57ndR/un/bmOZFIKQLAHsCMeaJNn5m1IAdC
	 IT7QwZZg2CUlPCaxjS2ddOCllpAOvkrCplH+/MFoUmJ9K618qDV5CEdJUWVqPybcB+F3r
	 m0/BMZDN+mO85Jp6QJ2/4tCaCXcCFh1slOC2dlz1TQLVSqj3hatlHb8GRz3CC+K/dP8gx
	 mgu/lcy+rMfLF/6Ws4v553jHYpr9xEaq0pGMD5P28PuwWnINyi8kmdHNx3TJY9yM/v+qs
	 R6HZgdnVOXlFGgq3pypK7Yn55SyHazafiMDhLHJyMNGJ+OX5ezDyU3d+X07Rdmj8qYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F6k1/YWp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F82606A338;
	Thu, 22 Oct 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6k1/YWp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5636A1F01825;
	Thu, 22 Oct 2026 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685589;
	bh=azoMIcJ3x4Fvz+6dWWV9H6mgNGUvVkZFe5SNxZfs6NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6k1/YWp8TIVbS4pVcrLu9eXZOp3mZo2Zfoety/ws1Bjz+XqWbkUANZenhqDfo9ni
	 7AtsjXmauY6WmX4Bn4CCSOxeCA5h9CytpP9DroeE9SgMgJaWtJliwrYDAyIL+SoSxb
	 kRnW7fDvaghoJ9wUSyv4mjIf6+k3mDgqw8oAWuruDEwSe+AttL7ypfkI1geGldGn4A
	 RCo1J0PmT7r4hGY4QRJGIQksMRWg7V8M/9jdy1mPnS0E2HMjK+7cTZMyVbRRXsPlvc
	 Fb7y2FhXRdWtcj8Qa+NZ+EnepRUS7IswreyBL2qvsRWYXMYZwUoUcfeQC3l220aCCI
	 Hq+KRyuuXGEEQ==
Message-ID: <sashiko-outbox-181775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/27] dt-bindings: i2c: rk3x: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:08 +0000
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
> Add the RK3572 I2C compatible using the RK3399 fallback.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D11

