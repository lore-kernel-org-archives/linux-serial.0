Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701A4C33FD
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845996; cv=none; b=aP5brV2DhLXzG0UVzEa9At9xwUhO/g5o1uDNmsybrkRO4q0Bwi2JSUyyIaub+RcWFgy2B0RnCQ504MHZZPrRUdW+nOxh7G+Z2VNJs8fbyKCuZokS+WAIQ6ePKJuJE5puHSyHxh5biIZGUUMEgtcDarmYwnqbuFbqs/+cPJEWYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845996; c=relaxed/simple;
	bh=ZqSquHge3i0iPK3wMZRcMZgipGoXka9QRl0QmDVK1u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfX0kNaVeHE22K+8pdgqhGLSUYLBgqkBH7Z+U+RUIkPMb0BRSpgUNG1EKX0KXOJG7FY8KUoGX+4epZmp2gsq9N9G9qktwhkEDFHAIITeka/7FAhZYp4hKTtkJm3K+AM4pPAqv35fWe0052NhStRZmGarXN+LyUDH2CKI2Tu+EWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdVYtqPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdVYtqPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86A21F000FF;
	Thu,  1 Oct 2026 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845994;
	bh=A2g/mVEyZfqNaUVZ0eOdzsMSoqgCo1CF4PHl24Z4CqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UdVYtqPJ91eywPVIkUj4yc3OrO82W+cJpRXSpxNlRVNCGphMFelxZefgEmbUCluiG
	 bWDdpFL7WVg/MZ+z3A+Yaf5KNpBtFvJfFy2Lm7WQmWwiuxG63hgflhgb25n2QEwSCr
	 QaS+sMou/pcEAin+LdUYXF5rflEAb60/xEM7bRlz14DgE3rGvIMEP5nKSwOFoAngky
	 bjI7N1w2ld1MaLrsi22OFAzfEpq2L7TFlNTbcAc0CizN7BCl29bNvNbmGmbREDmY8t
	 NiUdPyENfrEbG/GfenfyY26fN2js08s0NZH1aw35KBgNOyj+ikecl2hZ9Z9+T/mYvw
	 9Dk9N43hhTe7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] serial: 8250_bcm2835aux: Add support for RTS/CTS
 auto flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001090432.1045270-1-sairon@sairon.cz>
References: <20261001090432.1045270-1-sairon@sairon.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:13:13 +0000
Message-Id: <20261001091313.D86A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The bcm2835aux mini UART can automatically de-assert RTS based on the RX
> FIFO fill level and gate the transmitter on CTS, but the driver never
> made use of it. Wire it up:
>=20
> - Enable AUTORTS/AUTOCTS (with the RTS4 threshold and inverted, i.e.
>   conventional active-low, polarity) whenever CRTSCTS is set on ports
>   declaring the "uart-has-rtscts" property, advertised via
>   UPF_HARD_FLOW.
>=20
> - Gate the AUTORTS function on TIOCM_RTS in set_mctrl() so that clearing
>   RTS (port close, TIOCMBIC, B0) actually de-asserts the pin while auto
>   flow control is active.
>=20
> - Implement throttle()/unthrottle() by disabling the RX interrupts and
>   letting the FIFO fill up, making the hardware de-assert RTS - the same
> [ ... ]
>   without the rs485_stop_tx() callback ever being called, which would
>   leave the receiver disabled.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jan =C4=8Cerm=C3=A1k <sairon@sairon.cz>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001090432.1045=
270-1-sairon@sairon.cz?part=3D1

