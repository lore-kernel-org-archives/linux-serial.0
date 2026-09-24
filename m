Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268E485949
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256189; cv=none; b=G6bu9rLOV2kusvm3e11/P8R+I+K+p+/3EtqgDtmQJbZaDlB+xQogV0MbVEdGpL+tf60ovr+c0c50PVSEUzeeojDJGXWWwxrpGplCh6CaaT/y9RHt39AVgv4XOo1Ocq6CKX1lhDpIRWUsqTN9ZmmcWmWRzErHH6HTVSUVhnt+Ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256189; c=relaxed/simple;
	bh=j8BZ5hN2cJXgAqQvs1zKQW61bAU+pd1mrOD6QG18RiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T6hAq9pQZInyzUz/7xN3rwIImqb+4jpfw1S0N4SyjgrbraxqUHJFfuTdhIhL9cAXT/JCVYEqsnTkBoZp8uWm+ynEaxJScRnjRJ0T7ZP/lqCSjw7kyUshWmQ13RtYXFEr7lNoFRmsjhMm2OBWYUvMBTZO52cDruCwLwZh04SjwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R37K+AOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R37K+AOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D011F000FF;
	Thu, 24 Sep 2026 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256179;
	bh=CwoUIyzLCfi65i9CsWlqE/n9VT+t6Dlg83D/8JS281k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R37K+AOJYNDdRKSJr77XRNpKGDY3INcGf6a8YKAxlIctxJDxkPjSNk2PtwZPnWTxY
	 a6tVtuF89J2JnVUSXdIYi0bMW+JryO+4HoDyMOgZn7iZTjixZVhhBaC/pxJxPpDoyq
	 GNkHt5YSSjXTCKfyITsxmsqq0RaWIsZv7HEQfljNhDHZHpcBoPBeGyRoNnEmz7uR3l
	 XtCAiSBdS8qXxmd34OMZFjtLWJQnV4BRF7wDUOmTg8WKmx+hplz9DIp8p+NKkAxBVw
	 nvmmasHBOHxgIz/jce5p3wT5arFbJdbnpYnN/kq0BMT2c3+p0Bl1VDN8GMVNLWMRCE
	 n4U5gV7zmLx8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next,v2] serial: core: fix NULL/dangling port_dev on
 failed re-register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaosheng Cui" <cuigaosheng1@huawei.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924131147.1952634-1-cuigaosheng1@huawei.com>
References: <20260924131147.1952634-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 13:22:58 +0000
Message-Id: <20260924132258.E8D011F000FF@smtp.kernel.org>
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
> slot in the first place.
>=20
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924131147.1952=
634-1-cuigaosheng1@huawei.com?part=3D1

