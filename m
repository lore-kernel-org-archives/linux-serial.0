Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251020;
	b=QGxgG3pJZ/sejoU8kPDLd/wNcSqJ5D4MngIuF6caXewMfNMX7LWjeSQBRw/uesdlJ5E9
	 HAIpVrQfBOuZDsbiKQFcPqenCgDvwubDiMTDf7cu9En5FkHpghAvJJFXWes/3sB7OYmyf
	 eyuFqAk8+Qrx9azZ1oK+yzFaH9jTfc1pmYb2KAPq0u+7JaBJktPVMmNKH1g4I0N2V4wt3
	 3VYnXHmIvYgAwIN4VMTZNxWS7kZw9Hd66Zxp2EMgE5YFZreB5tljs/VqGt4JBzOK7OKJS
	 hVEWGgHZtjQCremmZAHhuA3EPjvhgCbIGSAMqduz0TilAXPR4J/W1TvoEWf6AdrW3Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZdSD0CsV3ud7CzyVHEirn5r1/YCVyFEIG+vBpbJ44fY=;
	b=nnHWtz1ol0B+8BDrgKp4fYWzW5IHztkZuEcdaKSSTqxLiH32Q7MtoQsa6lNISohYYJb2
	 w0lUPNjQHnfInwENE27p3KH2yvVEo5CI60DujBm+PmOOio/ElhrJsAcKbln/BFbSUQRtz
	 b/73D7dbJ8BCXYP+QnxCUDIf0FMvZal8/H74gA8OCzBSF3wbFrs3Qxrq9vCo9eKlSEbun
	 lGg/1vs1qeCiLsOtRtQ0iSoTC+8m+A91h/tmJdR3oCIz4OvnBt/CAKNzfWgKEk7+P7abk
	 WVK6wxv4p1kEhzGvdTi+G6XJvjAu+qOcDODSpOhVhmpVQ2RlwRZPcPwTpwBkVOHQHuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9jhHweb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B737606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9jhHweb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78171F01825;
	Thu, 29 Oct 2026 05:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793251019;
	bh=ZdSD0CsV3ud7CzyVHEirn5r1/YCVyFEIG+vBpbJ44fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9jhHwebg0+SfJBJIXY7DL0hjcmVl701Jfgn7YidVGOiLmugm+8FHirqil0Y4vk1E
	 sFIsy0Jgsrr4AAH1m//1l0qP1t6OksYVJf0syMuMEh5EB13xG7MRo5NcKAYSbPYB34
	 UDBwJeE1K8pkNA04OGO45+I0dAAMHD/5yNCWMrryN5l7/OpcuTiRhvbjpvzwXxwUZ2
	 Rt6HMb2h78Ejobn3N3jCefR2RsAYAdbst5x/Zay9FjSkT88tqRta71WJCk5ht6WN8V
	 qImD2+utdyB/94QvcGNHeQWiUf0zL7fmWuX4jmyiJx68uAvX/0XjuQ7GeAenS+X7wB
	 Nhu25T1JmVYnA==
Message-ID: <sashiko-outbox-188749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/12] serial: bflb: Add Rust BL808 polling console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-7-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-7-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:16:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a Rust driver for the Bouffalo Lab BL808 UART controller with polling
> console support. Register UART3 as ttyBFLB0 and provide bounded polling
> and newline conversion.
>=20
> The driver uses an exclusive MMIO mapping and a baud clock supplied by
> the device tree. Firmware configures clock routing, gates, reset and
> pinmux. Userspace TTY I/O, RX, interrupts and DMA are not implemented.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D7

