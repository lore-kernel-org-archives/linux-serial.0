Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018E388E60
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991237; cv=none; b=ncTeayC9CIwBEdpZZZmAmuiTNcmvxRL8LAgN52OdDbpUpXO8qgBEAmsMIW00ZTzuDE6Pc+oW/bRtYwGNwsDRv8P2y7I9zAQxeDM8MQdUvDPNQwQ3rJtIjvvkxZ93gdlXXoJmjxsOFVyOLx9/Lh3DGXYUhEHLCWA9qRJsa8RUhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991237; c=relaxed/simple;
	bh=ivLjYrH4rMM0C8lMq6R6WzIjnLeRJaI7ZZu2dWC05vg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OoJD2GTmvUndaSAKaLMlqOJquqcWtUtIn8ddqofB6w9WcxvPz2D2rwyIBgEAjLCOt6iZaPbQY5HjN6Wq1/m1gJsEvzXgrHfpz4V8qucfp7LM/ZZ/cMD3g1il4nVGvOl8Sp58/QNWfkcZ4AvcV7zTwWfB1xuoD5yDQheuMACnFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo13yR6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo13yR6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381CC1F00899;
	Sat,  3 Oct 2026 01:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991236;
	bh=ivLjYrH4rMM0C8lMq6R6WzIjnLeRJaI7ZZu2dWC05vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bo13yR6LLWm3QsfxK/9cO3pOpZL3UoTeXUPiLEd74saNj3Lwr5AdCq9ZIS5CernrB
	 jnS5qlzsGwY6HHlGxYUE6Jmg6DMjNJ3A7FTNEIl68Oe2bxsys+6AJoFurDjyNHXSd1
	 XCF2SBEGQgd4Hy/fLV1rRd5V2t3X8sqeKI/wGOVPMZ5MErOyiPB1TfhrNipZ5gFOI5
	 f1TqMu9vG25vfKL6W5yciwg9HOcwAcqhR4mpEoZ1Q9eEUKPrEdipviadvisSN9+EMj
	 yUBJw1501xNb0yOikW8ErB0iMzIbUC73xS7lzPxPKJ6bQGH8hOa2HKxXREr9fWJgUT
	 qARSMrMW5TkDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: pty: preserve open slaves after rejected locked
 open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akira Patafio" <kokokoala4211@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261002202455.25324-1-kokokoala4211@gmail.com>
References: <20261001165552.2439-1-kokokoala4211@gmail.com>
 <20261002202455.25324-1-kokokoala4211@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:55 +0000
Message-Id: <20261003013356.381CC1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Opening a locked PTY slave fails with EIO, but the failure path sets
> TTY_IO_ERROR on the shared slave tty. Previously opened slave files then
> fail I/O even though their master is still open.
>=20
> tty_open() releases a file after the slave open callback fails. Merely
> skipping TTY_IO_ERROR on the rejected open is insufficient: pty_close()
> can mistake the failed file for the last slave and close the master.
> Counting tty references is also insufficient because a real last close
> can race the failed open and its release.
>=20
> Track which slave files opened successfully. Ignore failed files during
> close, and mark the master peer closed only when the last successful
> slave file closes. In-kernel callers may pass NULL instead of a file;
> retain the count-based close behavior for those callers. A selftest
> checks locked opens with zero, one, and two existing slave files, plus
> ordinary last-slave close behavior.
>=20
> Fixes: 699390354da6 ("pty: Ignore slave pty close() if never successfully=
 opened")
> Assisted-by: LLM
> Signed-off-by: Akira Patafio <kokokoala4211@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002202455.2532=
4-1-kokokoala4211@gmail.com?part=3D1

