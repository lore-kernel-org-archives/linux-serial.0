Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5124B826B;
	Fri,  9 Oct 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544837; cv=none; b=P+uDRqnvSjdpA0U45QdFSNgOt34AWBpV7J/ennNaYeKuc4exp+joLnMpxdY2qnjtAPcDTDrXxtdiACdYjoqh5Y2T98HblidZQ6SB7EFDzFk0UDnTYX+GFstsyML0boteaq2h0XPQ5X2uiWL1v94PZKtb0UNXmqtG/tkIknlHEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544837; c=relaxed/simple;
	bh=wNnNrlFOP0lB0KUuDY4vxVnKq+6Rstx47xZvgRfXHqg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gtxMZXWg7eiO3G7G9ZHu4VVxBsLZ3rZYcKEKX58JQ9qtGCIVajJOEZhLGxK+UCxfPTPmO/girSGzO9p6UMiQ6aMb8WznmtiUhxqdW+7IpzDJnhgsMLOkjUF702GHD8c0AdgSbKb03endStH3kYnTPrCJP1uQKTf3eNGisXbfaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRRvI6IG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRRvI6IG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C461F000FF;
	Fri,  9 Oct 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544827;
	bh=wNnNrlFOP0lB0KUuDY4vxVnKq+6Rstx47xZvgRfXHqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRRvI6IGyDXCTR/2obyhJAalE187rhDa3OBizG9R9wl0jLLrSJ6jVPYrQq5oFXvlC
	 /pQFICVlOWz3E4iQnFq6pXN37LEq78EDOKqe13jv9PJofVHA0VycoLfXfpdzx69hUv
	 ohMgUcPxXx7+8qNS+HNBtNl33vnQ6jvqgOawNGe1TjZ2Er+OXHwdkfTm5BKA/ZJEDZ
	 Ao3apgHSULuR94fCzt1D3OrhDWpYMVmKMUnP4zGIJP394lCfNZzY2BI/jaEttaknoZ
	 DPWh8R31kG4XFPXJ0lEUVW2jF6+od9D41ebr8AMbaDTHxmnBOSI7xbAj9YPwl17KiV
	 Bh7Pqq2S//YuA==
Message-ID: <sashiko-outbox-165353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261009-cv75-uart-v1-2-38c098efaa99@ambarella.com>
References: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
 <20261009-cv75-uart-v1-2-38c098efaa99@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:20:26 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
>=20
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-cv75-uart-=
v1-0-38c098efaa99@ambarella.com?part=3D2

