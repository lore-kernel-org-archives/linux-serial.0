From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/10] Bluetooth: hci_uart: add serdev driver support
 library
Date: Fri, 17 Mar 2017 16:26:00 +0100
Message-ID: <20170317152600.GD8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-5-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170304115833.3538-5-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Rob Herring <robh@kernel.org>
>=20
> This adds library functions for serdev based BT drivers. This is largely
> copied from hci_ldisc.c and modified to use serdev calls. There's a little
> bit of duplication, but I avoided intermixing this as the ldisc code shou=
ld
> eventually go away.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Tested-By: Sebastian Reichel <sre@kernel.org>

Trivial comments below.

> @@ -0,0 +1,370 @@
> +/*
> + *
> + *  Bluetooth HCI serdev driver lib

Just one empty line.

> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
> + *
> + */

I don't think we put the address in there any more.

> +static void hci_uart_write_work(struct work_struct *work)
> +{
> +	struct hci_uart *hu =3D container_of(work, struct hci_uart, write_work);
> +	struct serdev_device *serdev =3D hu->serdev;
> +	struct hci_dev *hdev =3D hu->hdev;
> +	struct sk_buff *skb;
> +
> +	/* REVISIT: should we cope with bad skbs or ->write() returning
> +	 * and error value ?
> +	 */

"an error value"? Comment style?

> +restart:
> +	clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
> +
> +	while ((skb =3D hci_uart_dequeue(hu))) {
> +		int len;
> +
> +		len =3D serdev_device_write_buf(serdev, skb->data, skb->len);
> +		hdev->stat.byte_tx +=3D len;
> +
> +		skb_pull(skb, len);
> +		if (skb->len) {
> +			hu->tx_skb =3D skb;
> +			break;
> +		}
> +
> +		hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
> +		kfree_skb(skb);
> +	}
> +
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> +		goto restart;

do {} while () instead of goto?

> +/* ------- Interface to HCI layer ------ */
> +/* Initialize device */

Comment style?

> +	if (hu->proto->set_baudrate && speed) {
> +		err =3D hu->proto->set_baudrate(hu, speed);
> +		if (!err)
> +			serdev_device_set_baudrate(hu->serdev, speed);
> +	}

Complain about the error here?

> +	if (skb->len !=3D sizeof(*ver)) {
> +		BT_ERR("%s: Event length mismatch for version information",
> +		       hdev->name);
> +		goto done;
> +	}
> +
> +done:

Get rid of goto and label?

> +/* hci_uart_write_wakeup()
> + *
> + *    Callback for transmit wakeup. Called when low level
> + *    device driver can accept more send data.
> + *
> + * Arguments:        tty    pointer to associated tty instance data
> + * Return Value:    None
> + */

Kerneldoc? :-)

> +static void hci_uart_write_wakeup(struct serdev_device *serdev)
> +{
> +	struct hci_uart *hu =3D serdev_device_get_drvdata(serdev);
> +
> +	BT_DBG("");
> +
> +	if (!hu)
> +		return;
> +
> +	if (serdev !=3D hu->serdev)
> +		return;

WARN_ON on both of these? That should not be normal condition...

> +	/* Only when vendor specific setup callback is provided, consider
> +	 * the manufacturer information valid. This avoids filling in the
> +	 * value for Ericsson when nothing is specified.
> +	 */

Is this comment still up-to-date?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMAAgACgkQMOfwapXb+vKrBwCeMuTedU3JXC/6xiNczqFuIXgF
Z74AnRJ/wltmF0OIzLtPDCGs0JEH0qLb
=qvqN
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
