Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770780;
	b=hv50j+Xw5DbYMbmyoFGKS/5Aw41QuVAaLaencXECS0RGp4ZGcbM+tOFTpq8GmFhLNSyv
	 Haq1e0b/4BoNSZUYy5uAM4fADz+YJn2NgyL6PbB/wIpaE75mYomEB92RNU0WNXNq+K/7M
	 +ivfDdt2uWDJEimlHGHZYbbH0LxbfS31XGQhCOVLwFRZIA0wtU9zijFsaB+OuoNl40kOf
	 B1/6w8VJwtg+VfF3GN1Jk0j6X5BYdgFYZM3HSMlvLIrf5DLvYR36m/rVQB4fLgXdZJl0O
	 k6qptMWkjw7DgBQCMspQcfvYfTUISWW8Akp9Ko1GomdawBy2MMxfvNu8QyNxrqTHtpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f5o7X4fxB23ALa8QVU1p/bEnDNLqxhIQ2MO6MYFZMrE=;
	b=1V3bpaxrX3uVxrwYTmY/QSWPeTlUAME5y6v8KsJKqW761TkwrWbBTjpKWJIgm/YlP7qR
	 /E93yq5GJTj5HarlQXVl2yT33ge3IXQENY57NHW3CQv1Yu3CMKagaWXdTehGNChg0pOi1
	 EdKe7Ro/i18EQUaIbfkuAkNchO5aultLl0uPvqkZsARbcTKacLQwMcCFZ/oXSh34qixjR
	 3cjcnamd0a6qYOJZpS0PCiqItBlf9L1uIHuLSakG30FBSWKAVdjLnCb1vZMiz5Oj83zwe
	 B8L0vHPLHMKxQtr8V5icZV9cYo+wgwYu0uwHG57zT2EuFhTz7WZaUBuWRojRuy3MnWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbGZf2FW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0C606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbGZf2FW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511091F01825;
	Fri, 23 Oct 2026 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792770779;
	bh=f5o7X4fxB23ALa8QVU1p/bEnDNLqxhIQ2MO6MYFZMrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbGZf2FWRAOUGjfZ9eqtiQhMJRCtvCpgukXO6Aqp/oiI6RnBsa/AwC0ii8ZfrsGVj
	 p8D6zA442k6PWTcMTInMp6zPrH2h4YSnaabRbtm00cprPHj5sCdTwxBjoZrGG9DqPK
	 2/eL39ftvXD4AeM2XTr8POG+byAbtgGRN6/Ec4iH06qz3vdqXcEWn2ukqLgBleZOIt
	 N7FWgCjZcrDjRCOj9UNW7klwPFW0ElXW17SQxpnBJboB9w9gr5+44R/fwNoxqR0CZT
	 jDzj4XVJ7M2HptBBt9d/LBIcCPxzKElhbkkQGTcOgbv8gHgfZmeY+55HtDlDIDva6U
	 YjxqIpnW5wQcA==
Message-ID: <sashiko-outbox-182930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250: calculate TX length before preparing
 DMA flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
References: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 15:52:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Renesas RZ/N1 preparation hook programs the UART DMA block size from
> dma->tx_size. The generic TX path calls that hook before calculating the
> length of the new transfer, so it programs zero on the first transfer and
> the previous length on subsequent transfers.
>=20
> Calculate the scatterlist length before calling the preparation hook so
> the UART flow controller and DMA descriptor use the same transfer size.
>=20
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com?part=3D1

