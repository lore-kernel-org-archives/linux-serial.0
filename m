From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3.4.x-stable] 8250_pci: fix warnings in backport of Broadcom TruManage support
Date: Mon, 25 Aug 2014 13:33:20 -0400
Message-ID: <1408988000-32987-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Stephen Hurd <shurd@broadcom.com>, Michael Chan <mchan@broadcom.com>, Ben Hutchings <ben@decadent.org.uk>, Rui Xiang <rui.xiang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

commit 7400ce7ee9595432b2a1402b6ffcac9faf38d9ae (v3.4.92-76-g7400ce7ee9=
59)
was a backport of commit ebebd49a8eab5e9aa1b1f8f1614ccc3c2120f886 upstr=
eam
("8250/16?50: Add support for Broadcom TruManage redirected serial port=
")

However, in the context of 3.4.x kernels, the pci setup code was
expecting a struct uart_port and not a struct uart_8250_port, leading t=
o
the following concerning warnings:

drivers/tty/serial/8250/8250_pci.c: In function =E2=80=98pci_brcm_truma=
nage_setup=E2=80=99:
drivers/tty/serial/8250/8250_pci.c:1086:2: warning: passing argument 3 =
of =E2=80=98pci_default_setup=E2=80=99 from incompatible pointer type [=
enabled by default]
  int ret =3D pci_default_setup(priv, board, port, idx);
  ^
drivers/tty/serial/8250/8250_pci.c:1036:1: note: expected =E2=80=98stru=
ct uart_port *=E2=80=99 but argument is of type =E2=80=98struct uart_82=
50_port *=E2=80=99
 pci_default_setup(struct serial_private *priv,
 ^
drivers/tty/serial/8250/8250_pci.c: At top level:
drivers/tty/serial/8250/8250_pci.c:1746:3: warning: initialization from=
 incompatible pointer type [enabled by default]
   .setup  =3D pci_brcm_trumanage_setup,
   ^
drivers/tty/serial/8250/8250_pci.c:1746:3: warning: (near initializatio=
n for =E2=80=98pci_serial_quirks[56].setup=E2=80=99) [enabled by defaul=
t]

I'd also expect the initialization to not function correctly, and
perhaps dereference random garbage due to this.  Since the uart_port
is a field within the uart_8250_port, the adaptation to fix these
warnings is a straightforward removal of a layer of indirection.

Cc: Stephen Hurd <shurd@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Rui Xiang <rui.xiang@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Only build tested; I don't have this specific hardware, but the fix
 seems straightforward enough to be almost self evident, I hope...]

 drivers/tty/serial/8250/8250_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index cf7f1cdc1469..8e581dd01814 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1081,12 +1081,12 @@ pci_omegapci_setup(struct serial_private *priv,
 static int
 pci_brcm_trumanage_setup(struct serial_private *priv,
 			 const struct pciserial_board *board,
-			 struct uart_8250_port *port, int idx)
+			 struct uart_port *port, int idx)
 {
 	int ret =3D pci_default_setup(priv, board, port, idx);
=20
-	port->port.type =3D PORT_BRCM_TRUMANAGE;
-	port->port.flags =3D (port->port.flags | UPF_FIXED_PORT | UPF_FIXED_T=
YPE);
+	port->type =3D PORT_BRCM_TRUMANAGE;
+	port->flags =3D (port->flags | UPF_FIXED_PORT | UPF_FIXED_TYPE);
 	return ret;
 }
=20
--=20
2.0.1
