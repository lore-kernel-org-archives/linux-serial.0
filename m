Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964237E2F9
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444410; cv=none; b=BucmfuBIApXaVaB3DKQF/LGxOeUgVtMadQ0xHbh4iiMHtHrpHIETfOTHJZmSPh4Y7gT4HIoBm0oi5rn99p4kZ+06Qn78pv2zgMA8idYV0ab4riSqC2z+dLTZfzA8zM8ons5vM0T7QAUQF/1xrVzCA0iZkBGecwVSjV7GOsN6K7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444410; c=relaxed/simple;
	bh=XxsiVM2yW4k4T5TrmbuU0WZ2sA7XacbyurMQglabvu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3lDifx/Xzq+v2CdVc1nhxzsRfRpuqdThAan0eAKTPNhWSOk+9aqzsP0nd+bWUL3eyyeC6iN7Tsrw888lk8PoNGGBL2+GW10k1SCP4BbPJtDobn08a9TS90V9tZKpIHQIiJak+qUtYOZnZ0ZyoGHcWFosv8zQSR2n9GxUasiTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwKfiLS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwKfiLS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874231F000FF;
	Sat, 26 Sep 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444408;
	bh=XxsiVM2yW4k4T5TrmbuU0WZ2sA7XacbyurMQglabvu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwKfiLS5r9lHrwiO84YrwjE2HWQzxzXQtVbs4tb2Tj02CrfLbA3zzssZtEVPIxebe
	 tGtMs5AtBcMtFMX/xVW9k6vZ2y1laCFp+Zwqx22qy+bGVl50DGCoRYxhlXodgdVgZL
	 ZSz6KeRomGzDQrXIthAVX4Q+qbsSmyQ/eaSm1AEdUzMiKzFmf0pMbFMibga9JOveJK
	 WUM3dGJT+JcYqd5l3Uqm5WBK1C/t4RHR1TyE39UKto9eS+MBgKp4zZC4YATcQbiOlW
	 K+4FtTpO+BrRAKgc5DMzny4MJNT+yWfbuGdHl4byZr+bErKnpFgy94dfWJYxbIEKcU
	 eYzUrrZPbS0iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] rust: sync: lock: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: linux-serial@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260926173315.56772-6-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-6-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:40:08 +0000
Message-Id: <20260926174008.874231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard usage in the Rust locking implementation with
> DropGuard.
>=20
> The guard preserves the existing scope-exit cleanup behavior while using
> the DropGuard API from the Rust kernel memory module.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926173315.5677=
2-1-mohamed.osama189110@gmail.com?part=3D5

