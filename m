Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400453;
	b=TYBop/2wVHajPg/jSvKV7VOzqDPtNnaAEAjTClR7jsUbvoSIgARrG+uPDzVq4q7PSM4I
	 KLKBHSXGBIDtrrZ8a/r10ljEaYxVzNC45w3vfgVqznSW7DAPgHEgHtfgeDRfk1ozpW73y
	 2YPaCycFVE7ERkLyaAz3ZmH403+jnfz+p8C/dMPvGO843dffV2g3FT86sAShV2wqDc4dJ
	 4HpIFbaCwOzUd5LaI+cJpLcKiNDlAcjg6T1NgTHkeapAnkDTKKKNraEm44D++AJP3LLPf
	 rt2tgngW9PRoEKPK53+/tRHbScFP3JLZEpq4RHQ/fWBQyw5nLfrMjDxJ7iOAIZjJ4+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BuoBE5QnyVntRiaxuisOnJbZ/SogZyuoElOIwyHjRzI=;
	b=O/UDTk+eGYyG6aCa0wpmv5L8diySF5jVKizuYHwHs9PRA+kYoAjKSS8kHkw5KwTYo4+O
	 laS23cD5ZKJSh/Zw1qwkHBSCUCvS0Q+/Zt6Um7NlCFWVj6dCet8zOwBavQuYZO3/3pE/w
	 f8ugcD0TEOhT6skt0NJusYywlxVG9hbS25vABYzyTtrmyXNZ5i/+ib8+/cCi6JY7k+Vi2
	 GAIyqvz16aAwn/M6Gk24mlOR9pzAEYOh9pnIS3bLNgFoqVNN/lAaiAlosYIedcM/nXP5w
	 tFSvARlrabWx+mDD52krQD1U62Egu5Nk5FGut+j4SWIScueoYFvH6sIdqKiHkyWTrBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjRbmQIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545A606A32D
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjRbmQIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6A41F00A1C;
	Fri, 30 Oct 2026 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400452;
	bh=BuoBE5QnyVntRiaxuisOnJbZ/SogZyuoElOIwyHjRzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjRbmQIZCvCwY0GoHp5NinkV6f97HiBHpIPxOtbot441+9Kgi5xTySBMWDPne9Cck
	 fKuWn0ecx6bbawCWEeKH2KBfqi7PWrS0b7dyuUArIgtbUf5yM2YECbAJSDXjmPceVr
	 7yLib6yDMwZgQdvWq9HFPGkC8FntZb8j9/3e4D538/HWgVGoxKeXRL6FQv51q6O0V6
	 H6Pe3CVDJ9MaYMzoMSBwoeS4OnJ0OG9LcbdhwTC53PHJi52rM0CMWv79aipjwUzUMu
	 6DwUOgwVtL5WFFyHHD0PD1fnlqO0wwM7ivZgK37Us7N/A2h6ejCw8mSxeHH9fpPdXA
	 8PTCd6RTyhoig==
Message-ID: <sashiko-outbox-191597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] HID: ft260: i2c: reject an I2C clock outside
 the supported range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-14-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-14-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:47:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The clock sysfs attribute passes any 16-bit value to the chip. The chip
> accepts it, reports it back in the I2C status report that clock_show
> reads, and runs the bus at the 100 kHz default. A read of 2048 bytes
> takes the same 0.298 s after writing 50, 3500 or 65535 as it does after
> writing 100, while 60 and 3400 give 0.387 s and 0.058 s. Userspace has
> no way to see that the value was not applied.
>=20
> Refuse a value outside the 60-3400 kHz range named in the datasheet
> section 4.4.16. ft260_uart_change_speed() checks the baud rate against
> FT260_UART_CFG_BAUD_MIN and FT260_UART_CFG_BAUD_MAX, but termios has no
> error return, so it falls back to 9600. A sysfs store can return an
> error, so the clock store refuses the value.
>=20
> FT260_WORD_ATTR_STORE() takes the parse function as a parameter now, so
> a word attribute with no range of its own keeps passing kstrtou16.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D13

