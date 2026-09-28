Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A324B0E3B
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596069; cv=none; b=CGfCrZCbomrLjo/S8BetxwRhl5sQqjA1SPqnCVyveyNawUn9t4Joy00ziCruAwsBah3Qml4NlUYN/M3ErlnW5KljB0GJprkuqZv3+vSK9aqKNQNSgzwf72xm1a+vPuiSbG4GEf/tU9WOCGMXB6vFGlr8KkBOPexIo2lmsoVv0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596069; c=relaxed/simple;
	bh=hfLsWxFoSjmJormGXdQsfZFj9f8RCoN+fVO5pEv1kbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCxVCCw7Tn6ZFrM5wfARp5B2/Z+li8XdsMN5MvPynvxAiWjR21six/ETO/rKFTQT8JbauW82QyCvrVSNSG3h9B89WiOdJkDANWqTxghdhEarLGZLqWH+GYK5IbvEOFXZU3QD1aprDCngsG5/IX6sHn78tfohryC72zAVyQtvJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd0YqQF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd0YqQF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2482B1F00893;
	Mon, 28 Sep 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596067;
	bh=HZROVwnbI3R7Hni0sEeeLb+JMuj6Kg8p4zIsXKN0ikI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vd0YqQF1WEpzOdv2pk9a0Ith4lw95TsSY91wLvkeeae5skgNFajWOlK89dqt4VI1S
	 IFVBEjuYINN5oCH8zmfPUZYDEXBVtMMh3j156AzJuQZvlT+Au6KmDmNA//HBpsyRAY
	 q0aACp5S5mLNLue06vfPWRDfanjbkFlKwm8b6b6bYEeg9/aYqIG5MRlvOe6KzF9lIV
	 0Kwt1gylHzHrxNFqAuOe1xQ/rKg/R4Wh70EAaDbX67IeHoH6XcJSXJXH+zjO4DLNTs
	 sd/Zyy3DDD+i//K8S1gSKdyCBxnzdB9PYBQw3Q3gD5GrV5Nc+3bniQw4ra0yOZirLE
	 ZvhC9JgcSDnow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next,v3] serial: core: fix NULL/dangling port_dev on
 failed re-register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaosheng Cui" <cuigaosheng1@huawei.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
References: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:47:46 +0000
Message-Id: <20260928114747.2482B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Cui GaoSheng <cuigaosheng1@huawei.com>
>=20
> serial8250_unregister_port() removes a port and then re-registers it
> against the legacy serial8250 device when that device is still
> present, ignoring the return value of uart_add_one_port(). When the
> re-register fails, the error path of serial_core_register_port()
> removes the port device but leaves port->port_dev dangling (or NULL
> if the port device allocation itself failed). serial8250 matches
> ports on ->dev, so such half-registered slots still reach
> serial_core_unregister_port() on the next unbind:
>=20
>   Oops: general protection fault ... SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x40-0x47]
>   RIP: serial_core_unregister_port+0xe5/0xa00
>     serial8250_unregister_port+0x103
> [ ... ]
> port->port_dev under port_mutex, like all of its writers.
>=20
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928113456.3118=
750-1-cuigaosheng1@huawei.com?part=3D1

