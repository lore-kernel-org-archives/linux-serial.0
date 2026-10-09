Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA44156C6;
	Fri,  9 Oct 2026 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544353; cv=none; b=XBKRO2F6Ue/bViWuZqUMrTmRA4qjMBW8IC3gGH3UJxjZSfhA8xKWnh3eCqfYwFYvBMURTcEMYSJ6qeAgdz78BD8zMHINBtJwlT1rmdP39PVQ1TwVcJuOXZOcdieFd6SOXiELiUB+tr4itOoTD2/APNxTEgCtiW2G4I6+kpy3aYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544353; c=relaxed/simple;
	bh=FMP/hhfaGNVoVjQTdvVBNVfplWgXspz3WhxZFqRhpWU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UTfLPvdi2dLEnNYltR84unBnAzN2W244yHI3AEu8S8wHCg+dX6xNTnkaaVtamDrIkw58iieO4E4LbE8E7U3iGLOc3KAmBaIeXznskfcGvgahzti6+2eBecgiiLpydxn4dtW3fsVJAWRkUFyGPbZVIJgswKG43WQvRC/V3QjdMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc8PVjIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc8PVjIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EADD1F000FF;
	Fri,  9 Oct 2026 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544345;
	bh=FMP/hhfaGNVoVjQTdvVBNVfplWgXspz3WhxZFqRhpWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nc8PVjIgArtwKbOyeCy8OAZyc75yBwHalgzT8vwR3p6z/1vRNUBqHz1qZqTSk+Mf6
	 oHX6KhP+XEDPxkok6BsIvinD0pQLloJofL8TMsjm23ZXIDWb27BgvHwql2nlYMeZwn
	 +7QukyKIntlHUyLIw6w+xd/kIwKNR4JNcIEznGXnrcO8rzy+eV4N6TV/zYNXZ0y34+
	 fSZeegvtFiDbuHaxecM7J+x5jDR6paVOsOW3TnuorN6SysBrlmYWBMQ3/wQyBzeoJF
	 6Z7+Wpkf9k+g2K3fdqxXxZSZW/m8Xxf6DtF0/8fStKmYHSoPVsUGQGPfxytz5mMPiS
	 XFQiq6QeG/c2A==
Message-ID: <sashiko-outbox-165329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261009-cv75-uart-v1-1-38c098efaa99@ambarella.com>
References: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
 <20261009-cv75-uart-v1-1-38c098efaa99@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:12:25 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
> binding. The block is Ambarella IP with a DW-like register map, so it
> is described as a DW APB UART variant.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-cv75-uart-=
v1-0-38c098efaa99@ambarella.com?part=3D1

