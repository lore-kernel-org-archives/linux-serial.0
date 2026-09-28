Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FD3955E3;
	Mon, 28 Sep 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620904; cv=none; b=oqaudbxnU5LFUth5mkDIJyK16WKIUqHVqmG6/riwZYxziRknQKwKokxMGfhQWqnuVjCjizqre5wig4KWP6JysXvrEw56Y58CSIwOZbG1izJRCSg1DCoii7+TDrvdzz7zfC3oPbbevA9K8blmXDGANdw8dmDk+Y5PW5ZMTXtRLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620904; c=relaxed/simple;
	bh=j4Ir4sBtpZBA7auTn3zHB4/A4ORTxYCQ9F6efBlJJyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIXGH0Yg9gXtIkgV0SplxxJJiQ8iPNYyTAU1WKRfQ58bVHo0i5jtp6iec6QM0J0yo1CjzQFXagrG1/svERJ+tZoEJuaCtLEgrsGK9a4F6fOE5cdrOGynJF+RvGJuwCHAmVZnRpEqeDHZ76p+jz9dISy1JmU3zsH2Jx0PcszX+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVRX8wtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVRX8wtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2811F000FF;
	Mon, 28 Sep 2026 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620903;
	bh=F/WJjW4w72/Rkd6DNKXN8SiItJ0fZ8cv7mjHk8gGvN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVRX8wtc6NgtB5f9jopeiglS+4QhPPi18o0bUlQNaZYj5C6gBjjUpWUCY4y8OzgZY
	 obQW/7h8qYbUZeeT+PlJTewnJJ0WqAr5AALl3TByjuWoiKhMyuMeLkcYwYqWWINCxc
	 czH+kLQbPHYcAMkV/jsowuqjR7vafUg1OFOH1+MZTT8+yA3z5aGIhfcBJnHHnsFqnf
	 nrBpfc22+yI8J9fHRn0F18b6oA5PytTwsLSENLxblo2XnBma8s0ZrCXJXyieDs+cRU
	 g3Rmdz+3PtueM1WXexnnfVTnm4nwRsQ7MX/ArqIhERSzIRwOKcx5YjZDGAnmcjTkbk
	 6JGDfHTDvEfMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: use dmaengine_get_dma_device() instead
 of chan->device->dev
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-serial@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
References: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:41:42 +0000
Message-Id: <20260928184143.1B2811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API
>=20
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
>=20
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928183252.1965=
169-1-Frank.Li@oss.nxp.com?part=3D1

