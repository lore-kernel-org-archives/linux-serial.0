Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142480;
	b=fRfUL7U/EU9YFxh3HQyMzwZjL4f+H48H3WMDoKdW2oEyYstfzIESt7MyatBnP5kNpbzW
	 po6rH0h+OywdLiVeCCJJmW7/zWLG4CbBNObNJ39q+abtyMii7BAuYjq7YCyAjDFCKazR7
	 EkANpGsPRLMgm6hzz0AFPBND6FgW4ujQX8vz4IYJWcNfFoSWFQLgGzWILvwnTDRT/6BFc
	 8+uqaldNhb/N4pcw9jrticdKCttTYpleLH6cwe6Ew9mDPHtL6bH+QxtqjxuxcZJkEHHBF
	 kkoXTNQ36zEfHpSB2zbAss+NakjMOeVi5mYrX21kawFjOz3CK0oYScEZDZi16r68TaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sjwH3jzsL6EtY2UgzWITnBtwQGOl3dOucyDRPTiaEfw=;
	b=h1BN/04LVFDTJgKD4pCkCFNTijpySxLqgw9EEnegKqVP02xt4hxuQlrW/wJoAZ45mqAm
	 9ZMkaPqvxs/JaC3y8Ar1GI0Zjibuq4x6acB3aFJOqoEq4HsTCE8QpQm2ZNK0t5K68jfSp
	 GetSdPuOfM4hmogOAnPeuYnKgdK+CJYGdx/5hFq7TI0hc+j+j7yx6futYrWI9aFY+3iPw
	 VyerYS4WJX9di1u1AIDwEljufNmCaV3Dz0KV8vPKbZTH473LAk8R9uxuD4PVwqopD+pcO
	 qoR7+3sVbaobDffJY1E0v2ZIBH5bjQMSHAvV+sInkaUhmIERnV3rVOu93BkcH89SzFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNUYlKwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999D606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNUYlKwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029861F01828;
	Tue, 27 Oct 2026 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142479;
	bh=sjwH3jzsL6EtY2UgzWITnBtwQGOl3dOucyDRPTiaEfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNUYlKwZRHk5dYoTun4BoD3MguBrp6lgAK/VFcK2ods5doMZ+iFWRNeZu8bhpaN1O
	 93jdW9dAs6q6ETpXh5Ed7gZlJJ686BVzjhA3FY6wjugxyfoWoRe/R5IqWtPjJ4jG/k
	 EFBBtPF9Ia+enZPBIsrJoSdRM1K51v+v5srChTTQuFwOm450dihfAA+Tw/a1h8i0cc
	 KqmvHLjXQMv64lbPhiS0g7+3NPM5fMkDye5KU9N3o7wN1lmHsKKiKwoNrSWtna5y3W
	 wYahB3NhmPtg+ue5pxsyfUkPZANMdBhElTtYOeDmL2ktjelIjOUFLNzolHnGgiG8yp
	 Vi5lYpHxzCyWA==
Message-ID: <sashiko-outbox-187190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-3-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-3-d37e018fd0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:07:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-h61=
6-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com?part=3D3

