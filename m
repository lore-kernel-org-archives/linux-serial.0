From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Fri, 17 Mar 2017 16:26:19 +0100
Message-ID: <20170317152619.GF8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-11-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170304115833.3538-11-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +struct hci_nokia_neg_hdr {
> +	__u8	dlen;
> +} __packed;
> +
> +struct hci_nokia_neg_cmd {
> +	__u8	ack;
> +	__u16	baud;
> +	__u16	unused1;
> +	__u8	proto;
> +	__u16	sys_clk;
> +	__u16	unused2;
> +} __packed;

__u8 -> u8? This is not exported to userspace...

> +#define BT_BAUDRATE_DIVIDER	384000000

Is this really divider?

> +	int init_error;
> +	struct completion init_completion;
> +
> +	uint8_t man_id;
> +	uint8_t ver_id;

u8...

> +static int nokia_wait_for_cts(struct hci_uart *hu, bool state,
> +				 int timeout_ms)
> +{
> +	struct nokia_bt_dev *btdev =3D hu->priv;
> +	struct device *dev =3D &btdev->serdev->dev;
> +	unsigned long timeout;
> +	bool signal;
> +
> +	timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> +	while (!time_after(jiffies, timeout)) {
> +		signal =3D serdev_device_get_cts(btdev->serdev);
> +		if (signal =3D=3D state) {
> +			dev_dbg(dev, "wait for cts... received!");
> +			return 0;
> +		}
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

Do we have devices where cts triggers interrupt?

> +	if (btdev->init_error < 0)
> +		return btdev->init_error;
> +
> +	/* Change to previously negotiated speed. Flow Control
> +	 * is disabled until bluetooth adapter is ready to avoid
> +	 * broken bytes being ready by the bluetooth adapter
> +	 */

Umm. I'd at dot at end of sentence... but still can't understand the
sentence.

"to avoid broken bytes being received."?

> +	evt =3D (struct hci_nokia_neg_evt *)skb_pull(skb, sizeof(*hdr));
> +
> +	if (evt->ack !=3D NOKIA_NEG_ACK) {
> +		dev_err(dev, "Negotiation received: wrong reply");
> +		btdev->init_error =3D -EINVAL;
> +	}

But we still return success and trust the man_id / ver_id?

> +	pkt =3D (struct hci_nokia_alive_pkt *)skb_pull(skb, sizeof(*hdr));
> +
> +	if (pkt->mid !=3D NOKIA_ALIVE_RESP) {
> +		dev_err(dev, "Alive received: invalid response: 0x%02x!",
> +			pkt->mid);
> +		btdev->init_error =3D -EINVAL;
> +		goto finish_alive;
> +	}

ret =3D -EINVAL?

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMABsACgkQMOfwapXb+vLqIgCdGcfKH2gQi7bP+cJnVv90ATLg
YJUAniSb34AHdNnj++MIT+omkqxySvZ6
=daMY
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
