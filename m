Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685600;
	b=1lygkIk1KFZ0/xoEuNx7oy0BmFGR89ICDdziExkS+wgVSjbO+sVCW+XT5oWUw2e3Vqmy
	 5oP4VkJN8ql7RMU4Y86IpOxDLr8XTl2FHZtZQlDaC4Dta7KyVxgQ8mHGmym8ajL9nCsMz
	 ipyPuP6x3X7BZGPxqRwZD4LU4EyP+w+wQdgLpMb1vxk5VTVIcCt+09QUDeh+BO7nWcEwv
	 CCYmv/uSzyR53RKaJW+2bmrVXGabuhbxA8bZNXoe+O6O26gdxSd+Nmy0lq4LUETMu4zEs
	 JigabxcgDIdvs1jQU9MqsF7b+4iyILkAc4Py5U6DdY6tXgYRyMsn11r8TE1wZGi2FdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685600;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=83EKV/hJ4p0osy+EePw29t+G5WXg6CteVMFu1hQgkLQ=;
	b=3AjmHdY8ZfWVe10qbUMxIBA7jX4lwl91yvna9eXfV5MlI/x1sURgTT89TfYn1JdTWDyZ
	 OSPl+5D/CC766X9Q9DO01zB9B0d0bAp4CC9ZOx+0yqqxL7LgqQK7azgkZ/YBsJOcEkjQ+
	 8IhOp4+rutsYx9UlC/L2JVYzCnKimPvE4JcPVH2QvPxXSrZOHbKUuRo5Jf1SDKfgAC4nO
	 B3bLtBRVhqGC7GEy/KTGlk2L9m6qpyPRRlAKeI/iuyE5tCHUBS+a2zLyVSErfHd+soXUh
	 3Czv9JsG3C64/RVOSl1Jh8SdQdbesZ5qOJVIh6Ktt5NK50Vt2bsGnZSYC6zfnJ1ZEDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZTI2nVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510F60A260C;
	Thu, 22 Oct 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZTI2nVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9151F01825;
	Thu, 22 Oct 2026 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685600;
	bh=83EKV/hJ4p0osy+EePw29t+G5WXg6CteVMFu1hQgkLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZTI2nVuo7uFUwKFlPlz6ZpCoqm2TosU0kXLA0m7+YPt+LTDr9NdfCP3wrz/y1UNx
	 LyQgiVERZC86vzF9ILhnPYaAYG8rwXi3iPlCPXPZzHHq5nBSJO06Z7FW8pgNteP+j8
	 SFn4JU0TrJwdHQBp1CfbqPFSKW9Ku2d0oSahsUCKikhFTprmRORpjRWYE+8FJ5DGiY
	 MgmwbaG54Yu/KW2hVA7nbiswp5AhmmtwaqPAQVY7xhzMR8T7COnhrszh2uE3rMam+Y
	 llsi0dqn9iR4WeQPei2f5qkMHnAjvR0ozHsEl9KlUbtOo/h62ApruYOkDqAyCniMwp
	 9WU+ggQA/VKEQ==
Message-ID: <sashiko-outbox-181785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/27] phy: rockchip-inno-usb2: Add RK3572 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-21-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-21-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:19 +0000
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
> Support both RK3572 USB2 PHY instances.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D21

