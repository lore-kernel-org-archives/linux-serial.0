Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913085;
	b=cyEDkPUd+INQIh1xwSyzwrt7hx4YdFz56QL8/JcOkCGF8QRLRafZchxrc09lXW0kRkVh
	 fG3oGwBWAajI9+JCDNCSez1xfOPAVxxEkZNglrfTkbxcesCLL95bzD1+Q7sj/QEYXRECo
	 4DO7flVGwF3DJi9WY5VZnChkIETDfaahOawczcH1ubXGNNBv3d+acLyyG0ejkiYtbYT2k
	 jBtl1lNwtlL3nbIFdxDcmV/QqdPkC7V7HC0+BjbXMJYYq/kVvfAItZsWqolu9A0lHgffc
	 9XhoeNl3KdcXEAjA4DZR24nvk7zDJFT7dRnyOSvoVUsEOjf3RMGu7rnPllfvc2FxTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YBePgjCMjblYDXUSGHGhHDdlsXQBMAF3TB31zKMdiNs=;
	b=tGuNBKlv0kT29sQv4nYhRNClOIX1ReqcjL8CY2oP7iS6cWcXYFVjmYeu80lgrCzqyZ2l
	 8dQDh0iKr+B0sbI/VRQ1I/mXcJljaOo/fzTuly9f4ha0OmwPT+PiTTrahjpoZRQz0WvLE
	 BLIJyxw99Ody8n3rh0S+YK338M47d3QzteD0bKXjGfILUw0CjHPE0Gmw3kuzTD3wzSaxQ
	 m+2OyA5DcEc4XwNS9RgfunYyeUtER1Q3UlcpFaes8qdJacsGJ7Nd7xGZHblZa97eD8BuJ
	 HxwVbYA5/9nfEEz/E5VgiPY7cQ9YXgUsbmmH2TPmGR0znIikdI9hhNKYqrA9dv47uIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViYa8ADX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD3606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViYa8ADX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E5C1F0089F;
	Thu,  5 Nov 2026 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913084;
	bh=YBePgjCMjblYDXUSGHGhHDdlsXQBMAF3TB31zKMdiNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ViYa8ADXzjVEUqfeamSXgJGOV/VZxbZ4vB7bHbWCX8annWad3V9qOKTJCPvwjj9+u
	 Yc34vlHmsYVkWL4Ud9DvFLd848+Vqw6sOjy5O5fgojB0ItN2Ea1jXa1vvhhUg6cgFa
	 YzrHH9NEq7wtQA9wM3c5snMIO3UCZJe5o5qJ6ovLalRHaR0XEnGVvcD63Dz2ViRjp/
	 VtZ+pCOD7w8xXTQEpjeTZivx2U6rDTwgPL8mj6jAcAfYgN3dcZlNRfqlLS9hf11FrO
	 aRcpr7hqASZ7w6hz6GG7xMyz1lq6iarNyTKFW3Q2g0viVUow+y5LmHjJPfOaQ3cb1L
	 Cz7+T6g/2EpVw==
Message-ID: <sashiko-outbox-200199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/11] serial: 8250: expose RX trigger controls for
 custom callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-5-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-5-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:11:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
> set_rxtrig callbacks when present, but the attribute group is registered
> only when the port type has a static receive-trigger table.
>=20
> Allow a port that supplies both callbacks to expose the attribute without
> a static table. This lets integrations such as Octeon provide their
> FIFO-relative thresholds through callbacks while retaining their existing
> port type. Require both callbacks because the attribute is read/write;
> ports with a static table continue to use the existing fallback handlers.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D5

