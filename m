Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202508;
	b=PDfvRoUMVFfU8Fw3ql01bj0oi+hC9XCyQnRKbRr92dyxBY8R2hBpDYj87D0M+LOnYWNG
	 s+3LSjUCh9/M33Lq349upzIKBfptx/gwoT1DddAgDeZH8HXHqFyjkEc3bBvo9tlhxw/8e
	 T+D0670c7IQgHLlRu7YyshlWcdZmAaydryGV+afrFmmqM8qMIhQ4PMpWNRBhfcxi0hZV1
	 fpnjcGdG105mSvahbWZgzbv6WYZhjJzF/GCLxir3MzlIN1E6JW8bdCXAV3e0R0xZwAm8q
	 RmhQ+q6ac+9TqRJkDbS1bfdKu5qvvhWXosvbYxk4neebL9uuc3DkJRQGBcEn6HS3J2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GByHNmjLYtL+Tcyktco4we7ojhF+/eSdjqo90leRCFs=;
	b=rr/y43ZsJKjdZEW3BSeJYGYWk7r0idDHhpHJUKsxA6XoRAIacASF0N46cTwAX2SG4Ye9
	 VcU1ZrkYn9+zb6fcVyVOJCLzn2nSWdSoG5zd/n9fzy4GWNaRfFqwkuyM9LJbSZaf3i+E8
	 sTIIk5dPeXC2qDAgO76fuR56P/RMg1j5Tfi06fMkgbzAhePECL1Mq8q+IDkfTLUCf0pPe
	 iMWB5o7GVoPxxGDo0IyAdfz1a/i75oFwTE6uHQTMvqU5orUHX2gavAjmMmpzdPHDIBQ7E
	 aoJHdewqiNkvDUDnZnOb3PJnaRGtBPKI7UYrZi+A/udpEQYj0Ft4Z0il4zR+nsBylQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaLK9UW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFC606A6D5
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaLK9UW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9211F0156F;
	Fri, 20 Nov 2026 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202508;
	bh=GByHNmjLYtL+Tcyktco4we7ojhF+/eSdjqo90leRCFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaLK9UW+Wczf5MQVYz6LAlxxKc9q3TS2o73xhqppoBbDnfjPWXo7Nh2oKZfoZhbmL
	 Jy+4Rbh17pqlEspJt2rzeqJ20l9iccBU/Jym3uh9YokvxmhburiDhktRUidzXI4RnQ
	 PNfqNuh1MSyZzr6falWQaXPW/wvIu8DdloRlGvEM/v1EDxlQ2h0X2sfNk9mnkLOVR7
	 cJi2NceeRecOQgSNkfT/NQNxFGB+wbvKrgcLwFpfZWZ/nw6JBUMiGWKclOZTKuXMPv
	 r2frvDX6u5SZfxBuoph0T+qjTQ9TN+udVMonWRBA5+E9WshTaCB3HiMQHz8DRLfdDE
	 pnzPZI3rRLMCQ==
Message-ID: <sashiko-outbox-225918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] riscv: defconfig: enable A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-12-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-12-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:21:47 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Enable the A210 pinctrl and mailbox drivers, SCMI and the SCMI clock
> driver. The SCMI mailbox transport and reset driver follow SCMI by
> default.
>=20
> The A210 has 10 UARTs. With the default of 4, UARTs beyond the 4th
> don't get a fixed ttyS index and end up in whatever slot is free. Set
> SERIAL_8250_NR_UARTS and SERIAL_8250_RUNTIME_UARTS to 10 to keep the
> index stable.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D12

