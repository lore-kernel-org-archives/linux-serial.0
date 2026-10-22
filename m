Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698133;
	b=aGGm6wIuZdYI4nTmUa1C9buVs9esXSNMTPO+YScEvqrVtH/CsNt/8l8LEO3fsAvhEmQk
	 WvXNrhkcB6KHlZfRKT0WMSms+KXyGJrDrqYbUsB2tdl/lizp8Zl6TpV2rlDuELv5bQmm7
	 tzmz7lUKCsKP9lmjvhsEo0RMjvVSjyRUzHBmVyPwySXC7RT71S0ni5QmLLUeNpdJwtkLl
	 74a+F7EsgXTW4+vcJeQeMAwHQP/AX3sVujqBaNKT/HHSRdstbj1LABR4yQyT2cNrwhDsv
	 q8AqxJnyVtAWBu4DzsuShSwwqgG3iPN/FQValE32wdH8NR1+gvVQfpJ+k9qYAjD9jkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4gbJ38CxGZ63LQqmrDcPuyd5caansWaWUm5JI1grslU=;
	b=YxJ0udMdqxYFlZHbvW9e+VOHsWFxClxm4IDdkQlCKq4NGXIK6raq8yL3wX5kFsIDC/yx
	 6FQl7GvP+gNfnzpcWAl86aJx8PaKy8XNFu64/AKpYbOlu5sW+xTo4QDpndpU1rEXV6kL9
	 HN13W8yfCEkdYNAMWL/fOL7yRwTCIJGIfjKCxHRcUrYH6/IFQwCVSIHsU3y4jP+74XWO/
	 6rFNpe/3StVFtZ2Hj9z45cfbKeph9FthXFP0/I+OefEKic+V1e266yBSu0Zw63u7RQrro
	 V3lTScl06QKt7NJsZUkKuSCgI9ideG9TbWyf/TYlZ72SgNp+Wm0Ei8YDpcriK5diV7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlCZB9EB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955D606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlCZB9EB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C61F01825;
	Thu, 22 Oct 2026 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792698132;
	bh=4gbJ38CxGZ63LQqmrDcPuyd5caansWaWUm5JI1grslU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HlCZB9EBMl3p2OAe3uMGa2q6zix8/3DuyWxwHnB3gv9Nrs6MHMNgkKH52S0X9Lak7
	 bzM2PktlDam+aFG9BdUYyUd7+5tRV0wQsADDXKE6c6TTrhoXmvBECmyniF6SiT/nG6
	 Dp7WYa1tp7yjSQKYTsFFALvcRN7us5pHjAFC5Jli1w59JJuu5sx4enTmUFJi5k/H4+
	 vqFHPY2jghPwc7Sr6zVtKssKnQdLEO8cOAyyorMiMcTuVL1sw4opIz/8ty/p3ZIa4W
	 6bz0D4tGIl8By7NcRgsnNXeSUF0nZwPY/Q8AOLrGG6ONLYM2Oqh1W4QAvy9rySsEH2
	 l2200p2qJuCVg==
Message-ID: <sashiko-outbox-181975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: qcom-geni: Set UPSTAT_AUTOCTS for hardware
 flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael McAllister" <me@michaelmcallister.org>, linux-serial@vger.kernel.org
In-Reply-To: <179269779969.81501.3877980314174207182.geni-autocts-v2@michaelmcallister.org>
References: <20261021202603.42888-1-me@michaelmcallister.org>
 <179269779969.81501.3877980314174207182.geni-autocts-v2@michaelmcallister.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:42:12 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179269779969.81501.=
3877980314174207182.geni-autocts-v2@michaelmcallister.org?part=3D1

