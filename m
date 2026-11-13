Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564299;
	b=3fz2AViRFD6a6jPgrnYSex42oENM5De9Ohh+D3M2oYO6q7B+5ol0JbfYWWBZrQ+0bai3
	 FDN7Y70hs9aGJ5XNcMAAGygB+4fY/56wSnQ0uEEJDK/yrnOFbHViA26Ddf+kNvwVSvSkZ
	 uM07lpbZAFvF4Ej07VFj6YaGOCg0o+9EQPYCgScVzuEXbhDtd0t6CR8PE/aoj66H12a1n
	 IM8kcwz7/wNGCKPuqXA+0eb3R/EIP/rXhksOiyJLwayZpim4ef1vzfi0EgROhvc8o8Ls6
	 w9R2nAg9X9ZZOqtUcgglBuTjpa4T2HVBWf+dF0oni7Nc9cS/g8UXwxB0svix1TAGoaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NMJENyISmTqhaUuBqj4Y4CV1NQo3v7vV7era9GHBoKI=;
	b=ZQXv5q94fKvilMmI0ZjBPx5is6DgVAJtybQ9uzHiY9+Iy8cAZZo2jCbihNtXZbbW2EsP
	 tPtNEpJmIAkYylrgOsWgMjEHuaw2G8nimBgXGCH2/n0XMW7lpv1+2QfVbS0OUb7CLg7Do
	 dD7FDIPNeaeyjuTsmH2eJPRsG3dnMlF9D+RJ1RqVqgvtH4im6U9dXhjgDolBLz7t+jUSO
	 +1bYZbpz/YtRic2I63vePmAs6DIOZclj/BDUGHIupUfh00jaocDesyneic3kNh2PVbBSq
	 NObnN6l0FNlDDG1FRT9twmjUu5cKYkOKH9UyJMiUMns41qmz9taNC01MY6sTLr7TpPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKwA3seC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB19606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKwA3seC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC801F000C4;
	Fri, 13 Nov 2026 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564298;
	bh=NMJENyISmTqhaUuBqj4Y4CV1NQo3v7vV7era9GHBoKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKwA3seCw6MPUEro51+vXjYsqBRIbNsRZkz2EnVWLxJogxEo+XxzgnHoXKJ2tXl1z
	 rxDKd+3LTSGGzqaFRZifu13vVYxPSH83VQ1TDF1qIkY/ODV/b1skodqNcgSBIWPzX/
	 SDLgr5qwo9WFx4bwrAB0EpQNEdcISQpwnflCrnkDUIP+/uyiSOPkt8o/dVkEhDuLrO
	 3clW0bpxKq/Yei9sQh4kl7Q0QMK0syfgraSct7h3N+mfKke9KzUCZqthK1GOJPnv9K
	 X+hF1aCA50cIoCE1BrSX5EJyC/h21GABz1evvOghIg5PyxA06TIdCVl+lsGSZ9eR97
	 dbuJphChIQZMA==
Message-ID: <sashiko-outbox-212598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-3-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-3-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:04:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D3

