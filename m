Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665151;
	b=QxMZ8Q50wUXmx5x/nGFDtme+T9Uox/nexFq50Pg/PLiT//GAs3ppbPkyJals16odQ0SB
	 D583wv5A1rS8iS9Iyrzso7HOhP+3CqfATLdeD8iprT/gT8d+NMw+/6aJAd+MgoIN4Notu
	 /sDLdtSEehRVyIgDWOMWcQxboXvdViYKyrcCWXHr7KYcKERzneQ1zLyD2qE8nSTxzF0x4
	 nBhYtPyEOEo+ItM96LU+zl9BaOeIe0LnRLQ3i97q22eVx2LtjZvsAOZzG5qQPz648hx/p
	 TX9uIGwHPC36FfFx97pT1hGCA2FDhHnoULLf1dmW5tuWJpVvQz3ExQAX/iLUVRxAcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D3DRMxW5hdwwlOm3Hc350Jx9nWw6ye7l2TVN151lhQo=;
	b=Um1ylG7zxjjLDIJOmscguAkur0+7UEyBoFfAX2uU7K6gsFJY+Y/EhMXmRtJsc1Wc49+7
	 luphnG0VPDOH7+5f6wn5ojF5ZE8TMGkDD0hikeZC6MewnQ27xXEHXivSOVaKCw1ng2yEF
	 4Vm6Ha+jGaWOcizImmvMCbHYYy4VZ5QWfObB60Rd7jNoLAZ1Q+JyVOAk6rjNLvi2YWzPr
	 5fLkVq+Jdx/uHlssr3K6vxc8s82YfJEgKbCsuTrBi2+tVOKR8G6Uwzo/25f9ExKY0D6du
	 Ual5bov/ExxgmD4bqmMoBdpbtbN2/PUoG+c3Fw+jLJIUkH/R5EfoNsx1ih+0sxa/1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJHljwn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7710606A324;
	Tue,  3 Nov 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJHljwn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF31F000C1;
	Tue,  3 Nov 2026 00:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665150;
	bh=D3DRMxW5hdwwlOm3Hc350Jx9nWw6ye7l2TVN151lhQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJHljwn0ZvL0qOhTosjUJbm4ldqNCa/KjStpTYP3xqRWNV5Pny+6NDe2wpihm4/e8
	 C4q6cVD7iGz7pdwGDCQecb1tiGaozO3iVlC9hUrTceF9eIR3A565j5Fu9Ivygy7qbI
	 XRw+Y5sp7GwVXds4a9OEIzcpyyLslUhtnsa8ymxmckSs6fKJcsJHgmeH3TCL6H2DDN
	 a668BXCAEdtfswuAyQQuJoXSNBCBWtHokGdWEN3pL8qGdvLS5PkV04ACwqlsVsn4S8
	 YH6WI+TMIjVQVHR8+iSBtG9OQwGvnoNdSBqdpj46U4prEm13fLdMW4VDR3xADF5X5Z
	 lVeqzrCW1abog==
Message-ID: <sashiko-outbox-194371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>, devicetree@vger.kernel.org
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:19:09 +0000
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
- [Medium] dt-bindings: serial: 8250: missing RTL version in microchip,core=
16550
--

commit de9364d94e19f22c5fdbfabf92e9c1ea40cb4c1e
Author: Kohei Otsuka <kohei@spacemachines.com>

dt-bindings: serial: 8250: add Microchip Core16550

This commit adds the microchip,core16550 compatible string with ns16550a as=
 a
fallback to the 8250 serial Devicetree binding for the Microchip Core16550
FPGA soft IP core.

Link: https://github.com/linux4microchip/meta-mchp/issues/5

> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 50d5c977afa3d..33a5929bdaa69 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -137,6 +137,7 @@ properties:
>                - ti,da830-uart
>                - loongson,ls2k0500-uart
>                - loongson,ls2k1500-uart
> +              - microchip,core16550

[Severity: Medium]
Should this compatible string include the RTL version suffix (for example,
microchip,core16550-rtl-vN matching the Libero Core16550 major RTL release)
rather than using an unversioned microchip,core16550 name?

Unlike hard SoC peripherals whose IP revision is fixed by an SoC-specific
compatible string, Core16550 is a synthesizable soft IP core from Microchip=
's
Libero catalog that can be instantiated in FPGA fabric across different chip
families and IP revisions.

Existing Microchip FPGA soft IP core bindings follow the
microchip,<ip>-rtl-v<N> naming convention:

  Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml:
    - microchip,coreqspi-rtl-v2 # FPGA QSPI
    - microchip,corespi-rtl-v5 # FPGA CoreSPI

  Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml:
    - microchip,coregpio-rtl-v3

  Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml:
    - const: microchip,corei2c-rtl-v7 # Microchip Fabric based i2c IP core

  Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml:
    - const: microchip,corepwm-rtl-v4

Other soft 16550 IP cores in Documentation/devicetree/bindings/serial/8250.=
yaml
also include their RTL or IP version (opencores,uart16550-rtlsvn105 and
xlnx,xps-uart16550-2.00.b). Including the RTL version suffix would keep the
binding consistent with other Microchip soft IP cores and allow software to
distinguish between revisions if behavior (such as TEMT interrupt generation
or FIFO handling) changes across RTL releases.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-core16550-=
rs485-v1-0-6d15ebe1e5b9@spacemachines.com?part=3D1
