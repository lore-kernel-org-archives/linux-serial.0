Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879987;
	b=3I+Qg9pOgZT5PpjZcZPLpOIzEU7Ve22KsvN4stUAanKQKeKSdUVSAeOoBHo727yNoOZY
	 7BiZm2OCvJoP8LLBwkNijDZwVr0p5zjGt2tJYLJQTcFzifUostPFeqvcquzsQu0CTyEPo
	 Q7U6epwPHIhhfj/7yfXSDcWR3iwuazB6VRxeCgQFhGqM+ciOnlIowedEHY5+z3qwEh9Fx
	 u6nNSuh5C28+rOj/eU6OJnZAZ5tmAoco93zWq0K2pWBBMMjird7DL5qZnEolsWpNYDqf0
	 e75kgLd0x2pud9Fj1+LcxDT76DytzWNzaYf0paexQ8H7TUG9zuhOMPK3C8Bl6jphaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QCtqAVQQybseL0WdCVRTz3/hLN9X+ag7DkmL1EmVMUM=;
	b=EjvflPY4ArXevaDiIvQPKRxwiizxIS4rtSlc3ZTmC0T6CrIFVlHi+h27EqWwUcQbdOeA
	 yxxZcETECB2ls+awHlY2oaR5e7iHOyy+VNSghy+Fr2ecIjj9BBuQIYD6vbmBpLVxQ+3dE
	 bgI53rNEZLx2w9UNx7Ztp8ugg909LSKmdcTM2EoMOsWcUpBC7QLUtllceD7ThNBs+K/8V
	 Lzg9OJAe/X1sQwz3rGyACvihmIT92j9k0i9rbGgYER5vs5SJbWt35juP0V54HXSga0rKm
	 x/+KxUIte+r0e5t7bRKS6ZnmAwGU3GKOpRLxzV32yt+xObKUESx8QjfOIT6YqsfoqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOhaCFGk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18C606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOhaCFGk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959E21F01825;
	Sat, 24 Oct 2026 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792879986;
	bh=QCtqAVQQybseL0WdCVRTz3/hLN9X+ag7DkmL1EmVMUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOhaCFGkLFLcJacnuoXnVtNpP+yJFSU+L7wrQSvru6d4NSqXOtUfW+v9wYrjzfoEP
	 v+w4cldNJtkA4hdS4VKXzM+BMzZgoK07um9W9h2LQ28woSxpDjMU8cmQJgooh0Opgn
	 HdhW1jCbpkNLLc9/laOMdX8+3Mx5D4aEkPyo3kWRuYeIfxQrHRblV0WYK9MfNjVxkI
	 ArTTPZHYgGf6CFesQY4K9My1nYoO7SBjRTivMNpY3f9ntMju2QPpd4d/E+tpyNy4CG
	 b0b1m5nntSzigZbzl2T8FeGxoSMEZ+LqMSO7x/2Z1oGRqHyWMYj92xG6cqCQnde6Gb
	 zVeexqFJkO0wg==
Message-ID: <sashiko-outbox-183920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: ingenic: Add the X1600
Reply-To: sashiko-reviews@lists.linux.dev
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024220712.23250-2-olivier@mgcrea.io>
References: <20261024220712.23250-1-olivier@mgcrea.io>
 <20261024220712.23250-2-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 22:13:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The X1600's UARTs have the X1000's registers. Add ingenic,x1600-uart,
> with the X1000's as fallback.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024220712.2325=
0-1-olivier@mgcrea.io?part=3D1

