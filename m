From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Tue, 10 Oct 2017 10:15:28 +0200
Message-ID: <20171010081528.GJ4269@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151255.GH2618@localhost>
 <BC1C29B8-C76B-499D-B8BE-365B5D3A0065@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BC1C29B8-C76B-499D-B8BE-365B5D3A0065@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 10, 2017 at 10:10:58AM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >> This patch allows SerDev module to manage serial devices declared as
> >> attached to an UART in ACPI table.
> >> 
> >> acpi_serdev_add_device() callback will only take into account entries
> >> without enumerated flag set. This flags is set for all entries during
> >> ACPI scan, except for SPI and I2C serial devices, and for UART with
> >> 2nd patch in the series.
> >> 
> >> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> >> ---
> >> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
> >> 1 file changed, 94 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >> index c68fb3a..104777d 100644
> >> --- a/drivers/tty/serdev/core.c
> >> +++ b/drivers/tty/serdev/core.c

> >> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> >> +{
> >> +	acpi_status status;
> >> +	acpi_handle handle;
> >> +
> >> +	handle = ACPI_HANDLE(ctrl->dev.parent);
> >> +	if (!handle)
> >> +		return -ENODEV;
> >> +
> >> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> >> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
> >> +	if (ACPI_FAILURE(status)) {
> >> +		dev_warn(&ctrl->dev, "failed to enumerate Serial slaves\n");
> > 
> > s/Serial/serdev/
> > 
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	return 0;
> > 
> > What if there are no slaves defined? I'm not very familiar with the ACPI
> > helpers, but from a quick look it seems you'd then end up returning zero
> > here which would cause the serdev controller to be registered instead of
> > the tty-class device.
> > 
> > [ And if I'm mistaken, you do want to suppress that error message for
> > when there are no slaves defined. ]

> >> -	ret = of_serdev_register_devices(ctrl);
> >> -	if (ret)
> >> +	ret_of = of_serdev_register_devices(ctrl);
> >> +	ret_acpi = acpi_serdev_register_devices(ctrl);
> >> +	if (ret_of && ret_acpi) {
> >> +		dev_dbg(&ctrl->dev, "serdev%d no devices registered: of:%d acpi:%d\n",
> > 
> > "serdev%d" is redundant here as you're using dev_dbg (which will print
> > the device name).
> > 
> >> +			ctrl->nr, ret_of, ret_acpi);
> >> +		ret = -ENODEV;
> >> 		goto out_dev_del;
> >> +	}
> >> 
> >> 	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
> >> 		ctrl->nr, &ctrl->dev);
> > 
> > Hmm, I see it's already used here. No need to follow that example
> > though.
> 
> lets have an extra patch on top of it that fixes these.

Some of the above are minor nits that can be addressed by a follow-up
patch indeed, but the handling of nodes with no child devices needs to
be correct (or you could end up breaking normal serial-port support).

Johan
