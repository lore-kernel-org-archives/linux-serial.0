Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115550;
	b=dBSY57MYCU5LR83H6/J3Sap1oTZSSPj650fVTP4xElg9S0qLRh1faZYr1NBy/wDfhasq
	 VyM0Zuzz3q4lz8vitnrZDNA/FkPwngAtNA+IAN2nkp2qwYTr2oAZQMRTC3xBreu6kvvQm
	 xc/Qd9qo9fxVI19fB/o2vvGGOXkgkYbHNqJp0/bnu41yf1IKqSK+Dqmz1SXVh2ep5yMz4
	 6TSDX1z/StJQWMfH59gi97zTxLAIHPmMeWp/K4j+7xXEY7264E5AygSAefBc/oCxn3NT7
	 XCry3k9nSzDTX1vTuv9biZIPoE1WfR0sR5vQcUh+Pm9DHgnUtth3Ba8YA5KRH+XsK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115550;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eE6Sm3KsLalDgsuROdFQt4du14NFlRZl5d/Yj5hEdFE=;
	b=gt86VWikORzvkF+iI8q7YT3mzae2/64dGMsNti6iseWPU1Swy9LPeWK7aESyEZhZ2S4m
	 sRfBzU/QASy94K9i00XA5I4HalnkEiVzUYVPd7a7iHEx1MNMuYWZLvLtUqYsBRhzuD6sR
	 BE2BL8J+Bx1BoWj5NPIrORUUZbVJ2309XSfeMKbrI08UxY3KvGRTbsGvQvwGicheWxIx6
	 u/zin0vZPJK0to6rndPmW8E/hM9CitlrLw2g8P0ROveFX9N0yP6ii3GjTST3OX946qckx
	 Ht260ixXAaUyF+xUN8kCOUryvPn1u1zhyxHJGWVd6flIcBnMhoSHexlbDtUZSE8VLuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUOHItKj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F77606AA17
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUOHItKj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B801F01240;
	Tue, 27 Oct 2026 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115550;
	bh=eE6Sm3KsLalDgsuROdFQt4du14NFlRZl5d/Yj5hEdFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PUOHItKjT9NxNejXhA3JLiH6fhWEdWdDwAmIrsoL54Ws3rr33tQlD9sbEtb/YXq+c
	 7SqnOMZNFXd762rPSc57TxfDJky28Y6WBOOAnIg7BdTXpE9dJnITaqBl9eETHdFVDO
	 VJ6QCw2zGFgWbg1qYrLMMxxDsnow7fzzn5vDAatXqh3hwmX9vQ6xFCh5UnIOoAnlD7
	 H+fuU8O9IDh+xqMfrXQ8rMnHQeXHJEr/gpY/FjWSbVMegdTzyGCeZZlUUAsqrllflt
	 2JopDObYdy1PTxzpN++7KPwkG8eVN23RPamVIXP6ZjgXxCVt5mOlxxJNCBcJbVVeeu
	 1d3qJAk85VOXg==
Message-ID: <sashiko-outbox-186849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/18] dt-bindings: vendor-prefixes: add Zhihe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-2-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-2-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:39:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add the vendor prefix for Zhihe Computing.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D2

