Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946424;
	b=jbtMIoUFGRIQKxSFYjz+ON18CsvfvZ9LNrzy8LSBpnVnMouJWvf9WVrEc+Ry+D+wc+Xc
	 eazClSga3IUDxZ408VEFeQCDVZGY/Sid+qUXyoo25lnFmFjWJoL+4rKcE4SJT0IjIF+Hf
	 D3FoVKA3J9FchQ/k05E6bUyvPuaFi/HjJnOvMau0BFFWgk45J1xtelrOIXc0eVoM9l2hI
	 +5+I2pcQU/ohHTD7ZmJt2ZhILGbQqIi+Tn9eitTy/aUWJxYvO69KXiomSwktiAhgsfyrm
	 eo6lcDij/QluY9l+kYv7Wug3CGSouV7DHCuXIpnGPe9TMKk/enl+D6qiFuPfnz5rPcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XwqJ/1kZAs3yaDxc+GoSYSLlFkyamC3vajB04r7aS90=;
	b=ZuKvDkgoo7EMdbNQBA5ayXaDkxCupk6XFmsgZxBZdtHG3/bOqtcILIEymDqO+vFSM+jC
	 JaONopvVnss1kIL1jsonCKUSq52QVHpWxPNygQbZYIUoNY64PoTp4vIv/VIfvpssug+UA
	 o6Pj5IRuZSG7l6qXTL65JYypfCwwP06ryl5bYQBx40fQelGZuf6vpSM9EXyvED8FSeXbS
	 EhqOP14jQM3jvu32+xO2qa51G+tsWMTH53RVaTtZOCe22kokovqlGXtTaxdmSxRR63+uo
	 lAPqAsYAuMUN1Kg7fBD5rhJoxUxpRLy16BqqPYwK1r8NbEWlbxqEtFEFptcHY4MCEhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhT7UK8O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDD606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhT7UK8O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1707F1F000C4;
	Tue, 17 Nov 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946423;
	bh=XwqJ/1kZAs3yaDxc+GoSYSLlFkyamC3vajB04r7aS90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhT7UK8OUqJGzvej9RPKbjqeZi3zK9/OPl1H/JS9GENWH+XQXqcxujyenmiGx34ac
	 24Xd2YVtz/fvm8tthwV7lz9z7z1ye0DrVWrmXrYxNgvPQ5iFpflWAybU+eL0aXBk2k
	 1OSCjUGOdZ7KPF+MrDMt6yNyQ1omWv6XuSZOsr9nQ7J/Ub3rZw/9j5W0yO2tu2wyNY
	 hiigGyRDp+6jkqrHeuCuT1kvMJFBK5KUc+EJwNOj9wusAgheulLY7YxSZnFTVwFMs8
	 2qwRUh9TFnYsw1MqS3o/XLZlXayuv+3Ir42NL9beO56vJG9XzSveZAzNyluy56pZcG
	 +wcfKwdIpiYYw==
Message-ID: <sashiko-outbox-219578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] HID: ft260: i2c: reduce bus-error message
 severity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-7-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-7-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:13:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver logged errors when the FT260 reported an I2C bus error or
> when ft260_i2c_write / ft260_smbus_write failed after such a status.
> That was meant to flag unexpected failures, but bus scans (i2cdetect,
> HWMON discovery, transceiver monitoring, and similar) hit missing
> devices routinely and should not fill dmesg with lines such as:
>=20
>   ft260 0003:0403:6030.0001: ft260_i2c_write: failed with -5
>=20
> Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
> ft260_hid_output_report_check_status for actual HID/USB transport
> failures, which are genuine errors.
>=20
> Drop the extra __func__ from the write-path ft260_dbg calls; the helper
> already prints the function name.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D6

