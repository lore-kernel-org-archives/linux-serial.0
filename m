Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698070;
	b=KOI3LlVbMIrBIKHx6Wc9nreumWcoyer4iXUeiPeusU+pHuK3LT732U7HPRXYS5QiUpIs
	 7a1qsLqlX7eA5yS6zYO1/x3EKqgiMq+9ROVzMN7vz+Rx5NIMsFSM/VJ4dt9mdS1qgPUXQ
	 EqzGsdUkaR+lIfUa7kAJHxrattmLOmOZyyZCh4uaz96E3zUPhQjxikF5GVhG2lY+2Pp5D
	 u+o269Gw5nshy4HZDn/efuYc88jZtIV8VHAaNEuc3JlZYjZlBARU6KgkZZMtJ27jYBxsd
	 hotUHh51JTq4OH5MigoqXVDPCXUMPITy+wz3R7qDndPpEhQo9TaM4SM5e//yqy5KouA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8glBSsy6jmIU4FeDZwaF88o9ipVCv5hrc1j+VV2GRog=;
	b=vuXN8AN309OU+HKBRMGr+MgFf6jbv6JYcY0BZh2ZzuqA2GiJPnQfZe82Ht5yAYQwIrsd
	 3zsS2h34gV5ilacDlV3dZA/QrZhBKD15TtbHIW5uL+8vy8v/LlV6FtXBTphpRDsIWmIN7
	 59WOwem1AkUB92aEvKZ3+gMqO3mBUY8407Wc8XJdvPUrOCPA8616nsJhFiT6wEuWg+dqp
	 tOR3D2WUoAjW1XXJzfRE9VAxf/vu6cLBsKYs5HTv4q7ojDkWebJBZIopnzthfKx3fy8Ea
	 /tGhF4krpCLUTNNFtq+16708DyczswByk4iOtrvMgQASFsFajLDGDZhl8xHI/ncnRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onNqSjLI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67327606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onNqSjLI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6E41F000C4;
	Sat, 14 Nov 2026 23:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698069;
	bh=8glBSsy6jmIU4FeDZwaF88o9ipVCv5hrc1j+VV2GRog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onNqSjLIA97+FwEjy+L6SJgrdyCaJ+0t0fYhi/TLASxIiyJzLJhNWPAZxoOjuVggG
	 3JRmW++9Jk5ZE5+dqO5XwI7mKc5s8q4/c6OMKg5FvBSUSa2BdpngM8zaYJ/f2t/8a9
	 Obv7uPLnbBxHrLYfi5uSMIh5KylTlGhDc9VSrkNgX/hFyem9QtK//UVFMMdwYjCPLU
	 MvyenhgNihf1IySTEZmSxEmcR/VRjw3s7I6mqQxOrzHzLuCrfIKhn5QOES+2+KGIBo
	 4g2HHVizMrSdl61ymTvOGtFpibrqvZA7RhTOkiezNze/HUznDwrGw1NCoFfjLk+58F
	 C8LGh2k6qB92g==
Message-ID: <sashiko-outbox-215092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/16] HID: ft260: group sysfs attrs per HID
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-10-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-10-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:14:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Split the single sysfs attribute group into per-interface groups based
> on chip mode (DCNF0/DCNF1):
>=20
> - I2C-only (mode 1): I2C and GPIO attributes on the I2C HID interface
> - Dual mode (0/3): hid_over_i2c_en, i2c_reset and clock on the I2C
>   interface; GPIO and UART attrs on the UART interface
> - UART-only (mode 2): GPIO and UART attrs on the UART interface
>=20
> i2c_enable is GPIO-related too: it switches GPIO0 and GPIO1 between I2C
> and GPIO, and its store updates gpio_en of its own interface. So it is
> on the interface with the gpiochip, the UART interface in modes 0 and 3.
>=20
> i2c_reset is an I2C attribute, so it is only on the I2C interface and
> not in the UART group, which holds the GPIO and UART attributes.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D9

