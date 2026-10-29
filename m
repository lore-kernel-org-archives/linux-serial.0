Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300680;
	b=BFV0aminPljFjtLBHsH1fr1WAZNChrJcNX3apI8FmxMT/UlQE9EoJylbBfEgcl4nvd5v
	 KlBIwFb5KFPJjjBc2VTqsT3OKZu9P9iUnc+Glp7B6sLxWJeVEF6dvTvNmVU71TskKHJCE
	 5hl1NpUpn1ff1tYXtOML0SmfrlOUsubcaAbpRYpPCefSFJ+F9sdm7yFgwP8K34ar11JdC
	 4Xe2QEoKSWBvL5Q/Pqa0udXhQoJCXAho2510XUVJ2vE2IACzq+C//ITbzMLqBhzIWr+W8
	 bMysJMErObhIIygf0u2TOzRF724qkNqzxURcqCuo94DCQyas1neJsOuBTCQM1a20T2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P/pB80aKEUDfPNNhkbN4qbOo7UNSnFdy6Q+vTNrIguI=;
	b=AEXk4jdFhLmXhQpOSGU0RP/1fceZFk4avITeNxDJNXdo1rkvs1oS359L5Lbr74ctuWja
	 UUT2L4YwENB2z5d5Oj28kUfmNiSbjXibfUgZgUcPycAxxi7Dq9TQXH1nLoWfPIavzRUJL
	 JxybTzCsaqS1U6nCg+6AJo13NfWOIdsvPmMSgpCWvXC4eTmw4mV9UONPD0P9a3YX7qx10
	 hEG8V+Z5gYXe1JxamvvRvi+e9bw8TitHLeMLHqPWgbF09hOGTVhG99M67fGdakAmfBUXU
	 xgOLDDR+q64km6hK5GbCznj+9B65W9ytim9SkPGkSEbnqfhCgRDKnxyhZtxek2/NOLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjweY6At;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485B606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjweY6At
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A34B1F01816;
	Thu, 29 Oct 2026 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300679;
	bh=P/pB80aKEUDfPNNhkbN4qbOo7UNSnFdy6Q+vTNrIguI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jjweY6AtjJRIdNUc92SGBg/5+IZSzYv7lcOZWIFzpdODWIAVZqCdA66gmfJAhxgxu
	 hgNDCCDRxLyrErmQcK9ut4LSbc2aaJLE6jN1+p1SNJcsVzvGgBJEaA3/qYDzfnYuNN
	 LCiuImeN/572CQVCbFUUReGEPgPQHYE0MMJa7cvOu8pvkj6S/gp3Oyl//F2qCsauyH
	 ElLvQrdOuk30C7skn4KrCKcRboN1icC3Qd2naXAMp4a+E5lT8YLH2+3RcOH/GZOtO1
	 +Hlr674GaIH4qwXwCrN+dR8jKC5N4SBOrFLVu/3omj6c53/rKx7cyi3dmKGwyBi6yq
	 11CS12Ya4siug==
Message-ID: <sashiko-outbox-189834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-1-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-1-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:04:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while retaining
> its DMA setup. Select the DMA setup helper directly for this integration.
> Keep generic setup for devices without matched platform data as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D1

