Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685579;
	b=wxiqyonGyJgPM024YfAJvKalT/FV9zfe5cwWsRdT9vX3zbmtopB0nyaVFG96r0Rdy8/G
	 m8NVjeFpT54gHnDHoaXoO0D3rMmZ6uFxOmqJrFbFJk4/L+U0rbVOCDy7w+wGoQ6wEVDGU
	 mL7F12esN+TCkG+npd/SsangOSwYXpxOKY/aAb8VDJj4kWwfe2ADskOsVhCPI6S+gHNlF
	 rShf/m2TKPMei8v/SUklARrpOFGQSbPQrVEOr09clh1ySYe8Pzjr4VbLydkpHyTqmZJvm
	 CGnME1+EOA3j98/mbIvO9D+6qvmbHjfIdAtVHttXfVchFsJ8O8BKr6KLItmIbfKAF6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1NCN1R4GWNINpurfZSWqTZidHmCOEW8Bfq6+p1kmj7g=;
	b=LkoNHkn3FGf+oUZnAXS+ZubH8bn6JeUHJzUHsqjSHkOIs/EhJUHLJFNAFb2r+KBV0iLk
	 lLNq8HOcwMI6wzVsHaTmpdsmGwV5ctzNwkJhK/ao+iD5TMi+cwVtAUHApbEmZ6QKeFQ40
	 eo1CJWMDy+6uBsQcgqZrN/I/8zdMg6T5ormhxaR5AgOeD3il+QUjAbiWYCTRS9M3usLeP
	 c9aDWiWV2FCFV2buon2Tov4XnZDriH13VZnFu3aryhuybDFsE/Zp5lmqp3W1YloKEP4ap
	 o88YuNYtkxeEtHDUliYNBBa+whpKebcFp+RyZcXmHmCNYuck7b7Wq0IcE0UXm6gyQ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTcuAYhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F44606A319;
	Thu, 22 Oct 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTcuAYhm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7501F01825;
	Thu, 22 Oct 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685578;
	bh=1NCN1R4GWNINpurfZSWqTZidHmCOEW8Bfq6+p1kmj7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTcuAYhmzflgz/MOtOlqrfGwc1od5ntLtxgrqLyRjXcK5rBa5Xxj0jHO+RwuQMbvP
	 3ccoyMB/puMehBpclzhn9qJyg+Ir+JAvbZpyU407Kb03Hnv1GgXDZZyF+ZJNvE8Y5G
	 8VuIVEaXZxHRcaiBxUTfryFCsxgv+IjDHPny+p33pnX/osURuzLbn6zIQOSXBeonYh
	 hdHdC0jwsXCMwcvgSiOXNHpxNOT4wdKNeXWRsRj5PcgBjsHWv5MWD780qgGEkJlvAC
	 QuYfu0GB6Jbh+US918BXPIiR0LAvgSKuLeiKxn3EMrAEtkDVuTNxQcSP4452zbRbvv
	 SaTjkAUIAoU4A==
Message-ID: <sashiko-outbox-181765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/27] dt-bindings: clock: rockchip: Add RK3572 CRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-1-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-1-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:12:57 +0000
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
> The CRU uses the PMU0 GRF for PLL status and the AUPLL reference mux.
> Describe the controller and define its clock and reset IDs.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D1

