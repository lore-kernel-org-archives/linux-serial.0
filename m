Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262243;
	b=qvU85iJMs/rYf+xGb28pywkU676YhIoPhI0wbTaBRtaDOr3xQf3uRhmkJue1bmrcUUzG
	 fqNxgIIUOsNhyNUk1MTCdMoVL90+MPSM95EaztNgYPzor9gmeSsDFgsLuHTV4QHSIUTQd
	 CDr1WOOFa04AqDS7jkPw5tFbrFYPgWd0VRmcbh7Degoz0pkX5qn0faCIyMyNxopiZdCqw
	 YOkidIyfP9c3lw3H6UV3wACwNEEb8vT7dyS0w5T7pihVi6XDXfgvU5blGOtZryROXzvOA
	 0UqVW4sigj2i3ifRG9tneDvOw+4q7LfQ3eO4DpXEDqxqNbVPg0lHInfrK4Ir6ysHmEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XoUyAMixz7DHGWfNIApkw+orQbVsL0/3G3TDbj7pUjE=;
	b=dp3eEvUhep2Yn5hSeqPTLox6QXtEy+tkAoM1/m1jEhyQpy5dE0RbltJQuw2yLCNoTpCV
	 r/JqAW2mvmq9ExlJBNw0hTmVsWedMsRqW1GZmwhpUUGIZnpM8SMQEdUIvFXryPesOiOY8
	 JosVKGNLcZtCDlfUcN7IRqE89PUuKJvk2XDMpD+XiDgL0YM4nIeL8iZeznBAsSQkKID/j
	 s508/FMeHASwA4zVmeWd+eSMgDlDlFyVpq3mewBzzJwrwgFo88EUOCQqqOjmjhEQ0t2Zx
	 1P2d+WFqjrt+EXhOiXmrV6ZEQZ8LuQxhBMS/L05QXqE0nOUmmcr86t3Dwm2QgtQKgnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEMnKdGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA2606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEMnKdGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963551F008A1;
	Mon,  9 Nov 2026 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262242;
	bh=XoUyAMixz7DHGWfNIApkw+orQbVsL0/3G3TDbj7pUjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEMnKdGjO1MInffzYAlerY8pOUp/orryRwOtoHvWYIH5YVptxcKsHYQD+dqkBgzPJ
	 cKT9LBxWRJKstpvYEtuNpNzE38+il5s9iQEEgruylTbFVjquIP/S8OdTrqxZk1VQSc
	 qa7vLq122ffakmmw1MwFfE5ln9IuTEq9NTlcHKr9N8J0x7/MzRJPhFfB/OGIfBL7AT
	 P+ervlS9stl+bPu4ETA/izQCxmwE5b+fQmJiAnB/mCD4ClJLLMCkjV6T9ttyT1f1DB
	 ++0q2s9xysIpuKd2kgkVtAmV+4A5sY2jd2bq/f+r8WDT2vwPwTHz1uoQDiLFwVJDl1
	 oalj9D/W8EnOA==
Message-ID: <sashiko-outbox-205703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: 8250: add Microchip
 Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261110-core16550-rs485-v3-1-4294334243fa@spacemachines.com>
References: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
 <20261110-core16550-rs485-v3-1-4294334243fa@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:10:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kohei Otsuka <kohei@spacemachines.com>
>=20
> Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> including the fabric of PolarFire SoC. Its registers follow the 16550A,
> but it raises no interrupt on TEMT. A driver that knows only ns16550a
> waits for one in software RS-485 mode (em485), so RTS stays asserted
> after the first frame and the port stops receiving. ns16550a is
> therefore not a valid fallback.
>=20
> Add microchip,core16550-rtl-v3 as a compatible of its own. As for
> Microchip's other FPGA fabric cores, the -rtl-v3 suffix is the major
> RTL version of the IP, Core16550 3.x.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-core16550-=
rs485-v3-0-4294334243fa@spacemachines.com?part=3D1

