Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308504;
	b=VH54KvdYz+72wuPMCgCYVhKwaHOVnS016Ja927rXW348wASKeMVH6JRw/SFCuxg38121
	 94bCwv/Ch7mtaLls6T168t/8S6Hn7mr1u1QW/zjDAg4iSDneMJku0yq+nPUTru3FCgxN5
	 AvFY8RxIKxc6N3vt3tWpRb9D3Az9bGlZBrRintQRfSLLewY1hjZsZGrgJrcagXMi3MHcq
	 0S8S9xUlpPOYSAqM098YJM24/R445n8PiKGM3C3k0dWw2UjNHWmVqzklGESIIasOykda+
	 +hI+6I8S7ZbWXtUGHdrPxhwMqteYyW5cUlNme3e98uMb1UlEyjlQh1lQ3rEERUsTbOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wbFZRsPvg6UCeNUS4tqx+qGJrT4Nt/iG5AHSi8UbBEk=;
	b=b+UB6uyet8lHxPkbuUXAz3qcYgRuthdzv8ZdJ7/1c4CkfS4yKyahEklUtaRYgRpTnEiB
	 vGczEu0RenDCCzqobIfWOuazrMK0CXY0L91NGus2lqdEZ88R0prKc+zTjkibKD3koVKwU
	 mF9k5enoFOr8g8GdTB5UAjBGmvcr8KbDckqIjoyzDHh1q5FBXNFfjDuDL7lLY0fwGc/O9
	 ZRiTXUDnuiuhsoQh3elpZxsxY7A4aBXLHaXxunNmjAzJelU84qcWBsYvqVGAQdD24C/wt
	 ZxjNdfiJv8671MeEPB4rRLqOsvAFoVGsckGIC25OVPxUBx4agLflCvhT7eVRnWflxIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzcn580l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06680606A32A
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzcn580l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F381F0089F;
	Tue, 10 Nov 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308503;
	bh=wbFZRsPvg6UCeNUS4tqx+qGJrT4Nt/iG5AHSi8UbBEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fzcn580lc7xIAHD0f9bReR4hN/1F0cbNyX8TIwdaoxGpGtdlMWm4ph0fzRKynDDMl
	 EvsCwmAjala/QxzQZNGuRtLlNS7N3hM+T3vtLxgidL9hfQ49jNNedvAJ/+yF9x7xNo
	 qsk5XL6MB25Pkt4+LgBTS+Cq6wSzf0nhZTOL3S7m2jDRX0G/PthjUobndMZ34uoUGJ
	 UKfcHVRGO9DJW/SP6lEP2rXAaZjIDoagFF4MxaMcFk4BVpquvpqI+yHpR27M4d6aGW
	 Q/x3Y84G8hVAZiLR5iWI677roDFIKYMBpR2nRLOYOQmGN8cGWrWFKU+KXP6L0D2aCW
	 koJ2Hof2o64ng==
Message-ID: <sashiko-outbox-206910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: imx: return error when clk_per fails in
 imx_uart_poll_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261110105456.1563-1-gubin@cmss.chinamobile.com>
References: <20261110105456.1563-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:01:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> In imx_uart_poll_init(), when clk_prepare_enable(sport->clk_per) fails
> the error branch only disables the previously enabled clk_ipg and then
> falls through: the function keeps programming the UART (imx_uart_setup_uf=
cr
> and the register writes below) with both clocks disabled and eventually
> returns 0, reporting success for a port that never came up.
>=20
> The sibling imx_uart_startup() handles the same situation by returning
> the error after the rollback.
>=20
> Return the error after rolling back clk_ipg, matching
> imx_uart_startup().
>=20
> Fixes: 6b8bdad96164 ("serial: imx: add imx_poll_init()")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110105456.1563=
-1-gubin@cmss.chinamobile.com?part=3D1

