Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704788;
	b=wpCeVIEju6DysuUi0rMhQVrunmGX0i0aZuToh24tsknE8ZzXsuGF+q5zECVhUoCkwrKE
	 4fZy8aLiZ3vo4W8EvqOYFSZvlQL2kmvSqC8rwZc9HTVLBeQAPNRr6zkhkWToD+p1TiUKL
	 jF9bkrsDlFuxAcIaA6/76JcJ/lfm5TRLU0CrwPqM5irlnkHKqXBJlXhQQxMKVyTWNF1Nd
	 zIitNrmtRWHEPe0NRPe8peGlt/eWttS2Nvf15+ZjCxtOJmkPzlunqMdxY/iqlcsBGxa5P
	 HsKbucGUcd+VYKssqr8VSBdVGX+Qvsq8wDPn7LfkXTfBr8osYQnj9WuyRwP2AhD2kmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OxEH7vnnVj8XgO6CL/VpO8mwQ8y+HI7hIPH947aUe/g=;
	b=oAix12TigbFtK6LqYGUJwesVrfPgqOQ5litCMFK8YtPm1YPQY9qVAmhGKRVSYiwLvUF4
	 IxCYow8pd3wnAAGDvAulxYU2ryEDh/XHXSYmoc1uTsWU4m9oI/XnYAuVyLEfKu7DW3EAk
	 a7y7G64eWwQmnUqdcv2Qh209ksxgJvod8vLv8FgvA2uYHecS2Ea00j12WQGIP7AsW1nmZ
	 dbHjHj0sJaImd5QHRShe/dSJlMAKBT2nvlKMpL9J5dXdwgOlImGK2pvKD2NXgPbP/ezSR
	 xXQ+NCtaQFIHG2mvyGEjIQvKCcCH2o9a79ttMDscAPsZPmlhqKN6HT+3o/hV1+/PqHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aR7MZv1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC6606A817
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aR7MZv1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495181F00A02;
	Tue,  3 Nov 2026 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704787;
	bh=OxEH7vnnVj8XgO6CL/VpO8mwQ8y+HI7hIPH947aUe/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aR7MZv1BLISz8If9xImGJpCWh93WMRC33ApaEhqMKanqaRBp/OAyRwbN5fajCq4As
	 qjNtiJUh3ogu/QIHIGbFqlNdt7YR5dNFdbJTxtwpQBZ9dwyI+70l522aKDU+14SM28
	 WBxfy/ht8UVAp1JWqMLRdThf21Bd5Ea8UczZGbtQ4sLDdn/syZIxOhQpkDnffEPDRL
	 r1n/p9ChKPvmknB4xCNOMThHAw/ccdisCYwyVdn77VNanVjOcLcW2SilFjYvoBs+pH
	 OvysfeLoiqe49p1/SgEKeQt8IIMUZf6jaXH60Oak8ZpDNG1z/Eo1nAqjLmSwNgxGCN
	 gjrO/zvlc1QXw==
Message-ID: <sashiko-outbox-195137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] tty: fix misapplied compat_ptr() in
 tty_compat_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <63e9d84a1e8e23852423206cf3f8907aafc88f17.1793704520.git.jirislaby@kernel.org>
References: <cover.1793704520.git.jirislaby@kernel.org>
 <63e9d84a1e8e23852423206cf3f8907aafc88f17.1793704520.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:19:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit f0193d3ea73b below, `cmd` was converted with compat_ptr(),
> while `arg` was passed to ld->ops->ioctl() unmodified. Fix it so `cmd`
> stays `cmd` and `arg` gets converted through compat_ptr() as intended.
>=20
> Notes:
> 2) compat_ptr() did nothing to `cmd`, provided it is uint,
> 1) compat_ptr() is no-op everywhere (was different on s390 before
>    8e0b986c59c6 ("s390: Remove compat support")),
> 3) `arg` might not have been chopped correctly until 8e0b986c59c6. But I
>    am not sure why noone noticed all those (7) years (from f0193d3ea73b
>    to 8e0b986c59c6)?
>=20
> Fixes: f0193d3ea73b ("change semantics of ldisc ->compat_ioctl()")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793704520.gi=
t.jirislaby@kernel.org?part=3D3

