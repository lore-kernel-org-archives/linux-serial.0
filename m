Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283837;
	b=hwD9ZN55SVRKDvEFdSmhEvrvUAxYibeThAYfRu+3FUTLPYh/GwcJdld/2m0kpocI/FNe
	 WGeyopnjouNit7q7xccrTVfxVzbHjeFexcPgc6byzW1jzfLWUCM718lgRlj6+bxItdKWr
	 6NihG6gIA7hs98xK/CDI/couNlqRfM4DCqAE4FJXwGegApRZHb6b9j8GfzbPwexJmUf3/
	 KyHofmuDnKwvRI9yWOybuzAw/ElSDMQNqqvb7nJTPExs2dRJzT5vQ/0/SofC5JBWBsDJ9
	 TWYEOMXG2bnX0mGoy9yLvY4fhe8i5nPkLMBivL1/PhhbgmZhlUv+zfC+cUHRHNcu2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uXhD4nPq8U9HhbxQ0wsS61esWBQEApjhVMucs/Vuar4=;
	b=lAtYjIiUuB2XJUzgVkTedq7VCV1MOjbtVvQuQ0iZDlwk2MaxDAdUVU/+UkekRNog5OA0
	 KFhcopP/petIeNhnE47Gab9VmzCne09fbX/C7EeUfuVYAswuhceeFKcevwxq2FLV2xhwu
	 2rCbFQtnze40B7zWkhIdtlpB7Fm0YjogDr+ICOg6jgoiPt6GcK20ZNoD7oQ6yYqLN8o85
	 WDog7bMdb0cEUeXC3+Xrmpkt8ol+WcdfHMC9kgOPXEOhIqRIB5sNVdapQsyKFgZVlDrp0
	 /A0ORrrcjPJEL70+FL042pXSlt+2kpN2nvLmWdu7ISHMS0LkmQhHfpWIB47XJwfNkIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ymj6juTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F4606AA00
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ymj6juTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C169C1F008A3;
	Tue, 10 Nov 2026 04:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283836;
	bh=uXhD4nPq8U9HhbxQ0wsS61esWBQEApjhVMucs/Vuar4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ymj6juTXWgXlhES68J54M3O1Iru7FZN+5PtYo8PB0aXN0zLgAY82kxxv1dChSze89
	 Bxwh9itDXIJICk5jNnyjn3Ug4cV4ajZqhcLBoVddZqQaPB0B9MJSYMcjXBjXRTO7PP
	 r3meUJsWH8YzfgtwM42iL6lKr9TIClb+mhC0A0qL0eITZoj9t+QATZnxYhb4eMEwyi
	 9adbuq/PDa5VXYWVQfUN1Hks9EO1viO9Y06ueBg3dhy19HHzRTWvb00UFRTE6MtO3R
	 Ldb9rMQdaQMPxBMYPjQ1W5w8wrxkVeeppaMymYchFm+48WBvVmy0lQeqekMmF7nVfA
	 BdlT9uRvQrg+Q==
Message-ID: <sashiko-outbox-206176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-3-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-3-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:10:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
> completion callback calling it without rx_dma_lock. Shutdown and runtime
> suspend flush RX under rx_dma_lock but without the port lock, allowing
> these paths to overlap the callback's buffer accounting and flip-buffer
> insertion. RX submission and UART interrupt handling also require the
> port lock.
>=20
> Take rx_dma_lock inside the port lock in the completion callback. Hold
> the port lock around the shutdown and runtime-suspend flushes, matching
> the existing interrupt-path lock order. Assert both locks in the common
> completion helper and the port lock at the flush entry point.
>=20
> Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dm=
a_rx_do_complete()")
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D3

