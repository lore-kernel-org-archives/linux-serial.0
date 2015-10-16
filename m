From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] tty: serial core: provide a method to search uart
 by phandle
Date: Fri, 16 Oct 2015 19:39:00 +0100
Message-ID: <20151016183900.GF4039@leverpostej>
References: <cover.1445018912.git.hns@goldelico.com>
 <c46694357c903d8791f07e2ec287c684832056a5.1445018913.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c46694357c903d8791f07e2ec287c684832056a5.1445018913.git.hns@goldelico.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 16, 2015 at 08:08:33PM +0200, H. Nikolaus Schaller wrote:
> 1. add uart_ports to a search list as soon as they are registered
> 2. provide a function to search an uart_port by phandle. This copies the
>    mechanism how devm_usb_get_phy_by_phandle() works
> 3. add a bindings document how serial slaves should use this feature
> 4. add Documentation how serla slaves work in general

I thought maintainers preferred the child node approach to the phandle
approach, and this series comes with no rationale (nor change log,
despite being 'v3').

I don't understand. What is going on here?

Mark.

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/serial/slaves.txt          |  16 +++
>  Documentation/serial/slaves.txt                    |  36 +++++++
>  drivers/tty/serial/serial_core.c                   | 107 +++++++++++++++++++++
>  include/linux/serial_core.h                        |  10 ++
>  4 files changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/slaves.txt
>  create mode 100644 Documentation/serial/slaves.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/slaves.txt b/Documentation/devicetree/bindings/serial/slaves.txt
> new file mode 100644
> index 0000000..353b87f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/slaves.txt
> @@ -0,0 +1,16 @@
> +Device-Tree bindings for UART slave devices
> +
> +A node describing a slave device defines a phandle to reference the UART
> +the device is connected to. In the (unexpected) case of two or more UARTs
> +a list of phandles can be specified.
> +
> +properties:
> +	- uart: (list of) phandle(s) of UART(s) the device is connected to
> +
> +
> +example:
> +
> +	gps {
> +		compatible = "wi2wi,w2sg0004";
> +		uart = <&uart1>;
> +	};
> diff --git a/Documentation/serial/slaves.txt b/Documentation/serial/slaves.txt
> new file mode 100644
> index 0000000..6f8d44d
> --- /dev/null
> +++ b/Documentation/serial/slaves.txt
> @@ -0,0 +1,36 @@
> +UART slave device support
> +
> +A remote device connected to a RS232 interface is usually power controlled by the DTR line.
> +The DTR line is managed automatically by the UART driver for open() and close() syscalls
> +and on demand by tcsetattr().
> +
> +With embedded devices, the serial peripheral might be directly and always connected to the UART
> +and there might be no physical DTR line involved. Power control (on/off) has to be done by some
> +chip specific device driver (which we call "UART slave") through some mechanisms (I2C, GPIOs etc.)
> +not related to the serial interface. Some devices do not explicitly tell their power state except
> +by sending or not sending data to the UART. In such a case the device driver must be able to monitor
> +data activity. The role of the device driver is to encapsulate such power control in a single place.
> +
> +This patch series allows to support such drivers by providing:
> +* a mechanism that a slave driver can identify the UART instance it is connected to
> +* a mechanism that UART slave drivers can register to be notified
> +* notfications for DTR (and other modem control) state changes
> +* notifications that the UART has received some data from the UART
> +
> +A slave device simply adds a phandle reference to the UART it is connected to, e.g.
> +
> +	gps {
> +		compatible = "wi2wi,w2sg0004";
> +		uart = <&uart1>;
> +	};
> +
> +The slave driver calls devm_serial_get_uart_by_phandle() to identify the uart driver.
> +This API follows the concept of devm_usb_get_phy_by_phandle().
> +
> +A slave device driver registers itself with serial_register_slave() to receive notifications.
> +Notification handler callbacks can be registered by serial_register_mctrl_notification() and
> +serial_register_rx_notification(). If an UART has registered a NULL slave or a NULL handler,
> +no notifications are sent.
> +
> +RX notification handlers can define a ktermios during setup and the handler function can modify
> +or decide to throw away each character that is passed upwards.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 603d2cc..9caa33e 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -38,6 +38,36 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
>  
> +static LIST_HEAD(uart_list);
> +static DEFINE_SPINLOCK(uart_lock);
> +
> +/* same concept as __of_usb_find_phy */
> +static struct uart_port *__of_serial_find_uart(struct device_node *node)
> +{
> +	struct uart_port  *uart;
> +
> +	if (!of_device_is_available(node))
> +		return ERR_PTR(-ENODEV);
> +
> +	list_for_each_entry(uart, &uart_list, head) {
> +		if (node != uart->dev->of_node)
> +			continue;
> +
> +		return uart;
> +	}
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static void devm_serial_uart_release(struct device *dev, void *res)
> +{
> +	struct uart_port *uart = *(struct uart_port **)res;
> +
> +	/* FIXME: I don't understand the serial subsystem well enough
> +	 * to know if we should call serial_put_uart(uart); here
> +	 */
> +}
> +
>  /*
>   * This is used to lock changes in serial line configuration.
>   */
> @@ -64,6 +94,79 @@ static int uart_dcd_enabled(struct uart_port *uport)
>  	return !!(uport->status & UPSTAT_DCD_ENABLE);
>  }
>  
> +/**
> + * devm_serial_get_uart_by_phandle - find the uart by phandle
> + * @dev - device that requests this uart
> + * @phandle - name of the property holding the uart phandle value
> + * @index - the index of the uart
> + *
> + * Returns the uart_port associated with the given phandle value,
> + * after getting a refcount to it, -ENODEV if there is no such uart or
> + * -EPROBE_DEFER if there is a phandle to the uart, but the device is
> + * not yet loaded. While at that, it also associates the device with
> + * the uart using devres. On driver detach, release function is invoked
> + * on the devres data, then, devres data is freed.
> + *
> + * For use by tty host and peripheral drivers.
> + */
> +
> +/* same concept as devm_usb_get_phy_by_phandle() */
> +
> +struct uart_port *devm_serial_get_uart_by_phandle(struct device *dev,
> +		const char *phandle, u8 index)
> +{
> +	struct uart_port  *uart = ERR_PTR(-ENOMEM), **ptr;
> +	unsigned long   flags;
> +	struct device_node *node;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "device does not have a device node entry\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	node = of_parse_phandle(dev->of_node, phandle, index);
> +	if (!node) {
> +		dev_err(dev, "failed to get %s phandle in %s node\n", phandle,
> +			dev->of_node->full_name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ptr = devres_alloc(devm_serial_uart_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr) {
> +		dev_err(dev, "failed to allocate memory for devres\n");
> +		goto err0;
> +	}
> +
> +	spin_lock_irqsave(&uart_lock, flags);
> +
> +	uart = __of_serial_find_uart(node);
> +	if (IS_ERR(uart)) {
> +		devres_free(ptr);
> +		goto err1;
> +	}
> +
> +	if (!try_module_get(uart->dev->driver->owner)) {
> +		uart = ERR_PTR(-ENODEV);
> +		devres_free(ptr);
> +		goto err1;
> +	}
> +
> +	*ptr = uart;
> +	devres_add(dev, ptr);
> +
> +	get_device(uart->dev);
> +
> +err1:
> +	spin_unlock_irqrestore(&uart_lock, flags);
> +
> +err0:
> +	of_node_put(node);
> +
> +	return uart;
> +}
> +EXPORT_SYMBOL_GPL(devm_serial_get_uart_by_phandle);
> +
> +
>  /*
>   * This routine is used by the interrupt handler to schedule processing in
>   * the software interrupt portion of the driver.
> @@ -2733,6 +2836,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	 */
>  	uport->flags &= ~UPF_DEAD;
>  
> +	list_add_tail(&uport->head, &uart_list);
> +
>   out:
>  	mutex_unlock(&port->mutex);
>  	mutex_unlock(&port_mutex);
> @@ -2764,6 +2869,8 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  	mutex_lock(&port_mutex);
>  
> +	list_del(&uport->head);
> +
>  	/*
>  	 * Mark the port "dead" - this prevents any opens from
>  	 * succeeding while we shut down the port.
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 297d4fa..d7a2e15 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -247,6 +247,7 @@ struct uart_port {
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>  	struct serial_rs485     rs485;
>  	void			*private_data;		/* generic platform data pointer */
> +	struct list_head	head;			/* uarts list (lookup by phandle) */
>  };
>  
>  static inline int serial_port_in(struct uart_port *up, int offset)
> @@ -475,4 +476,13 @@ static inline int uart_handle_break(struct uart_port *port)
>  					 (cflag) & CRTSCTS || \
>  					 !((cflag) & CLOCAL))
>  
> +/*
> + * Helper functions for UART slave drivers
> + */
> +
> +/* find UART by phandle (e.g. with 'uart = <&uart2>;' then call as
> + * devm_serial_get_uart_by_phandle(dev, "uart", 0);
> + */
> +extern struct uart_port *devm_serial_get_uart_by_phandle(struct device *dev,
> +		const char *phandle, u8 index);
>  #endif /* LINUX_SERIAL_CORE_H */
> -- 
> 2.5.1
> 
