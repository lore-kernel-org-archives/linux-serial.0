Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115566;
	b=BQXtz+SNqyJW2cKY84hgMht1EPMTp21fv1UN21YgXCJ/9h+2lWRK7YprbEhcn/R+eTFN
	 QNg6IVItw4i3DJAfYyY6S5une1W5sHi9y+0atdpEFeLXYigDivP04YyK1BSsUFJbsyYl9
	 EXccNKA1DFQ76OAOSnoUqBNMXDvVMSozOXdFvpO+/UfEUZqLVUMzvxHkhKUC2kExcp+Is
	 CDQcMpSwh3YuvIk4qvRO9SkdaU+7d8IgnnZAVQe3yMdvNym+JVZv2cJoM6Y9g/ZBko/Ux
	 5ZUtamgeUka5338HeU3ehoouOwM5rdsJUzw1banQX3q/v36JZABm/CuFfrshaNJarIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oUrI24n/BvBWnaDDa2DEQJuUfdxzsKq0uI58LeqqW38=;
	b=CMklDxREDY51ekD00O5VwYPwNouez6KCjUjeWxvMyTJ3xvNT5VQRvSNr1AjrH96Uhm6b
	 4t62iwY1QPAFTuL5ajWubdQoOXfQsl2J+ZW2Ek78LOOWhEfDp0iO+XYV0XD39EmOPq07A
	 8cVBnZuFPBsGl5tLrtvR8vGqta37fGCHex5yA5ABPlSfM9UiNLfPLuvKsmNcpgiAhfCFm
	 ljnPLkx6IADyDcZsevNgnZc+NEhsSEsYVCQ8DYRnI03evGOugCmT3wt0k00yMtivPMykP
	 Oukl50Dm72z2RREDGHjddTH0gtni4yLyZmsmKPDoASQsZRdmuWEydn0vUaBIFS3JilA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niDsycWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50D606A33A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niDsycWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0BD1F01825;
	Tue, 27 Oct 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115566;
	bh=oUrI24n/BvBWnaDDa2DEQJuUfdxzsKq0uI58LeqqW38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niDsycWSSNxx/7PluK/dLedIJcLLYj4qMBs9PDb+Uu8O/6C6eeHmps6CFBxqNvc53
	 GIqKjO9mJ6V0dnVpkeKV61Ks/t8mSArml1TJXg05noJbkICdqnJ/y14B8F3a/Xskjs
	 Kc+lkobE0fY1MLkPcrQo0IKUqENUbjtoE4JGA8+S2Prv1mxUNCXnk7YHME6RWXXbk+
	 8WN73aQSo5gj1oSmzuyNEN+l6/yX0OgzrbDtnuEE2Ei8SLXmo2yzTIaTyP/pmZ1R5P
	 PJbK5cqcHUWHTzvumsmCv0jloOHzwCUfbbcEv2gSqFcllwbw8M1/ZKRGLATf3LVjrN
	 jurjRmBD54RPA==
Message-ID: <sashiko-outbox-186850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/18] dt-bindings: timer: add Zhihe A210 CLINT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-10-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-10-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:39:25 +0000
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
> Add the A210 CLINT compatible with the thead,c900-clint fallback.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D10

