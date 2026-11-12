Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442629;
	b=a8UnMquxV1+RjT+GriHqMyZwmYhFzbeka5tNakKXc68sz96+hx4/aNwkuoiAm4xtKfo9
	 0hL4afuxUvfC+HTGLjzCpg5wwudX75GbFIzzLVh6rA2mPK1Vr2dP2W9JGhB1MnDqydXdg
	 LeoBugH0xJOOuY2ySUN3+Zz+jv4Oz1+58dZSaIuATnuQMp0OSBR/0uExyStpRUHqCrt77
	 z/Dnv31KsKRO+Utzq1TsCnIHjoDKj8viKW1de2iJ+WHepotTKHkKu5P4zRf1a/pI4KjOl
	 hsICwI+oauMMrpBmMxiKxcfep95pTme6QfCGXvZdM8qcBRBsVT8jm9oZ8OM47knsq1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YsRmK/dJl1yPxP+nrzLvPm3LvTCUwb/yeH2cLF10F70=;
	b=GcWNwPsQE8VsEjoawCU/1jVB8WrXhW7eqgBjaeDxA4nORw/EeMBi30ZjK9sdrdJqQq7O
	 I86Sy4RI0VzknCwDYFMXvfxDwBCE/DvKDWzzMyzON86vRYOdewODWEAxEtJyB73IhkJJn
	 RBwimdascUld+XoiA1I7lVojqSBpxq8qGGD0Vu1CtYP/v+5lBKGIHm/MppnhMYJ2Tethw
	 EDSODJRFjDqATblRLOAhGnWp1utqYUwJvsGyh2s3FwAaz7tmMIOHrrCGiIdiGBbLkKhn9
	 SvUfa3ZxOS5AuDnzO2ZroVMfZMs1dTpH1027SH5lni6de+QDGigd75F6TMmta2hhe0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyu++5K2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A04606A32A
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyu++5K2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5351F00A05;
	Thu, 12 Nov 2026 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442628;
	bh=YsRmK/dJl1yPxP+nrzLvPm3LvTCUwb/yeH2cLF10F70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gyu++5K2nsmVa0CpO7gUxtJkkOOUeaWH0sIpIj5ie8Qozqxnw/UlcT5X6joy5tEXl
	 tOA0w61Z0L6tG3b2xfWNh7p+ga6ZTxKVe2L+OWtPrWRmQbrGMXj0fqFLOo+0VfWCcr
	 v8HWMQTDfDr62W1rtrk0i8BZSyDS7KL3NMiWmwjbKqBw5oH61LUjGuzAPskc8I0d9X
	 GLeisMlon337kVKPcRTLNER2n1KtGpjoHQ+nNiKcBV0jUMfuMpqKLoGW7U/p7TpDJs
	 SeGGRW8T08HszrGSaLCbyTAH9ZDWWqHYHrFPrrU2b6PlBcX8B44Tey40hGx09H9hO8
	 sWiKP2OEpJGrA==
Message-ID: <sashiko-outbox-209893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-1-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
 <20261111-submit-serial-8250-dma-cancel-v1-v12-1-9e3456bc2555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:17:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-submit-ser=
ial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com?part=3D1

