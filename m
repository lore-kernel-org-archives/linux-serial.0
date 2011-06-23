From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv2 1/2] dt: document the of_serial bindings
Date: Thu, 23 Jun 2011 08:55:21 -0600
Message-ID: <BANLkTim_=xToTYjATh8Z_ji3muMy3dXj0Q@mail.gmail.com>
References: <1308838115-23034-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56807 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab1FWOzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Jun 2011 10:55:41 -0400
Received: by ywe9 with SMTP id 9so741203ywe.19
        for <linux-serial@vger.kernel.org>; Thu, 23 Jun 2011 07:55:41 -0700 (PDT)
In-Reply-To: <1308838115-23034-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, Jun 23, 2011 at 8:08 AM, Jamie Iles <jamie@jamieiles.com> wrote=
:
> The of_serial bindings can be used to register a number of serial
> devices. =A0Document this binding with all of the others.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
> =A0.../devicetree/bindings/tty/serial/of-serial.txt =A0 | =A0 34 ++++=
++++++++++++++++
> =A01 files changed, 34 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/tty/serial/of=
-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.t=
xt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> new file mode 100644
> index 0000000..b0c52c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> @@ -0,0 +1,34 @@
> +* UART (Universal Asynchronous Receiver/Transmitter)
> +
> +Required properties:
> +- compatible : one of:
> + =A0 =A0 =A0 - "ns8250"
> + =A0 =A0 =A0 - "ns16450"
> + =A0 =A0 =A0 - "ns16550a"
> + =A0 =A0 =A0 - "ns16550"
> + =A0 =A0 =A0 - "ns16750"
> + =A0 =A0 =A0 - "ns16850"
> + =A0 =A0 =A0 - "nvidia,tegra250-uart"
> + =A0 =A0 =A0 - "ibm,qpace-nwp-serial"
> + =A0 =A0 =A0 - "serial" if the port type is unknown.
> +- reg : offset and length of the register set for the device.
> +- interrupts : should contain uart interrupt.
> +- clock-frequency : the input clock frequency for the UART.
> +
> +Optional properties:
> +- current-speed : the current active speed of the UART.
> +- reg-offset : offset to apply to the mapbase from the start of the =
registers.
> +- reg-shift : quantity to shift the register offsets by.
> +- used-by-rtas : set to indicate that the port is in use by the firm=
ware and
> + =A0should not be registered.
> +
> +Example:
> +
> + =A0 =A0 =A0 uart@80230000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ns8250";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device-type =3D "serial";

Drop device-type.  Otherwise looks good.

g.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x80230000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <3686400>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <10>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg-shift =3D <2>;
> + =A0 =A0 =A0 };
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
