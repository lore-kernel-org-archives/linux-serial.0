Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02D32E121
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586963; cv=none; b=ujVS4SJWP1V2aSLXBmDCFuUZMnVdXfQ4oGAaoY1MWJ8lbrr+xwmfcNPtpl1yLXZnLgwrzInTdCq94kdaI00mNzFNrM4KVVY1zKORXKINSzwcEuUFHSm3VzLmZGx6kbbRWKLiUtEoDNAsrcC35hoT3bl1RWUlOdZgx40eL2EsMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586963; c=relaxed/simple;
	bh=rnIk87VMHpiqbOwxetxCmMRk3S+iSynMmUNSvpU/uLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dji82kHlU/IUOCyLuTNjN5NO3saPb7F7b6Xk9cTRbXdDRXYqdgJeS8RI5I1OCrnOsWaHraM3nRnMzsuTOKu2CeGc0Jrw4iJrjptsvJf7mvpYV/0adz2Cb0no86d6tHy4KgZPfJ2t+dMyVjFdggbsWPYLiqd7dRXYyrVxBaavAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSXQCfo3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSXQCfo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD81F000FF;
	Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586961;
	bh=rnIk87VMHpiqbOwxetxCmMRk3S+iSynMmUNSvpU/uLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSXQCfo3KD2kmiQnGro8Ittn2TIfPeNsMGvNIFQhtdz+5gQOD7LmLMUPEqS+4nO08
	 liD7s5UjqpQpD29KKB3ZoNxt0GGFI2vlBKp1qb10LP/VRfqMh9Cp1krKxrHsCRotcH
	 wDMoQTeqYajAxGQsynTu/spmWLRhWk03z1cQx3cuIW1+1rJ3qRiBwoCyqyudLHoCNf
	 86EvMWM3HD+wLuGhLqhBSIP4IgJ/5SJRz/CuFtFJh/pd7PTJ2twQV2Fa9fL1YeC7sK
	 YyLTXvg1m1sA914fZvwV+ADXOe4vucDmMyKCzX9hbewMJ7yg0+4a02p3qqosPNb1Rx
	 XIiW2LXe4Nr2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] lib/fonts: Add font_glyph_cursor() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928085724.41660-5-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:16:00 +0000
Message-Id: <20260928091601.67FD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
> As with the font_glyph_rotate_*() helpers, the caller has to provide the
> output memory.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D4

