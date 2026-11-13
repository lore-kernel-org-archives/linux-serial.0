Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597139;
	b=j1uUeTScEdTLklO8VMrhE+jYOhhTVEANSJgeswTwdRdeXZFtQlYf6TNXq8mgx7/+q01G
	 k2DmVuiT9jBZzVNiMYOv4oQQQg/Lh+6I0GyAToTUXDVJKi/gq6BBUhwL4V9j10V/WE02s
	 Ep7I7dhlswje6nefay+kyLfJc+YtAki/2igPxtD5w8tspiCDeRYdV1vpocnzXsBxmmXIR
	 t9iu106ro5sGmqZK8tqTXwgXXGYFPAfkIcFPsvQsFJH9WTMt0iDecnxyc1XmJt6c+kVnJ
	 EGtxikd/NYc6AxRklu8AJ3HTdl0eVoalYceJMmmQ5YjGrR4PFQ080Ak/Q1OmZPuAJbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bzVhFLU2bAt9SEn2yMhdR9RVfjxWZRdxZ7rL6fNatQ8=;
	b=jegf8pkMU+AccUjFjfUPvexqu7HnGxsjRiQC11SYkCzN5gbfbHRdAE5ADGYgpQQ9fj6R
	 YQy0fU10LRlgkkSlKJVnbmfa3qCTmoekvCEVzcyvXJDq14dMAfSypDyXyMxS8aXXPvAE3
	 moFQ7eveOfxXou4pHIaUq2gyLZFOIavIdLE2wjnh91AhGvCplNBG+dWjq/6JIdoYaauts
	 veY30CrJL2XoI8XmmjHeLhtR/hLe1fuFbHUgvVQHeTXReWTjteDDqZItcUtm340OD3zV/
	 7neBDvyA2VJJ1ESVcSoeQdB5DU32VBEAysXK59sNJpKeX50htClG9nXC8yWsmk1EhZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mg3QexFo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6F606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mg3QexFo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7AE1F000C4;
	Fri, 13 Nov 2026 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597139;
	bh=bzVhFLU2bAt9SEn2yMhdR9RVfjxWZRdxZ7rL6fNatQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mg3QexFoPTb6rqU47UowPYBDLw3SLtIfUZ/8Cf13/tpn/3/ZzGFbQ7sdZAzAFHav6
	 ChXSplfrvICpmCgyK6jsPPOOYiIGVR3gx4Ze8rohN8N91i6N+7TmSYJ8O7jraRPETf
	 XkFblFeFygCBxMcmSP6osBc19+PCK23HgxkgD37wp55JAYqhB0MsheH0cHheaIQZk3
	 /QXHArtXMF1xqJyWjsiHXL+GQoSYr5rnTpoXZ4URz4E72PvQtwDAev38CkQst8fxzz
	 l6fWezwrtrARQeq4AcVOywtbIeErsCI1zf7l5o0B2eaU5r+yxY6f7T0cfAJG7KHJac
	 z5P5scafHjliw==
Message-ID: <sashiko-outbox-213521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add
 compatible for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:12:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a compatible string for the system timer (SYST) of the MediaTek
> MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
> through the mediatek,mt6765-timer fallback.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D5

