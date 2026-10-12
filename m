Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC833B0585
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831440; cv=none; b=qP/yTow2vidTNmZA2SeeMAjcAgAqwMiAi+hICnPdX7xaYZNeeHxSo8BjoUp1Za7sXIaktlYfCbHTURRX5KBc0pzmrntmA0qRuEg2sLGqMJ9PDlV+FendHsI5Tvx/fumU+KqAt2x8SkNLFZXnuEDJ9pPGnTwvFV1n/SKXnbT32RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831440; c=relaxed/simple;
	bh=pFA7Mrm+FsGNZ2Tk7Cvm7uV296KpQeTVl5uxl7KVijQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OBJv4xygWQniHhnmCRK9RSpdKDqRudziK4EQ7faf6BjR8+QATmEWnYprfNGs3fucJmYlLF0tIYGx+4OiWAqDZzlo+5+Dm9RaczBf3Zqm/9q+t00/3tZeyetkO0TMTtEMhqqUGGV+gUCKq2OOmMEGLz/Rung09EGZcKWS/eRcZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpHsaIjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpHsaIjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08BC1F0089B;
	Mon, 12 Oct 2026 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831438;
	bh=pFA7Mrm+FsGNZ2Tk7Cvm7uV296KpQeTVl5uxl7KVijQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpHsaIjfd4/4/3vXj2ohMyIwrLh1VTneK5eHZI0eI+sN4Q6zl0EDX5fvDD940gO5k
	 AMIffd0xKFsgcKOcwLf+ivm6+GgwLqr/FUo7jkhkd75Mx5YAFBmdv8XZFMR1xxiUMi
	 swfCP2g0tVEWMbjBSI9ckASfEZxMzZl+ktWThf5FFzbIncZTQUqhIII/Dbpp9s8YPU
	 8gejTk55ShVyFYnzVbdgLHeoqW2/cfUub8FhkpOzXu4XScaqdV+sdO4mhoBBC6JArz
	 RuEEo577cBm26OSE8qRBbJrKkqRDtd1Ff6vhD16I0ESoqwD9oMpr9JRWqkIhHmw1C1
	 BMTFTLKcnY+fg==
Message-ID: <sashiko-outbox-168560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-9-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-9-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:57:18 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> the firmware model and console endpoints before registering it. Keep
> firmware buffers in locked kernel mappings and serialize their use in
> atomic console contexts through the existing SPARC p1275 interface.
>=20
> Poll input while the TTY is open and synchronize close with timer
> rearming. Return zero on no progress so HVC retries buffered TTY output
> but drops stalled console chunks instead of spinning indefinitely.
> A firmware call that does not return remains unbounded.
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D8

