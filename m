Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762662;
	b=WTi/GBbt1oXvzGMQeBs2uNr55oG6rTT8d1+DDphDA+CpsHZ/+kdMctuzMCxmAMQvSHJA
	 /x0cSEPqOdOBKm859lbmotxqguLbDZx1PxMdVBsKRbEDahmcUW7g6xmx8JmEnssZdwhTz
	 /PQgZVib310jlXchvBdLjk0CEbw7wHdtr/HS60Mz/EPyVn1QVfS6LLU6TPE9XqiawJsmt
	 yO3qUCeK7PEfxTv0NR0rxYg6OnoSfXWF9R28tTAYl947JyNUfLBHYBx7P3GKxHJNnyxAq
	 WV7IFRqLO9vgMYLiY79DOKVBe2cdaxCn8KwEgtJKpnBPmLSMoqKm+P4NWm1W5N26jOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ADEl7//kIc7+wsij6ozUr4Uy40SE+e68KHezhrCM3LM=;
	b=xBskUSaztWEC1Y1xuS+k589RpJLYFIp6caKrn09lD2sgIgMJApL1BruTz+6o0nnB9OUS
	 xrFEm+18QlvE9xLz8pbX3f+6S3eOBRNpJmNVvAHGZu0pDiOtdlBFz1/xk4Wcspz8dzroB
	 2xlrLlyqnKUhBWGJCnUlOsCONBJPJNOdCLF/BYYgQ2N9zU2cs2p+E6mPH7fdRyR40DbN9
	 QxYnTTm9ewoE4OC23/ShdWDdXgTCr1J0G0wT9l6SxtDwZjg2yYnbUodfL/htSlg0eruaC
	 UUcyB/04bhA5HSAuAyd7rD7Nk/kxH++TMgAxU6o+yS92bFmvbdlM2NKlpl4FsOJHYsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxmjPNsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C1606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxmjPNsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB6B1F01825;
	Fri, 23 Oct 2026 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762661;
	bh=ADEl7//kIc7+wsij6ozUr4Uy40SE+e68KHezhrCM3LM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxmjPNsnhNtPBUT6kYVUOPe0vp4U4XJL/dhBFZfY25BjRBeYaYyP3GA0t9fp0CVf8
	 s0DCdvv7MJ3tlTOUmityzN5GGDSVvF7/BUowbTDCmvKy47JAABb1c59F3HpcDvCbfn
	 SVPltkF4wJHi7/WOa2U8llbx8b7fCjuLshB9f6vadVrgvtC7uJbLzf8eIBqRkjSI8q
	 yOa2eaFaV4mATpx/KhbDqGRqPtpdII/ntM8qnwH97BI69juipCNlt9lmCLRjZry50Y
	 sSIJ1RDJfFYVtEVodo59Jelk63fjmSOSdS7RkRAgDWDOwUl/oBYmrQGTBayY0e6GoQ
	 EYxcq/elNbsaA==
Message-ID: <sashiko-outbox-182831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] dummycon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-3-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:37:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Implement con_unblank from struct consw as a duplicate of con_blank.
> As dummycon does not do anything, the implementation only returns
> true or false to trigger a redraw (or not).
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D2

