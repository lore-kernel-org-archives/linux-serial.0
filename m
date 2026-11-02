Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650025;
	b=C7Y5PGiLP0uQcbaL1cBZZsWD1E9HhPLt+sREInm22MSxYk9nZ/KCA3lug0lq9N+CpLgP
	 vZkwgK/zTd5Qjz/u6xDLrNC5PFr1zr2wlu0XMLm2lvys8pcqbMayJCvxMZCpWgdhaKvcd
	 Mv0oQRj7oMJwzE1zEaGc8KOsb/9xUiuKZ4+JBkuGHXVvkcr2jv8dYoZWXug0exVqwrNYg
	 rHL341hf9JwK6JFlBNRlxtAfQlvSlOx4atKx7t5v9ANRXKf+K8G6M8wOwCgY1XY1HmAeS
	 aAw6efQY3ZMBE+rBmOGLgTAdksan9OzmM1+rBjN1DaxzqVDG7rVc4VHeuL2qHWLQ5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HBkG6r81V+tkcqb2GgLDk5w/vRLQ3vCaQZI2MVf5580=;
	b=q+XFb8cJFoh5f8f3Pv7Uw1rGiMetAI+AVQTOk6qOu8NbJ28G0AekLBcpSFQT7khGoYgm
	 rNreoRYZ0YpeKsAE71XGffKF6xpnGxntYvLxjyrQZaVjKfx0ZuwftdGJ98pNzo6aNxBX4
	 XPsQ3aHbxzU1lHXNKOCZWG4T+S9h17sG3CHCXjsnyMHw80uKlw0yJgL8UT+XvdPZVN3AY
	 /jtfuxsDXWt2ecUNwbmTUYFsPUMuKFak0T7ixAxoXelsoizjN8vnUjgwpMSxlKPwpAvKf
	 K/Qf8IIgv/0xLQ6+5FKjUGnu7WYRBezQMwKQuD37umDaAxilZ0XN4ZL8G5SZamZsnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY+fBZn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D6606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY+fBZn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13491F00A16;
	Mon,  2 Nov 2026 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650024;
	bh=HBkG6r81V+tkcqb2GgLDk5w/vRLQ3vCaQZI2MVf5580=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XY+fBZn3cv2T8tfUqksldQeXmAavjNPCYWb4sQo9jg7A9CwLINCg9GC7D83hghBO/
	 UcXUveNpbZqZEMnS9hK5EiXxcMfz78alNrurefNovVWyudZvvr5Cn5MZan34e6rs9k
	 aAdVuyRpW2FNVYVfiiXLje1uRxexemSX4kyD+J2hVfSy35+7YVVLovO23UIecTbKsa
	 fjYyDSmHC5pPYAxjvj6jdGH4Yot+NlZ9L4yP+zv30ZyJwAVyE7qmwEzCN47VIYUf98
	 jVfYaXeItjEiph9uBlBA/lxb/auHECBO4/iYRtLwA/ChSbi7TZSLZzhcvgn5v3/hbx
	 /OFA49fCp80Fg==
Message-ID: <sashiko-outbox-194062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 14/17] riscv: dts: zhihe: add A210 module memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-14-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-14-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:07:04 +0000
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
> Add the A210 module memory node with a default 4 GiB range for boot
> firmware to update with the detected capacity.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D14

