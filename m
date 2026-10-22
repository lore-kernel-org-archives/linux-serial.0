Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685599;
	b=leK/fNC5XZAwq5t5/ZgqH4mrDLqYssBIUqq3PR2mJQtSHhEXV9DTxyRSeK0YT8L+rHol
	 dyzhIu4thBeChwS1YTxjNim1AwSR9VGSP9kNhQcr1PEBgAWGdTE2cz6qpqFPI/uThgWZ9
	 3PrVpQ6UQlfQwIIlPxsofVaezGf6bVbfnUyRftPTU/Vha2/USIVcc0uGZY9P5pKwDMRnC
	 qLGPtC0f7sxLXSAsa3v5FqeULEHmCYmQ3IUyqDKmu+W99/m65ApnN92+4wc1E2C63mpyY
	 jwwKfmsX8PDjjOQdmMi2wzQ5q5kUHNgTe+H4HVLnmwT8KrBLv4muepx2xAPfPtPeaJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N8R+Fks1QutsF7rPJL9SN58MSC1Nt/1EkgbN94Y0haQ=;
	b=LvLRwFfj6R+0WJN4trVZvJsSEZ4o/yXgE1kOD6w1kzne7+OP5bD1xjWtt83SeIJZEejQ
	 JRph7emPDJHHY+3u+ggaBNQT7cjHKUHjXGufn0o2ZoHpSnKPHqBUigLYeOnyT1OIB1L6F
	 TfD8QRquH0cWTSWulXnKwzKjyHEcp6w8IK5qN8gQ/MrtAf0e+Xm7Zd1Yss6lCWV/9I+8t
	 L64O5uemx+bhftd2u3gQYikLcyUQ2+zdgl6ZXFrr18YREEWZ/TO5HJzNtnve3EWRBOPtl
	 p+QZE6rIazazzeUXQI82hguWNlwWoeNJbPyfyMIZhq4CFlutSzEj9xvoD/UBb9Czk+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3qG4LYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B34606A32E;
	Thu, 22 Oct 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3qG4LYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5B61F01829;
	Thu, 22 Oct 2026 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685599;
	bh=N8R+Fks1QutsF7rPJL9SN58MSC1Nt/1EkgbN94Y0haQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3qG4LYfmBEXR86T7mVVdedJkSWjwTMOfhHfqMUgciyJcNzi87UluCQVQ2i7g1hcV
	 IO9WVDmDTicPbOXH+RSTbEj7FdhSBR/mZcyahpRHJQgq0xiz+k1UzuiCcMJqfPlVOq
	 7ynQH7lZhmjTeyEhZQfOYJhQjI1aPX3jzlIHCTY3CnT7xlARGSP1T91GXd1x46DDgx
	 Ef2f7FhzqrrP9lnIRxIkAdL9awJutapVWQAUYuhLIUu2+wTNZKWeQEWuAV0VMyg1tC
	 2NdbXfGI5i6ilMV9BjQn2x+f0RXXaOQjRiaKBfUs5UPZi9ep0c7TJHcQPKdKjrCMZL
	 qdCwvdM3LVckw==
Message-ID: <sashiko-outbox-181784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/27] dt-bindings: usb: rockchip: Add RK3572 DWC3
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:18 +0000
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
> Describe the PHP GRF register used to configure the DWC3 PIPE port before
> controller discovery.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D20

