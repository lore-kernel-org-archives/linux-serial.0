Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F94D9F81;
	Mon,  5 Oct 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221659; cv=none; b=scElPLFzg+3oVz0Ae99EBIQZOtwLSY6tr/lhqQV9+n60TNWy++eaxUajd7lpwA6w4tDrn9MnP+9WyC9i1Wq+FYc+S4Dr9ruXyS26na/cBUfbz9Jd47s4RVr05Z/+xD2/Vlvl8hGthzdzCavU9wktMnxfPatAyMqYocdphyCWYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221659; c=relaxed/simple;
	bh=pDqwHNafpoLXPhLqCPAiIMzBz6dYwF1PKCI+ZHir8QQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/8TxOf+mGRsjcSJz9st2w40bGGq12x6sMqTdvXkk3dyuXhWrV9gDd7CjfqGLrFmwzl8FhFxIlM0soyds2xpFjQBZWtoYS5fRAUgL/EhVEYUtEPyqrs+OSKjvhrrMhaR5ja3Z9P8DWFcEDGbENXja4p5XdAlW3KdUikWToFUEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAshF4N3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAshF4N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870D51F000FF;
	Mon,  5 Oct 2026 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221657;
	bh=UbP82uNvwU7DMI342WunqOfPuho8S7H5eb6BJ2lZ9rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAshF4N3VPRk6/f2ygB8Q7Ep4g4F24+moVNA6B2/YjMOGC5NqhDDTk0daKwITBBC/
	 26Gugw5/8gqy9OUXVvyt33iIUhZkBo9TtE8RfZbm1vT/JwXUCZZ+HdxuGyrRCo/RtZ
	 GsAJk9wq5NVjrw9r748GyaPS/eLPhU0CDFS5SgcqaEhNyKJNLbIfcK6wpUqLfM1CwU
	 xla1hXfICsbJ9y4lLDSLIvWy19T7zlvO16VOR1vTRYN/dssXBpHV77DAIkK+3f84b5
	 CIhAjNhrIV3bDLIebsw958JaHzuufg4l8AILK4/ieu5ZK6M3ataA56yjLWAdgM8K7A
	 ohud3dEjM4RFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: snps-dw-apb-uart: Add
 Allwinner A733
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261005172538.398522-3-vinicius.eduardo.pedrosa@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
 <20261005172538.398522-3-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:34:17 +0000
Message-Id: <20261005173417.870D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dt-bindings: Invalid snps,dw-apb-uart fallback for Allwinner A733
--

commit 51cd638ddbc823709bc6b8874d8c1f36411d5573
Author: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733

This commit adds the Allwinner A733 UART compatible string to the DesignWare
APB UART bindings, specifying "snps,dw-apb-uart" as a fallback. It mentions
that the baud clock cannot change rate and offset 0xc0 is an RS485 control
register rather than a DLF register.

> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 86dc259193112..aa8cab5ba3d33 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -51,6 +51,7 @@ properties:
>            - const: renesas,rzn1-uart
>        - items:
>            - enum:
> +              - allwinner,sun60i-a733-uart

[Severity: High]
Is it safe to use "snps,dw-apb-uart" as a fallback for the A733?

When an OS binds to the generic "snps,dw-apb-uart" fallback, the 8250_dwlib
driver auto-probes offset 0xc0 (DW_UART_DLF) to detect DLF support:

drivers/tty/serial/8250/8250_dwlib.c:dw8250_setup_port() {
    ...
    old_dlf =3D dw8250_readl_ext(p, DW_UART_DLF);
    dw8250_writel_ext(p, DW_UART_DLF, ~0U);
    ...
}

Because 0xc0 is an active R/W RS485 register on the A733, the auto-probe wi=
ll
falsely succeed. The generic driver will then set p->set_divisor =3D
dw8250_set_divisor, which blindly overwrites the RS485 bits with fractional
divisor calculations on every baud rate change.

Can this corrupt the RS485 configuration and potentially trigger unintended
hardware states (such as bus collisions) on the RS485 line?

Furthermore, the generic fallback lacks the DW_UART_QUIRK_SKIP_SET_RATE
quirk, so it will erroneously attempt to call clk_set_rate() on the bus clo=
ck
gate during baud rate changes:

drivers/tty/serial/8250/8250_dw.c:dw8250_set_termios() {
    ...
    ret =3D clk_set_rate(d->clk, newrate);
    ...
}

Given that the generic fallback driver actively misbehaves on this hardware,
should the compatible definition omit the fallback string so that unmodified
kernels do not attempt to drive the A733 incorrectly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005172538.3985=
22-1-vinicius.eduardo.pedrosa@gmail.com?part=3D2
