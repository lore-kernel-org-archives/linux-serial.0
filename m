Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862638;
	b=Yhm7qurJMayXU9lUf/NRaqHwnt3PF21X0lX6oYBNiIoJ3VcIxNY2f8GzpVuMKNJ8Ccbo
	 Ge7RsDfNJF397jAgosP9KOXanTkoOsfrwl6eSGxG1eBuML5f5yWoChMacf72bzPnh3BA7
	 uk6RJSsP3807VH9GZ0rqZfpIKK/0VasFHY95VJWXIN1N+tThk8NY0/K3Bhr0CoO0Tymbk
	 mNpqqUXjkiPFadZFWcTYnuZVb2fu5OkDSLQc3+5DvL+xTToGcOv5a1GwEZWon8+vG3dXX
	 qqidsHxjTtfsjfPmvWx7SqULltu+ZvgI+uvmqb1ajm224wQfI8UgntYPOwbcmDnPvkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862638;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=M9m5zzaSa9x02c7lCxTqJXB+aAtIcTuE3vabyXJlYe0=;
	b=Lhj5mnAjAGKY3EeseCs3U9nahSLSdcpKZSavCA8iPmogqGrensI830uzjlQHwuNl4qJg
	 61V2YVEa8uMpHN+7vTTlhJUdAJ0ZKDHWf0xAcFWoKFTImbhdXdAMy2ZDD7X/JYyEmk5w/
	 78XBW4jhim3c79lXpHI/kCWwXSf1pyR79Ixb53FZDHZ7zY2r4d/4E6mnA04b8SA//fgSQ
	 q1e2vnneItTgHTSauMW2sMHHRXRWMU6C4jFzD5rbOi5D/HeN+cpTA30dByO/EDsr9oiGV
	 fMFlCgsIPOZe+EqpLdb6z08z9/KYXghbf8Pu3Sxb2uiG5pjDEAqUfKzdYMaRB/eRQRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="abwLC/p2";
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="2Jq7/VTT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D2606A31A;
	Sat, 24 Oct 2026 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 205D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=abwLC/p2;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2Jq7/VTT
ARC-Seal: i=1; a=rsa-sha256; t=1792862626; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bFjv2h8C9fooxwGDjur2bBKmhkxWD8iMQO71jSZpt03sGOm2pffpBjztslvGPXd8m8
    oZPXAIEEfe9ISc/uoCoBfGXkkHP2E8mNYEgI0Ywx9R0x90XIdJprdRCowJQc+cR94tDR
    plETGz9n9HiyHGvcjQZ0xIlAIqSYjgj02IBGIqYBZ05Mc4+ZiVBQUV/SIQ+WYy0THv3W
    itSsSabToaDs9OpucpmGAXRCE+5vxcYUqH1h4JnqWZLYwUaoBApbomcd5L0oTA1lwL19
    h7cP8D+rb3LkUpsKiVmDcBaDCfWrShmpENWaTiFZ6m8HCfBl7coHWIfzvOtRoVI7cAMF
    2c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792862626;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M9m5zzaSa9x02c7lCxTqJXB+aAtIcTuE3vabyXJlYe0=;
    b=OZ7CYd8vWN1/qtzIzCdltFCK2faWcP6Nf+5Qs8moEsK1Pa/h6K1r+BY1TyrDLEM+hC
    1BstVBsvHtSX6nGxRgXttAasRwkhjJT/T0N4qFKRp5ajCYekEVZPX3hcgFbsIT63MSgh
    kL1OLjK/2IQScK6iFFWZ1ycXKuT5MEhjkYNgAuTKDVZnMakuuAr3Wr7W3sokymVgaQW5
    kJa2vSAtpli0k+OknqgEwqi9XXbbVGuRWeH8skEqnDmX7MvgFtyKV4zRe9HgpsU9r1Qb
    80lFqX5cu5NqxrVOIYpY3RvhCbbpr9+D9pP7e+WPltTnAc/QZ6M3AsKWziqlxi1fl9e2
    ga3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792862626;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M9m5zzaSa9x02c7lCxTqJXB+aAtIcTuE3vabyXJlYe0=;
    b=abwLC/p2md+SjBsSzF62IL4A5mo0slDrCt8vw5V1Sm/mK0n3TIPqKI9YRsiQLhfPxF
    /ZdjQuD7lx6EG+Yb3GEI9tFSAExuPiRT99odB6JX0SZBU1f2ZAXvU6jXUeKDqqFTkJYY
    EbODiQqlJOax3AZvFBJTUK++J9WwR8d6YkF0DTFZLLnRqgKAepEHMM2GESdnBR1NPt2/
    BpcM2Amx31zZJ239KnSPos1xq6T/NLAyn+NMJPUkfDOul0zqz+Xe3SZs84rIdlWO5VPq
    n5ABZdhSMQOibpQngJfP6jnrM1jtoybryzHON+4RCL1T6fd+Un2dhoPb8N9fODnSOQdz
    MZVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792862626;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M9m5zzaSa9x02c7lCxTqJXB+aAtIcTuE3vabyXJlYe0=;
    b=2Jq7/VTTRVBfmbeXTT0xwzHULw34qqan+v9q3EK3vu4cGIS8ovV9nBfO2PAms/XgWJ
    zUlWsSKtJqotPh+CfRBw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzptYNlV1C1yk7253raiyx+O3Hxli"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229OHNjwqO
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 19:23:45 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH 2/2] serial: 8250_ingenic: Start the X1600 UART from 16
 clocks a bit
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261024051515.55639-2-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 19:23:15 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACAE791A-545A-4AB7-842B-BD3F4ABE9208@goldelico.com>
References: <20261024051515.55639-1-olivier@mgcrea.io>
 <20261024051515.55639-2-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 24.10.2026 um 07:15 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600 UART samples each bit with UMR clocks, adjusted per bit by
> UACR, while the divisor the 8250 core computes assumes 16. The driver
> never sets them, so the UART keeps what ran before it: on a HiBy R1 =
the
> vendor kernel leaves UART0's UMR at 8, which by the register's meaning

So this patch adjusts a driver to a specific board and not the x1600 =
chip?

Then, this asks for a device tree property if it is really needed.

Or it should be fixed in U-Boot. Otherwise, assuming now that UMR =3D 16 =
is
correct for all x1600 boards would introduce a big issue for other =
boards
which suddenly stop working at the previously correct rate.

> doubles every rate set here (the line rate itself was not measured). =
The
> Bluetooth chip on that UART then never answers: "command 0xfc18 tx
> timeout" from hci_bcm.
>=20
> Add an X1600 entry that writes UMR =3D 16 and UACR =3D 0 at probe. The
> offsets come from Rockbox's X1600 register headers and match the UMR
> read on the R1. The X1000, whose compatible the X1600's falls back to,
> may have the same registers, but I could not check one, so it is left
> alone.

Well, it should be checked...

... the x1000 has the same register.

Of course it does not seem to be a standard 8250 register. Anyways,
it should be checked is how other 8250 drivers handle special/private
register setup.

Or this should even become part of the clock setup?

>=20
> Tested on a HiBy R1: UMR reads 16 and UACR 0 after probe, and the
> BCM43430A1 on UART0 comes up at 1.5 Mbaud and streams A2DP audio.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> The test on the R1 ran with the same reset placed in the X1000 entry; =
the
> R1's device tree lists "ingenic,x1600-uart" first, so it takes the =
same
> path with this version. Build-tested with W=3D1 on tty-next.
>=20
> drivers/tty/serial/8250/8250_ingenic.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c =
b/drivers/tty/serial/8250/8250_ingenic.c
> index 0cdadacd7019..40307189021b 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -25,6 +25,7 @@
> struct ingenic_uart_config {
> int tx_loadsz;
> int fifosize;
> + bool has_umr;
> };
>=20
> struct ingenic_uart_data {
> @@ -40,6 +41,10 @@ static const struct of_device_id of_match[];
> #define UART_MCR_MDCE BIT(7)
> #define UART_MCR_FCM BIT(6)
>=20
> +/* Clocks a bit, 16 for the divisor the 8250 core computes, and their =
per-bit adjustment. */
> +#define UART_UMR 9
> +#define UART_UACR 10
> +
> static struct earlycon_device *early_device;
>=20
> static uint8_t early_in(struct uart_port *port, int offset)
> @@ -298,6 +303,12 @@ static int ingenic_uart_probe(struct =
platform_device *pdev)
> }
> uart.port.uartclk =3D clk_get_rate(data->clk_baud);
>=20
> + /* Whatever ran before may have left another count: 8 on a HiBy R1. =
*/
> + if (cdata->has_umr) {
> + writel(16, uart.port.membase + (UART_UMR << uart.port.regshift));
> + writel(0, uart.port.membase + (UART_UACR << uart.port.regshift));
> + }
> +
> data->uport =3D serial8250_register_8250_port(&uart);
> if (IS_ERR(data->uport)) {
> err =3D PTR_ERR(data->uport);
> @@ -344,6 +355,12 @@ static const struct ingenic_uart_config =
x1000_uart_config =3D {
> .fifosize =3D 64,
> };
>=20
> +static const struct ingenic_uart_config x1600_uart_config =3D {
> + .tx_loadsz =3D 32,
> + .fifosize =3D 64,
> + .has_umr =3D true,

the x1000 has it as well. And even the jz4780. So correctly setting this
flag (as it is named) for more SoC variants will break more boards...

> +};
> +
> static const struct of_device_id of_match[] =3D {
> { .compatible =3D "ingenic,jz4740-uart", .data =3D &jz4740_uart_config =
},
> { .compatible =3D "ingenic,jz4750-uart", .data =3D &jz4760_uart_config =
},
> @@ -352,6 +369,7 @@ static const struct of_device_id of_match[] =3D {
> { .compatible =3D "ingenic,jz4775-uart", .data =3D &jz4760_uart_config =
},
> { .compatible =3D "ingenic,jz4780-uart", .data =3D &jz4780_uart_config =
},
> { .compatible =3D "ingenic,x1000-uart", .data =3D &x1000_uart_config =
},
> + { .compatible =3D "ingenic,x1600-uart", .data =3D &x1600_uart_config =
},

No, this is not special to the x1600, but a workaround of some peculiar
setup of your bootloader.

> { /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, of_match);
> --=20
> 2.39.5

BR, H. Nikolaus Schaller <hns@goldelico.com>=
