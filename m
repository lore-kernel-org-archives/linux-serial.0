Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715846;
	b=S/3TjRrYLcH2YJGDLYcUM027vJ1laOGN0iiQuyzqzAWKdGI3av7tlK1VDRMgrhZ2loVS
	 Gg1IB/xcfrcMn9GPqk8b11ZWb6rDv/qk6jwUG9sW0cdocuJtpdsOgF9/viNoCbStHDkPK
	 EhRspLeN9Fv7ZvAtCIyTQIU5W/1U4o4wOXu5tWKtLbqgEvWB3bRW7bKKC+9IOzZTKCqJs
	 i8C0gEiigQdW5WLtLVE8zBuGC/Ig24UIQjE3cn+22JIgx8ibnmeNrc6XrzsQurv+GoyY9
	 EbQB6CLOiGJFlNvFsf7uEAvH29MKejbW4XV7UkzwdGN7TmGoNWBSp6QA93pPUgyzmmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqasZOYCK+IiZsnjn3Qxy8t0YF4qoVPpZmQOZfvDz3E=;
	b=Svj4FSlHaIAn5HBZcWfK8hr9h9FnJZrKicxHLiYKp0DsgJAMUxrnb6NvFCLh/njVBXcw
	 CA7HeM4Cu5JR8Qq3GnqgB1Zb3V32VL/J0y2d+UXPn8GAsn4cqHeKIOQGgaq3Wi5XmPvGu
	 P8Eol4yMFHc8OwLiwxa5B4jJmzLuy9GtHJooE9FGPLfakAVXQuBIgMuno1gmI5DEgNRzg
	 ooozHYGujVTC9iigjjBDnw2o+4VfdhE+fjQHZsr4NJqFAVUBDxR6hp3gHY21hf3O10lkh
	 xBV1RYkQ07KYHUpKC6+UVkoJDRE9H3Du9PLFaj1CB8hqRmsmoXuSb98CcDPZcdYDb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/c6Pg/T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB86606A32F
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/c6Pg/T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3A61F01829;
	Fri, 23 Oct 2026 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792715845;
	bh=yqasZOYCK+IiZsnjn3Qxy8t0YF4qoVPpZmQOZfvDz3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/c6Pg/Tn1PNbaK1ANLG9QG+RWY2jN5tRT6YuBoL4wZTCYLnS2st1im0bXF6UPI9d
	 XUQD2gRryA4keprc/0a2s8ZyLYmxzKLUNv6nzUzefHg17ad1cfDiseDYkOjFj9n3Jg
	 BzJFa5cchzSv5cBHxkCD1BhC1/DVWrMfANn/RAC69UOglWRlotvjrILFDKyC70olpP
	 z3aHIHow81dklwKk9kgEgsbzoklEWNYpG4VXaj6yoI7HFMeQcojOAVze4leOdPJcG3
	 zl1hKhvztDeDvtEN6cI+qdKV3Bdz49u5XpxbCVvrJekPdFqcTOGzEC1KZKmKY6cHKy
	 UmiKFkYNXvNHw==
Message-ID: <sashiko-outbox-182176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-1-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-1-088ea51e3891@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:37:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com?part=3D1

