Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704803;
	b=WfJh6KKekYnl4QjHwwu6KyLOFBVkKYxCslRMOV/lqz95p25bNF202nQ3fkf5n9IyfE+t
	 uHh12RJP99pQ7TeVYZ+IneoPkmzWGDmJyDBXSBWTWltavE8fe4BteuJDDEfhF67S9TUSc
	 Stg+AMYWFni7HSlrnHsDChRf8VIBF8IdFuChObXvb1py1FrCEOnpYx4zjVE+MppMFP4We
	 QawVuvlqLOz9m71bxxVAF2IChNdSavqBKDmVtbF7Bi0uZY5wS5hlMzStwa8K5KlM29zc0
	 4MGoPT7wREv4bDdPyEayGMRlg4MM0QDWMh70VmpcSHRH60rX+sSYj3HDsIaZP4MDM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h9EYk+LU+/T2yvOEXBPQ2dN6lcf2AAYOJZaXUb7o6lI=;
	b=QtJT4DgAHPY86dwgByDpey/57Pjc2ZSu2ZTp2Le9SBIadyD+Q9qlzOg6VwbZJjTMSVPg
	 yxggrpGlctIvWKjHPay5T1CsV7EdyigaH6d61vqL7xBaHr3YFPWfP52yrKFNv/kuUsx1p
	 B+uY70MPekUC7Ctr+y19YQUk+HdTHUTLJntqmCOmdsx5dHi4u51pXOtaGb+FfJwL7mayx
	 QcaP4EQwJ0NtNVIlCF1gt5Ryq8zlN/ieyjHmUnIBZayuJePltWnCDCz6vdmiFESqSonfI
	 EyNBrDQQiMi27v74sQrbOqMMcvpseXJMqxDv1r/WrZfNarbFktkK147JYOLKripeg2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKl5Uiu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615D606A339
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKl5Uiu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040781F000C1;
	Tue,  3 Nov 2026 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704803;
	bh=h9EYk+LU+/T2yvOEXBPQ2dN6lcf2AAYOJZaXUb7o6lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKl5Uiu6lQA6+tQVHchojXfS7/jIrJLsyL4w9N8V1sjcmNK7DI9xgTQgHjSRTbHtx
	 wDyc1Kg1Mqmca/mzfndXCl1ztSNI87ZmP5aMkc3ehtZi7UjypPy2f1QGF4vs2uMm5P
	 sZS/yHdi5yWeFOQ4fQDXz4KxvMGZruqR/DFwCyEdqtprwlowsn/LuN409XUMCVUauI
	 zJpPM/6ALSA35QxIQLFtamkwc4N+sstS/NoAYrCNeJS5pflMHTumWDz8uQRjQkpr12
	 cCl6GtFzN+BdHqkMEPNyk1mqU3EBPWwroNg+e7AdTa/Mr2s7ZTkwpoCy9X7TsYW+yE
	 OxJJCN9EEHxvA==
Message-ID: <sashiko-outbox-195138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_hp300: reorder HPDCA code
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <f4dbbb45248771baa130e56bcb0b1916cd909256.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
 <f4dbbb45248771baa130e56bcb0b1916cd909256.1793704520.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:20:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> To have less ifdefs (code is now under one) and no forward declarations.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793704520.gi=
t.jirislaby@kernel.org?part=3D2

