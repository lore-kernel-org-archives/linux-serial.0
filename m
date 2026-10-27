Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115916;
	b=gw2kP7zjo1ux3tkvUOlbXN6neA7ST7SGxi4LVjD8UjAawVED0m3LlXK+lKG7g/EohqD7
	 lcxIioAStgukUyxvmhKULpIn5OhDX/IZ/A4r8uSN8I4RuzgUTaZFvnKX+87N+NnwzWBIn
	 UgFmZps1ibJTglcr6JeyMYGs1oGwuRviqnfrnk+QT/vBIUbKZMBnyEDcnG3DFZW3OZado
	 emtzmqOuVxRTy6erj59/nvKhidO/hrDQxyp364YEy1UC4ktJLNlWW/I+gA0uzqbWocQQ1
	 i+XdqK8ybjQrGw9TGwruaCxaj89YmRXseX3aI2bFlCZHptwOTd/jMWSI+DejtvFSdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UNQl46VMsStUFN+cofYraOxa7DqEK5OrJRlhwOKz1Gg=;
	b=xnDIev2c5V+0FBZpkYrnzxplZcbpvNhDWt3Ei6zDFm5ixAA9svqE679U6tM3G2fI3B1A
	 LuzprEyLHywK8k+JV8x9E/jDd9qLaH6t+GMISm8TWx6EYPCb6PTkxaFXiBpssxuMdzH9G
	 0Wu/ssnr8c9RIvpiuypGpJMNJ/nsy8jI3liHWZzFyeoVkTL414Fp8GxG/miiXpo/aHvxW
	 9y5zTZ8qUZQOQMcurOzrZ1ueHXYVzMa/yqwqGjmp2EIou4+SOmirdj9UTN5KbnHtTDbc4
	 aB9vhMbowMI+8OOVnIMy9+LY+UoN57QeGoyWNg+QSDvvFVyJUIz03kNV8HmxdSdwYhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Os4o6LBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77124606D942;
	Tue, 27 Oct 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Os4o6LBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA32A1F01825;
	Tue, 27 Oct 2026 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115916;
	bh=UNQl46VMsStUFN+cofYraOxa7DqEK5OrJRlhwOKz1Gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Os4o6LBBlz9jrvmLgc5vX2uUW82XtoT3JjD9MW1UWlLHudZkwMTorHDSj7jUC+seJ
	 6oo7S1QMiSQDh5Hw1cDgLlezWVdZ0d2JZowyr8JgivCJ5eLzg06VlvyU++BJype0zR
	 Tt/z4O9OTqnktDt/q+rMxD47NNoAQEVDT6b/yGzxFVs4RDOzKuBrtwUvHfF92KNgQ4
	 YZ3eUrMJgltM0eVz2HOj8glHMtwYjBzl5aRb8fZzJH0qrTwecDx759/PSn1YlcFlsk
	 qnilsN07uke2g1UGZUNhEvNxzs6Pc4n4t1f28YwcbWSv3UdUMogvwa2PNyNdvadKAC
	 c7XiIE36jVf+w==
Message-ID: <sashiko-outbox-186865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/18] dt-bindings: mailbox: add the A210 AP to E902
 doorbell
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261027-a210-scmi-v1-4-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-4-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:45:15 +0000
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
- [Medium] dt-bindings: mailbox: zhihe,a210-ap-mailbox models software SCMI=
 usage in DT
--

commit e3663120f1bca9d6b72ccfedb9289dcb341101ef
Author: Han Gao <gaohan@iscas.ac.cn>

dt-bindings: mailbox: add the A210 AP to E902 doorbell

This patch adds the Devicetree binding schema for the Zhihe A210 application
processor to E902 doorbell mailbox controller.

> diff --git a/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mail=
box.yaml b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.=
yaml
> new file mode 100644
> index 0000000000000..4541750223eb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/zhihe,a210-ap-mailbox.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/zhihe,a210-ap-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Zhihe A210 application processor to E902 doorbell
> +
> +maintainers:
> +  - Han Gao <gaohan@iscas.ac.cn>
> +
> +description: |
> +  The A210 exposes a bidirectional notification channel between the
> +  application processors and E902 firmware. Payloads and transaction
> +  completion are managed by the client using shared memory. The firmware
> +  initializes the remote endpoint before the application processor binds.
> +  When firmware manages the endpoint clocks and keeps them running, omit
> +  clocks and clock-names to avoid a dependency on services using this ma=
ilbox.
> +
> +properties:
> +  compatible:
> +    const: zhihe,a210-ap-mailbox
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: Application processor interrupt status and control
> +      - description: Remote E902 notification channel
> +      - description:
> +          E902 to application processor channel data, which identifies t=
he
> +          channel that raised the shared interrupt
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: interrupt
> +      - const: tx
> +      - const: rx
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    items:
> +      - description: Application processor mailbox clock
> +      - description: E902 mailbox clock
> +  clock-names:
> +    items:
> +      - const: local
> +      - const: remote
> +  '#mbox-cells':
> +    const: 1
> +    description: |
> +      Channel index. Channel 0 carries requests to E902 and their comple=
tion.
> +      Channel 1 receives E902 notifications and requires the rx region.

[ ... ]

> +examples:
> +  - |
> +    mailbox@321000 {
> +        compatible =3D "zhihe,a210-ap-mailbox";
> +        reg =3D <0x321000 0x1000>, <0x311000 0x1000>, <0x320000 0x1000>;
> +        reg-names =3D "interrupt", "tx", "rx";

[Severity: Medium]
Does this binding model software-specific SCMI usage and driver probe
workarounds rather than the physical A210 ICU mailbox hardware?

Looking at the example and the corresponding driver in
drivers/mailbox/mailbox-a210.c alongside drivers/mailbox/mailbox-th1520.c, =
the
A210 uses the ICU mailbox architecture where 0x320000 (size 0x1000, the rx
INFO registers from E902) and 0x321000 (size 0x1000, the AP interrupt statu=
s,
clear, and mask registers) are adjacent 4 KiB slices of the same local AP
mailbox peripheral starting at 0x320000, while 0x311000 (size 0x1000, tx) is
the remote E902 ICU slice for the AP.

By splitting the contiguous local AP mailbox region out of address order and
placing 0x321000 first so that 0x320000 can be an optional third reg entry =
via
minItems: 2, the node unit-address becomes an interior offset (mailbox@3210=
00
instead of mailbox@320000), and a physically present hardware register bank
(0x320000) is marked optional depending on whether a client uses channel 1.

In addition, the description and #mbox-cells properties define the mailbox
channels in terms of SCMI shared-memory protocol roles (channel 0 for reque=
sts
and completion, channel 1 for notifications requiring the rx region), and t=
he
description instructs DT authors to omit clocks and clock-names when firmwa=
re
keeps the clocks running to avoid a circular dependency on services using t=
his
mailbox.

If those clocks are controlled via SCMI over this mailbox, referencing them
from the mailbox node creates a circular dependency that cannot resolve bef=
ore
probe; if they are physical SoC clock inputs, they are fixed hardware
connections that should not be conditionally omitted based on OS probe
ordering.

Should the binding instead describe the physical hardware layout (starting =
at
0x320000 with non-optional physical register regions) and hardware channel
endpoints without encoding SCMI client protocol behavior or clock omission
workarounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D4
