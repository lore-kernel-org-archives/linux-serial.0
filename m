From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v7 0/5] ACPI: parse the SPCR table
Date: Wed, 06 Apr 2016 10:18:14 -0400
Message-ID: <1459952294.10130.32.camel@redhat.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
	 <1459873627.10130.21.camel@redhat.com> <5704E3CC.8000104@linaro.org>
	 <20160406105252.GB2820@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160406105252.GB2820@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, linux-serial@vger.kernel.org, Len Brown <lenb@kernel.org>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-06 at 11:52 +0100, Graeme Gregory wrote:
> On Wed, Apr 06, 2016 at 01:24:12PM +0300, Aleksey Makarov wrote:
> >=20
> >=20
> >=20
> > On 04/05/2016 07:27 PM, Mark Salter wrote:
> > >=20
> > > Could you CC me on future postings of this series, please?
> > >=20
> > > So v3 fixed a problem where platforms using 8250 didn't work.
> > > Then in v5, that fix was lost so 8250 no longer works.
> > That fix was dropped because now this is implemented differently.=C2=
=A0=C2=A0
> > Now the code uses the existing match() member of struct console.
> > It has already been implemented for 8250.=C2=A0=C2=A0
> > Probably SPCR table specifies incorrect data.
> > It was reported that D02 board has similar issue.
> >=20
> The D02 issue referred to is the 8250 implementation they used has 32=
bit
> only MMIO access which there is no manner to represent in SPCR. It al=
so
> doesn't use the "standard" 16550 clock rate so supplying a baud rate
> makes it change to a random baud rate.

So, the problem with Mustang and m400 was the mmio vs mmio32. Right now=
,
the kernel only supports mmio32 in the 8250_dw.c driver when probed wit=
h
ACPI. Other x86 machines just use legacy 8250 ports which don't need
entries in the DSDT and use legacy io. The 8250_dw driver does support
non-standard clocks specified in the DSDT. That works fine for Mustang
and m400.

So with this quick hack, v7 is working with Mustang/m400:

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 68ffc33..dade9de 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -37,6 +37,7 @@ int __init parse_spcr(bool earlycon)
=C2=A0	acpi_status status;
=C2=A0	char *uart;
=C2=A0	char *iotype;
+	int mmio;
=C2=A0	int baud_rate;
=C2=A0	int err;
=C2=A0
@@ -56,8 +57,8 @@ int __init parse_spcr(bool earlycon)
=C2=A0		goto done;
=C2=A0	}
=C2=A0
-	iotype =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_M=
EMORY ?
-			"mmio" : "io";
+	mmio =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEM=
ORY;
+	iotype =3D mmio ? "mmio" : "io";
=C2=A0
=C2=A0	switch (table->interface_type) {
=C2=A0	case ACPI_DBG2_ARM_SBSA_32BIT:
@@ -71,6 +72,8 @@ int __init parse_spcr(bool earlycon)
=C2=A0	case ACPI_DBG2_16550_COMPATIBLE:
=C2=A0	case ACPI_DBG2_16550_SUBSET:
=C2=A0		uart =3D "uart";
+		if (mmio)
+			iotype =3D "mmio32";
=C2=A0		break;
=C2=A0	default:
=C2=A0		err =3D -ENOENT;

>=20
> We may need two 8250 subset entries, one just means no clock given, a=
nd
> one no clock given + mmio32 only.
>=20
> Graeme
>=20
>=20
> >=20
> > Thank you
> > Aleksey Makarov
> >=20
> > >=20
> > >=20
> > > --Mark
> > >=20
> > >=20
> > > On Thu, 2016-03-31 at 16:40 +0300, Aleksey Makarov wrote:
> > > >=20
> > > > 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial P=
ort
> > > > Console Redirection Table) [2] as a mandatory ACPI table that
> > > > specifies the configuration of serial console.
> > > >=20
> > > > Move "earlycon" early_param handling to earlycon.c to parse thi=
s option once
> > > >=20
> > > > *** PATCH=C2=A0=C2=A0"ACPICA: Headers: Add new constants for th=
e DBG2 ACPI table"
> > > > *** IS JUST TO ENABLE BUILDING THE PATCHSET ON linux-next
> > > >=20
> > > > Patch "ACPICA: Headers: Add new constants for the DBG2 ACPI tab=
le" is required
> > > > for the next patch.=C2=A0=C2=A0It is taken from ACPICA series [=
3], but it has not appeared
> > > > in linux-next yet.
> > > >=20
> > > > Parse SPCR table, setup earlycon and add register specified con=
sole.
> > > >=20
> > > > Enable parsing this table on ARM64.=C2=A0=C2=A0Earlycon should =
be set up
> > > > as early as possible.=C2=A0=C2=A0ACPI boot tables are mapped in
> > > > arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from set=
up_arch()
> > > > and that's where we parse spcr.=C2=A0=C2=A0So it has to be opte=
d-in per-arch.
> > > >=20
> > > > Implement console_match() for pl011.
> > > >=20
> > > > Based on the work by Leif Lindholm [4]
> > > > Thanks to Peter Hurley for explaining how this should work.
> > > >=20
> > > > Should be applied to next-20160331.
> > > >=20
> > > > Tested on QEMU.=C2=A0=C2=A0SPCR support is included in QEMU's A=
RM mach-virt
> > > > since 2.4 release.
> > > >=20
> > > > v7:
> > > > - add Acked-by: Rob Herring for "of/serial: move earlycon early=
_param handling
> > > > =C2=A0 to serial"
> > > > - call DT earlycon initialization from the arch ACPI code, not =
from parse_spcr()
> > > > =C2=A0 (Rafael J. Wysocki)
> > > > - fix a few minor issues (Rafael J. Wysocki)
> > > >=20
> > > > v6:
> > > > https://lkml.kernel.org/g/1458823925-19560-1-git-send-email-ale=
ksey.makarov@linaro.org
> > > > - add documentation for parse_spcr() functioin (Yury Norov)
> > > > - don't initialize err variable (Yury Norov)
> > > > - add __initdata for the earlycon_init_is_deferred flag variabl=
e
> > > > - rename the function exported in "of/serial: move earlycon ear=
ly_param handling
> > > > =C2=A0 to serial" to avoid clash with the function from arch/mi=
croblaze/kernel/prom.c
> > > > - defer initialization of DT earlycon until DT/ACPI decision is=
 made
> > > > =C2=A0 (Rob Herring, Peter Hurley)
> > > > - use snprintf instead of sprintf (Andy Shevchenko)
> > > > - drop patch that adds EARLYCON_DECLARE for pl011 as EARLYCON_D=
ECLARE is
> > > > =C2=A0 equivalent to OF_EARLYCON_DECLARE for 4.6+ (Peter Hurley=
).=C2=A0=C2=A0This means that
> > > > =C2=A0 SPCR earlycon will not work on the kernels before 4.6
> > > >=20
> > > > v5:
> > > > https://lkml.kernel.org/g/1458643595-14719-1-git-send-email-ale=
ksey.makarov@linaro.org
> > > > - drop patch "serial: pl011: use ACPI SPCR to setup 32-bit acce=
ss" because
> > > > =C2=A0 it is ugly. Also because Christopher Covington came with=
 a better solution [5]
> > > > - remove error message when the table is not provided by ACPI (=
Andy Shevchenko)
> > > > - rewrite spcr.c following the suggestions by Peter Hurley
> > > > - add console_match() for pl011 in a separate patch
> > > > - add EARLYCON_DECLARE for pl011 in a separate patch
> > > > - add patch "of/serial: move earlycon early_param handling to s=
erial" from
> > > > =C2=A0 the GDB2 series
> > > >=20
> > > > v4:
> > > > https://lkml.kernel.org/g/1456747355-15692-1-git-send-email-ale=
ksey.makarov@linaro.org
> > > > - drop patch "ACPI: change __init to __ref for early_acpi_os_un=
map_memory()"
> > > > =C2=A0 ACPI developers work on a new API and asked not to do th=
at.
> > > > =C2=A0 Instead, use acpi_get_table_with_size()/early_acpi_os_un=
map_memory() once
> > > > =C2=A0 and cache the result. (Lv Zheng)
> > > > - fix some style issues (Yury Norov)
> > > >=20
> > > > v3:
> > > > https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-alek=
sey.makarov@linaro.org
> > > >=20
> > > > Greg Kroah-Hartman did not like v2 so I have rewritten this pat=
chset:
> > > >=20
> > > > - drop acpi_match() member of struct console
> > > > - drop implementations of this member for pl011 and 8250
> > > > - drop the patch that renames some vars in printk.c as it is no=
t needed anymore
> > > > - drop patch that introduces system wide acpi_table_parse2().
> > > > =C2=A0 Instead introduce a custom acpi_table_parse_spcr() in sp=
cr.c
> > > >=20
> > > > Instead of introducing a new match_acpi() member of struct cons=
ole,
> > > > this patchset introduces a new function acpi_console_check().
> > > > This function is called when a new uart is registered at serial=
_core.c
> > > > the same way OF code checks for console.=C2=A0=C2=A0If the regi=
stered uart is the
> > > > console specified by SPCR table, this function calls add_prefer=
red_console()
> > > >=20
> > > > The restrictions of this approach are:
> > > >=20
> > > > - only serial consoles can be set up
> > > > - only consoles specified by the memory/io address can be set u=
p
> > > > =C2=A0 (SPCR can specify devices by PCI id/PCI address)
> > > >=20
> > > > v2:
> > > > https://lkml.kernel.org/g/1455299022-11641-1-git-send-email-ale=
ksey.makarov@linaro.org
> > > > - don't use SPCR if user specified console in command line
> > > > - fix initialization order of newcon->index =3D 0
> > > > - rename some variables at printk.c (Joe Perches, Peter Hurley)
> > > > - enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchenko)
> > > > - remove the retry loop for console registering (Peter Hurley).
> > > > =C2=A0 Instead, obtain SPCR with acpi_get_table().=C2=A0=C2=A0T=
hat works after
> > > > =C2=A0 call to acpi_early_init() i. e. in any *_initcall()
> > > > - describe design decision behind introducing acpi_match() (Pet=
er Hurley)
> > > > - fix compilation for x86 + ACPI (Graeme Gregory)
> > > > - introduce DBG2 constants in a separate patch (Andy Shevchenko=
)
> > > > - fix a typo in DBG2 constants (Andy Shevchenko)
> > > > - add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Covington)
> > > > - add support for ACPI_DBG2_ARM_SBSA_* consoles (Christopher Co=
vington)
> > > > - add documentation for functions
> > > > - add a patch that uses SPCR to find if SBSA serial driver shou=
ld use 32-bit
> > > > =C2=A0 accessor functions (Christopher Covington)
> > > > - change __init to __ref for early_acpi_os_unmap_memory() in a =
separate patch
> > > > - introduce acpi_table_parse2() in a separate patch
> > > > - fix fetching the SPCR table early (Mark Salter)
> > > > - add a patch from Mark Salter that introduces support for matc=
hing 8250-based
> > > > =C2=A0 consoles
> > > >=20
> > > > v1:
> > > > https://lkml.kernel.org/g/1453722324-22407-1-git-send-email-ale=
ksey.makarov@linaro.org
> > > >=20
> > > > [1] http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.d=
oc.den0044a/index.html
> > > > [2] https://msdn.microsoft.com/en-us/library/windows/hardware/d=
n639132(v=3Dvs.85).aspx
> > > > [3] https://lkml.kernel.org/g/cover.1458714002.git.lv.zheng@int=
el.com
> > > > [4] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email=
-leif.lindholm@linaro.org
> > > > [5] https://lkml.kernel.org/g/1457415800-8799-1-git-send-email-=
cov@codeaurora.org
> > > >=20
> > > > Aleksey Makarov (4):
> > > > =C2=A0 ACPICA: Headers: Add new constants for the DBG2 ACPI tab=
le
> > > > =C2=A0 ACPI: parse SPCR and enable matching console
> > > > =C2=A0 ARM64: ACPI: enable ACPI_SPCR_TABLE
> > > > =C2=A0 serial: pl011: add console matching function
> > > >=20
> > > > Leif Lindholm (1):
> > > > =C2=A0 of/serial: move earlycon early_param handling to serial
> > > >=20
> > > > =C2=A0arch/arm64/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > > =C2=A0arch/arm64/kernel/acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A011 +++-
> > > > =C2=A0drivers/acpi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A03 ++
> > > > =C2=A0drivers/acpi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > > =C2=A0drivers/acpi/spcr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 111 ++++++++++++++++++++++++++=
++++++++++++++
> > > > =C2=A0drivers/of/fdt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A011 +=
---
> > > > =C2=A0drivers/tty/serial/amba-pl011.c |=C2=A0=C2=A056 +++++++++=
+++++++++++
> > > > =C2=A0drivers/tty/serial/earlycon.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A019 ++++++-
> > > > =C2=A0include/acpi/actbl2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A07 ++-
> > > > =C2=A0include/linux/acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A06 +++
> > > > =C2=A0include/linux/of_fdt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> > > > =C2=A0include/linux/serial_core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A06 +++
> > > > =C2=A012 files changed, 220 insertions(+), 14 deletions(-)
> > > > =C2=A0create mode 100644 drivers/acpi/spcr.c
> > > >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
