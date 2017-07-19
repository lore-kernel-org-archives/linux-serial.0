From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Wed, 19 Jul 2017 17:00:38 +0200
Message-ID: <20170719150038.GA6172@katana>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uli,

> +struct max9260_device {
> +	struct serdev_device *serdev;
> +	u8 *rx_buf;
> +	int rx_len;
> +	int rx_state;
> +	wait_queue_head_t rx_wq;
> +	struct i2c_adapter adap;
> +};
> +
> +static void wait_for_transaction(struct max9260_device *dev)

max9260_ prefix as well?

> +{
> +	wait_event_interruptible_timeout(dev->rx_wq,
> +		dev->rx_state <= RX_FRAME_ERROR,
> +		HZ/2);

I'd suggest to drop the interruptible. It can be done but it is usually
not trivial to abort the operation gracefully when a signal comes in.

Also, timeout is superfluous since you don't get the return value?

> +static int max9260_setup(struct max9260_device *dev)
> +{
> +	int ret;
> +
> +	ret = max9260_read_reg(dev, 0x1e);
> +
> +	if (ret != 0x02) {
> +		dev_err(&dev->serdev->dev,
> +			"device does not identify as MAX9260\n");
> +		return -EINVAL;

I think -ENODEV is the proper errno for a not-found device. Also, the
error message could probably go.

> +	}
> +
> +	return 0;
> +}
> +
> +static void max9260_uart_write_wakeup(struct serdev_device *serdev)
> +{

Maybe a FIXME comment for this empty function?

> +static u32 max9260_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA;

Spaces around operators.

> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;

You don't like devm_* it seems ;)

Rest looks good to me!

Regards,

   Wolfram

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllvdBIACgkQFA3kzBSg
KbYBoQ//akita3cWm5fWkW4a71QO+xL3PmdN+HCclSaIObuGi3GBy45xfd4RcYZ5
VnNdET0QMGi+7Ft4G3ortAUry9NVqg7mYl1VD83JDCKRaZWjv/oK6mU/NzAk1GNa
HUWYXeED/eiHuTkgwLVLQ9Zo+2yJt9OYQ1W/LpLJpYwqhEaqhrhVMG32ZrfGYgBo
KyJdp2kllZ+O5eBUpueZitqX3A1FWa45AWft99iQw5ff6LMYD3Npdk92Dl1qxupk
Vp8A2CG3NeHkyk6PuVo2Tjz9BDBpUhIUYJ7HmegevlNwCs3vigeBlYtJ72KUdmgL
9BcSgs/NRclehtLfsWGlmet2kTOVFGxo8ZaDibUDPv2sLz6N0giBLwJBvQSHY2RE
6I7b850hJfJoGRrUb+xClsLnEIFEbmNr5JBFbGsvPUpO9sMh2C5oJ+cwJlHVHsQv
Q3q9MyP+W3Qzls1KJs5NdDKI91UmGHzmcbjoms9bMhl2M8kQ/oUYyi2/WMoJcSDK
KPhPMY7IKe6e6qBwF8zeV88ffp/KoSvh+1jVcHSaqH+x4+CYhSkCBrauPaNe5QM2
P1215zZZlt5X+iTnez5Sm7DMrjUL3Upg3XDA5DLgsMMclNsNtEdQMxGm7uay7UkZ
+im3EIh5hMDXmAddXATHZyYE0ugikk+8s4js5iuyrd3Z+a/+oIc=
=f3ek
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
