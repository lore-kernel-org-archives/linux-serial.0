Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649320;
	b=XhCDaVEMMMhMZDbA5MhgeKJRFR5s173lF6FVAhamDrt95C18fhMsXLf3WSXGT0b8eAeA
	 M+7R6on34XYqmkA6+sZAnKQslXGYQENx/vq8tYkSMtGuoUND30/5lrWU+5bRA+G+tQnOl
	 9ALAsmVJxs5cbUES0MKS6a8Gu2MgPSzluYkm/naz6KfxrxTIZ9aWC2KT5mqkkM7X8dSAX
	 BoM8sff7BKqcVwHOS5gOT3Sk3REvGMIM7u59iqP+M4va809FPnX+SKquE+kEnFmrFRvgy
	 GcsJkjDZ0YG2DFRIpHqTiovU7QFFyluGxQHHrJHM7z9B7z6nkb0bf8d4oSZXgEBXFJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yj7bPL/QcxOBshuuFMXdKPv3GiZzj25CYGfkuOZEJwQ=;
	b=0Yzq7dWXJD77t+WzNRFx6X3o9YKH2xmtkYwx4oLYVCqIbVNkkgzuJCwZj4B42amVHU3J
	 5QRz9gSzMfxgEuFk6bEYXnf/dbnYY8zr7f0cUHSgJzVshm9IkXH/3z7BFqEkW4vCYPyOG
	 2VsZFR+HhRTVDYhCtTzYJ9lW6nZ5D+AjxA5Xpr0PNef2ca8YmTJyltyWQM7KPVaUl+Owf
	 LdQq0Wz0Obhk76kPJWzomI037FEGApbUZy3/XME+e1OM6l/pGk2RSPmbUyvikXupg+BmO
	 +QFTByFtHd1QH3YXD24xkQUbAtEd0nKGTTLXWpRTq7vvnNaRd1mIOt3j/UTYRUHNnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DlBY/S1W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F2606D82D;
	Mon,  2 Nov 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlBY/S1W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1705A1F00A1D;
	Mon,  2 Nov 2026 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649319;
	bh=Yj7bPL/QcxOBshuuFMXdKPv3GiZzj25CYGfkuOZEJwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlBY/S1WdPUIq7DR2DUQKwqIURI5DL643tNoktvg2qhfsmYFgFSPIvCuDs3xGf2Nx
	 0r9WJBo6cflZZLN/OH+IkGJxkuo8Uvf+dUJrMUTwBv01CYUhBf0rgPdHsnQdmLpDqT
	 cL4R7qVaVdxBlgdEobvzytkhz2/e5hYR5ETsZeHM3tdz24flC7PI6oF+JuB+IH7PgP
	 eb0+us0iTvKWIAhNgz8O5WyLBmC+0XHkEAp5ZWehuuuwd8AutMM2vXT2WniKFsiji3
	 KgcTpEzssV72y8jEP0XE7dTWrR3am+t2Yq5JXU1yITVTWGtEzD6D7IYF25sQ2jxX5j
	 w4EkJtddx8RMg==
Message-ID: <sashiko-outbox-194037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 01/17] firmware: arm_scmi: Drop the ARM
 architecture dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-a210-scmi-v3-1-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-1-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:55:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] firmware: arm_scmi: missing HAS_IOMEM dependency on ARM_SCMI_PROTOC=
OL
--

commit 2b45f4669350cda60b185c5a0c439cbdd7f35cc9
Author: Han Gao <gaohan@iscas.ac.cn>

firmware: arm_scmi: Drop the ARM architecture dependency

This commit removes the ARM, ARM64, and COMPILE_TEST dependency from
ARM_SCMI_PROTOCOL in Kconfig so that other architectures can build and use
the SCMI protocol driver.

> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scm=
i/Kconfig
> index 783c24a20e291..b56aed46a3870 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -3,7 +3,6 @@ menu "ARM System Control and Management Interface Protoco=
l"
> =20
>  config ARM_SCMI_PROTOCOL
>  	tristate "ARM System Control and Management Interface (SCMI) Message Pr=
otocol"
> -	depends on ARM || ARM64 || COMPILE_TEST

[Severity: Low]
Should ARM_SCMI_PROTOCOL retain a dependency on HAS_IOMEM?

Previously, ARM and ARM64 selected HAS_IOMEM, and COMPILE_TEST in
init/Kconfig depends on HAS_IOMEM, which guaranteed that CONFIG_HAS_IOMEM
was enabled whenever ARM_SCMI_PROTOCOL was selectable. Dropping this line
leaves ARM_SCMI_PROTOCOL with no dependencies, allowing it to be enabled on
targets where CONFIG_HAS_IOMEM is disabled (such as ARCH=3Dum).

When CONFIG_ARM_SCMI_PROTOCOL is enabled, the core driver in
drivers/firmware/arm_scmi/driver.c unconditionally compiles
scmi_common_fastchannel_init(), which calls devm_ioremap():

    addr =3D devm_ioremap(ph->dev, phys_addr, size);

In addition, when CONFIG_MAILBOX or CONFIG_OPTEE is enabled,
ARM_SCMI_TRANSPORT_MAILBOX or ARM_SCMI_TRANSPORT_OPTEE selects
ARM_SCMI_HAVE_SHMEM, which compiles drivers/firmware/arm_scmi/shmem.c
(calling __ioread32_copy() in shmem_memcpy_fromio32(), __iowrite32_copy()
in shmem_memcpy_toio32(), and devm_ioremap() in shmem_setup_iomap()) and
drivers/firmware/arm_scmi/transports/mailbox.c (calling devm_iounmap() in
mailbox_chan_setup()).

Because lib/Makefile only builds iomap_copy.o and devres.o when
CONFIG_HAS_IOMEM is enabled:

    obj-$(CONFIG_HAS_IOMEM) +=3D iomap_copy.o devres.o

won't building ARM_SCMI_PROTOCOL with CONFIG_HAS_IOMEM disabled fail at link
time with undefined references to devm_ioremap(), devm_iounmap(),
__ioread32_copy(), and __iowrite32_copy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D1
