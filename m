Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297493;
	b=QXHSwcsifBxLfkUuRlJiqrmEqtOe1dDKTv84vH/W5Xc9gXOwaH+UElT/9Yv40GC+UI1p
	 aX1TmXZ3cRHWrk8N3/L5za1I+25pzyOz70lZ3CYzEczap2oGyiEu0rqmxpC9UGH/pAGI+
	 h30kf8XbE+gt5DfB65iRTXCuFS5gUzNMbUPm3Fwc4Bkkhob9xMminJ+V5rDX9ZxkXSBSo
	 crvIknqujSuT7SalWnVyva7Z2OC7oAuqV1Li7+xem0vZAp0k2T/szgkbBf/OWzhX1pIkI
	 qiX5jzyc2rD+02Pk0O7TAmzzOHDxj0ZHuimq7+5kKVHajPkyeyCokQqx69+/mE1rs2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=les8Y053Wskakgj1RXwcNWYlb5LrVeXzSrVI2thZxzo=;
	b=zFLiwATMJ0/idgijh1dFjz6zuKDSPuNJlxF5dD1TyObWMj73V57qcpseWPP0bIUoZpqb
	 O3MQC389IHAZNgtfT4KuQ/9Xb3URKZhSrFEZ7R7nIlZw1DEq630BIlfyPtjHsFG79kyRv
	 EAqT6IjQM71yhHdKkmakHhssQ+mo8jYlukZiBgyWGKoJE/VobkL3x9iOL+oqf+R+PsCJd
	 3CHaDZzTRjywyUu4ApPZKbUMowzLVks7RIz/NWLnkZNU7obGRRKXZGejAg18bBuw4uhwN
	 nrAKUqmzsRLBVWNdlQlmEvvufswmE8mtqzq/fnqyn4xH5R13vIF2Uy7BQ3Fz7kRtdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="laX/Lh4J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77007606A320
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laX/Lh4J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C31F000C4;
	Sat, 21 Nov 2026 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795297493;
	bh=les8Y053Wskakgj1RXwcNWYlb5LrVeXzSrVI2thZxzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laX/Lh4Jsr/6PK+x6WCaj+z62GdcxzRJ34Wo8awXF7uvNy5XwjVWzhg3Npke93dAg
	 CH7ZUL4t6CEpwkbD/3aZlgO0sE7DkhKTw/WgAw8kVTsbHL2u4QbTNYhDA3G0CUdsIr
	 aEu2CIsukW2zc0JBGsoiFCMjL7mcTYg/YszaPJVPukC9NcV1ah5ODhafmfJqLT/Mfp
	 xotXodTh9o3Vj+4f0AtxOe9fSGX9VNcAP4xp7D4JZp6fk24shEwqSDrVNDORfwNrBk
	 9FTysrsQTZehVhly+mf2/alhxZPJ2T/vaTcWJvWKeWtLjGySL70IoCA158QwvtEotF
	 6OxlYw+CquTJQ==
Message-ID: <sashiko-outbox-227421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 00/10] ARM: Add support for Cortina Systems CS75xx
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:44:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 10-patch series:

- Patches 1-9: no issues found.
- Patch 10: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-cs75xx-=
v9-0-1fc1b90bd097@gmail.com
