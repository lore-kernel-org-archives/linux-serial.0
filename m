Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173845A285
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748898; cv=none; b=EmZc5V8Q9TJ9fa0+A7y7z6cnWaZaKrAecrJpXn4yMyPYYBvp1vJKlLCfphsV1UvFj/gy1FjPZu1SNW4QU0Hyg7hW7Wa0PgqHPU62Vt2w5hblENJJLphv5raNa+8Db/ohQ//u6htgVX4ZcKjRo7XdoTbD5unChYCWdw6V/zpNt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748898; c=relaxed/simple;
	bh=akzXxuhCVd0J5CulfWaqm/jHK9yHyBJFJCoxe8uMGDU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n9p5BF1uNYWbmKGe1ZCdH0fFolFbqPbXX4aQ6gM2Ix9cL4Zz88XEmUfsiuS1qGyzaKl6eBR6bB0cWxb8oExWhPkBcsten5D2c9KLO1AJ3iIVfEpZxE8G6/s1vSLltTt8NKd9aMRFohxFzsg1GPxGQGN3r1L7Ri7q5HOOE3eqqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPhKTq0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPhKTq0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18AC1F0089C;
	Sun, 11 Oct 2026 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748896;
	bh=akzXxuhCVd0J5CulfWaqm/jHK9yHyBJFJCoxe8uMGDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TPhKTq0OOapjJGmcBRN75m6ZLo3D4dDMtAtBj07u1AXtiWpxwqRJ2ZF1XgVA1up/9
	 +QG7iVHIrdqQA5AS23sz6tbWg5dsQTDY6vYR39V6eLEB+ZxmeyGMydOD668yy3F0Zg
	 FdYBFGMDCeE7BnIHc9PmneU9Rdllvs04SobMrsHSOz08rikAxho3pzk2NzaX5gdpWs
	 qIbt4L/51shwgc++BL0tpiSLa1iksssvprAK+u1f+naX8Q7R6QXmYzSzAmdYilOJVX
	 LwIpGyFASgPD1gcWo87E6WQm/tcEN2HOm27gU5HJqmECPg8ajQ1y8iDmQ4J9DRlrSq
	 8qvcj2cTMPF/g==
Message-ID: <sashiko-outbox-167437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] sparc64: return from the generic clear_page
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-2-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-2-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:01:36 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> GENclear_page falls through into generic_patch_pageops after clearing
> its page. The patcher then rewrites kernel text on each invocation.
> Return to the caller once the clear loop completes, as GENcopy_page does.
> This affects processors using the generic page-operation fallback.
>=20
> Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin=
/store-init support.")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D1

