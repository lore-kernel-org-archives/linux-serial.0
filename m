Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650170;
	b=DtzFVP+WjlMWTg5InhXtCbZ2DVlOcKU/6OOKowv7ATneZhgxxamVz9Zj49qd3G6lKRLL
	 DC1l+sr3E8exP0smZRwpd+n6Hjx3eefPWXQ8hHY59WWNnRQoMnbQLyis15hNDU3dcUWb/
	 fo7vL21CFP7EsF52awnpKSHOtkQyUpuUQ0icuMySGR7T53BrkQedZmmQh/5HJzxbwZhRa
	 e3Ro938WC328W2dxxc9PBac/Vg3TYwEuY7u018qBcSMMCgPh4LRzmP3qzNN6HZPiKPs6/
	 o9P7eNeJjM4MLMbbPyggVU7CAFPapy4F89f2eBc/BBcpDXPd4qUj3GiD14zY3QXHngg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ura6KqchYkHJ6gJqwrwFEfkL2t1CS90L9Xh4NNbGC9I=;
	b=pz1BIdtzWInH4md+RgdCb1/4IOoavu2cYoufOLU4XnO6EfChhj0S51rIebqoZb796c71
	 SmlON9DK1ntLoyKacnnhYtCz4vs3O21o6tStmrOQk7joxLHRD0zcp2NTovn9BbpFBODXt
	 OSlgiP82QwRFliHZYACpsQggZvMsP/ZZkDLQBV6DxWx6fR3d6Da6ChMt8dAx+e3zgSqGI
	 9yUpYUtyJKxX58kuxDaxji88W2+Nwqs7Dk2M4bMpn3eQ6YPiL9Ta0dwf5h3Pbo09XHCyO
	 MR0aVFfo1QjhXsV965jweVTO2mtKkOGttnNzOXuZguJ6XDXWSvUxRLlmTCjlZ0mEOgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVZJhE8Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612B606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVZJhE8Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EFC1F00A16;
	Mon,  2 Nov 2026 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650170;
	bh=Ura6KqchYkHJ6gJqwrwFEfkL2t1CS90L9Xh4NNbGC9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aVZJhE8YESVus1OyJ/PzOkC8VRcwc0jvWmgFZUwPNf/0bJtKizPS75YKA35wL7g9P
	 SxB+QGmQ44yZRSDHvrRiosYZ1TkuHt84WrWHfafAIh3VAKQ/pCg//N+z/SkrZDNmuV
	 zD3xeWxQ1cG2xJYoj5Mqpaz9T9ocPS70+JPQ1QMDA3XA5UGQjzaYAgGkxBGOFhRNIW
	 jyoX0lJHkgw+rHtaeVZcdC0g7SoqeXiK6iuxylV2fUTtv/sR2klJPWpPodIurnjLPJ
	 5RctY4ic8rxWRe5i71nJkMBk/xp42zwGf4vKfnfdhSFm6P3b/38PwCn564AUvFs8U6
	 sgjsjNWwU+Log==
Message-ID: <sashiko-outbox-194071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 16/17] riscv: defconfig: enable A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-16-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-16-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:09:29 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D16

