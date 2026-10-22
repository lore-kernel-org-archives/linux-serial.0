Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685584;
	b=uw8KbrCcDxAd4ga+2MlAWAKcIKE330Hb+ODwCD5DZuW7v3JsUxlyWHGergyJ5TwoixMF
	 2rUfLCMgJn2PnDiVKBk8EXxeJPLrfMJJclJ+8HsuA847BB+QaS9a/bIYrgvdh2hR9rkh5
	 c3GP7gwCp1hS6l4ZbXxraPKQl93vwFCyMUawEPG3nk/ySFKKO7YsGcq65xIgjU19eEvrb
	 A+uSUBviIO8Jv+J5FU760Id95oCtK/wLKwdaEh0cdD9UZT45w4c8y121eOhoq3npA8hDe
	 swMKGk9CIZKl8son2/qxtwZnOPPk5NXd5pDDiZzav6KDKo9JA/cQJPSWrrDF72nCOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o2pzhiYpfOiDXRrvdH109eS/abs+aKrkY1HcbzWhDKQ=;
	b=5Ql6JBLlO/Srm3/3YIxGEhOjIRGPJqGUD6BXijLBko2Q4SgQUonUNZU/Al92Rc0FAlOD
	 n2426V9s+eyACreJPCKQkwFcmvfqxazwHN6Hrb47P8F/Jik1R0EmnVXm4JP/GYwB3T0vi
	 RJOkl22eiMiu6K6hqsPVi42aUrYABV7D09yerIRnXG9qv1qVPqs8t1HeZtVP+H3maRiiv
	 BuAltAPQ5tSekLd5EAN6SwtECmnnG+y+qmGCKMxKsIeYv8qbB61Hh3PZGVT+JCEKBPDFz
	 R9IlINGBAzcrLDCWmMByTWNwWxxT4jwP8jhKq9K3mEK/JcrZG7oa4C+RPiJ2nfwlg7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgRk9HrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C37606A326;
	Thu, 22 Oct 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgRk9HrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92B1F01829;
	Thu, 22 Oct 2026 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685583;
	bh=o2pzhiYpfOiDXRrvdH109eS/abs+aKrkY1HcbzWhDKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgRk9HrAmGNtftuyEksH+NNDsIaHVaIp0kPTfur5NoM05Tu2jhEK3Lj2PFxP9cfRl
	 rg0Ry46ImWAXMTUnz1Pqb1mz3hgNrnXKrT2V0JNEBwfxeWJD94UgECFDrDJosM3jvO
	 E0/i+TZV+DSNIqokpVznIXBuMoMuKvbYQlfbr48za4xIJzP2aKZVeAQ8664C2sdy9s
	 AHLqMIa1NpEZN+wbCHA65dKarc5dYE1nG8hGqMq2WEtaHKvLh9k0/meknaTBXtudND
	 Rps4oUnTAimWMRINuhLz39Gs8VuuzbPawGVatx5lLrgJvWYk1zjS9P0AHcG5CQFIj6
	 0hAmt5CGYYS9g==
Message-ID: <sashiko-outbox-181770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/27] dt-bindings: gpio: rockchip: Add RK3572 GPIO
 banks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:02 +0000
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
> RK3572 GPIO banks have four parent interrupts and a separate debounce
> clock.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D6

