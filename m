From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Tue, 7 Mar 2017 22:08:37 +0100
Message-ID: <20170307210837.w5fdwc2sy3xmzci7@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-11-sre@kernel.org>
 <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyrn52jkxqwaw7jb"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--wyrn52jkxqwaw7jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Mar 07, 2017 at 10:30:51AM -0600, Rob Herring wrote:
> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > This adds a driver for the Nokia H4+ protocol, which is used
> > at least on the Nokia N9, N900 & N950.
> >
> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
>=20
> This should be separate and before the dts files.
>=20
> >  drivers/bluetooth/Kconfig                          |  12 +
> >  drivers/bluetooth/Makefile                         |   2 +
> >  drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++=
++++++++
> >  4 files changed, 904 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetoo=
th.txt
> >  create mode 100644 drivers/bluetooth/hci_nokia.c
> >
> > diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt =
b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> > new file mode 100644
> > index 000000000000..6c80a92f31e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> > @@ -0,0 +1,51 @@
> > +Nokia Bluetooth Chips
> > +---------------------
> > +
> > +Nokia phones often come with UART connected bluetooth chips from diffe=
rent
> > +vendors and modified device API. Those devices speak a protocol named =
H4+
> > +by Nokia, which is similar to the H4 protocol from the Bluetooth stand=
ard.
> > +In addition to the H4 protocol it specifies two more UART status lines=
 for
> > +wakeup of UART transceivers to improve power management and a few new =
packet
> > +types used to negotiate uart speed.
> > +
> > +Required properties:
> > +
> > + - compatible: should be one of the following:
> > +   * "nokia,brcm,bcm2048"
> > +   * "nokia,ti,wl1271-bluetooth"
>=20
> Drop the chip vendors' prefix here. I don't really want to start a
> pattern of 2 vendor prefixes.

Right, I think we discussed this before, but I don't remember the
result. How about

- compatible: should contain "nokia,h4p-bluetooth" as well as one of the fo=
llowing:
 * "brcm,bcm2048-nokia"
 * "ti,wl1271-blueooth-nokia"

For the driver it should be enough to know "nokia,h4p-bluetooth"
actually. The device identifies itself in the negotiation reply.

> > + - reset-gpios: GPIO specifier, used to reset the BT module
>=20
> Need to state active state.

ok. Any suggestion about the wording? The BT chips use usually
active low reset pin. The driver handles all GPIOs as active
high with the DT binding translating this transparently.

> > + - bluetooth-wakeup-gpios: GPIO specifier, used to wakeup the BT module
> > + - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
>=20
> I think most BCM devices have these. These apply to the TI device too?
> If not, then add brcm prefix.

Yes, Nokia N950 uses a TI WL1271 and also has them. Actually the example
=66rom below is a TI chip.

> Also need to specify the active state.

ok.

> > + - clock-names: should be "sysclk"
> > + - clocks: should contain a clock specifier for every name in clock-na=
mes
> > +
> > +Optional properties:
> > +
> > + - None
> > +
> > +Example:
> > +
> > +/ {
> > +       /* controlled (enabled/disabled) directly by BT module */
> > +       bluetooth_clk: vctcxo {
> > +               compatible =3D "fixed-clock";
> > +               #clock-cells =3D <0>;
> > +               clock-frequency =3D <38400000>;
> > +       };
> > +};
> > +
> > +&uart2 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&uart2_pins>;
> > +
> > +       bluetooth {
> > +               compatible =3D "nokia,ti,wl1271-bluetooth";
> > +
> > +               reset-gpios =3D <&gpio1 26 GPIO_ACTIVE_LOW>; /* gpio26 =
*/
> > +               host-wakeup-gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>; /* g=
pio101 */
> > +               bluetooth-wakeup-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>;=
 /* gpio37 */
> > +
> > +               clocks =3D <&bluetooth_clk>;
> > +               clock-names =3D "sysclk";
> > +       };
> > +};

-- Sebastian

--wyrn52jkxqwaw7jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli/IVEACgkQ2O7X88g7
+poVfBAAllK8SdR5wZi4DU5j3MP3yOrv2zsSj9QM5fTHPxuhoMUk1LPyTsgoxGBW
DND4VG4T2HPKtOAiQgd7lu7/WFnVij8P1dZC4fSCUopMR4iaPnqvQc+nlbBi+gKe
hM1VJfy6t5X3ZKPByze/F741UeiWWnIlha4KxvWOL4WWnSq3qlbKSwG2MacZKqi9
buaHPbVcx/sIZtzsYpWrqWYIVC/P4szaJj91vf4f7P9WAtILtAWqV2g2ZqiffKL6
YGoD6RDJl6T3Gf0XM6i575Dag7GW9dp5L2N/wWxP2/+fzDH95HL03u2+pQQRzA39
1+fl59AHEQNOxaUMt9NVjQBLa+xd10sECPeG1Tz0L0DrO2wEicOvPjxxdsWaN5bG
IRxZgJpzht8SafGYJLQb3gy1RctNECfTPXTsmfbE7PKuc63TVnMdF0U8I6QAOM69
o6ioZtyMEadzOHelcJBrSMQ88Q3vHksR72IDw+mr0zgZ1NLl0sxQ3v7sOPgVG6of
ZwHe+Ho0znWdv3EWz/aRussbWAMyWsU133T4Srl7t06IOT9Cl2OUD4eu3Onzordl
PnTsm8pF7CBUWfuFXa+owezbp3kidD5RLWZPeD++E9oTUYI2KhZq/2A/vWdD48bf
+Wv8XJ+a3whKIq6TTWq9EAxj8B5dhC3OHEnMCv57OV8/+EKcIxU=
=ymu/
-----END PGP SIGNATURE-----

--wyrn52jkxqwaw7jb--
