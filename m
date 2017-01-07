From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 7/9] serdev: Introduce new bus for serial attached
 devices
Date: Sat, 07 Jan 2017 16:02:51 +0200
Message-ID: <1483797771.26691.1.camel@linux.intel.com>
References: <20170106162635.19677-1-robh@kernel.org>
         <20170106162635.19677-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106162635.19677-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
> The serdev bus is designed for devices such as Bluetooth, WiFi, GPS
> and NFC connected to UARTs on host processors. Tradionally these have
> been handled with tty line disciplines, rfkill, and userspace glue
> such
> as hciattach. This approach has many drawbacks since it doesn't fit
> into the Linux driver model. Handling of sideband signals, power
> control
> and firmware loading are the main issues.
> 
> This creates a serdev bus with controllers (i.e. host serial ports)
> and
> attached devices. Typically, these are point to point connections, but
> some devices have muxing protocols or a h/w mux is conceivable. Any
> muxing is not yet supported with the serdev bus.


> --- /dev/null
> +++ b/drivers/tty/serdev/core.c
> @@ -0,0 +1,388 @@
> 

> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/idr.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/serdev.h>

Alphabetical order?

> +
> +static bool is_registered;
> +static DEFINE_IDA(ctrl_ida);
> +
> +static void serdev_device_release(struct device *dev)
> +{
> +	struct serdev_device *serdev = to_serdev_device(dev);
> +	kfree(serdev);
> +}
> +
> +static const struct device_type serdev_device_type = {
> +	.release	= serdev_device_release,
> +};
> +
> +static void serdev_ctrl_release(struct device *dev)
> +{
> +	struct serdev_controller *ctrl = to_serdev_controller(dev);
> +	ida_simple_remove(&ctrl_ida, ctrl->nr);
> +	kfree(ctrl);
> +}
> +
> +static const struct device_type serdev_ctrl_type = {
> +	.release	= serdev_ctrl_release,
> +};
> +
> +static int serdev_device_match(struct device *dev, struct
> device_driver *drv)
> +{
> +	return of_driver_match_device(dev, drv);
> +}
> +
> 

> +int serdev_device_open(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->open)
> +		return 0;
> +

> +	return serdev->ctrl->ops->open(ctrl);

Perhaps just ctrl->...();

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_open);
> +
> +void serdev_device_close(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (ctrl && ctrl->ops->close)

Perhaps same pattern

 if (!ctrl || !ctrl->ops->close)
  return;

> +		serdev->ctrl->ops->close(ctrl);

Just ctrl->... ?

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_close);
> +
> +int serdev_device_write_buf(struct serdev_device *serdev,
> +			    const unsigned char *buf, size_t count)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->write_buf)
> +		return 0;
> +
> +	return serdev->ctrl->ops->write_buf(ctrl, buf, count);

Just ctrl->... ?

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write_buf);
> +
> +void serdev_device_write_flush(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (ctrl && ctrl->ops->write_flush)
> +		serdev->ctrl->ops->write_flush(ctrl);

Both comments.

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write_flush);
> +
> +int serdev_device_write_room(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (ctrl && ctrl->ops->write_room)
> +		return serdev->ctrl->ops->write_room(ctrl);
> +

Ditto.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_write_room);
> +
> +unsigned int serdev_device_set_baudrate(struct serdev_device *serdev,
> unsigned int speed)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->set_baudrate)
> +		return 0;
> +
> +	return serdev->ctrl->ops->set_baudrate(ctrl, speed);

ctrl->...

> +
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
> +
> +void serdev_device_set_flow_control(struct serdev_device *serdev,
> bool enable)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (ctrl && ctrl->ops->set_flow_control)
> +		serdev->ctrl->ops->set_flow_control(ctrl, enable);

Both comments.

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
> +



> +static int of_serdev_register_devices(struct serdev_controller *ctrl)
> +{
> +	struct device_node *node;
> +	struct serdev_device *serdev = NULL;
> +	int err;
> +	bool found = false;
> +
> +	for_each_available_child_of_node(ctrl->dev.of_node, node) {
> +		if (!of_get_property(node, "compatible", NULL))
> +			continue;
> +
> +		dev_dbg(&ctrl->dev, "adding child %s\n", node-
> >full_name);
> +
> +		serdev = serdev_device_alloc(ctrl);
> +		if (!serdev)
> +			continue;
> +
> +		serdev->dev.of_node = node;
> +
> +		err = serdev_device_add(serdev);
> +		if (err) {
> +			dev_err(&serdev->dev,
> +				"failure adding device. status %d\n",
> err);
> +			serdev_device_put(serdev);
> +		}
> 

> +		found = true;

Perhaps

} else if (!found)
 found = true;

Otherwise if we end up with all devices not being added, called will not
know about it.


> +	}
> +	if (!found)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> 


+/**
> + * serdev_controller_remove(): remove an serdev controller
> + * @ctrl:	controller to remove
> + *
> + * Remove a serdev controller.  Caller is responsible for calling
> + * serdev_controller_put() to discard the allocated controller.
> + */
> +void serdev_controller_remove(struct serdev_controller *ctrl)
> +{
> +	int dummy;
> +
> 

> +	if (!ctrl)
> +		return;

By the way, should we take care or caller? What is the best practice
here?


> +#include <linux/types.h>
> +#include <linux/device.h>


> 

> +static inline void serdev_controller_write_wakeup(struct
> serdev_controller *ctrl)
> +{
> +	if (ctrl->serdev && ctrl->serdev->ops->write_wakeup)
> +		ctrl->serdev->ops->write_wakeup(ctrl->serdev);

Same comment about pattern.

> +}
> +
> +static inline int serdev_controller_receive_buf(struct
> serdev_controller *ctrl,
> +					      const unsigned char
> *data,
> +					      size_t count)
> +{
> +	if (ctrl->serdev && ctrl->serdev->ops->receive_buf)
> +		return ctrl->serdev->ops->receive_buf(ctrl->serdev,
> data, count);

Ditto.

> +
> +	return 0;
> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
