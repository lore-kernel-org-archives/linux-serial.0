Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662335;
	b=WuhndNfAbKRlM6DJMGRIP24U3khWGILJp3w8fsj/67+51cdKuuhUf+rFhXNOA1ptCkvP
	 K6uqYWInwR+z9nopM4b70QP/CkKJUEySO1qj/eMT/ybHxySwi/Ul6utCw9uhYvbvLm89U
	 NSewmt/Ki1JhC8vxwmF6tBsJXZOVuEfAKb/8Ep8kQK/CJ7/VwKRtQoGcfAfWbNC9PPjHe
	 h1AqHYcqGREAO+s+pWYpf9ZMoqN42Z8efAwWlRB5JDTTD9uZfklMFAR1UkfSkrTBNDAbm
	 XvxtBUWTiOZimkzb1L8FX0C2GZTA5i+0ktHwbtnto1Pmz++Mi+9UDOLynUJ+Eqv4j8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q2dmye238AYlOwI7Z4R55rOJ/WXKhUP1OJgrCEvZwr8=;
	b=Ft04a6qTYleY10Zw6FOR7Zkb32hOH4oYz2nuanJdigyR2M1VnAp24+tOkzdRTbJUO77Y
	 YhtGOHOJE2EnXJU/o3DX0CskJKP1jmuX2IQXHYud+oIowy7XYqdwopDG3LQIrYhf7XhjK
	 DmUJGb11miXLBD4nAKO2nuc1gDWMZ5D+qYl16637FOpJzMvN+mFN9L1svqgJ/M/zk4OwE
	 Qpa8MVGTivBXOcH0qwmgeZQBiMRvOQM3rZV4eA8TSqpzcT5kpKPU5fkrCHHcbubzjoaE/
	 Xb+HR6EwALrRzSM9EbGDaOUiMDcXb2qD4ccs8dhntRaNOapNahSPWk9TODNIxck/0Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uy0k2xr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52439606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uy0k2xr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C993C1F00A16;
	Mon,  2 Nov 2026 23:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662334;
	bh=Q2dmye238AYlOwI7Z4R55rOJ/WXKhUP1OJgrCEvZwr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uy0k2xr3xDo3cbnJGjnUBoSO770pyLnMHeSdkIWDt5GDPVQtt2TPbuL8Dmq8Y3PPF
	 ip3lKAvYcQlYuILX4cd+GByQlsJcpfcQQj0ok2v6gNTtZkSaAFR/kRZRS2vXc9aDmD
	 GiaTQQrMJZA2whnSeRAMX02wwAYBF/rywtCLQOCSTjtiNNTTPPadl613GVI1G/icYR
	 kUMRg0hTUY4qNQVdMW62y/m/B5x+/IUK26xlxW/yCstU83ydz/8GoevFdLYp818Gxl
	 vnFdyfq6+cy5tkFyCn9yL7H+WpZzWnXYpbcdKqKRrGjSebQ/3LqVn8cKABDvp6nEGN
	 lOVNDT3khlFxw==
Message-ID: <sashiko-outbox-194335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion
 and flushing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:32:13 +0000
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
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D3

