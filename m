Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099893;
	b=VmKpNrIfYYx3Gt/uInUgRJSiTjsP3cXwCrWRaYWL41Y9vR8rt4fiEKWE3AGw+avbeWvI
	 oBCJaJ493tJ9/fTL3bWxrVO7COY+tXzP4tveu2xSpsVXfQP2pUNidhXcNyzXyRATwsppm
	 1TXr8uvF2mxOcsMcRFJNzLVkehXk+9N91LcZ2bPSgRfl/R+TI73blTbmtFcUdHMdFlSLQ
	 CptX8cbTxBkL6hxjP0KJYqluympuNifpE+UjjQh/7ciJ0/5893U9S3F81gAf1gOrjteeN
	 /ycHgZJ4nV71It+OoRjYEYngf6p8AdD6ukI1IZff/uMFrqtqo75oJtajDcbWPHP6hdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0AsyteYHdrx8ziO5wOUdV55Te7CpZXe4YrDNPXLZyzA=;
	b=kbpCdf1p6F+0lMh1c4ah2pnM02Kn3Un99KxkL/1PiaqIsc/H5CBvu5HKUXqlKkfs4Ccm
	 FKqphNW9E1AiKswjumpo2wqFub+Sl52cKydwMGHpc3oju/Hs8wJt2DSHcV/aAiSvgo9GP
	 ImRJBd6tv6pHk2Dy/uLMiFRSBXRuzkcDkAxQJ4dX3HDOR1CXHyaKwXBlQAI0u/A8BzjCR
	 HVy0U2ZxgMglb0CJ10JQL0Nr0nit/HUwuDKXl8r2+0CodoPoh1e/BIibd7wkSCN+zgmWh
	 Es6CaOrbzX7u5zAgTz4l4KDZC+wU/Q/440L3dDEgXp+Ur2NCKMKmOkyxdS2rPFoRUKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjszyJVP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0E606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjszyJVP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A951F01825;
	Tue, 27 Oct 2026 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099892;
	bh=0AsyteYHdrx8ziO5wOUdV55Te7CpZXe4YrDNPXLZyzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjszyJVPy9Mb9pofF+Fu6aQlZVm8JKvd14MTLoySGQVVtYJJlkciGWtUWqSjepXw+
	 XXqkPqlYfWR6xlu1KdqcFhBw8vH8Nv1yXcOS/HoFmc2oHgbOpoo9BoWzp+0X6+hY4w
	 nysYebKfCkoNZNZMQOJjQ9Dq4IKaxmgnBhw+tRTZZQ7l6NtwGWBaNVKsrRCnCVpkUU
	 u0uF/+oMom01wgSW/dfBFX1BMRuexYj/Ud7d9vsRKWjCwgr8icQuTHFH5SnpPxIIOX
	 ZNLQURWWRRL6fKIzNdTo3UsA2NhsSdeXkPe+rOgjE2dimHIzaYCE5/lIBmQQV2FB2x
	 7zXTAEofMSZsw==
Message-ID: <sashiko-outbox-186432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count
 against BAR size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:18:12 +0000
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
- [High] serial: 8250: returning 0 in pci_oxsemi_tornado_init() bypasses BA=
R size cap
--

commit 26f7484037e0f4875aba7039d37fa5afbc65ceb4
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: cap OxSemi Tornado UART count against BAR size

This commit caps the device-reported UART count in pci_oxsemi_tornado_init()
against the size of BAR0 based on the Tornado register layout.

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
> index 1dda63be6b893..9919504334bb7 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1083,6 +1083,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *=
dev)
>  	u8 __iomem *p;
>  	unsigned long deviceID;
>  	unsigned int  number_uarts =3D 0;
> +	resource_size_t bar_len;
> =20
>  	if (!pci_oxsemi_tornado_p(dev))
>  		return 0;
> @@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev =
*dev)
>  	/* Tornado device */
>  	if (deviceID =3D=3D 0x07000200) {
>  		number_uarts =3D ioread8(p + 4);
> +
> +		/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
> +		bar_len =3D pci_resource_len(dev, 0);
> +		if (bar_len >=3D 0x1000)
> +			number_uarts =3D min_t(unsigned int, number_uarts,
> +					     (bar_len - 0x1000) / 0x200);
> +		else
> +			number_uarts =3D 0;

[Severity: High]
If bar_len is smaller than 0x1200 (either because bar_len < 0x1000 or becau=
se
0x1000 <=3D bar_len < 0x1200 where (bar_len - 0x1000) / 0x200 evaluates to =
0),
or if ioread8(p + 4) returns 0, pci_oxsemi_tornado_init() sets number_uarts
to 0 and returns 0.

However, in the caller pciserial_init_ports() in
drivers/tty/serial/8250/8250_pci.c, a return value of 0 from quirk->init()
means "use board->num_ports" rather than 0 ports:

	if (quirk->init) {
		rc =3D quirk->init(dev);
		if (rc < 0) {
			priv =3D ERR_PTR(rc);
			goto err_out;
		}
		if (rc)
			nr_ports =3D rc;
	}

Because the Tornado board entries (such as pbn_oxsemi_1_15625000 through
pbn_oxsemi_8_15625000 in pci_boards[]) do not set FL_REGION_SZ_CAP in
board->flags, pci_default_setup() does not check idx against maxnr:

	if (board->flags & FL_REGION_SZ_CAP && idx >=3D maxnr)
		return 1;

	return setup_port(priv, port, bar, offset, board->reg_shift);

When pci_oxsemi_tornado_init() returns 0 on an undersized BAR0, won't
pciserial_init_ports() fall back to board->num_ports (up to 8 ports) and map
only bar_len bytes in setup_port() -> serial8250_pci_setup_port(), causing
out-of-bounds MMIO accesses at offsets 0x1000 + idx * 0x200 past the end of
BAR0?

Should pci_oxsemi_tornado_init() return a negative error code (such as
-ENODEV or -EINVAL) when number_uarts is 0 for a Tornado device so that
pciserial_init_ports() aborts probing instead of falling back to
board->num_ports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D11
