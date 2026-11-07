Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054276;
	b=trikCHSWSG+FcKN6yyZ7+Lt/4y+YB7GL0gQay9EeF35iVVnOR5gREeA28iu4Q5n5E84X
	 SJ6hK4djg8YVqdjv07wZtP/e0CaGpJsawcOkAsH3Ihik0QwNSCsl9mlgr6QpyxN2sWjLU
	 31kjmkoHHBlNy7vd6jJYAZmHQQNnV7Bs3Tv5Rv6LRMuaEpX3Wz5U0HWUzg2QKt6Z9KhoU
	 Y0uydGYkP2cQOgFgy9xWx5ajzheEsGJ+ejdUTjQ4AwJ5Ux+pyRviL1i/6+y8Rw8ePHZd3
	 nxGzM7lqq3I8bF1SNMYWaXApWabHN8OWKyDB5mNx1DpjilIYUrvgqR28CxeB2H/48JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=acIs7afIze9jSO2Przy2PNrsulFs1CEsQjf9qI8+Hv0=;
	b=MGw8pCN20Wbabh5eM7KIHWmfTJstt2X6xR5EU7HsyYMs6fJK1uhFHyL0q4M9nLj/mYLK
	 wnkskBiAGG8TDrG4+Tq0G4d2t5BGjFBhgjTtgpgl5ZwfrluFzFyCZFAAuz+ZGrMgTgjFg
	 32WZEEzewCvIMHDUsV7vGVg6crn1UJnzPP7NTkqhwi0bkfS1LNsDMZpTaCWXreCUXOv6f
	 snFyKfN9bbgSRypxDWPQrbWhlrxy9gUPkG8KdHoN7Kec1MpUwOQIC0K7GYqeXByvPxlee
	 Y8WinJ8oXjjU9CpstOtG71erpAB4ybl3MtS/WyVR3yMKQ6LH3ac9Av3kPAfXnLg3AHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOBQry6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A2606A326
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOBQry6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BEA1F008A3;
	Sat,  7 Nov 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054276;
	bh=acIs7afIze9jSO2Przy2PNrsulFs1CEsQjf9qI8+Hv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOBQry6qBfKjmBZpYEKf4pUqOdmv8ciGSafHzYrCW5eWGjzDoVv5AwHZnxf2Ay8Fk
	 uO5LSLkdp2cZAB3KyNWYjkwPgaSUy+fXrVBGCeXxzbjFAwWg8phymdCy5yWYXuq/4o
	 Nq7nW1rtmfP0YhZDss3SKM+PuQBgJKyfNe1b3yHXdOLUBFpq6tc+VyUJ9iuxAyAo1M
	 tlvy24y0bzd9/bLmC4h7/vGMA6TvV+qtsvrGcqFNGqQkBoANuWLwT88TGTvLnUfGly
	 77t77/d7yFaJjphCEn8+ZLSqNj9veC1mf5K6quO3SVyvkHE/JQ930n+bFKpMRQHePK
	 VurxqQKbTiZ5w==
Message-ID: <sashiko-outbox-202891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: mediatek: Add MT6833 and the
 Xiaomi Redmi Note 13 5G
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:24:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700) and the Xiaomi Redmi Note 13 5G,
> codenamed gold, which is built on it.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-mt6833-bas=
e-v1-0-bda21083e9f3@udp0.com?part=3D1

