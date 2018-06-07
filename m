From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Date: Thu, 7 Jun 2018 12:27:40 +0200
Message-ID: <20180607102740.GD4372@localhost>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-5-ricardo.ribalda@gmail.com>
 <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi!

> > Describe which hardware is supported by the current driver.
> > 
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: linux-bluetooth@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > drivers/bluetooth/hci_nokia.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> > index 3539fd03f47e..e32dfcd56b8d 100644
> > --- a/drivers/bluetooth/hci_nokia.c
> > +++ b/drivers/bluetooth/hci_nokia.c
> > @@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
> > MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> > #endif
> > 
> > +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> > +	{ "hp4-bluetooth", },
> > +	{},
> > +};
> > +
> > static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> > 	.probe = nokia_bluetooth_serdev_probe,
> > 	.remove = nokia_bluetooth_serdev_remove,
> > @@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> > 		.pm = &nokia_bluetooth_pm_ops,
> > 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
> > 	},
> > +	.id_table = nokia_bluetooth_serdev_id,
> > };
> 
> I would actually skip this hardware. First of all it is such a dedicated custom Nokia transport and hardware, and secondly it is no longer produced anyway.
> 

Would it make sense to cc: sre here? We want good support even for old
hardware, and this is n9/n950, it is still on "top ten supported
phones" list... Probably even top 5.

Thanks,
								 Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
