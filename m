Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115588;
	b=ydkBQ98arQd3UDBfMuSZi+JX/yB4TmIwWBP6R2LRLUOaAjllAPuCgRrV+UdEt+cCcAxF
	 vweb5aekx7+WA1yfowVtBp2N51GtWedbenFKL2zH4e8J8Q88LMIf2nV8WeDG3W2xgOUFJ
	 2r72+8vetcWq+FYddTo8vjbMtB+mIxB9maeo3Rkk6rh1sPCdkao6sHK04yXVY6pSF+aJ2
	 uJTJZddZIe+b96umb98HksxbZ659+OA2aZcVl7vgC8N0goN01mCTAeUM5cPUtbejC1Xtf
	 Y1JX7kEKqe6GTM7nhJdhg6QkaloCfI5JTgQBoZts+0kQTcq1Y7/ZdnPz46lBudSolaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=icJUWVH9uBkIYvW2yt47UrBs+VV8ZyDfcQOCTS0da9E=;
	b=dSggfnHj8a6mgeQxurOcFOdFg+7kJpuB1XwoBXJ4odNcIhACxN3JZGN1iKoFibjbh9Bo
	 eqkIA7bSgYclvNGIyiwtQjg1sLMQXB14o/80BJFbfr84O6OBl5RAVgCXoIHhyCQaihelq
	 Vsx8B39XpSnQUY84Oqpwz2oqJYp34k66ibTn+4UVfv05TxgbfMT32vUhE6MwrYKxwgqTM
	 siL0YduRDQSw4ntC8QpFi12VQ1nOQNrvoQdppActQOs8FAc+ZQ+4POQ6WzFpt/V32O21o
	 D7IeARFcsQ0bZ3Ll5j0UgzqMXJyAaMjeMVPpuHIFbJgYMle/j7EnTLmjEkTorX0L7SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cU7wQpEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE30606B55B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cU7wQpEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A341F01825;
	Tue, 27 Oct 2026 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115587;
	bh=icJUWVH9uBkIYvW2yt47UrBs+VV8ZyDfcQOCTS0da9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cU7wQpEHdavUHd7ICBXyi1dG+bC+2uvCOYclM0Jx44I1F56mIw6wi2CEtusNT2YQj
	 Mb22TOxT9EvWnAUKvu5t7Zh4bPY9kRZHgRg6/Q3Q72pnngymRh3R7mg1zSMgVM6V7z
	 eNHWVrYhFK31REnGzPGIC+WHaGuXuX4Kdor1DvOanCvd1NruVrvGRpcmb2N+daS83M
	 Aixb0MKi0gc/lTxyOlZHeAg+uoYh2Iu0EA5s0DiIyJTW/GOyifQefIxWNZ97xEOFvG
	 TwwRsfo168SYlTtitySg4lUUdytLhTshHA57d3kiEe8SlVLPlK6/2cGnLsoLfjq1K7
	 vCfsCpdxbHM3g==
Message-ID: <sashiko-outbox-186852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/18] riscv: dts: zhihe: add A210 module memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-15-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-15-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:39:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the A210 module memory node with a default 4 GiB range for boot
> firmware to update with the detected capacity.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D15

