Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742407;
	b=KiEPgXNIydTUjRYO8krgjDDv/SMvzc4J02SlJQfBAQV+6RU1p2+GYH4gA3cfOo6RICuH
	 th5qYGG+kH9wcaJW+PXCpZsX1Ji/RitdNRIMN44nszmHBCUfCvocOzY3fjK5vPUUqrbnt
	 hBsf/vAiFAMDXpWIxYpxYFC8sGmrLN+PV6he9InI0fIyqhgwNTQlcoI/F4FlFlu+rayNt
	 +5b9pfzFkVkpaGYkWga4myfbRT9m7MILwPD4Rg6YHavEnBkMC+rFw/xjO/TlAAcHHrsxi
	 1i7bsnfpVKNVUXtA7yFVPAjnPaTEVUf4MZ3dZ87B1kgiNQPa9vB60p//2OWn8EIgoIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8tn8Nu0s+IYP1ztizIgKz7+X1gBdWCceZM9LcvAQNF4=;
	b=Tvjjuxi+Xzf8b+9SJSKCAghG8e8AfAkagC5eL+iJXLmi8bJlvPL1xKSPOKPa6vl228gk
	 2RVqSa52scKSgfjNf8niPPy7YUcBZMm+FqD1Rdd4LXTgVcP/EZIQ2LOO8xSk2IVvFOqEO
	 x4e0poqly58CFGMd72ekPM77vlH2LigeZyqzIxmTvn03HpvJTmgSPWsgquZ0DnOWtqA/y
	 S3Qov6wbWlLSA26Fmbt1wq9ed12KUwFXXzQBwiPhQBr2LOHV/Okqy6sPAqXSti8KOu1N4
	 AlRS+cD3bCrVkvuYaxwJqzWn/pTb1iMkhwHW0paXFYnRUofww4/DHFTTNuBGbgPr+Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWhQPLrm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E0606A330
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWhQPLrm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB31F1F00A02;
	Tue,  3 Nov 2026 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742407;
	bh=8tn8Nu0s+IYP1ztizIgKz7+X1gBdWCceZM9LcvAQNF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWhQPLrmRs+O8N2UuCgirglN6ySzpMllA+YzdNul5kIxnBtV5a6iObe9cMAUUqzG7
	 ZLp1P2ro7s4RjMHkvsk8HUsMyr+90upT/JCOzUIk+l67nDgKYtthamqmsScZHKfdYd
	 mKsPCllCeWkmyd6/n4/ZRd7k6VehOH+zPLmXPtJz4jUrvtXbhtTnODrTdaNf3SlrFW
	 en4Q5GNmUImgZK4XJ0fW1yRyNxjt3R+xTw9vQYbew9SfrEETj3nk5HAqddsV7dJsPo
	 mYP+KPEGk2Sv9mRzQLpAmlvtf+ceAFNQ2/l3TT+KpHJgHQSkEuFsEBmydirEyUUTfX
	 d0ehxe1qDLYfw==
Message-ID: <sashiko-outbox-196078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/12] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-7-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-7-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:46:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
>=20
> Keep PORT_16550A and supply the fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth. Use the shared
> DesignWare receive-trigger setup to describe the 1, 64, 128 and 254-byte
> thresholds, with the normal half-full FCR setting selecting 128 bytes.
>=20
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
> DesignWare termios path for hardware CTS handling.
>=20
> Select this configuration through the platform setup callback. H616
> has debug-divisor and RS485 control registers overlapping the optional
> DesignWare feature probes. Use the fixed configuration with BUSY-safe
> integer divisor programming and software RS485 handling.
>=20
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D7

