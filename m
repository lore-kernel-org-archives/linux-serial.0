From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Subject: sh-sci regression without scif_clk in 4.6-rc5
Date: Mon, 25 Apr 2016 14:24:41 +0200
Message-ID: <1461587081.28870.2.camel@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: geert+renesas@glider.be
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

testing 4.6-rc5 on a custom R-Car H3 board, I noticed that the Linux
console attached to SCIF2 no longer works (it works on 4.5). earlycon
works fine, though. Unlike Salvator-X, this H3 board does not use an
external SCIF clock and thus, scif_clk is not enabled in the board
device tree.

The first "bad" commit is
commit 3e5dd6f6e690048d0fd1c913397506648724474e
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:=C2=A0=C2=A0=C2=A0Fri Feb 26 16:54:31 2016 +0100

=C2=A0=C2=A0=C2=A0=C2=A0clk: Ignore disabled DT clock providers

As far as I can tell, the issue is that, with the above commit,
devm_clk_get() returns -EPROBE_DEFER for disabled clocks and the sh-sci=
=20
driver aborts probing with -EPROBE_DEFER even though scif_clk is
optional.

I can work around this issue with the patch below but I'm not sure
about the correct fix. Intuitively, I would expect devm_clk_get() to
return -ENOENT instead of -EPROBE_DEFER for disabled clocks but I don't
know whether this can be changed in the common clock framework without
risking issues in other places.

What do you think is the best solution to this issue?

Regards,
J=C3=BCrg

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8e966d9..0916159 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2462,7 +2462,7 @@ static int sci_init_clocks(struct sci_port *sci_p=
ort, struct device *dev)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < SCI_N=
UM_CLKS; i++) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clk =3D devm_clk_get(dev, clk_names[i]);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER && i !=3D SCI_S=
CIF_CLK)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return -EPROBE_DEFER;
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(clk) && i =3D=3D SCI_FCK) {
