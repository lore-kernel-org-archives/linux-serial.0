Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DF374E7F;
	Sat,  3 Oct 2026 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991197; cv=none; b=vErm64g4hP51AY0bhsdQZjBhH8Rfnl/f2NXxAWdVEmKRzXu93v/EvrnfiC0gdAIDa32m/UnfYgagFFNMZvipf/TJcFRmQ0NdwaXb+S/JLhSVO/EXS5r6IswReNLimRL8opwMbYJlqL4Kb4nPrjsjtjBn2OMD42qYtQwtij+kl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991197; c=relaxed/simple;
	bh=qPLcfKmG0ie8ZIPM6e5n3R5vqh74qkocTAMN6dWDXmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRD8T0L0swTDu05KpJl9yQFh7mTtWtlCExpukZS6PUYL0LeW8FKFNo8O3oCYV4ccL16E9R/pPL4946vvTZm76MaGELupOAf1cZJCvbyNEEACwCtMFyA6STUB4U+AGKH78wj0TrrTXwDs9KZZEpE+HOr9/BT3wWD6TN1+43bGT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJlwf1Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJlwf1Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8541F000FF;
	Sat,  3 Oct 2026 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991195;
	bh=G2D8UEN24dTXan+vYlPB15K4SSQ7OVSpTTNwIi59SS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJlwf1GhwROfkmA0dMssI1Y2CkyuxxJAagHFzi6Eqw7n5V0IfMTkDL8BmQ96kARWy
	 wTMeXNgX+sCTprM4N7TGhx5lFhj+X8/yyhkttQZiAIfnq9gt2wHr60312jAaMlRpnB
	 +EVK3pvVpGkH1HlumCXv5GeOA3SvUGLoNDOG1hernyHIuFelio71ZgKmUDUvneJvUX
	 Wk/5ecJ8aPejipQVXDnchUMou8HRlsP1v49zf8bzbsNlVud+ihuPXQlvgxxWVZhvWG
	 WtyyBG62DUhPg99UsFeiUUlFLafGCz7fPmybp0gwGnIpIvHnvGnoTitoF/Ryf0dA2j
	 ARTBuumena3pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/38] mfd: ioc3: add support for IOC4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: lee@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <ceef655fed6e8fdc2f7d34a82fd3e4eb21b64855.1790857966.git.kaloz@kernel.org>
References: <cover.1790857966.git.kaloz@kernel.org>
 <ceef655fed6e8fdc2f7d34a82fd3e4eb21b64855.1790857966.git.kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:15 +0000
Message-Id: <20261003013315.AA8541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mfd: NULL pointer dereference due to complex pointer in pci_device=
_id match table
- [Low] mfd: ioc4_cells array is not static const
- [Low] mfd: ioc3: commit message capitalization violation
--

commit 6ec254319e574e5b3a17ca8a7e4c5206dfed5e04
Author: Imre Kaloz <kaloz@kernel.org>

mfd: ioc3: add support for IOC4

This commit adds support for IOC4, which is IOC3's successor on IP35 Origin
350-class boards. It reuses the serial and PS/2 drivers of IOC3 and splits
interrupt status into two banks.

> mfd: ioc3: add support for IOC4

[Severity: Low]
Does this commit title violate the MFD subsystem formatting requirements?

The MFD subsystem conventions mandate that the description after the subsys=
tem
prefix must always be capitalized (e.g., "mfd: ioc3: Add support...").

> diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
> index 5f8ac364b610e..fd50bae0f10b3 100644
> --- a/drivers/mfd/ioc3.c
> +++ b/drivers/mfd/ioc3.c

[ ... ]

> @@ -565,8 +605,11 @@ static int ioc3_setup(struct ioc3_priv_data *ipd)
>  static int ioc3_mfd_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *pci_id)
>  {
> +	const struct ioc3_variant *var =3D (void *)pci_id->driver_data;

[Severity: High]
Is it safe to blindly retrieve the pointer from driver_data?

If the driver is bound to a device dynamically via the sysfs 'new_id'
interface (where driver_data often defaults to 0), the 'var' pointer becomes
NULL.

>  	struct ioc3_priv_data *ipd;
> -	struct ioc3 __iomem *regs;
> +	void __iomem *base;
> +	unsigned int i;
> +	u16 cmd;
>  	int ret;
> =20
>  	ret =3D pci_enable_device(pdev);
> @@ -576,6 +619,12 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
>  	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, IOC3_LATENCY);
>  	pci_set_master(pdev);
> =20
> +	if (var->pci_command) {

[Severity: High]
Does this cause a NULL pointer dereference if 'var' is NULL?

As mentioned above, if 'driver_data' is 0, 'var' will be NULL, leading to a
crash here. The MFD subsystem guidelines explicitly prohibit passing complex
pointers through match data tables and mandate using an integer ID/enum,
selecting the static const data in the probe function.

[ ... ]

> @@ -649,12 +708,152 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)

[ ... ]

> +#define IOC4_SERIAL_CELL(port) {					\
> +	.name =3D "ioc3-serial8250",					\
> +	.resources =3D ioc4_uart_resources[port],				\
> +	.num_resources =3D ARRAY_SIZE(ioc4_uart_resources[port]),		\
> +	.platform_data =3D &ioc4_serial_pdata,				\
> +	.pdata_size =3D sizeof(ioc4_serial_pdata),			\
> +}
> +
> +static struct mfd_cell ioc4_cells[] =3D {

[Severity: Low]
Should this array be declared as 'static const'?

The MFD subsystem guidelines strictly require that mfd_cell arrays must be
defined as 'static const' to prevent dynamic platform data amendments and
memory safety hazards. The newly introduced 'ioc4_cells' array is missing t=
he
'const' qualifier.

> +	IOC4_SERIAL_CELL(0),
> +	IOC4_SERIAL_CELL(1),

[ ... ]

> +static const struct ioc3_variant ioc4_variant =3D {
> +	.name =3D "IOC4",
> +	.chip =3D &ioc4_irq_chip,
> +	.banks =3D ioc4_irq_banks,
> +	.nr_banks =3D ARRAY_SIZE(ioc4_irq_banks),
> +	.nr_irqs =3D IOC4_NUM_IRQS,
> +	/* Parity and SERR# reporting, as the SN2 IOC4 core enabled them. */
> +	.pci_command =3D PCI_COMMAND_PARITY | PCI_COMMAND_SERR,
> +	.setup =3D ioc4_setup,
> +};
> +
>  static struct pci_device_id ioc3_mfd_id_table[] =3D {
> -	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
> +	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID,
> +	  0, 0, (kernel_ulong_t)&ioc3_variant },
> +	{ PCI_VENDOR_ID_SGI, 0x100a, PCI_ANY_ID, PCI_ANY_ID,
> +	  0, 0, (kernel_ulong_t)&ioc4_variant },
>  	{ 0, },
>  };

[Severity: High]
Is it safe to embed complex pointers in the match table?

The patch passes a pointer to 'ioc3_variant' / 'ioc4_variant' through the
pci_device_id match table's driver_data field. The MFD subsystem guidelines
explicitly prohibit this and mandate using an integer ID/enum, selecting the
static const data in the probe function instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790857966.gi=
t.kaloz@kernel.org?part=3D26
