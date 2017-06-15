From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 3/4] max9260: add driver for i2c over GMSL passthrough
Date: Thu, 15 Jun 2017 17:37:38 +0200
Message-ID: <20170615153738.g7zm327oou5b2kxy@ninjato>
References: <1497451130-7741-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1497451130-7741-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rlspv7u2nzocs2f7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497451130-7741-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: robh@kernel.org, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--rlspv7u2nzocs2f7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uli,

> +static void wait_for_transaction(struct max9260_device *dev)
> +{
> +	wait_event_interruptible_timeout(dev->rx_wq,
> +		dev->rx_state <= RX_FRAME_ERROR,
> +		HZ/2);
> +}

> +static void transact(struct max9260_device *dev,

max9260_transact?

> +			     int expect,
> +			     u8 *request, int len)
> +{
> +	serdev_device_mux_select(dev->serdev);
> +
> +	serdev_device_set_baudrate(dev->serdev, 115200);
> +	serdev_device_set_parity(dev->serdev, 1, 0);
> +
> +	dev->rx_state = expect;
> +	serdev_device_write_buf(dev->serdev, request, len);
> +
> +	wait_for_transaction(dev);
> +
> +	serdev_device_mux_deselect(dev->serdev);
> +}
> +
> +static int max9260_read_reg(struct max9260_device *dev, int reg)
> +{
> +	u8 request[] = { 0x79, 0x91, reg, 1 };
> +	u8 rx;
> +
> +	dev->rx_len = 1;
> +	dev->rx_buf = &rx;
> +
> +	transact(dev, RX_EXPECT_ACK_DATA, request, 4);
> +
> +	if (dev->rx_state == RX_FINISHED)
> +		return rx;
> +
> +	return -1;

-EIO?

> +}
> +
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
> +	}
> +
> +	return 0;
> +}
> +
> +static void max9260_uart_write_wakeup(struct serdev_device *serdev)
> +{
> +}
> +
> +static int max9260_uart_receive_buf(struct serdev_device *serdev,
> +				    const u8 *data, size_t count)
> +{
> +	struct max9260_device *dev = serdev_device_get_drvdata(serdev);
> +	int accepted;
> +
> +	switch (dev->rx_state) {
> +	case RX_FINISHED:
> +		dev_dbg(&dev->serdev->dev, "excess data ignored\n");
> +		return count;
> +
> +	case RX_EXPECT_ACK:
> +	case RX_EXPECT_ACK_DATA:
> +		if (data[0] != ACK) {
> +			dev_dbg(&dev->serdev->dev, "frame error");
> +			dev->rx_state = RX_FRAME_ERROR;
> +			wake_up_interruptible(&dev->rx_wq);
> +			return 1;
> +		}
> +		switch (dev->rx_state) {
> +		case RX_EXPECT_ACK_DATA:
> +			dev->rx_state = RX_EXPECT_DATA;
> +			break;
> +		case RX_EXPECT_ACK:
> +			dev->rx_state = RX_FINISHED;
> +			wake_up_interruptible(&dev->rx_wq);
> +			break;
> +		}

This switch inside a switch evaluating the same variable is easy to
misunderstand. What about a simple if-else for the second switch block
above?

> +		return 1;
> +
> +	case RX_EXPECT_DATA:
> +		accepted = dev->rx_len < count ? dev->rx_len : count;
> +
> +		memcpy(dev->rx_buf, data, accepted);
> +
> +		dev->rx_len -= accepted;
> +		dev->rx_buf += accepted;
> +
> +		if (!dev->rx_len) {
> +			dev->rx_state = RX_FINISHED;
> +			wake_up_interruptible(&dev->rx_wq);
> +		}
> +
> +		return accepted;
> +
> +	case RX_FRAME_ERROR:
> +		dev_dbg(&dev->serdev->dev, "%d bytes ignored\n", count);
> +		return count;
> +
> +	}
> +	return 0;
> +}
> +
> +struct serdev_device_ops max9260_serdev_client_ops = {
> +	.receive_buf = max9260_uart_receive_buf,
> +	.write_wakeup = max9260_uart_write_wakeup,
> +};
> +
> +static u32 max9260_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_EMUL;

According to the below xfer function, it should return:

I2C_SMBUS_BYTE | I2C_SMBUS_BYTE_DATA;

> +}
> +
...

> +static int max9260_probe(struct serdev_device *serdev)
> +{
> +	struct max9260_device *dev;
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);

devm_kzalloc?

> +	if (!dev)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&dev->rx_wq);
> +
> +	dev->serdev = serdev;
> +	serdev_device_open(serdev);
> +	serdev_device_set_drvdata(serdev, dev);
> +
> +	serdev_device_set_client_ops(serdev, &max9260_serdev_client_ops);
> +
> +	ret = max9260_setup(dev);
> +

Newline can go.

> +	if (ret < 0)
> +		goto err_free;
> +
> +	adap = &dev->adap;
> +	i2c_set_adapdata(adap, dev);
> +
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &max9260_i2c_algorithm;
> +	adap->dev.parent = &serdev->dev;
> +	adap->retries = 5;
> +	adap->nr = -1;

You can skip this...

> +	strlcpy(adap->name, dev_name(&serdev->dev), sizeof(adap->name));
> +
> +	ret = i2c_add_numbered_adapter(adap);

... if you use i2c_add_adapter(adap); here. No 'numbered'.

> +	if (ret < 0) {
> +		dev_err(&serdev->dev, "failed to register i2c adapter\n");

No need for dev_err. The core will properly report failures.

> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	kfree(dev);
> +	return ret;
> +}

Regards,

   Wolfram

--rlspv7u2nzocs2f7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllCqbgACgkQFA3kzBSg
KbY/vQ//RleqK68AbhTCrJoxA8UQm6XtUNoEZ9onPTQamaeU9ESjs4j26QR7jYrS
FvkGszwnhoB+K88rBaOWwhMxqpJA+2wo7QGC9JFoQ0ZZjeVLLeUE1ihio+RCHBCm
HWfb6j+cK/ZrAak2a+BIjIEqumc4pmenkMUjanxnEKLhvriEAYXIqU86e10tGRBM
5mNnLcDHgBRUS2Zn0fxolr+nucWuXXzYh5AX8uA2swSsmM+SpOKRBRanmUMsekW7
zlJlrU5dn8/PZeE/drt/f0SGQrubkuKyEogYu64KZkhamIAYk0F7XA9SrUMcMa2u
2g7jYrPgLN2mrEVoFEjllGcY/nsj5wKQfZaaO4GXD+z16Fa7z9ZXp4i1FTp04pwY
/9epoBsxwmNQyYOvVe6QfKbYh93ZKBWYIfLAMSuDz/4f4fqJO/dXZjMuWxSwbnSU
6JYkvrTCNJSF0uzUGasH6oZC8FuMsDIyFlIkUEy2UmiLHyNdBEu/J3DFnJVuiCzU
1qstpVn27JmiVa5H85JchLGRQGEfP3nGL5YYwaDEkbZhLTkgHxKBEle3ZHM1Mhhq
31mwNbxE4WFsV6jN70IicqLfkphJA2fBI1PiAcFP/yYo98ExNpViTGHClMFWQC2d
A9vRohq9w5uUiGuKPWDs8hN4EheVTMv3krQeqSpxK6VIdVvw5zU=
=h1g0
-----END PGP SIGNATURE-----

--rlspv7u2nzocs2f7--
