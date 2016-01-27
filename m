From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Serial ports with non connected RTS/CTS
Date: Wed, 27 Jan 2016 11:58:17 +0100
Message-ID: <20160127115817.79e384b1@ipc1.ka-ro>
References: <56A89C48.1040604@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56A89C48.1040604-mB3Nsq4MPf1BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Fuzzey <mfuzzey-mB3Nsq4MPf1BDgjK7y7TUQ@public.gmane.org>
Cc: "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Wed, 27 Jan 2016 11:30:32 +0100 Martin Fuzzey wrote:
> Hi all,
>=20
> currently, at least for 8250 based serial ports using of_serial, ther=
e=20
> is no way of indicating that the RTS / CTS lines, although supported =
by=20
> the UART, are not actually connected on the board.
>=20
> This means that userspace needs to know about this and not use the=20
> CRTSCTS termios flag (otherwise no data is sent).
>=20
> This is currently the case for Debian stattach for example (nettools=20
> 1.60) which unconditionally uses CRTSCTS (but the busybox version of=20
> slattach has a "-F" option that can be used to disable CRTSCTS).
>=20
> Would it not be better to allow this situation to be described in the=
=20
> device tree?
>=20
> Such an option already exists for the imx UART (""fsl,uart-has-rtscts=
")
>=20
> of_serial already has the "auto-flow-control" DT property but, as sta=
ted=20
> in the documentation:
>      "The  driver is allowed to detect support for the capability eve=
n=20
> without this  property."
>=20
> In the past there was a (since reverted) property "has-hw-flow-contro=
l"
> See
>      06aa82e "serial: uart: add hw flow control support configuration=
"
>      a6eec92 " Revert "serial: uart: add hw flow control support=20
> configuration"
>=20
> However that just provided another (redundant) way of *activating*=20
> hardware flow control and did not allow it to be disactivated.
>=20
> Would a new DT property "no-rtscts" to do this be acceptable?
>=20
> I think it would have to be a negative property to avoid breaking old=
=20
> device trees.
>=20
> Since there seems to have been some to and fro on this issue I though=
t=20
> it would be a good idea to discuss before writing the patch...
>=20
If a driver has no support for RTS/CTS (e.g. due to the missing
fsl,uart-has-rtscts property for i.MX UARTs) then trying to enable HW
flowcontrol via the TCETS ioctl should fail (as is the case with the
i.MX serial driver).
Thus it should be impossible to enable crtscts if the serial driver has
no RTC/CTS support without any need for userspace to know about the
HW details.


Lothar Wa=C3=9Fmann
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
