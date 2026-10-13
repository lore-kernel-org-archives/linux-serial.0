Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5437F75D
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856087; cv=none; b=mqujZwqMedGejtXLH0xAG+ei5RcHuHvcVaqTVJXHNZ0iVu4PLsrHRx2dPkg9Dlo7x/lXGynKxN3x1vb2aO27YZAwM0KUwgQMh4lY6pEP6ac72mnZki7bWP6yQp3mKr+x8ae8lbZ6p1VGWArOVNvNCEolGq70wrtj20CWxlM0VRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856087; c=relaxed/simple;
	bh=jdNG9kCDE2gRFzxypY9RwzY9cam3Qf7tALsDlHdd2cc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Qoj943OtEI6tYIs5fYVj8NFvfm+YhyvB6Lhm1xp+SmMtk5S8KmLN4LfKPeHe00ljnH8jWHd3Ksvtrf35hB9PQuGhHkqzk8UdRQ0A/17/zdr1uoAmJkWvJlyVMPLD+gfIZrAIzuB+b+UuA/8o3uwh78uXIVWJuayg+fAqHYsPS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B65wrXxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B65wrXxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE7A1F00893;
	Tue, 13 Oct 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791856086;
	bh=jdNG9kCDE2gRFzxypY9RwzY9cam3Qf7tALsDlHdd2cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B65wrXxw/ZPaSII2v6ayP+4WMilBwsuFR5TB9zWVgNwp87ZESkx7LtcRO9YjKewix
	 xYJTz4MoWbjz3mW23WJ1zKj5VixCK39phWbqMXqoDBG44iKgCIZxZiaNR+7lF/O7zF
	 smRQlW7KyuNmvup4/vB5ikbnZINo7IL3QIjFYOsK/NtkJ/NMecJVoqNfzN6VjSuCUh
	 af9BGe5qCWjM7XtplT7B90ngQUyJnKaB6VX8Tni3ds3dahPsIdRduCcaUMByyceW4o
	 i0V9pAQtS6Fp1e2qs7OWvS9U6D7QuwsXjSLeLjqaqEGfqigAgEntlp440TY3bIJT8V
	 KR1thZ4NqdUcw==
Message-ID: <sashiko-outbox-168840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: pmac_zilog: push received data to the port
 that received it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Douglas" <me@timdoug.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013013541.4535-2-me@timdoug.com>
References: <20261013013541.4535-1-me@timdoug.com>
 <20261013013541.4535-2-me@timdoug.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 01:48:05 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> pmz_interrupt() drains both channels but, since commit 2e124b4a390c
> ("TTY: switch tty_flip_buffer_push"), pushes the flip buffer of the
> port whose handler is running rather than the port that was drained.
> With both ports open, data received on the other port can be left in
> its flip buffer until something else pushes it, so its reader may not
> see it.
>=20
> Fixes: 2e124b4a390c ("TTY: switch tty_flip_buffer_push")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tim Douglas <me@timdoug.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013013541.4535=
-1-me@timdoug.com?part=3D1

