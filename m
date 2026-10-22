Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685583;
	b=Bu7yHta6ClU+4+zDBiUMK1Vcvn43ruxe6K9J06n/OcjF7kefVhiZMP1FMkzCMFP1fwiH
	 6h2e5//3XURWhJ08TOhNyncP0FV6QFLhx5YfNGpz1aNh+cMNhiXpEe4+nIqps5mloCeWX
	 mwsMo8xu18n7GHjAwixBDJHkModzxpwoGF0+XZ/NWOhjYyLDJ2GAfxS0oYS/xNwdVyIQ9
	 37vZiHyyDcRc0vhnUxEifDd4mLt0kKZp1bVbL4O6aZ4fd9rRqHIpkrf1OUhbFwicQz1MK
	 CFxBHSkRjJGBOhzP8gjID5rZVgkcA2M7nFEFl2ao/0yBdlw9bgu1qbRknNH4skUN6+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v46MHQL55oAS8mKQU6hEzpzOZIzUFt6hoavtQhgBXx4=;
	b=mULkIfc4INShNX5epuAP1FPOsyrcBsiehSj4QJ8W8AMUvKRugjbxI0icwGKmHPCZyRWY
	 3jmlYVrKjWQcCZr0Y3PKqtHkdRxTyzudavm3Kvzk2pq+SyxJyaWd5ezT/RmTkuOwx2bLj
	 CnbLXfBvnybOyOVNBMCeYgGZrvKlIjm+3llJgEc16loLXgw61Iy+Q3HZidO8rBeP15Qdc
	 AmTMeyGnpSC9nAd68D5lNLYOP3iHl/5Pz+mQzdNXMXiD1rCk6pMT19odI9UNWoPsAFv//
	 uFFR5N9018x5wCSmw0NZKURecgK+5DrtLFCjPPYkUFp+ItiYbDAv8MvBAm+juOflBmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWizAqJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1431606A31D;
	Thu, 22 Oct 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWizAqJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A81F01825;
	Thu, 22 Oct 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685582;
	bh=v46MHQL55oAS8mKQU6hEzpzOZIzUFt6hoavtQhgBXx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWizAqJz0bMo6ryg4Ffwypfdw9tBZUML06LyFTKGURaRJVFEV8b2jrJ1wcHZYi/ZY
	 zrDEmfQM0xUiSGcVTzmfxt+HMbOBD6R6mvjkWnN19PbBth63FnQwOYRjqbUOcMEIkR
	 xxIuf51TWbu6BqxXJ19+JlxF5D/ZvrjwAW4aq4F/ufW/QMgmlJVUJsImW3/ZbkbwwR
	 vlWAirmHMMDh/fpk01yz2/mPfWeLPk4G31CFcHDGOMO9EOG7+Ji9ZGCkyN2Re9GdWm
	 hfx1nwycEY+8d36HJvqMfap+tqhKg+xSXGQy3DybGDZ/orSJ6fiZ8k/xzjHYV2ZL5Q
	 IR3osdddAK5CA==
Message-ID: <sashiko-outbox-181769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:01 +0000
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
> Add the RK3572 pinctrl compatible.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D5

