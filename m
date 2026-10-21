Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614709;
	b=N9V9bRbnA+jy9Bgu1oZLPtOqnzBk3Qp3Ci3vVs9T6lD1hBPHb9a34EI2s3jUNv2AJvzp
	 KSe7o8+8UgUMx0s23eFECTGfk5QacdBWTbwthyhlIQtF7lwuB43S2VmBJ1slxX3xTt/D2
	 H1O4ZxABGpvWzT2TyV3IIroorCxgLHTzFPKRQF6CbJHHYjDpRHaf9jF2mlPGlIR258xSl
	 qUyvbfxZOx9onD+AcZ+nsbaKtcMFzEZglTIoamwTiF70CapCeOPRFLXV1CbvYyLHZxDjs
	 dJfsG3aQUjkbK6j0SWNkrM+ElS4OtbJ5v+pHuGZL2BICCDl5ZBszxfHLG3zgO2nwW7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614709;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DGBvjIZQK7BbiW5WrZwKGfgW3Pd5/47lDN949Rh8V3Y=;
	b=u76U256K3DwtaFyFTDUGtuEkPdI8/J1T9429SJJqh8YHY5W3fHsGNr0GByVsxciWPnnB
	 p0/fK74GfSAyCD7JJHzq7UoNYqK8stBt3ke45+tMfh6JjZ0UyLYg4b5Ny85tQMnpOjPVU
	 k7b7m7eyYXZvIw7cSot6LsiH3CteKEq+2CcnmhIx2uzN/c7eMPwb4TikCi0qAfMtDvtUj
	 LEYfJ6cJQTlqXPBhjBAHdNQS36WIoTez6r8XTu953RiuzewIPc5hHchFl5mLj4S4UrNj8
	 urXU+73jFkyaeRB3pR9bDDQGUCYVv5/+kaY5CRH9c6A4MtI31inTDT5it/YIQ1cIIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRnrTUWT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F793606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRnrTUWT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E081F000C1;
	Wed, 21 Oct 2026 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614708;
	bh=DGBvjIZQK7BbiW5WrZwKGfgW3Pd5/47lDN949Rh8V3Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CRnrTUWTQQEg13oTxCJrGQxG2GYon/odr1FOazpsNI+gFybjPQbfM4JHtFyePeLJe
	 6RW0YX2TsdTaXh+KtPZeFd9VeS/y8dXIhzMnR1OMQ2vO5pJBHMESouAG76tRbrwsoY
	 1gzD3202841nqN0817IddzyulmPnIn1Ua/3VL7tu5Y1kXJ0VpnB/S1vtHmhV/X4TOJ
	 zwXmmg+HoG2ixxYh5kRdCaYWHwvLxrDdwPdpV0dypL1PsUA42eLgs+VHm2+1+RurgO
	 7oFa2hhItilpcIOWgNAt657flJnZ6/LJK47G84eEQTexCuzHR2lSKUxfFBWbcAxMnC
	 ElHMJHRuC2nKQ==
Message-ID: <sashiko-outbox-180643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Set UPSTAT_AUTOCTS for hardware flow
 control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael McAllister" <me@michaelmcallister.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261021202603.42888-1-me@michaelmcallister.org>
References: <20261021202603.42888-1-me@michaelmcallister.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:31:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> qcom_geni_serial_set_termios() clears UART_CTS_MASK when CRTSCTS is set,
> enabling hardware CTS flow control. However, it never sets UPSTAT_AUTOCTS,
> so uart_softcts_mode() also selects software-assisted CTS flow control.
>=20
> If CTS is deasserted when uart_change_line_settings() samples the modem
> status, serial core sets hw_stopped and stops transmission. The GENI
> driver does not handle CTS-change interrupts, so asserting CTS again does
> not clear hw_stopped or restart the transmitter.
>=20
> On a Motorola Moto G10 with WCN3950, this can stall Bluetooth setup in
> tty_wait_until_sent() while qca_setup() closes the serial port. A captured
> stall had one byte left in the software transmit queue, hw_stopped set,
> and CTS asserted, with the UART powered and its interrupt enabled.
>=20
> Set UPSTAT_AUTOCTS under the port lock when CRTSCTS is enabled, and clear
> it when CRTSCTS is disabled, to match the hardware configuration.
>=20
> Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow=
 control")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021202603.4288=
8-1-me@michaelmcallister.org?part=3D1

