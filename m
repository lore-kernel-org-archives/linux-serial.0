From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 00/15] tty: serial: 8250: Fix checkpatch warnings
Date: Thu, 14 Jan 2016 11:13:00 +0200
Message-ID: <1452762780.2521.20.camel@linux.intel.com>
References: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-01-13 at 22:29 +0100, Anton Wuerfel wrote:
> Hello Andy,
>=20
> > Also, please thin out the Cc list, I would recommend remove just
> > ordinary commiters (with maybe few exceptions) and leave
> > maintainers.=C2=A0
> > Moreover some addresses are bounced.
> I thinned out the Cc list and left over only maintainers and major
> contributors to the code.
>=20
> > Yep!
> > However, you forgot to fix switch-case as well.
> Phillip and me are kind of git magicians. We can make code disappear
> during
> rebase :-) The piece of code was part of a commit, but it never made
> it into
> the final patch file.
> =C2=A0
> I hope, there are no major issues with our patch set.

There are comments regarding patch 12, otherwise FWIW:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


>=20
> Regards,
> Anton Wuerfel
> Phillip Raffeck
>=20
> This patch set fixes several checkpatch warnings in tty/serial/8250.
>=20
> Patch 1/15:=C2=A0=C2=A0Adds missing spaces (mainly to function/macro =
headers)
> Patch 2/15:=C2=A0=C2=A0Replace spaces with tabs wherever possible
> Patch 3/15:=C2=A0=C2=A0Slight patch which moves an opening curly brac=
e
> Patch 4/15:=C2=A0=C2=A0Fixes multiline comment style
> Patch 5/15:=C2=A0=C2=A0Removes else blocks after return statements
> Patch 6/15:=C2=A0=C2=A0Slight patch which moves EXPORT_SYMBOL macro t=
o correct
> position
> Patch 7/15:=C2=A0=C2=A0Slight patch which removes an unneccessary lin=
e
> continuation
> Patch 8/15:=C2=A0=C2=A0Slight patch which adds parentheses to a macro
> definition
> Patch 9/15:=C2=A0=C2=A0Merges user-visible multiline strings to a sin=
gle line
> Patch 10/15: Replace printk by dev_* or pr_* where appropriate
> Patch 11/15: Remove orphaned debug macro
> Patch 12/15: Fix warnings in dev_dbg by adding two casts
> Patch 13/15: Fixes code indentation
> Patch 14/15: Add a generic port macro
> Patch 15/15: Refactor a switch/case statement
>=20
> Remaining checkpatch warnings after applying this patch series:
>=20
> -line over 80 characters
> 	This error mostly occurs in serial_cs.c, which contains long-
> lined
> 	macro calls. However, splitting these calls into multiple lines
> would
> 	not increase readability.
>=20
> -externs should be avoided in .c files
> 	This occurs in 8250_hp300.c. There is no corresponding header
> file
> 	the extern statement could be moved to. It could be moved to
> 8250.h
> 	but this would affect other .c files.
>=20
> -Use #include <linux/*.h> instead of <asm/*.h>
> 	This warning has been left open for more experienced kernel
> hackers.
> 	This patch series is about style issues. We do not intend to
> alter
> 	the code behavior.
> -struct uart_ops should normally be const
> 	This warning only occurs in 8250_core.c. The corresponding
> struct
> 	cannot be declared as const because it is altered in
> 	serial8250_isa_init_ports(). Maybe a checkpatch exception
> should
> 	be added for this particular warning.
>=20
> -quoted string split across lines
> 	These strings were ignored because they otherwise would exceed
> 	80 characters in a single line. These particular strings use
> 	format specifiers, which break the ability to grep for them
> anyway.
>=20
> Anton Wuerfel (15):
> Phillip Raffeck (15):
> =C2=A0 tty: serial: 8250: Fix whitespace errors
> =C2=A0 tty: serial: 8250: Replace spaces with tabs
> =C2=A0 tty: serial: 8250: Fix braces after struct
> =C2=A0 tty: serial: 8250: Fix multiline comment style
> =C2=A0 tty: serial: 8250: Remove else after return
> =C2=A0 tty: serial: 8250: Move EXPORT_SYMBOL to function
> =C2=A0 tty: serial: 8250: Fix line continuation warning
> =C2=A0 tty: serial: 8250: Add parentheses to macro
> =C2=A0 tty: serial: 8250: Fix multi-line strings
> =C2=A0 tty: serial: 8250: Correct conversion specifiers
> =C2=A0 tty: serial: 8250: Merge duplicate conditions
> =C2=A0 tty: serial: 8250: Fix indentation warnings
> =C2=A0 tty: serial: 8250: Add generic port init macro
> =C2=A0 tty: serial: 8250: Suitably replace printk
> =C2=A0 tty: serial: 8250: Remove SERIAL_DEBUG_PNP macro
>=20
> =C2=A0drivers/tty/serial/8250/8250.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 12 ++++
> =C2=A0drivers/tty/serial/8250/8250_accent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 13 +---
> =C2=A0drivers/tty/serial/8250/8250_acorn.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/tty/serial/8250/8250_boca.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 41 ++++++-------
> =C2=A0drivers/tty/serial/8250/8250_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 15 ++---
> =C2=A0drivers/tty/serial/8250/8250_exar_st16c554.c | 17 ++----
> =C2=A0drivers/tty/serial/8250/8250_fourport.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 28 ++++-----
> =C2=A0drivers/tty/serial/8250/8250_gsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A07 ++-
> =C2=A0drivers/tty/serial/8250/8250_hp300.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 27 +++++----
> =C2=A0drivers/tty/serial/8250/8250_hub6.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/tty/serial/8250/8250_ingenic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 12 ++--
> =C2=A0drivers/tty/serial/8250/8250_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 60 ++++++++++------
> ---
> =C2=A0drivers/tty/serial/8250/8250_pnp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 28 +++++----
> =C2=A0drivers/tty/serial/8250/8250_port.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 47 ++++++++-------
> =C2=A0drivers/tty/serial/8250/serial_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 90 +++++++++++++++---
> ----------
> =C2=A015 files changed, 203 insertions(+), 198 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
