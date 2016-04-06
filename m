From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v7 0/5] ACPI: parse the SPCR table
Date: Wed, 06 Apr 2016 15:00:13 -0400
Message-ID: <1459969213.23766.7.camel@redhat.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
	 <1459873627.10130.21.camel@redhat.com> <5704E3CC.8000104@linaro.org>
	 <20160406105252.GB2820@xora-haswell.xora.org.uk>
	 <1459952294.10130.32.camel@redhat.com>
	 <570538F0.1030701@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <570538F0.1030701@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, linux-serial@vger.kernel.org, Len Brown <lenb@kernel.org>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-06 at 09:27 -0700, Peter Hurley wrote:
> On 04/06/2016 07:18 AM, Mark Salter wrote:
> >=20
> > On Wed, 2016-04-06 at 11:52 +0100, Graeme Gregory wrote:
> > >=20
> > > On Wed, Apr 06, 2016 at 01:24:12PM +0300, Aleksey Makarov wrote:
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > On 04/05/2016 07:27 PM, Mark Salter wrote:
> > > > >=20
> > > > >=20
> > > > > Could you CC me on future postings of this series, please?
> > > > >=20
> > > > > So v3 fixed a problem where platforms using 8250 didn't work.
> > > > > Then in v5, that fix was lost so 8250 no longer works.
> > > > That fix was dropped because now this is implemented differentl=
y.=C2=A0=C2=A0
> > > > Now the code uses the existing match() member of struct console=
=2E
> > > > It has already been implemented for 8250.=C2=A0=C2=A0
> > > > Probably SPCR table specifies incorrect data.
> > > > It was reported that D02 board has similar issue.
> > > >=20
> > > The D02 issue referred to is the 8250 implementation they used ha=
s 32bit
> > > only MMIO access which there is no manner to represent in SPCR. I=
t also
> > > doesn't use the "standard" 16550 clock rate so supplying a baud r=
ate
> > > makes it change to a random baud rate.
> > So, the problem with Mustang and m400 was the mmio vs mmio32.
> Bummer. Maybe that firmware can use a different DBG2 port designation=
 to
> indicate it's a DesignWare 8250 (or generically 32-bit mmio).
>=20
> >=20
> > Right now,
> > the kernel only supports mmio32 in the 8250_dw.c driver when probed=
 with
> > ACPI.
> While that's true specifically for DesignWare 8250 + ACPI, that's not
> true for _all_ 8250 + ACPI.
>=20
> >=20
> > Other x86 machines just use legacy 8250 ports which don't need
> > entries in the DSDT and use legacy io.
> I find that statement hard to believe. I know for a fact ia64 servers=
 didn't,
> so the assertion that SPCR + 16550 + MMIO automatically means 32-bit =
data width
> seems unlikely.

You're right. Other than DesignWare, 8250 ports can be descibed with PN=
P IDs
which is the bit I was missing. And all of those assume 8-bit width. So=
 it
seems a DBG2 port designation for 8250 with 32-bit mmio is needed.

>=20
> In fact, I suspect the opposite is true; that before these arm64 desi=
gns,
> SPCR + 16550 + MMIO automatically meant 8-bit data width, which is wh=
y it's
> unspecified in the SPCR table.
>=20
> Regards,
> Peter Hurley
>=20
>=20
> >=20
> > The 8250_dw driver does support
> > non-standard clocks specified in the DSDT. That works fine for Must=
ang
> > and m400.
> >=20
> > So with this quick hack, v7 is working with Mustang/m400:
> >=20
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index 68ffc33..dade9de 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -37,6 +37,7 @@ int __init parse_spcr(bool earlycon)
> > =C2=A0	acpi_status status;
> > =C2=A0	char *uart;
> > =C2=A0	char *iotype;
> > +	int mmio;
> > =C2=A0	int baud_rate;
> > =C2=A0	int err;
> > =C2=A0
> > @@ -56,8 +57,8 @@ int __init parse_spcr(bool earlycon)
> > =C2=A0		goto done;
> > =C2=A0	}
> > =C2=A0
> > -	iotype =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYST=
EM_MEMORY ?
> > -			"mmio" : "io";
> > +	mmio =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM=
_MEMORY;
> > +	iotype =3D mmio ? "mmio" : "io";
> > =C2=A0
> > =C2=A0	switch (table->interface_type) {
> > =C2=A0	case ACPI_DBG2_ARM_SBSA_32BIT:
> > @@ -71,6 +72,8 @@ int __init parse_spcr(bool earlycon)
> > =C2=A0	case ACPI_DBG2_16550_COMPATIBLE:
> > =C2=A0	case ACPI_DBG2_16550_SUBSET:
> > =C2=A0		uart =3D "uart";
> > +		if (mmio)
> > +			iotype =3D "mmio32";
> > =C2=A0		break;
> > =C2=A0	default:
> > =C2=A0		err =3D -ENOENT;
> >=20
> > >=20
> > >=20
> > > We may need two 8250 subset entries, one just means no clock give=
n, and
> > > one no clock given + mmio32 only.
> > >=20
> > > Graeme
> > >=20
> > >=20
> > > >=20
> > > >=20
> > > > Thank you
> > > > Aleksey Makarov
> > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > --Mark
> > > > >=20
> > > > >=20
> > > > > On Thu, 2016-03-31 at 16:40 +0300, Aleksey Makarov wrote:
> > > > > >=20
> > > > > >=20
> > > > > > 'ARM Server Base Boot Requirements' [1] mentions SPCR (Seri=
al Port
> > > > > > Console Redirection Table) [2] as a mandatory ACPI table th=
at
> > > > > > specifies the configuration of serial console.
> > > > > >=20
> > > > > > Move "earlycon" early_param handling to earlycon.c to parse=
 this option once
> > > > > >=20
> > > > > > *** PATCH=C2=A0=C2=A0"ACPICA: Headers: Add new constants fo=
r the DBG2 ACPI table"
> > > > > > *** IS JUST TO ENABLE BUILDING THE PATCHSET ON linux-next
> > > > > >=20
> > > > > > Patch "ACPICA: Headers: Add new constants for the DBG2 ACPI=
 table" is required
> > > > > > for the next patch.=C2=A0=C2=A0It is taken from ACPICA seri=
es [3], but it has not appeared
> > > > > > in linux-next yet.
> > > > > >=20
> > > > > > Parse SPCR table, setup earlycon and add register specified=
 console.
> > > > > >=20
> > > > > > Enable parsing this table on ARM64.=C2=A0=C2=A0Earlycon sho=
uld be set up
> > > > > > as early as possible.=C2=A0=C2=A0ACPI boot tables are mappe=
d in
> > > > > > arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from=
 setup_arch()
> > > > > > and that's where we parse spcr.=C2=A0=C2=A0So it has to be =
opted-in per-arch.
> > > > > >=20
> > > > > > Implement console_match() for pl011.
> > > > > >=20
> > > > > > Based on the work by Leif Lindholm [4]
> > > > > > Thanks to Peter Hurley for explaining how this should work.
> > > > > >=20
> > > > > > Should be applied to next-20160331.
> > > > > >=20
> > > > > > Tested on QEMU.=C2=A0=C2=A0SPCR support is included in QEMU=
's ARM mach-virt
> > > > > > since 2.4 release.
> > > > > >=20
> > > > > > v7:
> > > > > > - add Acked-by: Rob Herring for "of/serial: move earlycon e=
arly_param handling
> > > > > > =C2=A0 to serial"
> > > > > > - call DT earlycon initialization from the arch ACPI code, =
not from parse_spcr()
> > > > > > =C2=A0 (Rafael J. Wysocki)
> > > > > > - fix a few minor issues (Rafael J. Wysocki)
> > > > > >=20
> > > > > > v6:
> > > > > > https://lkml.kernel.org/g/1458823925-19560-1-git-send-email=
-aleksey.makarov@linaro.org
> > > > > > - add documentation for parse_spcr() functioin (Yury Norov)
> > > > > > - don't initialize err variable (Yury Norov)
> > > > > > - add __initdata for the earlycon_init_is_deferred flag var=
iable
> > > > > > - rename the function exported in "of/serial: move earlycon=
 early_param handling
> > > > > > =C2=A0 to serial" to avoid clash with the function from arc=
h/microblaze/kernel/prom.c
> > > > > > - defer initialization of DT earlycon until DT/ACPI decisio=
n is made
> > > > > > =C2=A0 (Rob Herring, Peter Hurley)
> > > > > > - use snprintf instead of sprintf (Andy Shevchenko)
> > > > > > - drop patch that adds EARLYCON_DECLARE for pl011 as EARLYC=
ON_DECLARE is
> > > > > > =C2=A0 equivalent to OF_EARLYCON_DECLARE for 4.6+ (Peter Hu=
rley).=C2=A0=C2=A0This means that
> > > > > > =C2=A0 SPCR earlycon will not work on the kernels before 4.=
6
> > > > > >=20
> > > > > > v5:
> > > > > > https://lkml.kernel.org/g/1458643595-14719-1-git-send-email=
-aleksey.makarov@linaro.org
> > > > > > - drop patch "serial: pl011: use ACPI SPCR to setup 32-bit =
access" because
> > > > > > =C2=A0 it is ugly. Also because Christopher Covington came =
with a better solution [5]
> > > > > > - remove error message when the table is not provided by AC=
PI (Andy Shevchenko)
> > > > > > - rewrite spcr.c following the suggestions by Peter Hurley
> > > > > > - add console_match() for pl011 in a separate patch
> > > > > > - add EARLYCON_DECLARE for pl011 in a separate patch
> > > > > > - add patch "of/serial: move earlycon early_param handling =
to serial" from
> > > > > > =C2=A0 the GDB2 series
> > > > > >=20
> > > > > > v4:
> > > > > > https://lkml.kernel.org/g/1456747355-15692-1-git-send-email=
-aleksey.makarov@linaro.org
> > > > > > - drop patch "ACPI: change __init to __ref for early_acpi_o=
s_unmap_memory()"
> > > > > > =C2=A0 ACPI developers work on a new API and asked not to d=
o that.
> > > > > > =C2=A0 Instead, use acpi_get_table_with_size()/early_acpi_o=
s_unmap_memory() once
> > > > > > =C2=A0 and cache the result. (Lv Zheng)
> > > > > > - fix some style issues (Yury Norov)
> > > > > >=20
> > > > > > v3:
> > > > > > https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-=
aleksey.makarov@linaro.org
> > > > > >=20
> > > > > > Greg Kroah-Hartman did not like v2 so I have rewritten this=
 patchset:
> > > > > >=20
> > > > > > - drop acpi_match() member of struct console
> > > > > > - drop implementations of this member for pl011 and 8250
> > > > > > - drop the patch that renames some vars in printk.c as it i=
s not needed anymore
> > > > > > - drop patch that introduces system wide acpi_table_parse2(=
).
> > > > > > =C2=A0 Instead introduce a custom acpi_table_parse_spcr() i=
n spcr.c
> > > > > >=20
> > > > > > Instead of introducing a new match_acpi() member of struct =
console,
> > > > > > this patchset introduces a new function acpi_console_check(=
).
> > > > > > This function is called when a new uart is registered at se=
rial_core.c
> > > > > > the same way OF code checks for console.=C2=A0=C2=A0If the =
registered uart is the
> > > > > > console specified by SPCR table, this function calls add_pr=
eferred_console()
> > > > > >=20
> > > > > > The restrictions of this approach are:
> > > > > >=20
> > > > > > - only serial consoles can be set up
> > > > > > - only consoles specified by the memory/io address can be s=
et up
> > > > > > =C2=A0 (SPCR can specify devices by PCI id/PCI address)
> > > > > >=20
> > > > > > v2:
> > > > > > https://lkml.kernel.org/g/1455299022-11641-1-git-send-email=
-aleksey.makarov@linaro.org
> > > > > > - don't use SPCR if user specified console in command line
> > > > > > - fix initialization order of newcon->index =3D 0
> > > > > > - rename some variables at printk.c (Joe Perches, Peter Hur=
ley)
> > > > > > - enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchen=
ko)
> > > > > > - remove the retry loop for console registering (Peter Hurl=
ey).
> > > > > > =C2=A0 Instead, obtain SPCR with acpi_get_table().=C2=A0=C2=
=A0That works after
> > > > > > =C2=A0 call to acpi_early_init() i. e. in any *_initcall()
> > > > > > - describe design decision behind introducing acpi_match() =
(Peter Hurley)
> > > > > > - fix compilation for x86 + ACPI (Graeme Gregory)
> > > > > > - introduce DBG2 constants in a separate patch (Andy Shevch=
enko)
> > > > > > - fix a typo in DBG2 constants (Andy Shevchenko)
> > > > > > - add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Coving=
ton)
> > > > > > - add support for ACPI_DBG2_ARM_SBSA_* consoles (Christophe=
r Covington)
> > > > > > - add documentation for functions
> > > > > > - add a patch that uses SPCR to find if SBSA serial driver =
should use 32-bit
> > > > > > =C2=A0 accessor functions (Christopher Covington)
> > > > > > - change __init to __ref for early_acpi_os_unmap_memory() i=
n a separate patch
> > > > > > - introduce acpi_table_parse2() in a separate patch
> > > > > > - fix fetching the SPCR table early (Mark Salter)
> > > > > > - add a patch from Mark Salter that introduces support for =
matching 8250-based
> > > > > > =C2=A0 consoles
> > > > > >=20
> > > > > > v1:
> > > > > > https://lkml.kernel.org/g/1453722324-22407-1-git-send-email=
-aleksey.makarov@linaro.org
> > > > > >=20
> > > > > > [1] http://infocenter.arm.com/help/index.jsp?topic=3D/com.a=
rm.doc.den0044a/index.html
> > > > > > [2] https://msdn.microsoft.com/en-us/library/windows/hardwa=
re/dn639132(v=3Dvs.85).aspx
> > > > > > [3] https://lkml.kernel.org/g/cover.1458714002.git.lv.zheng=
@intel.com
> > > > > > [4] https://lkml.kernel.org/g/1441716217-23786-1-git-send-e=
mail-leif.lindholm@linaro.org
> > > > > > [5] https://lkml.kernel.org/g/1457415800-8799-1-git-send-em=
ail-cov@codeaurora.org
> > > > > >=20
> > > > > > Aleksey Makarov (4):
> > > > > > =C2=A0 ACPICA: Headers: Add new constants for the DBG2 ACPI=
 table
> > > > > > =C2=A0 ACPI: parse SPCR and enable matching console
> > > > > > =C2=A0 ARM64: ACPI: enable ACPI_SPCR_TABLE
> > > > > > =C2=A0 serial: pl011: add console matching function
> > > > > >=20
> > > > > > Leif Lindholm (1):
> > > > > > =C2=A0 of/serial: move earlycon early_param handling to ser=
ial
> > > > > >=20
> > > > > > =C2=A0arch/arm64/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > > > > =C2=A0arch/arm64/kernel/acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A011 +++-
> > > > > > =C2=A0drivers/acpi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A03 ++
> > > > > > =C2=A0drivers/acpi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > > > > =C2=A0drivers/acpi/spcr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 111 +++++++++++++++++++++++=
+++++++++++++++++
> > > > > > =C2=A0drivers/of/fdt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01=
1 +---
> > > > > > =C2=A0drivers/tty/serial/amba-pl011.c |=C2=A0=C2=A056 +++++=
+++++++++++++++
> > > > > > =C2=A0drivers/tty/serial/earlycon.c=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A019 ++++++-
> > > > > > =C2=A0include/acpi/actbl2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A07 ++-
> > > > > > =C2=A0include/linux/acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A06 +++
> > > > > > =C2=A0include/linux/of_fdt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> > > > > > =C2=A0include/linux/serial_core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A0=C2=A06 +++
> > > > > > =C2=A012 files changed, 220 insertions(+), 14 deletions(-)
> > > > > > =C2=A0create mode 100644 drivers/acpi/spcr.c
> > > > > >=20
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
