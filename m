Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EA153598;
	Tue,  4 Feb 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692308; cv=none; b=WcBlM1XrDRexDsiUDwawNv3jV9mYAO8DqeP14KDR01VbKoXmvmAPlaqtsWLUC0SyzAoyX3Yg1c1U7/KehsnwSPw05DtHS/6md0IOtDBXm0wfkyKRVfUeqUVuosjnwkCd4CAjXhJWJl7yOYXizjvEEmSqVR/I31fwGg4kld0OLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692308; c=relaxed/simple;
	bh=rPWErur0muffrrd68Q+PJ4Le9SEMJHK5eMUGEmuJyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+sfqkYbjgkFAOU/OTB4P3nKA9nqRYeLIe8k+jcU/K3vZpgKdiuom3EWp/0aeAH6ds33utjVIxIwdo/fqeBX42AOj9dMGCCENOseT8H/A9p2ZygV3hCiEFjqBWGp3vgSX827ckON/FDWrnrSE7cYlHDLLRFa7fvaX0PhsgaLIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: /W14jKo9SnqoXZ6UVIw52w==
X-CSE-MsgGUID: s/VAe+AHSGC6FtnWNa5NPQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 03:05:03 +0900
Received: from [10.24.1.103] (unknown [10.24.1.103])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C83A540065D0;
	Wed,  5 Feb 2025 03:04:58 +0900 (JST)
Message-ID: <46ae969b-f24a-42cc-8477-70d9e8f8c057@bp.renesas.com>
Date: Tue, 4 Feb 2025 18:04:57 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] serial: sh-sci: Introduced function pointers
Content-Language: en-GB
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250129165122.2980-1-thierry.bultel.yh@bp.renesas.com>
 <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------x0NxAdUVowxnEZRev3B96Dkd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------x0NxAdUVowxnEZRev3B96Dkd
Content-Type: multipart/mixed; boundary="------------eioP0Hm1VW2OG9xKJGS5LRub";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-ID: <46ae969b-f24a-42cc-8477-70d9e8f8c057@bp.renesas.com>
Subject: Re: [PATCH 09/14] serial: sh-sci: Introduced function pointers
References: <20250129165122.2980-1-thierry.bultel.yh@bp.renesas.com>
 <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>
In-Reply-To: <20250129165122.2980-10-thierry.bultel.yh@bp.renesas.com>

--------------eioP0Hm1VW2OG9xKJGS5LRub
Content-Type: multipart/mixed; boundary="------------cRVittwlHBbNPvmnaF1dlDuM"

--------------cRVittwlHBbNPvmnaF1dlDuM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

I've just had time to review the header file changes in this patch
today.

On 29/01/2025 16:37, Thierry Bultel wrote:
> The aim here is to prepare support for new sci controllers like
> the T2H/RSCI whose registers are too much different for being
> handled in common code.
>=20
> This named serial controller also has 32 bits register,
> so some return types had to be changed.
>=20
> The needed generic functions are no longer static, with prototypes
> defined in sh-sci-common.h so that they can be used from specific
> implementation in a separate file, to keep this driver as little
> changed as possible.
>=20
> For doing so, a set of 'ops' is added to struct sci_port.
>=20
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c        | 339 +++++++++++++++--------------=

>  drivers/tty/serial/sh-sci_common.h | 178 +++++++++++++++
>  2 files changed, 349 insertions(+), 168 deletions(-)
>  create mode 100644 drivers/tty/serial/sh-sci_common.h

[snip]

> diff --git a/drivers/tty/serial/sh-sci_common.h b/drivers/tty/serial/sh=
-sci_common.h
> new file mode 100644
> index 000000000000..cbfacdc1a836
> --- /dev/null
> +++ b/drivers/tty/serial/sh-sci_common.h
> @@ -0,0 +1,178 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __SH_SCI_COMMON_H__
> +#define __SH_SCI_COMMON_H__
> +
> +#define SCI_MAJOR	204
> +#define SCI_MINOR_START	8
> +
> +#include <linux/serial_core.h>
> +
> +enum SCI_CLKS {
> +	SCI_FCK,		/* Functional Clock */
> +	SCI_SCK,		/* Optional External Clock */
> +	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
> +	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
> +	SCI_NUM_CLKS
> +};
> +
> +/* Offsets into the sci_port->irqs array */
> +enum {
> +	SCIx_ERI_IRQ,
> +	SCIx_RXI_IRQ,
> +	SCIx_TXI_IRQ,
> +	SCIx_BRI_IRQ,
> +	SCIx_DRI_IRQ,
> +	SCIx_TEI_IRQ,
> +	SCIx_NR_IRQS,
> +
> +	SCIx_MUX_IRQ =3D SCIx_NR_IRQS,	/* special case */
> +};
> +
> +/* Bit x set means sampling rate x + 1 is supported */
> +#define SCI_SR(x)		BIT((x) - 1)
> +
> +extern void sci_release_port(struct uart_port *port);
> +extern int sci_request_port(struct uart_port *port);
> +extern void sci_config_port(struct uart_port *port, int flags);
> +extern int sci_verify_port(struct uart_port *port, struct serial_struc=
t *ser);
> +extern void sci_pm(struct uart_port *port, unsigned int state,
> +		   unsigned int oldstate);
> +extern void sci_enable_ms(struct uart_port *port);
> +
> +#ifdef CONFIG_CONSOLE_POLL
> +extern int sci_poll_get_char(struct uart_port *port);
> +extern void sci_poll_put_char(struct uart_port *port, unsigned char c)=
;

The extern keyword isn't needed for function definitions in header
files.

> +#endif /* CONFIG_CONSOLE_POLL */
> +
> +struct plat_sci_reg {
> +	u8 offset, size;

Please define struct members on separate lines.

> +};
> +
> +/* The actual number of needed registers depends on the sci controller=
;
> + * using this value as a max covers both sci and rsci cases
> + */
> +#define SCI_NR_REGS 20
> +
> +struct sci_port_params_bits {
> +	unsigned int rxtx_enable;
> +	unsigned int te_clear;
> +	unsigned int poll_sent_bits;
> +};
> +
> +struct sci_common_regs {
> +	unsigned int status;
> +	unsigned int control;
> +};
> +
> +struct sci_port_params {
> +	const struct plat_sci_reg regs[SCI_NR_REGS];

I don't see any usage of the regs field of this struct - is it needed?
If not, can we also get rid of SCI_NR_REGS?

> +	const struct sci_common_regs *common_regs;
> +	unsigned int fifosize;
> +	unsigned int overrun_reg;
> +	unsigned int overrun_mask;
> +	unsigned int sampling_rate_mask;
> +	unsigned int error_mask;
> +	unsigned int error_clear;
> +	struct sci_port_params_bits param_bits;

It looks like we always initialise param_bits via a `static const struct
sci_port_params_bits` instance. Is there any reason we copy the contents
of this into the sci_port_params instance instead of using a pointer?

> +};
> +
> +struct sci_port_ops {
> +	u32 (*read_reg)(struct uart_port *port, int reg);
> +	void (*write_reg)(struct uart_port *port, int reg, int value);
> +	void (*clear_SCxSR)(struct uart_port *port, unsigned int mask);
> +
> +	void (*transmit_chars)(struct uart_port *port);
> +	void (*receive_chars)(struct uart_port *port);
> +
> +	void (*poll_put_char)(struct uart_port *port, unsigned char c);
> +
> +	int (*set_rtrg)(struct uart_port *port, int rx_trig);
> +	int (*rtrg_enabled)(struct uart_port *port);
> +
> +	void (*shutdown_complete)(struct uart_port *port);
> +
> +	unsigned int (*get_ctrl_temp)(struct uart_port *port, unsigned int ct=
rl);

I think we need a better name for this one. ctrl_temp is just the name
of the value we want to write to the control register in the
serial_console_write function, the name doesn't give any clue as to its
intended function.

Perhaps it would be better to define a prepare_console_write operation
which modifies the control register state and returns the old control
register state (so that it can later be restored). That would result in
a little more code duplication but it'd be easier to understand.

> +};

[snipped the rest]

Thanks,

--=20
Paul Barker
--------------cRVittwlHBbNPvmnaF1dlDuM
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------cRVittwlHBbNPvmnaF1dlDuM--

--------------eioP0Hm1VW2OG9xKJGS5LRub--

--------------x0NxAdUVowxnEZRev3B96Dkd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ6JWyQUDAAAAAAAKCRDbaV4Vf/JGvfeB
AP97VmLRTev40THQumFlvJDrpXZMjoO2FwHLQ/u8M2tjnQEAnwocJDdjqM1zsGyZXSP47a3N6+B7
FDDNxnarHgU4kAw=
=al0R
-----END PGP SIGNATURE-----

--------------x0NxAdUVowxnEZRev3B96Dkd--
