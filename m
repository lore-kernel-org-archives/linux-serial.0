Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295165;
	b=qKhUosApffTiRgKXlNI1tkNMB23VzEFQJ3v9nL1ACI9EnY2twNp0L07puqFCTKp/j31S
	 6E38BU2xNzQgqYzba+/H3RMqhrMOfnQQ0Up3aba9ZZxIp3B92KfvDG1/nyh0VdoAGTnyv
	 U2BGOJzFw5Ckr/7GItcxMnXzhRtJLkhwoIl8WJSHDhWAJp5O0gKBku5Nm/N/7gr6T+7wt
	 L+n5T7HZbtASqU+QQuIv10SoRxiNNUDLonW9x8aFHHyenJ7db+au7CtVs11nqgxK60F/5
	 2BHooRHnGqF6WkFM/r5pmMX2RySThTxF8LDPc6fkiips8k7PtQQOJrDk5rObNWi/zIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AQOuc6P4A7e7laZ5onDFzK/I38BHgS/Q4vVy1qpK7xE=;
	b=JB625cO+i+pHogJjybUCXT4ll5/KKmT/QCn8FdAHawR8hqdR+o4542TMBlXnsy311REK
	 fqGURKlcerV2MJV4YXfuQopxbZBw2Jtj0AupmQPczM9gqlM0J1d3bIuZlZiux3R2K9V6F
	 bI6jTLBOQ03Nd5R4+dFVg4QZKCk3TlZWDHYjXPycpmSiSCopUTnDyxPU5WhRxo7E4S55c
	 inxzaFOF/UT1851wJUSd3rdQCePmkFXpl9lXvH+5/wse4XPOvVzylDCJEHxV4WanfUcEI
	 PzTs+lvGo+5rIG3oBiIJPo1+P37kHwzaWNLYaNCdyQpvG1OnQDGg+bTJ7wHNG2IosRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUTQh97k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67521606A320;
	Sat, 21 Nov 2026 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUTQh97k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC3E1F000C6;
	Sat, 21 Nov 2026 21:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295165;
	bh=AQOuc6P4A7e7laZ5onDFzK/I38BHgS/Q4vVy1qpK7xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUTQh97ku3zVPvi5VUesmp6Lv1yCNCDc7kxHibtVdIn6FTD+R5nfpvL7i+TvfzbDO
	 wf2PhOzHj+ttjbc8s1WtKtbYOvPBy67KEAdSJYuxlkfVxPJfO0c9J0mu6258i5E8LT
	 FaEx8a0kwlUbx6DIS1RMR51Mnzlrnki2HGW4ZcGSrGoOYZRitEpfbJV4AJhU3hBFmi
	 6+VspxxMAj3E69UGcsOtE7Zki5nIDVW+5FW9sJG/eB01CWwja75mJPMAKNLZRcSfjz
	 fXu2Q9v/9S1Etv+NFRkir6lXAxnuVKJxjcnk/mYTA7raWVI+aSPlcOrzrSw0701aJE
	 d6X4XOXy6SKLg==
Message-ID: <sashiko-outbox-227370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122-b4-cs75xx-v8-6-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
 <20261122-b4-cs75xx-v8-6-5f971b0dc69c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:06:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: serial: cortina,cs7542-uart: interrupts listed
  before clocks
--

commit 9cf5cd80f03458b63f383ce2437badbe51f15cfd
Author: Fil Dunsky <filipp.dunsky@gmail.com>

dt-bindings: serial: Add Cortina Systems CS7542 UART

This commit adds the Device Tree binding schema for the UART found in the
Cortina Systems CS75xx (Goldengate G2) SoCs.

> diff --git a/Documentation/devicetree/bindings/serial/cortina,cs7542-uart=
.yaml b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
> new file mode 100644
> index 0000000000000..2879a71880239
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
> @@ -0,0 +1,52 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: cortina,cs7542-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@f0070110 {
> +        compatible =3D "cortina,cs7542-uart";
> +        reg =3D <0xf0070110 0x30>;
> +        interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&apb_clk>;
> +    };

[Severity: Low]
This isn't a bug, but clocks is normally listed before interrupts in
properties, required, and example nodes (compatible, reg, clocks,
interrupts).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-cs75xx-=
v8-0-5f971b0dc69c@gmail.com?part=3D6
