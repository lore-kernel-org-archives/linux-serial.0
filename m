Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947070;
	b=G7MONNOKVWcfSz1FWFLBy+OoxrvixRE99SmMinzF1QEOk9ZT9XzZKAdTh+V6UFxEzvDr
	 zCT+RDhXg1qYZXgTOfSyi10KB8tDpIYWbhlQK233c4ecEr4mXeyYoHeQ388VR+PyD2iEq
	 n2nvAAxLwhOZ5w0MWooozHR+RVkZRnmSVsbCnyckh9v4+s6ydaintn3XB+Zy/OGb434Of
	 qR2W2uE7Sdr+b9wc0uOV+qdgSp2ifXs4NV8VM+qQiSV8sgWZYgmbtGhrfnaBtd3DjQ0vX
	 Aac/kucRUqBN9JUNRSx0gxwMv+N4y3Q6zZF26FfQIQ/BV9nAbIdVRvto8M/2K/7L+AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HwTHuStp3/sajm37zlPZTfC1bVEKAHOtFGh+paI5wzE=;
	b=fdUErtpv6xFptoArzId053R5wjmcFgcHD0Rx6BXARwhIoZJ1O/NtV4ntBBf6dv57vNqq
	 kWt35FX1xLHNBJ4R/Vt0vnw8mZe3rxmknsGArBxfD8n67pywC9s03BfndETZ58dytApnh
	 P8QC/A7NKvfiyMDxYsOACp9v98OPpI+pfL5EnpnQ7Cb/5OXX0ESCXEf3OovWSgebzREQw
	 9nmGE0sU3IkZILGiqWE0YqRDL13FfeYgudWNOj9POfuP1TlfgMlFIyr3VRf285SiVtRS2
	 /6XfJ+iV9oeuqy7KBgQq89xFTpt5QprM+9tS8CMBzbSFi2Lv3uBVxGjpUgJE5SLidmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mriu6IfV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4265606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mriu6IfV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E83B1F000C4;
	Tue, 17 Nov 2026 20:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947070;
	bh=HwTHuStp3/sajm37zlPZTfC1bVEKAHOtFGh+paI5wzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mriu6IfVnX9h+PErLNfmbiv0ME/PunWQvU20136aE2CJnZYqqcJd2mJyBHC416e1q
	 3sjGA/ula/WKGpbQ/0spDGf+NW44agFeMO1xynLG4lqGTaCtfqT3w3j2XPHw10S0Qx
	 2ewXZZN4mRoT6BCeZB+E9dRtGxyq1tgh0G7FPxGU5vXHKOmN4jA4i+GUewI56IEeRH
	 ifxhyJmY+67PhaiXDKqXIPdpLDwBCNiCA54u6qL+CLBcPe6SJH6BsXJgYAM290xZch
	 9kyA8/caB6mxOF6N2V9oke7netOtW93CeUqoaKa73nx9nRqw5ROrBYJR+ffrJvrtUB
	 xYI79MCItCk5g==
Message-ID: <sashiko-outbox-219597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-9-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-9-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:24:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add TIOCMGET/TIOCMSET (and thus TIOCMBIS/TIOCMBIC) support so userspace
> can drive DTR/RTS when the modem pins are in GPIO mode. This enables
> programming an ESP32 over the FT260 with esptool, which resets the chip
> via those lines.
>=20
> Set up the gpiochip and the sysfs attributes on the UART interface when
> the chip mode has UART, and on the I2C interface only in the I2C-only
> mode. Before, the choice depended on USB interface number 0, which is
> the I2C interface in mode 3, but TIOCMGET and TIOCMSET run on the UART
> interface and need the GPIO state there. Add DCD and RI (GPIO4 and
> GPIO5) to the GPIO set of UART modes 3 and 4, so that TIOCMGET can read
> the two lines from their pins.
>=20
> The RTS, CTS, DTR and DSR pins are active-low, so TIOCMGET inverts the
> sense of those four lines and TIOCMSET drives 0 to assert them. DCD and
> [ ... ]
> using hdev after hid_hw_stop().
>=20
> Co-developed-by: Rio Liu <rio@r26.me>
> Signed-off-by: Rio Liu <rio@r26.me>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D8

