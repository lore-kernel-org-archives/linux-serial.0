Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400452;
	b=1MInrLMvTJ2MbWKfBgoiZmhw0WgAHx9LvnOQl2JSrO7J2sAg2he8H+v2HGJ6qPGdLiT2
	 +XjDkcuQp3DWtMvh58cNnaBQpnwyBzM3wR4dEPRPI9edPcxtiTjLKB2VFuhhnOFABNtUZ
	 6RI4kIeJGDOIO3jLAQLSRwT8OmfOtkkfkT2DjmIE7WRWLDRhErbNbBR1bYsOu+P1NwZGk
	 pydKtHzeWp+5jSESJZxX8UHwQvMLD7cDfig2hITAftSCVWAe9wXyeOBVum0eLW3n/UWsn
	 xrxZkX76UsaFCaLmlYugiTU2ZGTrfdZJXjEqBGFGpjORgMBBeOrORg/oRwb7anFp37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rWaV7AnLCLrnicZB2vcm3r0rgd15EPEIHJnEb5+rYjU=;
	b=oQZLnTi4aMYf7AzIel0Vot3nAEU9WsHuPFHPV9Pt6YmJZT8nUnnGI0jZhhSFclpYvXU5
	 fLW4Ii6wcmR0DO/efDighV/wOXmfSIUCsitvrsO/6CJmxdEryZg3X+I82sYhA9iWV04zd
	 MnkrisdKDY7V4Gq+ND7H7Y7NYMTfOKhWljoWCaP4CN8n6DSu/+D0JN9ZLZ0Ok0BZBGN2O
	 ElNR0g9SsP7oXm5JgXuPWEsbz1FFrspj8UCx/K0EyTW6aW5/Jh8wOMvG7qGPtF644MdZj
	 HfTSQaxmXsj/IDY5kAXsVW5Monypqbx2ZBjXSxtyE9GhbA5IAL1YYUvoRV2DSSfTuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSWm4fra;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64D606A324
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSWm4fra
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805AA1F00A16;
	Fri, 30 Oct 2026 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400451;
	bh=rWaV7AnLCLrnicZB2vcm3r0rgd15EPEIHJnEb5+rYjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSWm4frabPj9xEZ/aOkYlTWOxT4+Z96/lcvUnLlB9F99sn91kCBYJ6hAuis73c1ap
	 jRr00pULzN0ZFCeKg84qQ2vNYjrnnkcYRBtviRjpP5/ZI6wexABpgdrpOEfNVltqgw
	 jrmvDP5CEciNhfrEPHAqrGOBU9CJ6ZosCliPr1o6ORk5mLR7joc0S/dLv9qFjTXEiB
	 3PWdBEHwpk6cYDDhpIM1zTT3AmK/JLHqimAK06rbeLrWdawnEaV1u8F06qmlmMmTyV
	 nqLGUDVLJyHqZ7l52KkkT/z+ctNOi0kBCiQJTL/5SAIhVFTOD6OMW1pV9mVcLIUZdf
	 Tn+fuWVVsru2g==
Message-ID: <sashiko-outbox-191593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] HID: ft260: uart: enable flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-8-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-8-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:47:30 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
> with a 64-byte max packet size, so the theoretical UART payload ceiling
> is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
> above 1M and small transfers can work there, but large transfers are not
> reliable above 460800 baud without flow control.
>=20
> Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
> CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.
>=20
> Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
> and with RTS/CTS (~2.9 MB transfers, no data corruption).
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D7

