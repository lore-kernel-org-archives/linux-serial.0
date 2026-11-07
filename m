Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054273;
	b=kV1BiV1jAYC5esuvbYj7Cr9OtwUET4fqS9TBLeJVI8+LxiAQ1eT/yF24gtXCQkiTqX0k
	 vz5YzaI5ZHynC8/dWLNzSfWxWXW9uAzSnLeukX10xBCvJm2tpgqQkcPy91fSJVXj9UbyH
	 aPCe4BSqYU3iYHSFXBs4BXUdK1Hz7uHhHs51ZgdpXz52/whD7Z6+MoDgUaJvdjEY0+97U
	 S/EUoPi94PYaZYVwDWAeQA8DU61JMeDu+IhsXj04+veCfHRo6cN07t2R/irg3rO08ef3l
	 riU5gUzKu2LTBsi+x+vcGwvk1CXLYP4gAIxUr844+ArdVU97Tx4sCkJk03UrlKCRfVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fIy66eTyDVXXS/pGjK5xRwlbo9721I5FOyaKJ+2mPmU=;
	b=YEoPUr573JTzWdlYkqj65xYYXa2XR81OYy4CPJhEwZJACGW0sOwh7M1f/ytDQUczqGRm
	 WWk9sw9/Jk6uPh5E71KB8giT8iJRFMF+BhRwMjV4ZHZsCr3QOpG26SVIDiephxrbS+KBR
	 KMi+IwlCR4y5F3AX/i5vYIx+gitJyk0cey9BsENdu3FJ2C5/BVYCE23exihQP1IlJBVH4
	 FGHOUeL9gv8ADQw3hJZtMVXnyrOlIU4Me6nu6PsbCSgcS0UpAzPBnR6IwgEkI4ByfKhgy
	 irNEkaStJjUpJrR9DTAAOnZLW+UsAXpJZrM6CRg/a68ENc1BSbFZ7ENpoyCdWCeNzUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILaZdqih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9884606A32C
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILaZdqih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF811F0089F;
	Sat,  7 Nov 2026 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054272;
	bh=fIy66eTyDVXXS/pGjK5xRwlbo9721I5FOyaKJ+2mPmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILaZdqih1H/WxZmLz+deBXK3Nvf1o16UFGakz++XXC2KB+S54u+0pEsUk49CW+d3X
	 s0DmUYkRFSHXdtwb0yO7QAPEm0FKVVLEQFqx9TRoLkO//I7AX9J+iC4UZQPPsGFfzS
	 RaxwGr9ltCbF3QNqKGCW+eeqzSbVSjQb6WkbDNgVcwULVqrS1cYiOmxdhOLCJ+vVwa
	 AZ7SBWZwYbU6T0QhzSy35kR14Z9N1sAxG/gIfiGfXjaS2oO6bnB32BZ2CLSCdcHKKW
	 JGCYmVGMCnfysptqLfDkk/p/iP5Vx1R8OwAhoviVxGOp77rQ8F34C4NfJft9sNuK4K
	 CQ13fWPWzrymA==
Message-ID: <sashiko-outbox-202889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: serial: mediatek,uart: Add MT6833
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261107-mt6833-base-v1-3-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-3-bda21083e9f3@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:24:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700). Its UARTs are MT6577-compatible:
> MediaTek's MT6833 device tree gives them "mediatek,mt6577-uart" alone.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-mt6833-bas=
e-v1-0-bda21083e9f3@udp0.com?part=3D3

