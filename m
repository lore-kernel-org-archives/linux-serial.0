From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] serial: samsung: earlycon support depends on
 CONFIG_SERIAL_SAMSUNG_CONSOLE
Date: Mon, 02 Feb 2015 10:47:35 +0100
Message-ID: <1422870455-19581-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, thomas.ab@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

EarlyCon support depends on serial console infrastructure, so the code
implementing it should depend on CONFIG_SERIAL_SAMSUNG_CONSOLE.

This patch fixes the following build break:
CC [M]  drivers/tty/serial/samsung.o
drivers/tty/serial/samsung.c:2468:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2468:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2410_setup_earlycon=E2=
=80=99
drivers/tty/serial/samsung.c:2487:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2487:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2412_setup_earlycon=E2=
=80=99
drivers/tty/serial/samsung.c:2488:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2488:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2440_setup_earlycon=E2=
=80=99
drivers/tty/serial/samsung.c:2489:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2489:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98s3c6400_setup_earlycon=E2=
=80=99
drivers/tty/serial/samsung.c:2506:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2506:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98s5pv210_setup_earlycon=E2=
=80=99
drivers/tty/serial/samsung.c:2507:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before string constant
drivers/tty/serial/samsung.c:2507:1: error: expected declaration specif=
iers or =E2=80=98...=E2=80=99 before =E2=80=98exynos4210_setup_earlycon=
=E2=80=99
drivers/tty/serial/samsung.c:2468:1: warning: =E2=80=98s3c2410_setup_ea=
rlycon=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/samsung.c:2487:1: warning: =E2=80=98s3c2412_setup_ea=
rlycon=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/samsung.c:2488:1: warning: =E2=80=98s3c2440_setup_ea=
rlycon=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/samsung.c:2489:1: warning: =E2=80=98s3c6400_setup_ea=
rlycon=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/samsung.c:2506:1: warning: =E2=80=98s5pv210_setup_ea=
rlycon=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/samsung.c:2507:1: warning: =E2=80=98exynos4210_setup=
_earlycon=E2=80=99 defined but not used [-Wunused-function]
make[3]: *** [drivers/tty/serial/samsung.o] Error 1

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.=
c
index a6bef8dcdc3c..bb73897809a1 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -2403,6 +2403,7 @@ static struct platform_driver samsung_serial_driv=
er =3D {
=20
 module_platform_driver(samsung_serial_driver);
=20
+#ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
 /*
  * Early console.
  */
@@ -2505,6 +2506,7 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos42=
10-uart",
 			s5pv210_early_console_setup);
 EARLYCON_DECLARE(s5pv210, s5pv210_early_console_setup);
 EARLYCON_DECLARE(exynos4210, s5pv210_early_console_setup);
+#endif
=20
 MODULE_ALIAS("platform:samsung-uart");
 MODULE_DESCRIPTION("Samsung SoC Serial port driver");
--=20
1.9.2
