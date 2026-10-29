Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250918;
	b=bTAEprLoOfVPWS2lV1Py101GK1S/LHBcAX03b9A/lJdWR9u209Pw68TkgOIjYh2ibseO
	 Q1qx5cbVcqYVP5yOYaJ8ht7GeVQsgOs5XtdpWDz1KCw0Z8SQzS24xPa+Ph7YJ//ccq+8b
	 E+DTUhR9Nouny7U0V+fypw+3OM/8dSpnMV3rp8MF+BbgOhcHp34bVzIEtGBTtUFuOOBWh
	 Shzai077nDCKpik0b8WDNKrkkSFIV3F+uz35La6n+IRBqBFMcGm4PuIDVtXKN7Z3Rjvk0
	 Mj9CRvtivPOSoW5lKxwW+wxLpNwsBxwULAz7coiYVmJLbUyZZxUYW2WKL4PTz7/6gcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bzpZXYV5Y+s9QuvDS8yWpiGVzX4IZyPP+trA01Cvxs0=;
	b=C+QoHbnDgNMsrIGhmvBaSWfBAlns/SoaRM4DTsBUjik8+J+hyFdp7q/rPlyrBWPE1CJV
	 d2HRikmOrCFa9xCuy/mC9HWxU+I1vDhO+/Sfi3waCIQQLAujH7spyt8hf7Pvho9iC4oh7
	 7dOeItiN+3tdqOZQysLyBxk938KDxrKOv5GyFZ3Yl441GlCY3P8w+W+Ie4OkPlLCaOnmB
	 2pybHDFEDc+2tL8c5GizTQ02A1Ga2Jqv0SKysCEtGNZI4iPcq4WMT4G4R1L1UuRakj+r5
	 1WWI1jo0n9exeVNwct0rjY+7NSWsIWufCdbqjbraB72SL0+NHx/F8GHxAozxQPVCLbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmdctj8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98859606A31A;
	Thu, 29 Oct 2026 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmdctj8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BCB1F01825;
	Thu, 29 Oct 2026 05:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250918;
	bh=bzpZXYV5Y+s9QuvDS8yWpiGVzX4IZyPP+trA01Cvxs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rmdctj8cJp2xOATIxhQ5PjhECk1b+7wDoSpKy9yv4MRV4W50EnClK+lt4J3EBn6Ac
	 QUW/+3fRGpIc99RM5clufflTqkGv3Ljy2b0MtHh4LlIiyWQGtMcRAv1s9do2UkU5Xj
	 sGF1Rf4TCZZ5ugVMl0Jqknw3mNtNsQ/0evjHG115iREQLvq7YMg7Zu71PMfo2COS9U
	 VSpbccbCEhyCemgKcrLADTPU4LM+XqdXuY4UwPSaN5wLbv4e2mn2U35dFPQb9zuTf3
	 Uh7aFZJbwJaWBPHA3XUo0moG6TfnWZ9MCRSok3t5fgxehUe0ebEE5Q+SevxTA369C4
	 wQgf2giM2BjNg==
Message-ID: <sashiko-outbox-188747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/12] dt-bindings: serial: Add BL808 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261029-rust-bl808-console-v1-5-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-5-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:15:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: serial: missing SoC-specific compatible in bflb,uar=
t.yaml
- [Low] dt-bindings: serial: unused label in bflb,uart.yaml example
--

commit 1bdd5b51639067c3a28b1a40beeb8fbfbbc65a65
Author: Kwanghoon Son <asdfkwang@gmail.com>

dt-bindings: serial: Add BL808 UART

This commit adds the Device Tree binding schema for the Bouffalo Lab UART
controller, describing its register range, interrupt, and baud clock input.

Link: https://docs.zephyrproject.org/latest/build/dts/api/bindings/serial/b=
flb,uart.html

> diff --git a/Documentation/devicetree/bindings/serial/bflb,uart.yaml b/Do=
cumentation/devicetree/bindings/serial/bflb,uart.yaml
> new file mode 100644
> index 0000000000000..df29d258f0a1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bflb,uart.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/bflb,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalo Lab UART Controller
> +
> +description: |
> +  UART IP used by Bouffalo Lab SoCs. Initial Linux support covers the
> +  BL808 controller with a 32-byte FIFO. The compatible follows Zephyr.
> +
> +maintainers:
> +  - Kwanghoon Son <asdfkwang@gmail.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: bflb,uart

[Severity: Medium]
Should the compatible property in Documentation/devicetree/bindings/serial/=
bflb,uart.yaml
include a SoC-specific compatible string such as bflb,bl808-uart (either
alone or with bflb,uart as a fallback), and should the description section
describe the hardware rather than what Linux currently supports?

Documentation/devicetree/bindings/writing-bindings.rst requires SoC-specific
compatible strings for SoC devices rather than generic vendor-wide names, a=
nd
notes that bindings should describe the hardware rather than what an OS or
driver currently supports.

In the accompanying driver (drivers/tty/serial/bflb_uart.rs), tx_empty()
relies on a hardcoded 32-byte FIFO depth to check whether all TX FIFO slots
are free:

    const FIFO_DEPTH: u32 =3D 32;
    ...
    fn tx_empty(&self) -> bool {
        self.read::<FIFO_CONFIG1>() & TX_FIFO_CNT_MASK =3D=3D FIFO_DEPTH
    }

Without a SoC-specific compatible string like bflb,bl808-uart, Device Trees
using only bflb,uart cannot distinguish the BL808 UART from other Bouffalo =
Lab
SoCs with different FIFO depths or hardware capabilities without breaking t=
he
DT ABI.

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    uart3: serial@30002000 {
> +        compatible =3D "bflb,uart";

[Severity: Low]
Can the unused uart3 label be dropped from the serial@30002000 node in the
examples section of Documentation/devicetree/bindings/serial/bflb,uart.yaml?

Because uart3 is never referenced by a phandle in the example, running
scripts/dtc/dt-check-style --mode=3Dstrict reports an unused-labels warning=
 in
check_unused_labels().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D5
