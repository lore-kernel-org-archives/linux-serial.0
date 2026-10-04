Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7021426D37
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117017; cv=none; b=XpQerdHr2fxVHiqAtHpSd+Zy0l1F1Sg46OBs3a+IIY20tvz2VV3Y2l2yavYmXXd5ryUip5jfV3e/TznnXxM6dD2Pg5rFku+hZcJdcM42AbKwRmRtN0idRHvWekgcJ7fSfeZ1Xdr62CMA/O7pXGemPlceqHKA293edES35qZbQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117017; c=relaxed/simple;
	bh=oQwCvKk/c5efFVhgNqqhjvvoBSPk/EH4coE9UDaSfKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hqLQywa1EpR1rbfPnCSYS3Ie/OlA3s1/XgHRVGzX4y9/wUfeyK6oexm2p7I86ZG9PE10M0t1BLWQhxsxFczkR2X0qN1zp6f6tPtYuw3PQK9aCEyvUEjlGc/wn/YJQ7yvA7Zp2OqhfY4bjHpmbGUckGrdYkrA8AHyb8LCp805S3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBdtS58p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBdtS58p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA5B1F000FF;
	Sun,  4 Oct 2026 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791117016;
	bh=oQwCvKk/c5efFVhgNqqhjvvoBSPk/EH4coE9UDaSfKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBdtS58pzrbT3L5qr3leuK9EeTykrtjIcqj5vR2ALVTgpohkzyMbGfBa92NJuB4dZ
	 z0UDvkzPS+jtFyGuEZSaOSt8rqrDAbsIFuEaQU8ONrQEch5F+ERVr7r1ZtVRpxL7Ii
	 ZzhZDoYp8q5vrX3p0PLiuFOu8NBZpgd6mE7UH3fONaj9TOIPwNHBcgCrIsMZnTtYQQ
	 m/TUYkiszkQXPwtvww6aNk3P9hszgvLLnu8DYxcGxkmcxcXhmsSLHU4N+eTvAO8DmP
	 8fzaXphevZIO0kGpuFlXowVrYAFkVPDw08ynZhVUWQ+Vr+7mqKEnb0JUvILyIQYN5s
	 Nos0r9ipJHBXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-4-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-4-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:30:15 +0000
Message-Id: <20261004123016.4AA5B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The HDPIXDELAY register counts the RTS setup and hold delays in
> bit-times, four bits per direction, but the driver has been writing the
> struct serial_rs485 delay_rts_before_send/delay_rts_after_send values
> into it unconverted - and the uapi expresses those in milliseconds. A
> requested 9 ms setup delay is programmed as 9 bit-times, which at 9600
> baud is 0.94 ms, roughly a tenth of what userspace asked for; the error
> grows with the baud rate.
>=20
> Cache the baud rate in set_termios() and convert the delays to
> bit-times at the current rate, rounding up so the delay on the wire is
> never shorter than requested, and capping at the 15 bit-times the
> 4-bit field can hold. The conversion lives in
> max310x_set_rts_ctl_params(); set_termios() now calls it as well,
> since the conversion depends on the baud rate.
>=20
> The delays a 4-bit bit-time field can represent still fall well short
> of the milliseconds the uapi can express; requests beyond 15 bit-times
> are capped, and the -ERANGE rejection of values above 15 ms remains in
> place for now.
>=20
> Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D4

