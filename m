From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] serdev: add method to set parity
Date: Mon, 22 Jan 2018 13:03:32 +0100
Message-ID: <09434305-0622-4213-AFBA-C499134DD874@holtmann.org>
References: <1516203739-4705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20180118022355.GA3286@localhost>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180118022355.GA3286@localhost>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Bluez mailing list <linux-bluetooth@vger.kernel.org>, Rob Herring <robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, geert@linux-m68k.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

>> Adds serdev_device_set_parity() and an implementation for ttyport.
> 
> Perhaps you can mention that the interface uses an enum and the three
> settings that you add here.
> 
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>> Broken out of the "[PATCH 0/6] serdev multiplexing support" series
>> because this kind of functionality is apparently also required
>> for "[RFC v2 0/9] Realtek Bluetooth serdev support (H5 protocol)",
>> which contains an earlier revision of this patch.
> 
> Thanks for submitting this separately.
> 
>> drivers/tty/serdev/core.c           | 12 ++++++++++++
>> drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++++++
>> include/linux/serdev.h              | 10 ++++++++++
>> 3 files changed, 40 insertions(+)
>> 
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index 5dc88f6..1f25896 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -290,6 +290,18 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>> }
>> EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>> 
>> +int serdev_device_set_parity(struct serdev_device *serdev,
>> +			     enum serdev_parity parity)
>> +{
>> +	struct serdev_controller *ctrl = serdev->ctrl;
>> +
>> +	if (!ctrl || !ctrl->ops->set_parity)
>> +		return -ENOTSUPP;
>> +
>> +	return ctrl->ops->set_parity(ctrl, parity);
>> +}
>> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);
> 
> Please place the parity functions (and fields) after the set_flow
> equivalents so that we keep the line-setting functionality grouped
> together.
> 
>> +static int ttyport_set_parity(struct serdev_controller *ctrl,
>> +			      enum serdev_parity parity)
>> +{
>> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>> +	struct tty_struct *tty = serport->tty;
>> +	struct ktermios ktermios = tty->termios;
>> +
>> +	ktermios.c_cflag &= ~(PARENB | PARODD);
> 
> You should also clear CMSPAR.
> 
>> +	if (parity != SERDEV_PARITY_NONE) {
>> +		ktermios.c_cflag |= PARENB;
>> +		if (parity == SERDEV_PARITY_ODD)
>> +			ktermios.c_cflag |= PARODD;
>> +	}
>> +
>> +	return tty_set_termios(tty, &ktermios);
> 
> Note that tty_set_termios() always return 0. You need to verify that you
> got what you requested by looking at the termios after the function
> returns (and possibly return -EINVAL). Not all drivers support (all)
> parity modes.
> 
> Note that we currently do not implement proper error handling for flow
> control, but that should be fixed.
> 
> Looks good otherwise.

can I get an updated patch addressing the comments and also including the Reviewed-by tags.

Regards

Marcel
