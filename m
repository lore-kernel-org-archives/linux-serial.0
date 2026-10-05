Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD5463B8E
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207200; cv=none; b=C8OA4TNLGvbff1rZ+6rq5NqKs42Oy1Mkj48fatioSLb/KTKlSNFB7B3ev2rkDSbAnNFZ5Zg/45H6vnP14nikTsnpqmPn0FSNaRucO6b0dXxEuNi3prMZ/UuTgk/JxQDOgODoxFDbeouZ3CAu+CABf98DKbi+sJ3qCIwbtGU1+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207200; c=relaxed/simple;
	bh=tFBfVvvvr+ElsFF6cy/jj8gMe9dBPNWina8K0wFtlHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FHsVuVOEca81/xUIj4it/9BbpSBQ04YjnA3oajzNP+k1RnHiQiwC+MovxZhS4i6RA7d7ojjv29Px7fkojdMHBhdpaJyH6jAzysg5szPTF+BA2qo3Va3dHgLPEyt04klm0vDsmwKdtEy1+K0vZk4hz75HlZqvykGIHnFWeuLyaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAjuWbvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAjuWbvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492D51F00893;
	Mon,  5 Oct 2026 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207199;
	bh=tFBfVvvvr+ElsFF6cy/jj8gMe9dBPNWina8K0wFtlHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAjuWbvoz9ZtN1IabGyPgzy6UhW4eNL8+Et10mutFynQO5dEQQrZsAppND1ngivL5
	 lzOO77UMI4EE+4HpB5NEZoLpW/gqW7oQVSaAsWAFYyCK47mNjjVbIUGkabiWAZPmLE
	 DVmwOV1J0d+we5huXNXkcyPqtHQwYm99/6++Ql7mTk03rthzZbaheVA9CYTa4SqIqs
	 Wh1MSxv+ozM467C9Ciso34Saj7+RZxyTbL4FpuUpZsXjsEC5WTEHacnGtHSyl+hXU7
	 amw5M45Tl7NBv3OCaU7pgJ/WTa3qKlvOwoUJHJdrZ12+C/us4XiW8gmaiRJz7pbKUf
	 YTEPG+6Hu99cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-4-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-4-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:33:18 +0000
Message-Id: <20261005133319.492D51F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D4

