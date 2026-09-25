Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3529443AA5;
	Fri, 25 Sep 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367390; cv=none; b=jNXpRrcYpo4XzuO6LpAhlw9/cDS2VxVNBCJLorZMOj73BjC7DjYb6475m52lJmKqfaT+fCynI8QFo60IgBRH8GPegH9Cr8I5DEK+zmOFlpwrZ9fdDAD1bjw9OIKyOcTtbHgoccqafwsaxQGNqUZsyw2ljkmo56pjuXKDG0rz9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367390; c=relaxed/simple;
	bh=cchNmN4CTgovTsd8urYnk0Xos6lLEgrCs6S1imcLrLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUyOL1bLMInVD05pADiWh2pHhI2dKzMGD56+xN/+V5H6FbTrAJ7XvcYUWpDNfbvkOED04o55SCvDkGEilDs5ZxujnyujDYrP9B/OuX6W8kvM/OvxdHZLGes9E+FSwRY8txPApjDwxxEDqN3bg/i987zvFdVspYuP5Y7GobuIiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVfZ95ui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVfZ95ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F441F000FF;
	Fri, 25 Sep 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367388;
	bh=6gD84913SDr2sGSI/B05NWeYvcY7ps02+peIGPqC530=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVfZ95uifwka+k3Q2mdTCzaP89E9pK+9YEshtFpLK9WWYmNKK5AqO+nccX9ydcPtD
	 KBvN1Tj/GANru6Xwu2raLz7j6zsJs6rZ/TnzNSqWK7QCKRqI5rfH1WlEQ3XF5rcWuT
	 znhra/rj3oHfP0Y+FKXXqx8TMFj05XwCjj6r/OG1wWbufZ2k0mtYeJ/B7JPAntqANV
	 xkpJJ2Ql6Lm3JkPjkOBS+xlZ3QJyamp/t0S8tdXjpU8bwovzxFtnVjS5ybPGMZOYJk
	 eS00J3KsiQHSSQqhxkUrmJzeth2vk0x2qDag0/KcqIQcXRXLZx8NyX5mrcs2/8Rf0c
	 iXNQABq9PxTeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: amba-pl011: use dmaengine public API
 instead of raw ops
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-serial@vger.kernel.org
In-Reply-To: <20260925200850.1678179-2-Frank.Li@oss.nxp.com>
References: <20260925200850.1678179-1-Frank.Li@oss.nxp.com>
 <20260925200850.1678179-2-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:16:27 +0000
Message-Id: <20260925201628.80F441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace direct calls to the internal DMA device ops
> (device->device_tx_status() and device->device_issue_pending())
> with the proper public DMA engine wrappers:
>   - dmaengine_tx_status()
>   - dma_async_issue_pending()
>=20
> Drivers must not call device ops directly; the wrappers provide
> locking, debug checks, and a stable interface that hides internal
> implementation details of the DMA controller driver.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925200850.1678=
179-1-Frank.Li@oss.nxp.com?part=3D2

