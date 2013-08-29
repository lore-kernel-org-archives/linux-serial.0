From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] tty: ar933x_uart: add device tree support and binding
 documentation
Date: Thu, 29 Aug 2013 11:44:06 +0200
Message-ID: <521F17E6.1080704@openwrt.org>
References: <1377758641-4078-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43850 "EHLO
	mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab3H2Jnq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Aug 2013 05:43:46 -0400
In-Reply-To: <1377758641-4078-1-git-send-email-juhosg@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gabor Juhos <juhosg@openwrt.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

2013.08.29. 8:44 keltez=E9ssel, Gabor Juhos =EDrta:
> Modify the probe routine to get the port line number
> from device tree if the 'of_node' is populated in the
> platform device. The driver can be built as module,
> thus add an OF specific module device table as well
> to support module auto loading.

Erm, the last statement is not true. I forgot to send the patch which m=
akes it
possible to build the driver as a module. I did that a few minutes ago.

>=20
> This makes it possible to use the driver for AR9330
> UART devices specified in device tree.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> The patch is agains the 'tty-next' branch of the
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
> ---
>  .../bindings/tty/serial/qca,ar9330-uart.txt        |   34 ++++++++++=
++++++++++
>  drivers/tty/serial/ar933x_uart.c                   |   28 ++++++++++=
++++--
>  2 files changed, 59 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/qca,=
ar9330-uart.txt

Additionally, according to the recent thread [1] on the linux-serial li=
st the
binding doc should go into bindings/serial.

Please drop this patch. I will send an updated version.

-Gabor

1. http://marc.info/?l=3Dlinux-serial&m=3D137771717313040&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
