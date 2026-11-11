Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389383;
	b=xgYKzjR0OVi9OXJvS+W6rg80qEtXVAQ7eu6nR44dCAxsT2qrtJ8iQSjBdBbQ5w3J15YC
	 /ovX9OfUpvdLN/d3pArRJJznayZYbtZ1I2eDDQdOVg0Gu764lG3689UFYXJTxkbPul/fy
	 L5BODXaHp+RMLRdCZGxXMl+NTCpEND0hPRrc2f2YLWlGkZt4dr/PaOKc3nisoArwrnUch
	 4fxZY/yU70PyxxWO7t3Hi6z9qNs57T5GcWMtPBSY3+apMkJJc2IOCV5Haig0Bo+zlBMzQ
	 HHiMKIY75e7g1qjmzM8n9IpNi+uCwf4WTZxxTyEhjD/oJybCH+oMJOWybqdDAbndTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2k3zg31gZMy2KjkR2Gl2liR6BJAMB/hJP32fmmRyPCc=;
	b=3mK/AYnoGl7VDhDtVD8EjAeiFN3ZypTSZXbIHUadXjJSUegtX1cY+Recx1TBcxb3+3ZP
	 46Xl//RMsoIXWAnWgl++3P1tRYPqRlMXjQhKVzlfkzRMLLV4qCC+k7PwodZeT/Xu7J5zR
	 RRMFobgCXS1i4RiPLUgMxNNubLF5FwjaUlkUrNO521K/4FxR0NRurJlQ8XYQPqQcz2co0
	 W4OxjnJnfAMNA01wfJEoPxOUgFsQmyu/4jbrQCPmePCTS7smig5eRpqH7BlcdLAxv4owD
	 NvBzzesq5ZpS3aeeN9s7LLUkx+rW1dLE5s7sUfSDmA0Q0/lpAecG6YEkLH0HA66fOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXr6+YDL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7960A2609
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXr6+YDL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242141F00A07;
	Wed, 11 Nov 2026 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794389383;
	bh=2k3zg31gZMy2KjkR2Gl2liR6BJAMB/hJP32fmmRyPCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXr6+YDLpOSD6hOvQaNZjIqhfbFyyR0S1i8zoQjJIdpGOCaSCp3/HYw5VwLDtRrp1
	 PFth8ggHuxec1FiomtQRCwjUvmJIe4l9HBR3zJc2bum2YMO9YP5ROKNkY0u+64buU5
	 4KncMwCZvk1vsh5ljTUEskOqt+hKC8mHydci/wxcnYabNRFcF+DA4RGBprWxND1Jon
	 OSu1PiwBqufkc0l9CeYhmThFsZV38gY7CBGKzRYyTXBIpq/Sk8kaJkLyubuulBWEKz
	 reW/KnfJpyDr37CMVwjAvt2yAb90UxnvYkfgcymgvlC8zDQTfdtoiZmL7ESBtsfZMb
	 kRyAQZ9Nk9dbw==
Message-ID: <sashiko-outbox-208698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: Fix divide by zero in
 pl011_console_get_options()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Carpenter" <dan@cryspen.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <6fdea544b2fb8f4226e296a952331cd42684474d.1794315353.git.dan@cryspen.com>
References: <6fdea544b2fb8f4226e296a952331cd42684474d.1794315353.git.dan@cryspen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:29:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> When you boot QEMU with -kernel and don't set a baud rate the ibrd and
> fbrd values are zero and so clkdiv is also zero.  It results in a divide
> by zero.  Most of the time people don't notice because on
> qemu-system-arm64 when you divide by zero the result is zero and
> everything works.  However, if you enable UBSAN, then the divide by zero
> leads to a crash and the boot fails.
>=20
> Return early when clkdev is zero.  This leaves the baud rate set to its
> default value of 38400.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan@cryspen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6fdea544b2fb8f4226e=
296a952331cd42684474d.1794315353.git.dan@cryspen.com?part=3D1

