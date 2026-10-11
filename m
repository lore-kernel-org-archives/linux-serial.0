Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3031A682C
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749140; cv=none; b=inyj3q8hwvnAu7hYt0UYn4Ze33D4kFF7lGQpSkY0NG/Y4MTINzLh1ZW/69DusB5rkwAgSLrmnmt6wNcVH1UuGjey1OWjUsUQHp/V+epaFCl/lbPQR3izf1dOwrLLnWRalkiKQuw6atr1SOoi4snBWSvH9+oEbfgvynSia9IqQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749140; c=relaxed/simple;
	bh=VQkoLzNQC4B76XLOr13VH5hnTqpFa9gjNwr+FiXpBFE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rk3i3DEUpj5k8pyWmxaCIo/okDoJ9vHl7xrb5Zujw7p25YGmqUZKkAHEZpWrXwwL609P9SIGSJ0uxMXuvRIxZVKbGNdrFYGIUp3KwDQY/A4RuaenT8P0uQmI3E7kw6kzyle6uWEsmT0wNL21LNAu/MzT68ieNXLzC79aZEXwPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoEIMmC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoEIMmC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B21F0089C;
	Sun, 11 Oct 2026 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749139;
	bh=VQkoLzNQC4B76XLOr13VH5hnTqpFa9gjNwr+FiXpBFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NoEIMmC8zuNMWuvxJWexHhwh8X0DpKIfWVjYPEPDLJ9iWWoWm9fHi/ZingF5U3bAd
	 QHrLyuIUg0vy8m7yvo0q87Twz//FFH6XV44t6BxFqBT6gY8xS8IbSj2n0q2mBireGJ
	 xNjC01mgpe4kLO46WZUzA3M97CW80iocQNO7qx+NH7u28B4ytkvRH8TsrjIWUUKznH
	 R1KoxI2Dz8ZYnrW2yWyeJVYJnBAXY3Yc67aJImxRXMzBpG5QAtHN6uxXbDmB++Bc8R
	 OWPR9qOtc9e/O2b+HczJRgV3njbYgP+dsfNqzNqYDaOPFZGFHQ6lKyavFKT2N9y2HI
	 NhPp6qltOELXg==
Message-ID: <sashiko-outbox-167443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-7-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-7-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:05:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D6

