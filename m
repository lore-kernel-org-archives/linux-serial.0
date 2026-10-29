Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313638;
	b=3FKZaJ3KqYo5IEAcdVB0ZHlgpbviUoZndJxcBofYskMaGBlBCC+IQ1x0blsA3Zqdcu9O
	 E/rElheOJ4cwgnjpacQRbCF/RCImFvTcDP4InzD+pNnWsEu/kU9HTUv4mM2ffxwZwPxOI
	 nU73vGZmG1mVplmZZhNjT1hmLTkUmSjC3hPXlacjKZAwBNEHlK/9n1dvLpPCAS7Kr5eE3
	 imkpjz8Vymd308n4NTL73WAe19QVJTG4WrOtxDcWqTDR8lFBBEvGeH+WXjVlK4rWcipRW
	 KIDA57jgfzNWtmuRKSRk37M7Ibkd18Hk0zwOaBxnxbUrVUb6pb1KPwOnDZtf9qfXGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313638;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wwd63d+rTAq0RvcOl054PLdp7GEVO5l1OsjxyPfRjaQ=;
	b=ItWfnN8kOfDzvg/s+HHPy2njc8bscd9X8uaUtOfLpjvJ6d5Y1arHFQ2IvYOyN81Wh1W4
	 Wew1VtGNGnapPSBYXmZ9Jc0SYMDrvURtr/RPIMOzlmXaYOjiewgZZjQxfxlD0Xbbazpfw
	 IeAzQlxyxMKl6mXIO/BnnuMZTwuQe/z8rXPdiRXCrcKjjifKiQyQ6iKbEfxwz+xW6yNmq
	 OCAWuIYAIIJ/vCzX1ApI0LoEEXbEsUyvghHk8gjsbJI9LOx5L8cZEKR+DRyKBWdCn35tP
	 ncD2a52k51osgGD6kY/or3y4xFPLBvyful1bVowkgKQIdxgYCb5MkzZpl6VCNAyVe4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZR2SM4yc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661E606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZR2SM4yc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ACA1F01816;
	Thu, 29 Oct 2026 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313637;
	bh=wwd63d+rTAq0RvcOl054PLdp7GEVO5l1OsjxyPfRjaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZR2SM4ycx+sIMK3WgxJ/ykbL9hMm/VIxKxU33mNzLcLT4UIyjkKPG86I+8kCyQEeX
	 VBhg4KReQ5SolTcMYHu5l7KZxYWlRQkxTHQ+us2xeCdV4kdCVGRIgapisJXGquStU/
	 wtpJeOn1kiju+jgDXEtMgdKinW9QAjKFBGcFyx8DqQW+p6UAW0Kbr60V4Kq3SOvb63
	 4T13XeF05cDfUHEkV+j+uSZYYW3XN0jitI6AD+lZ+mjVlFvXDyhxIl0IgeyhwqJDTK
	 gqlg2MN1AMiRX1BeMzVJDb+gGdDBzTMfSiYiJ7oyV/ch6NNYmZhl6KbMtY54j+ePgs
	 T4AiXUQGltH8g==
Message-ID: <sashiko-outbox-190092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] dmaengine: dw: drain the tasklet before
 releasing channel resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:40:36 +0000
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
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D5

