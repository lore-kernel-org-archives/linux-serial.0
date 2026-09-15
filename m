Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA53803DF
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503629; cv=none; b=PNElFnF001Dtxfq1rx0YbhIb9A+g4ZN1MnpJ4NF7jTQMQ0Q5Py78DVy3BrPW1kDocFGgkAw0Yb+MMyLjxNFmVXMfY91ivJtNuT6qSGKDct7jlZPk+vLNz2lymOPWjc6R8VMsMnmGtJNhjo/vSJBlHsfadGdL6zy6iEyqBlCMBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503629; c=relaxed/simple;
	bh=CKaP4x+Qfp6M0tfPOnB7UE3bTV0RvuitFjIr0B33IM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SJjsA3I8xBLkypdVanggyncZoq/4gmP6h8MFQHUVEFHk9+0NdypktDXeq4Ixc11sBSIJIbZsxoj8Bd02bvqZgpVX5npi7Utsr1+NVVllpLf1GMS3saueKtiefnHIHGbR3Cc3D6ApFB1TJRkKnPxxKjUmb4pBF8CqI+me4M+JrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwSo/lzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwSo/lzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835BF1F00893;
	Tue, 15 Sep 2026 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503627;
	bh=8JFZJNJ/rJhWIejn9k2wFQNAPBJGQiKlEUXpOgd2myc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwSo/lzzYzLU+jyr46b0AAxieTBc1jtM8WXmtng+r61odgT58KYn1mWYwcO5gl7Gf
	 5cXmzynJaQrhx81+cH4zpGjSh6/vw7M+ybTxe8Z4U48EjxawJjCZ4G9DTqtEsOupPu
	 PWLZy9IqwwFSJSI2CnVpL/zXWKUVCU+wHaAbFjO9UGZxOvXNb5AlFx/A6YQ4lkFNd2
	 z8f8avhuoi4GHJ2xnP79g0lv8OtknaDl67+jRXB9U+JLxTUKkkQUVDMLZac8pjV3oJ
	 qFxt7kierQtkmb1Y072wy/0VueGD4BFENXM4YZvPG1SJFj5ZoaPewpRLKgf/+yXzOd
	 Jk0o3CzVGWr9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: avoid unused-function warning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260915200435.3524505-1-arnd@kernel.org>
References: <20260915200435.3524505-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:20:27 +0000
Message-Id: <20260915202027.835BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The qcom_geni_serial_poll_rx_fifo_locked() function is only
> used for console support, but defined outside of the #ifdef block:
>=20
> drivers/tty/serial/qcom_geni_serial.c:918:13: error: 'qcom_geni_serial_po=
ll_rx_fifo_locked' defined but not used [-Werror=3Dunused-function]
>   918 | static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port=
 *uport)
>=20
> Move the function definition to a more appropriate place that
> avoids the warning.
>=20
> Fixes: 8200871327d1 ("serial: qcom-geni: Keep FIFO RX active during conso=
le TX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915200435.3524=
505-1-arnd@kernel.org?part=3D1

