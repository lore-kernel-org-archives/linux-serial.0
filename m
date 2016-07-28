From: Pascal JEAN <epsilonrt@gmail.com>
Subject: Re: [PATCH 1/2] sc16is7xx: fix RTS/CTS implementation
Date: Thu, 28 Jul 2016 08:56:17 +0200
Message-ID: <76565f8e-be11-8a39-4626-2e58641e8203@gmail.com>
References: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
 <1469653123-21867-2-git-send-email-epsilonrt@gmail.com>
 <20160727212844.GB7821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727212844.GB7821@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Here are changelog for this patch.
Best Regards

Le 27/07/2016 =E0 23:28, Greg KH a =E9crit :
> On Wed, Jul 27, 2016 at 10:58:42PM +0200, Pascal JEAN wrote:
>> Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
>> ---
>>  drivers/tty/serial/sc16is7xx.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> I can't take patches with out any changelog text, sorry, please add t=
he
> information you had in patch 0/2 to the text in these two patches, pl=
us
> any other information that might be needed.
>=20
> Also, your Signed-off-by: and From: email addresses don't match, plea=
se
> fix that up somehow.
>=20
> thanks,
>=20
> greg k-h
>=20

Changelog:

sc16is7xx: fix RTS/CTS implementation

	RTS/CTS handshaking for sc16is7xx driver does not work,
	no character is sent regardless of the state of CTS.
	Fixes:
	1- sc16is7xx_set_baud() overwrites the flow control
	   configuration bits in EFR.
	   Writing in EFR has been replaced by an update.
	2- As noted in the file Documentation/serial/driver,
	   get_mctrl() should return an active state for
	   unsupported entries.
	After those changes everything works.


Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
index f36e6df..3e65079 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -511,16 +511,18 @@ static int sc16is7xx_set_baud(struct uart_port
*port, int baud)

 	/* Enable enhanced features */
 	regcache_cache_bypass(s->regmap, true);
-	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-			     SC16IS7XX_EFR_ENABLE_BIT);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			     SC16IS7XX_EFR_ENABLE_BIT,
+			     SC16IS7XX_EFR_ENABLE_BIT);
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
+			      SC16IS7XX_MCR_CLKSEL_BIT,
+			      prescaler);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			     SC16IS7XX_EFR_ENABLE_BIT, 0);
 	regcache_cache_bypass(s->regmap, false);

 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);

-	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
-			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);

 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -817,9 +819,9 @@ static unsigned int sc16is7xx_tx_empty(struct
uart_port *port)
 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
 	/* DCD and DSR are not wired and CTS/RTS is handled automatically
-	 * so just indicate DSR and CAR asserted
+	 * so just indicate all inputs asserted
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+	return TIOCM_DSR | TIOCM_CAR | TIOCM_RI | TIOCM_CTS;
 }

 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int m=
ctrl)
--=20
2.7.4
