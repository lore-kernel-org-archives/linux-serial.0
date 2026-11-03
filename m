Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745594;
	b=ggEkeG0l6G65LXY0Xj/FZoR2FhiNozqf08AdgUeyyXOEBzTgF2EjWIiw+zxODdpdFlx/
	 WEx7L6x95SeybGvWFbUsraOJGkLuLx0BrLw1pl989ZJRyGeJ6BQRh8FvZuS0/p7Vxj7eD
	 floCGcImCmDtdqZL5YhdkI08WGEfv9WyGcQblrgbd+L/BR1S5dll3C4snJc3zcNtAR7RC
	 3C/lUoIZv9MnEtnf1loAlY/5+nxxEIGSrLRXarJHzbrLDkXdheTevhAzZWJZw2CBsH30X
	 u9WWNHtjwrMKJIWcoRSMTqvRv8KP7aNOwPZUNbeFzCbdpJNmmNlLHnUF/iO03T4iyxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jlSxk+1u8SZuknLLfLVRGgEqF7QY62rRnLl+9Eg61jE=;
	b=2E5IeCYMC312wdTOc7PI+kKwSagY2XmQrWw5/SnQ8LlKglvcz8rS2BjUh1+n3heqn1Qu
	 pAudP5LNPy4f2bShVsAr5naWlVZQOpI9+ikf1Unl+Tkt47oCqpC7gb2n//lEgnspRGykG
	 W6cL69n22u2TKPavfgCVd/TVcRRMV/2+jOoQkKDJ98qdrrfRz2eVEavuVV6bl38o8reYZ
	 bfolYKvysstHdrgfJ6Uf/zKU1uVLbXMdS0MwOXfhXsf9hNRHW4UEpx7zcqi7eyrV7iazh
	 f0gsCGrGwhjRtUwRSSv9lOFvPT5AXagGcxWNEhVSV4vNiAevcJPcVBa4XjLI290Wieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niWAQMi3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26C606A32D
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niWAQMi3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FE61F0093A;
	Tue,  3 Nov 2026 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745594;
	bh=jlSxk+1u8SZuknLLfLVRGgEqF7QY62rRnLl+9Eg61jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niWAQMi3h0eAO9wENPX4rJe9gfWH2NWWJv2m7wLNlWJsKNfUqiWOgFZ+2tNt9ZADA
	 moQmTgCfe7/bn8YY8uDlubZ+nEN/kDCO0zqbdxB3slqmor6wHWv1B1fQNcEdWzAkKT
	 Htrh6IAyDxQFfuwtHbmzGv7jrkSKa2knp8ab7agJ4OdD9stksUIqW/Rt7PjASwOa4F
	 HH6wzyTMOD0qvPM1nbV4xD3ajkZbojSbklLzZ9dVJjaoxspgfVuOg9Jcwc8crLMzgp
	 gMuXUMtSQolBtDP1wxYV115SFpw4lEERopqhVLxrf+dgK00Wf0Sg+x7vL/IfCziK6Y
	 4/cYmLOTlGlwQ==
Message-ID: <sashiko-outbox-196146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-10-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-10-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:39:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> The DMA transfer status getter can invoke a completion callback from
> dwc_scan_descriptors(). An 8250 RX timeout queries that status while
> holding the UART port lock, and its DMA callback takes the same lock:
>=20
>   serial8250_handle_irq()
>     uart_port_lock_irqsave(port)
>     serial8250_rx_dma_flush()
>       dmaengine_tx_status()
>         dwc_scan_descriptors()
>           dwc_descriptor_free()
>             dma_rx_complete()
>               uart_port_lock_irqsave(port)
>=20
> [ ... ]
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: defer notifications while preserving polled completion and cleanu=
p]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D10

