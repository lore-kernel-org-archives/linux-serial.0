Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947569;
	b=ihj/ns+lsJwP37tKmzNsvyG/RnvQVkd2yu+AElAjHV02RYNdNfVLLr/fVrb7FFirqY0C
	 s1Yzppyh4QLkhX705HVDEtoNhXzIZvRszIIQ9YzvX73AT/aFkqx7+MQ+gtFT0Mnl9NF34
	 Q2PLjuAO8qwR2Vd7yFhoiILyUp8KEHVfSOFncqqCKBXNZn+zjQXEoIpYUWuNcN8fqcqoS
	 xV0UKeALfFMFNalR/6sk0bPaBZ2kHlWfgCp1JgC6yGWvH05EmcOUSpmSuZQn4WAC91pT3
	 9pfBpV0/Zb+Vg6qxffYjrf9LHdANPUPXSYf6+7JYCwwIgd8FEe58JRyYIX/4MU2dIxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9T6tmltOQQzyyJNh6k13Do+jCluVWuSxZ/WZJJ01p+0=;
	b=HqYPy8MNwgkZnZIJ/rb0VATCildzGlJnlKuCqMSk3I3f3I7YYUjpgaEYfxVPhzpmYE2Q
	 drfiJm//2W9iRcgNOOL2D7/BI013T5g7gN1tVTN0z1MI1qANXRUQDUFEoqqh9sW1g95CK
	 9/JL16Pb35hEtI+Da5YEfM443UrxyFm8V36VlvskyPqij1dZs/dR56Oda7Zldcf9OoWar
	 Gl3tt+S9cejTMTu+Sqv0mrRrjgrPd/oJODu2OAzG+bXzmKc4TwWRKmzAD8Bw+5cgzX6YT
	 S79NmVgVil6VeH2Q1Ks2ZNNUhWdzPeY9NjkvE/p1qlUmJM53W2NfpdSjPYfd66n9uIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCc33QkB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6B606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCc33QkB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8461F000C4;
	Tue, 17 Nov 2026 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947569;
	bh=9T6tmltOQQzyyJNh6k13Do+jCluVWuSxZ/WZJJ01p+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCc33QkBicEUYklWeEb7Dw4QILraEUJefMKo4PKGcDXzdUfPFConEbNJ5soCPApUl
	 WRu1jNRbp3HohPoK5kECAx4CZkaIi1yzgZkqUQ3iPDY2+Kp3ofkcuZHQuNGpp+nlJP
	 qSdu7NztmT/bNXgucVVZlWeTqF/WIjEYemCJ+orBzhmrapdtO+oAAg9gNUFBpOuBjw
	 7UBwAh72UvEBBWfwqt/No1kt5wLJDhPg15ws89lBKvkJXykj2O8Wi7bVo9wOyDEZj8
	 NIm6CB1IcggGwV3CTs8l6zfH4Uxmf15jkYgPwCdcO9qMALMY3rr0eO0qKvnZMEBZ7R
	 h4hKWT8HgTNJw==
Message-ID: <sashiko-outbox-219619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] HID: ft260: add serial driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-2-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-2-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:32:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Christina Quast <contact@christina-quast.de>
>=20
> Add a TTY serial interface (/dev/ttyFTx) for FT260 USB HID devices,
> providing baud rate configuration, data transfer, and termios settings
> without requiring userspace HID report formatting.
>=20
> The FT260 exposes I2C and UART through separate HID interfaces. Only
> I2C was supported previously; UART required FTDI hidraw example code.
>=20
> This is the v4 patch:
> https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-qua=
st.de/
>=20
> The follow-up v5 series stalled without being applied:
> https://lore.kernel.org/linux-input/20240216-ft260_review5-v5-1-36db44673=
ac7@christina-quast.de/
>=20
> [ ... ]
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> Co-developed-by: Daniel Beer <daniel.beer@igorinstitute.com>
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> Co-developed-by: Michael Zaidman <michael.zaidman@gmail.com>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D1

