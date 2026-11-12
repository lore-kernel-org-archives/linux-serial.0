Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454233;
	b=wlKh/bOXNBinfPRsQX49mkyVv1/2LQ8JyglYbWbaihkyw49JJBa6slyON/ZR+cTobcht
	 FsGlGStfzy11PYMAzDe/IelOcoPrVI7bkvY+GoV1cdOrsZRtX/X7Ju0AQ/8zC21caalCM
	 VHuL8P2ON94I1IN92wSCnhtiu6Ib71TMwpttmS+H5jvPw94ioTFHKHqvkED4fMX36xdcB
	 qj9mABFxs2x9KORwhlD0Svks5tGb5G5tQ0otjI0VnJDd8AqqeDv9IxaOGvjstmve1sfe0
	 6aGw2IIA3I85sD3H1RqC8njW3dBnMcN7K/JZ2IJN79p1KatK1cQQ6q/PBIwI4tZxWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hCQLvwwUXzpOqc24e27PA26Nq8Gx6FEEwU3A0P0Gw+0=;
	b=p4CVmc0R55jsrLb0186ZUpRCBdbn8P3hvplyGYuTzHDKr5/xgGQF5mllnt8JHy+Eck0i
	 MF5z+udy29D/7Bps39T3LbxjNEScBGr8yJ6UtjZnSKoELM+e1Dv8EP/oT7Wk1YEwdZfnh
	 IQtZAWKqViRsLOEIqfoQY4rGZ7ieEFQuKQq82SQ5dLTmAENMSe/5mzGPbFpBlqW4pNfxc
	 8p+0kbyCrNGlMSMF/xYFNKO6VPEv2R+GLQzpZ+YB0OEcm+DfQ8jC8g+XBnpZEudfgmN6I
	 v+RU7uhLgsIPGVLxCvsrNj2RzUmQ+bxaEXXIpcTRi6fjuNbwD+diE26tclO0A9CPavw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td2AWsHu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AB606A323
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td2AWsHu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D65B1F00A05;
	Thu, 12 Nov 2026 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454233;
	bh=hCQLvwwUXzpOqc24e27PA26Nq8Gx6FEEwU3A0P0Gw+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Td2AWsHu50rvfwFKgqWTrij7dEo1wVToStGBW9ssy0wvgRMY3Y9q5yWOZ7hMgUXy0
	 G5YN+HR+hdzEp+ZU8slQ70xB8BrytAg3wE5yMEtTbMBlOM8/vhqjqvk0iKU4uuIdcl
	 Xh4DeiXPrOy7MXUjCrPKjbYL5T22aWPtiK8mRPMehMmNknORpnRh91MrSe04QpR+Al
	 ZCEBSfXeiEkWoaSIA42o8rPeANlhZ2KLHWxuLGu4UlKZykK5+zam6b3PYFB9mqp4Ax
	 dyfZtZLKLNpSacWdUHDCnoqphfICzJmriIWAlFmNLGFvIy+nLV0jeXncG1n2OCwxPw
	 jELePFzzRbPkg==
Message-ID: <sashiko-outbox-210279@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: serial: lpuart: Add port lock for registers
 read in lpuart32_set_termios()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
References: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:30:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> lpuart32_set_termios() reads UARTCTRL at function entry without holding
> the port lock. lpuart32_console_write() can run concurrently on another
> CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
> it polls characters out. If the unlocked read in set_termios lands inside
> that window, the stale snapshot is written back, permanently clearing
> RIE. Once lost, no normal code path re-enables them, so the UART stops
> receiving characters and becomes unresponsive.
>=20
> Need to add port lock for the registers read in lpuart32_set_termios() to
> avoid the unlocked snapshot captured. Since neither uart_get_baud_rate()
> nor lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, the register
> reads and bit manipulations could be moved into the existing
> uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
>=20
> Please note that this only fix the normal printk path, in the
> oops_in_progress path of lpuart32_console_write(), when trylock fails,
> RIE is cleared and old_cr restored without the port lock held, there is
> still a risk of stale snapshot, but it's acceptable for the post-oops
> state and the trylock-fail window.
>=20
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interf=
ace support")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-lpuart_por=
t_lock-v2-1-e1d914e52660@nxp.com?part=3D1

