From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Wed, 16 Aug 2017 15:23:27 +0200
Message-ID: <CAO3366zyKbiEv0vUsbXtZN6HXwzJrr1GQA_d6f=BCj=9Z+HQpQ@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com> <12735239.0iiT7hxZXA@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <12735239.0iiT7hxZXA@avalon>
Sender: linux-i2c-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 31, 2017 at 1:13 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +static int max9260_probe(struct serdev_device *serdev)
>> +{
>> +     struct max9260_device *dev;
>> +     struct i2c_adapter *adap;
>> +     int ret;
>> +
>> +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +     if (!dev)
>> +             return -ENOMEM;
>> +
>> +     init_waitqueue_head(&dev->rx_wq);
>> +
>> +     dev->serdev = serdev;
>> +     serdev_device_open(serdev);
>> +     serdev_device_set_drvdata(serdev, dev);
>> +
>> +     serdev_device_set_client_ops(serdev, &max9260_serdev_client_ops);
>> +
>> +     ret = max9260_setup(dev);
>> +     if (ret < 0)
>> +             goto err_free;
>> +
>> +     adap = &dev->adap;
>> +     i2c_set_adapdata(adap, dev);
>> +
>> +     adap->owner = THIS_MODULE;
>> +     adap->algo = &max9260_i2c_algorithm;
>> +     adap->dev.parent = &serdev->dev;
>> +     adap->retries = 5;
>> +     strlcpy(adap->name, dev_name(&serdev->dev), sizeof(adap->name));
>> +
>> +     ret = i2c_add_adapter(adap);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return 0;
>> +
>> +err_free:
>
> No need for a serdev_device_close() ?

serdev_device_{open,close}() actually operate on the controller, so
that would pull the rug from under the other devices connected to that
controller.

CU
Uli
