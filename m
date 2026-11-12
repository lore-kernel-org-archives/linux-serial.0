Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443563;
	b=mQrZWs6HJ4camKcw8G4ZnAi00fJSYfwDyWbQW9e7XZ6X/RRT5TFMXaE2UOa5WjU1tYI+
	 +/3OCR1dWoLcsN8AptQu1RAzsL0dLXMFsnWRC121lPryHpPV06521dhI/fZN29dbfnP10
	 1rDdiwzgdczcD7D4J7vpR3bqPovcWcQPgV9Fcq5JWWePFf4XT0CvayaSniukREa5UzqmA
	 FErXvKz0raCFjHmDMiqdizAX4waYb9strOLWe1SXbz7T59NfU6ryZtfbmTtQ5BSbPPYvP
	 CkmJ+9rMqBl6pE/cwf3m19vN9G89+/mU7QBr57u/d7wDzb4PjkQfx7Utc7EiaQWCnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZRBbcWOveZR1OW1FA8QwKkdoaYWhbFMDqc/6d2mS8mQ=;
	b=OTuXuhNJ9c1nakjv/NcKnpdt1J9nbs38oDp2cvuy40bAziINX2o+6RXSNMVK2gvzh0H/
	 Yfdqgg/djCRs/ibubYbEz60WqhMzKMOEA0keOHMVMxH5Vsa/R7K2RIiJlGOp/0Fs8Q3X5
	 Ckn+RuaYoVbKZmADgCaiwa7ffCuXEmH6CmqNj1E/+IkhyugIBIRUSjT6/O/mn390ScU3D
	 BuXoCkA9YjXuIdL6ZXCs+WYBWk4nXtXQRVHIEvxat0oPcrctMm/V4v7g8fe7qwiPv/A/x
	 wCA6gV1RWunCoup8iqGUzL+2mQlX+i8F5FR6UHkPW4lGNfVjmN0qe//QvnMkDmXIOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cyDsAA/o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46614606A321
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyDsAA/o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60591F00A05;
	Thu, 12 Nov 2026 00:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443562;
	bh=ZRBbcWOveZR1OW1FA8QwKkdoaYWhbFMDqc/6d2mS8mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyDsAA/oYbOtRpujmJitV6UEbTHeY9ea5sIoQLQXuR0KBLIWDp1nZ/4jjD/qyuFTD
	 4PZ4bbVGH8bR75tsDkKnspOC3xk+4s7x68yDveugN373hPrxmNQHbb0nNmdFNX0y3F
	 CuUaq7tA+3TBUGWmYWYnVWUQphElOs62GC7gkgpTrrZDPWkk8qk2i7dPO8rJHukxw1
	 gcZc+itoiLOCun1zLERjlgA3HN7Q6BO+Keo7EI+gSEN2/3xak9Jg6jf6L7aLS8l+Lg
	 w8dQX+sO95b1Z6aJUwdC2ornmq4/7wJKOsK84ijIv1CtnerNcWUV8293MNlcmc+git
	 nCmJxm/l/eiRg==
Message-ID: <sashiko-outbox-209955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-3-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-3-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:32:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D3

