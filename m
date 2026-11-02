Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649081;
	b=L9t93jVg3J6+vgMNvQgvYNIr9A+/EnGKznn1DIHgceWmk3j6HDCBkXvdXUL7sLDTJ7Qs
	 asUo1mN63ESHQ3F3RGbxdVq2YKncX3CsJcfGXKwSpt6eC9bgjBQjn1fXD9pA/H1utVOgv
	 cwruOzobxfahJxKYDdFmHRU/yBBZvVqOo19sfY/fChEWuaufkx+mtWCaH6XrFOqQP3p5O
	 3IwCTlxh6K5lWtWDCExjRvNM8pHjfO8NJ28y6Wthh4mj83Gud2pqn9kCZdRiCuGhtolAi
	 I78Af3ebXrhzH3dIoE2zkrpeiyOQM/PxOoxtYVtaogBfx/7K197uAmRZSB6hfr3a8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FPJhkAlQTPW1DH6FYmQZMN+jrtPORFxZr0eQdm16iUM=;
	b=nAJDLoovY9CU+bA9yNMVYcYNm6Ce83eMjCbfqtdUihk8yNRoA5CGfcYnpcDZP0dupF+g
	 BqFJZaSwVnbfAjehSlTEZUsBwCzrl3dXwca5DJDo6N5faejIeYBUN0DmjBEBL5NnUHXs7
	 0w+nivl9Vam0crms1Bj/8pn+QveQqfdOYm7ljGBlPUTKdXVm+6NFCQCVb8405+NZ5/920
	 2tWC0/0cYW1XwlksQsDEsMGWuMhdF45LMLbTGSImpkpiEz1FURc7BFmBNRiK1mBQb6r9W
	 4bmzsF2QYlNKknsb8WsHZo/h12+b1i04qMw4q4G5+84cY/KLStrw2M2Y9oFMwMMST7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVUb6aTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E85606A330
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVUb6aTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E091F00A16;
	Mon,  2 Nov 2026 19:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649080;
	bh=FPJhkAlQTPW1DH6FYmQZMN+jrtPORFxZr0eQdm16iUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVUb6aTTaL0s41efSMAhVG5PZ51nZrmmiOEhGSkPGPlrvg4KDMRdBIzRb4zAF6FvK
	 VJgZ6rvbn2Z5V6Pmn7FYLXOkehNAvVgGSjt+9Wc0Z1PRRpvCLPI843VZ7pnIGwd6JK
	 Ro9qlVm0lGH/n9y9ubrH9j6iF0MoHYhU8iMmej5cknzt8T3S5jVwEgFxWX7kkH1adm
	 sEGed+IGoNAojS03rxH564P5aSaxdOek43TrAb916q5MZmiJdl6dKkBvvQJAZVKxpJ
	 H21BWm2QNFC2BD+fhXU/PCth5aAj46UXQKi/LOa0oYW+EMUMCsU4eN8zktjG4Sdsm7
	 0bS+FbBEWlLng==
Message-ID: <sashiko-outbox-194027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] dmaengine: dw: drain the tasklet before
 releasing channel resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-8-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-8-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:51:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet invokes callbacks after dropping the channel lock.
> Releasing a channel can therefore clear its configuration and disable the
> controller while that tasklet run is still using them.
>=20
> Disable the tasklet before clearing channel resources and re-enable it
> after updating the controller's in-use mask. This waits for an executing
> run while preserving pending schedules for the other channels. Have a
> pending run return before accessing registers when the last channel has
> already been released.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D8

