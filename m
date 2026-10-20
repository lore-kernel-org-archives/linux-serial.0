Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522658;
	b=bCNICr5XFB2Df5L4ngnVcH8pNv0SZKp23KDNOore2s36pW7aHyW+CY63A9V8BWatYM6o
	 6E7L3k78jKFwwe6ZzRfbSIhLPWHwE89UCLkk3iR8nJKSidkHnP9tZAxA36d7kn/WLtDyv
	 nig9EY38EMv1fTtH4Trgkb8hpcbo7adLnzw/qTFyk9GBkizDeTdtHNu4ygoEyJyw/stjF
	 S5hGMOJ8vQkDUz4dHJb0LDtHe05hsRsHz8/0wf5EN+yiQ8X+GNVWeA3Y+Pzzm8Agg2fII
	 N68ft1oNeM1Z5nxrQ3NDJj0zQOutD4VdFnL8Quev1ng+T5hQGBGIFJ5FonlPto49mtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CWoA637OTPEEEvxb3cnKVUbsuLBYN3sRZL9av8NLHp8=;
	b=T9cDHzVZ7ClUnQcroxY/dh1G6Ai5CnEJYg2ScRIajLLP5vTkLVRVIa8wsVemGL+PXKMj
	 oNhdrc8L25kSazCFlBJCOLv/SBLNWJMgcqns3+w06IjyUU47YTokQ8eJjRCBJF8bmZapz
	 I6UuJX1yjuYLFd9yLCUX8UhMgyxvxfImyO/u325/nkkw3BwErc0uL6owx26bTVFrItDuU
	 evZl854DH5e1epY5HL0uOjuI5LaSai2pHtEfRS4pHnlfbl+2UorfI41ieg8tJfJngLvwP
	 aEb22YkCtnrArVrynfQkOVUqoAsuCdxNVkBSM48TlQjCOwS/6g1BOkQiGWBLgQP5fXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtTsj0yV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01D606A31A
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtTsj0yV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656251F000C9;
	Tue, 20 Oct 2026 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522657;
	bh=CWoA637OTPEEEvxb3cnKVUbsuLBYN3sRZL9av8NLHp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtTsj0yV5xGsQpwkdgJ2wmDrL1plcfQW+vh+lYHtkqD+8LoGxdFhoV9w9L19PXCYf
	 DD/rfqE17BUCZEHvIZ4JcZJGfTuoP1tP20R3up49zsMHlO4WeIzuz6/Ds5OJUSg5gE
	 dkYDf9g2VCk2EiYX0mBY29iDzazCIddTIMlTViU6Hcm6IvW2wcM5W0eiAgeGQsQx/G
	 gV7LOGyrluCfzGseZ77Ozwf3v5w6NLV1ncPT/4/1sanmgCBBtuYxjf94eAT7RuKw4u
	 COzK0apZC/T3oFxcm1izqGvnunVR48u6Sj2SZxT5KFT1UTLH3BPVEhktqXFZZKELc5
	 no69r6wbIq1ZQ==
Message-ID: <sashiko-outbox-179500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] serial: core: always return in-range baud rate even
 in case of failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261020184131.2893575-4-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
 <20261020184131.2893575-4-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:57:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Returning a zero baud rate from uart_get_baud_rate() can trigger a divisi=
on
> by zero fault. To prevent this, always make sure to return non-zero baud
> rate if the loop exits without a valid baud rate.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020184131.2893=
575-1-hugo@hugovil.com?part=3D3

