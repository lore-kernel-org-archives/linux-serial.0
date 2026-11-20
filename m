Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202332;
	b=k78yTQLGX5Ui9wxe4+a6pbGhtnzXbL58TGBRDBwGOUWwawP7HZeXZKulF2Exb2ays0c7
	 HPI2SoovHqpB4wbauv6j+fWAQtLOgpBpeLp9Vk3YpgNXdZ505bmK08z4+8zbC6pXGdS7I
	 rRr/grsrr0qc1ukXdKtqkoRl+Nvoh7KNKLsW176n/2mhJwddpbARYl08bv40ZZK4BAN30
	 1GG9GrGkfq0OWakU95s4pD82T4RYuxjIN0xguHTs0/n0c15wcNyOnFJlrrA4CMmKhb3rJ
	 //ikqjnfuhNUu112GhdAHOEq4phUIM/mUMk0f7f/dU0pM4b0grSbFQy8cx/dWZRsgHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P9QcNjygpe6B/V5GbMeRpdoQ90vpvXsMtnUPIi7uHCU=;
	b=aqplfR8tc0DHNDZGl/k/GKpZu5Z38yrpaDYlr9eBrEIniKChdT0zOJRTUqYkVlKooei+
	 zjlHCg73vU56w5cW2CcbnCdTxb3xF68Y/2e+KcEKN2earkAAWrFk4FCGBpiprblIChU1E
	 YRmjgxLoZqYtDRkDxiVhgiIrFMOovwIkVYpLCPLOKBqx0zO4/Sx0QHHGKszqwQ5G+9x64
	 DMWoAijLuvzm7OxJftZU4wIFKrThqg/8Y2Kp/5vk9LG6hf61K5mi3sIJXXFAMFISKzJ9B
	 1kwZRP53dYo3ao+38PJd9P2GpdhoCkF/k/Zbp0rfxTsdhwNvmIzY8NK0Lv3M/L3c06A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAhtXeiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D61606A6DA
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAhtXeiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075021F000CA;
	Fri, 20 Nov 2026 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202332;
	bh=P9QcNjygpe6B/V5GbMeRpdoQ90vpvXsMtnUPIi7uHCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAhtXeiBK4l5L9YaR4OpoTkebN1bBfAg8NQuwCj4MTsv8GgfFbzz++usFBYwTONBi
	 nFtZEklfIEDv0PeDXG4yS+BPgWEBiU5N18H7OAiedTk0rLqJeATgxEwhcr2Lg79Ycx
	 dYr8tNhf8OjjMkNg2poXQm18NzbC1tDzb0KyUqw9gAE0sEn6+i/AJWF0M4Eohd0Pqx
	 RLDT+mK1p6KJRdCophtwzPrQnaR0Y89OE5uKnpMUBkGT+xe2iyV8531QxSi1sEFsyA
	 +/D1uDWjjc6LOyWHAl8AicMx8K3bsWPDihmcBw4K3NLD1UAlmTIr6kSS9vXSjAEWra
	 j9KpKrHdAVkxQ==
Message-ID: <sashiko-outbox-225905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/13] dt-bindings: serial: snps-dw-apb-uart: add
 Zhihe A210 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-7-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-7-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:18:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The Zhihe A210 UARTs have separate APB and serial clock domain resets.
> Add an SoC-specific compatible that, like the StarFive JH7110 one,
> allows both resets.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D7

