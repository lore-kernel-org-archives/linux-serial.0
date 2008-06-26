From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCH] cpm_uart: Support uart_wait_until_sent()
Date: Thu, 26 Jun 2008 13:55:03 +0200
Message-ID: <200806261355.09334.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1881114.T7qVHi569F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:53433 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726AbYFZLzM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jun 2008 07:55:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, galak@kernel.crashing.org

--nextPart1881114.T7qVHi569F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Set port->fifosize to the software FIFO size, and update the port timeout
when the baud rate is modified. SCC ports have an optional 32 byte hardware
=46IFO which is currently not taken into account, as there is no documented=
 way
to check when the FIFO becomes empty.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_u=
art/cpm_uart_core.c
index a19dc7e..151cad2 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -547,6 +547,11 @@ static void cpm_uart_set_termios(struct uart_port *por=
t,
 	}
=20
 	/*
+	 * Update the timeout
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
 	 * Set up parity check flag
 	 */
 #define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
@@ -1154,6 +1159,7 @@ int cpm_uart_drv_get_platform_data(struct platform_de=
vice *pdev, int is_con)
 	pinfo->port.uartclk =3D pdata->uart_clk;
 	pinfo->port.mapbase =3D (unsigned long)mem;
 	pinfo->port.irq =3D platform_get_irq(pdev, 0);
+	pinfo->port.fifosize =3D pinfo->tx_nrfifos * pinfo->tx_fifosize;
=20
 	return 0;
 }
=2D-=20
1.5.0

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1881114.T7qVHi569F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY4Od8y9gWxC9vpcRArheAJ4itu/nIrMxuLJezvl9sfvRgLR10wCg30AR
+fJA5hFGrrneVnZDLsdzKGA=
=hS1Q
-----END PGP SIGNATURE-----

--nextPart1881114.T7qVHi569F--
