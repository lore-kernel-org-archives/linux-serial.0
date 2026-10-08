Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457E441619
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453813; cv=none; b=mUqICElZ4r2ft/fvAb9LblNCHGK9KsjlhMf27OdKX8PHYl5oIQPh/nzK9rCdV9FlKRU2w6mDVD9A6Ui/WXYP84s7aXnowUznKZU3Tbw+OeKgc64mZriR8/aAKN3XRLr/fBcc7DUmOy5LZ37tkohnitMBfUJ0ZwyhRVPDIflb4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453813; c=relaxed/simple;
	bh=dmx0nyALRuhQktinFWIiL/wvuNAnCbun0Yay44HcZfk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ru74M5anNWRBCzJV2r8fiJZzWPTJCq9KgtLpZhU5WYPE0NBEXHhV05NqzRNFVRXgg2zGAlWxhWOTKna8wNj38laecQgA+AY/mm4U/56aKhUTngd+uBDEU+e5uhKSPGedkxJaMDAsiKuLPM4o/GvxgDjiQrS2qdlyH4jfBI7W40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHGnKSbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHGnKSbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356451F000FF;
	Thu,  8 Oct 2026 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453812;
	bh=dmx0nyALRuhQktinFWIiL/wvuNAnCbun0Yay44HcZfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHGnKSbe/yCt0lF9iNdLbA/HCYZCASJ9tO3GkyM8ubFKG7xtF/7uYs6doXkXJQWvI
	 bMbbKoSW9sVQZHOfXKPvK4I3o82uZG/CWVFL8koxcfHV/3gR/31zjYvYV0fjoImDPP
	 CqitUbHFc2kGpM12TNhIukawTyPsxkveTEkk2Rqp3zAahPRQi1hH6+nj8oy/JMAQZx
	 5kbMfBeo2B09vpns2K6HVAoU2ahXVZ/coSKimVjXajByZhSbB+70r1sr4usstCPP7I
	 nU2z2Bl0KufjF+ez/REXwb7tc568xeq3gzEV5KWxdUKvNcXPvOEQZHxJGLzZshBgM5
	 UZ4KkQY4eamVA==
Message-ID: <sashiko-outbox-163984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] serial: max310x: fix RS485 delays being
 programmed as bit-times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-4-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-4-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:03:31 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D4

