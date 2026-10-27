Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142109;
	b=JU/lDGtcdsAQ9nkyArBmiDuWvbd8wzo/wTmqrCljNqNEIk2U6wgqPN8gQRmusXYUfvRi
	 pjM8LiYOMBY+zSg8SvuCPPh0aVVN8/9dZoH6g5a5BMOLOYPLOmuR87P/W5kqU3zIzqiLz
	 dYdJeJDMvIK3Gp9+utJuoSqR40KgJlDO24FVU5BD0ppyPHx1H+5QYYnTlIn31PpjI0anS
	 dehx8sDjezr+I6iM/2jCr+Y48fAlp7fn75BhnXjJn3GWZlfjp5laBJ9+OveOonDNjF33+
	 022f1s2W3RXFNmCmclLEderQYIzizp/lkdEX9ZZtyofm6wXK5Lr3wsrjvR09e2QpJGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cLGhjcDMZfkl7aaHZJXhx+XScDXQ9cV1zMdONXIoBsk=;
	b=GfdB3Si1w0UEtK8/lKHcxJednPIvBN2ArtzMPEROEaU1yv8Vx+Aa4VKJ2XECSHjoku/M
	 18fQHH48S5CH4v9e8Z942VqYUMPE0b702PxxokEKF16s7H8fv2SNn3rP2F2XSegMinkQG
	 ZBYz4ZY8iTq4G60BmshWkbI7uKboshjMxX7FItk0BKyiGTjyQsK9v1/n7gKVwC1fi76Tq
	 07Ntmw5tJTeNG8FqRoPIXvJ7bS2Lb37onkDg4ZN7axA8/9O4NnDkdmwAsg4OnKLYAHIOv
	 0Bdls4oTUPhq919AweoMuLL6tTtyIg8AC+JMgmNVjLn9F7cQHmB/ABZIaIuCI25u8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNfYCRjB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A825606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNfYCRjB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43DB1F01825;
	Tue, 27 Oct 2026 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142108;
	bh=cLGhjcDMZfkl7aaHZJXhx+XScDXQ9cV1zMdONXIoBsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNfYCRjBfShcJOcXJzqKGnw61Vd6SOrZjTN2SJOGW0k8FKOo+wbdV5gUbqPgx/t4N
	 Efj62GI/fvlsd6mAdk/N/NsrIUCXg5jsPoXWUsce/8m4Jpb63Csau8dY8WbGjVAVqG
	 1cWMHXQXpqhl8AUqbuK27ZavpL8gLzlV0/sk6J3it2WSMlE68U7pBt3lR1DPaLvm3F
	 OQfSVGndJM+LFAqxe/0DUVpw5rxMqP3UM4lX2JuBd0WPaheE1hkhSaq8l/X9CeBuIM
	 uvdEjxLSmB5hUmBs0EsL9azzqKoXeEKLT4tEg3QUWwUkUWIGMIr9bAzYfqMtFFvYxH
	 smO9MCzi6q/bg==
Message-ID: <sashiko-outbox-187185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: qcom-geni: Set the serial engine up again
 after hibernation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Birk Skyum" <birk.skyum@pm.me>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027224800.86418-1-birk.skyum@pm.me>
References: <20261027224800.86418-1-birk.skyum@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:01:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A hibernation image is restored after a power cycle, which resets every
> serial engine. The kernel that loads the image only sets up the engines
> it uses itself, and on laptops the Bluetooth UART is opened from the
> root file system, so that kernel never touches it.
>=20
> The restored kernel still has port->setup set from before, so the
> startup in uart_resume_port() skips qcom_geni_serial_port_setup() and
> the port runs on an engine whose FIFOs, packing and transfer mode were
> never configured. On a Lenovo Yoga Slim 7x (X1E80100) the WCN7850's
> Bluetooth controller then never comes back: every setup attempt of
> hci_qca's error recovery ends in "command 0xfc00 tx timeout" and
> "Reading QCA version information failed (-110)".
>=20
> Clear port->setup in a restore callback of its own, so the next startup
> sets the engine up again. Leave console ports alone: the kernel that
> loads the image sets up its console when it registers it, and setting
> the engine up again in qcom_geni_serial_startup() would run without the
> port lock while the console may be writing. The other system sleep
> callbacks are unchanged.
>=20
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027224800.8641=
8-1-birk.skyum@pm.me?part=3D1

