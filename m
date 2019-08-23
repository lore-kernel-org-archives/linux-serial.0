From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v3 3/7] serial: fsl_linflexuart: Update compatible string
Date: Fri, 23 Aug 2019 19:11:35 +0000
Message-ID: <20190823191115.18490-4-stefan-gabriel.mirea@nxp.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

The "fsl,s32-linflexuart" compatible string is too generic. Make it SoC
specific.

Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_=
linflexuart.c
index 26b9601a0952..e54c65830e5e 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -127,7 +127,7 @@
=20
 static const struct of_device_id linflex_dt_ids[] =3D {
 	{
-		.compatible =3D "fsl,s32-linflexuart",
+		.compatible =3D "fsl,s32v234-linflexuart",
 	},
 	{ /* sentinel */ }
 };
@@ -801,7 +801,7 @@ static int __init linflex_early_console_setup(struct ea=
rlycon_device *device,
 	return 0;
 }
=20
-OF_EARLYCON_DECLARE(linflex, "fsl,s32-linflexuart",
+OF_EARLYCON_DECLARE(linflex, "fsl,s32v234-linflexuart",
 		    linflex_early_console_setup);
=20
 #define LINFLEX_CONSOLE	(&linflex_console)
--=20
2.22.0
