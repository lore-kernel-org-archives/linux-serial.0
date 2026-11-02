Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649897;
	b=ZG/E4EW8tB8PFeRA8/iEwAerkq/U2TR8URFEUsAc9fTQMYoHi9gqxfFkMd7BnSeMzq6H
	 UKAxY7ZmdA2m3uZqUdGDRknkEkdNBkF3e9cmX8LH+asJHTo263CGLlS+c1dqmOdIctDAt
	 jX3zxV/I6DEfXsl3iI8yCKj3IbhWMIlz+T/LMgyABiLUSaVa6aLHp/gWXzGo4bXgZeO7x
	 go9kHI2v4lGRsajUJcv0QwlZbrYgtKao8CmsKZc+YKV3OzcVYya06hPiqJ1viuFI/PaCP
	 UFIhQmBcIRG19x6UXyaSVQduZiTJBkLBAGL2TVCO9A7iRL8+TvEUrHLFw14e9w7Pk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZbUcVzhtk+Yc4QujSPCgQwaWByNhfU6RWe0KXVEEIQ=;
	b=3z30KFWp0MfutAEUBDOu9++a4abUyxJOb7m9y7KXns0/pC3UzCqKuuYi25Sp6yRnKdXB
	 DT7NYarnidYprtG3Hyf8h+59KUD5OUA+3N76IvAbfcX2B1BpuVgb5/t8j2G9wHY/IQ5Bt
	 dFQoGN7U16TkWlBqZCsZIU+zHrIMat3LwMBCE9qJKco+mYZebN+1INkqy/MYRHWPda1ih
	 awIipzYbFYJwLfYvUoKizaKnYU9Czrj4eri5R0xeVmEo9ZeJ25i/uwpApC4EGet+L3SbM
	 433tEFanR01upJr8l/4fi6qd/VkgzulBguRgAo/eimUrBH7vxl3n6yzAWpVlN0VRurg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDTp4PY1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD0606A32C
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDTp4PY1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE931F00A17;
	Mon,  2 Nov 2026 20:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649896;
	bh=ZZbUcVzhtk+Yc4QujSPCgQwaWByNhfU6RWe0KXVEEIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDTp4PY1pmevphXz0ElG4jPtzYS0zqCTeqA1NbdGzh8H/41kFogCdLRzAckoDKw9/
	 ZTqV6EUptz5pTrVGVCVLLz/TXjHaREOmuQ3l18ViBSc5wZ9C2uCWAw5meodSUWvHED
	 57dUMhB17pEo4Ws6jrKMaHCXoOxHxcNTebsRgoAXfhjA8m5rJDKVcVdKbswvvG97pY
	 dQlAGG78NN+p+aAlvOsxeHnB3Ktgu/EV3as11GDXH/swKBOf9u2eQGTDR25GrNlo6z
	 rw7JM7b/GeXyHZweZubVXUcSSTqbSdvV0uuytV4+eB1kg7hFeP8diWFSV5u4YsetxG
	 F8M+0OzSx9jdA==
Message-ID: <sashiko-outbox-194054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/17] dt-bindings: serial: snps-dw-apb-uart: add
 Zhihe A210 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-11-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-11-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:04:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D11

