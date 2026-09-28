Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE4370ADB;
	Mon, 28 Sep 2026 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620797; cv=none; b=msgL7GfmyOy0m3peQIkx1xbMAYQXALaAByZgDpzuPDsK3jOCOCyF79q1YLoCZogGHJN26qhJMUc9OyupRy4+U3mtc0FD/R4HrVrYjcc4KZnZB93jCWqhOzFHfTdPhcv0bgY4wl6gu7fdhaj0O4zvbqtKoD7aUjX61m8VdQPyB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620797; c=relaxed/simple;
	bh=ckX955NKPa0QbdCy16vmeM3zuIDQhdWjTKAPKnNJAdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNOsCFkef6c28C4BUvUxDPLUEuvJLLXrf+Fm5PtK++S63VkwcReb6V9vpc5pJKmVi8rItPRQDq1Xw9Epa2vJVzHe03AFnv7tYOscQfot71S1CTn7evqCD/YyY3KfvXdL4p+S9IfBLqHXD0ndQ7r3GNBwJmTHtWGS+l1d+oU8AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS2PkOI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS2PkOI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3601F000FF;
	Mon, 28 Sep 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620796;
	bh=1O/7ZzlG0aCxSQnCRmQ1gum5rj5Vsnh9vbrQxoVj+Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZS2PkOI0dHlQt+BZBYCIYPthJWZwzsC/mVsmmvvZDgnR4XKTOI43niX6mCAWkzI9A
	 yZ+s3TOqzKcwIo5X2TxlwYcyLtGbWzvRi4Xp5IeRxT7bKwXS0bft+aNo+Db2AQroru
	 CvLTbjO7440x5P5EFVyw1nI+6xTN8PaDICSJ/ZRANcV6Xua6nQErKgROIIkIY9AGzy
	 LSprz/orTLG3K0G7F5QtFqq0yayYPnXg7VR5vNwSKgr0Mrdmw8lR9P+l3QzOiwIatd
	 +tphZf/qp5zZuHbyzr2dI380rBU1R+qKO1F1RqaZ/6ig1mtP1dca6PS+zEDIFYr0af
	 ZRbCtqgTDhOPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: amba-pl011: use dmaengine public API
 instead of raw ops
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, linux-serial@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260928183252.1965169-2-Frank.Li@oss.nxp.com>
References: <20260928183252.1965169-1-Frank.Li@oss.nxp.com>
 <20260928183252.1965169-2-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:39:55 +0000
Message-Id: <20260928183955.DA3601F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928183252.1965=
169-1-Frank.Li@oss.nxp.com?part=3D2

