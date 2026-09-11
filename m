Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785646AEFE;
	Fri, 11 Sep 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118929; cv=none; b=J3YhmBhAzY4lFseuLXMFMQXgg8vh17xo1hm+fpWTRj7cPKLU4ljFGUH/x8arw2Yi7SkcoN7wx3wvPdlJXlnVzedU3a+EPKsmD0LP4rVsCY2hQNZdKtbWqvkQfkUNjz5dmxQTdD7+nMAmStNyUxP3qwwtFEIqYzRsXEZEqv4qA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118929; c=relaxed/simple;
	bh=ICPLJIJdKweJxU/hQEeK2TLLOKWwDmPM9LCnjoADSEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fTVQs/wKL4ZvXjIMUzUWNXP5BG6DyvX/hmo6hk55XMh+fcJhqlRymqxMHyABjNYYs4jzC9fh6+eYu5/xYYk2zR2PrEahOx0mloGfQcvWpcHlZ2zA4i8zM8G1DwM9/pF+D9FWVk1Jle4tGKp3cJcMipCCg4q1hutkiw+jb5joKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5jrSV+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5jrSV+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB78E1F000FF;
	Fri, 11 Sep 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789118928;
	bh=ICPLJIJdKweJxU/hQEeK2TLLOKWwDmPM9LCnjoADSEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5jrSV+MmgxbcscqSzL5YPiN7y1Z2HT1cK4DXHbBaQa3FnjR3aPzTBCIW8oLfLIxR
	 Y2TiF9SbZsxLMEfcvOyBjSPM587hT7rE+ZM7+TGgLVAHGI5jtq/pAuuEsroRKjoWiu
	 Go66OLEJLEz9XpQvVz74GS1StfzO91ELnQblVC8P8zFaGsuxvAaRZlksja0yH2iY1b
	 AsRXWHsZ1/tzZc30G5xzy2SkPJiRNdxP0jft/xiwtr6rxPZjQlWp75JBAOYTAVW30w
	 0RR4aj6TxEggZNIuM0D0ibv27qQekNUA8dXDvizmCLcA+dr9o5c1OuBzhXUvExSziO
	 d41JZrq60VO0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add
 ti,tda54-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moteen Shah" <m-shah@ti.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260911092529.306082-2-m-shah@ti.com>
References: <20260911092529.306082-1-m-shah@ti.com>
 <20260911092529.306082-2-m-shah@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:28:47 +0000
Message-Id: <20260911092847.AB78E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The TDA54 UART is compatible with the existing DesignWare APB UART
> binding. Add the ti,tda54-uart compatible string.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Moteen Shah <m-shah@ti.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911092529.3060=
82-1-m-shah@ti.com?part=3D1

