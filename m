From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH RFC v2 1/3] tty: serial core: provide method to search uart by phandle
Date: Mon, 29 Jun 2015 18:44:23 +0200
Message-ID: <72C0781B-5DEC-474C-83B5-3CD6B8D68890@goldelico.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com> <1435520786-31867-2-git-send-email-marek@goldelico.com> <20150628213434.GB21426@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150628213434.GB21426@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Zviagintsev <sergei@s15v.net>
Cc: Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi,
thanks for the comments.

Am 28.06.2015 um 23:34 schrieb Sergei Zviagintsev <sergei@s15v.net>:

> Hi,
>=20
> Some comments below.
>=20
> On Sun, Jun 28, 2015 at 09:46:24PM +0200, Marek Belisko wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>=20
>> 1. add registered uart_ports to a search list
>> 2. provide a function to search an uart_port by phandle. This copies=
 the
>>   mechanism how devm_usb_get_phy_by_phandle() works
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> Documentation/serial/slaves.txt  |  36 ++++++++++++++
>> drivers/tty/serial/serial_core.c | 103 +++++++++++++++++++++++++++++=
++++++++++
>> include/linux/serial_core.h      |  10 ++++
>> 3 files changed, 149 insertions(+)
>> create mode 100644 Documentation/serial/slaves.txt
>>=20
>> diff --git a/Documentation/serial/slaves.txt b/Documentation/serial/=
slaves.txt
>> new file mode 100644
>> index 0000000..6f8d44d
>> --- /dev/null
>> +++ b/Documentation/serial/slaves.txt
>> @@ -0,0 +1,36 @@
>> +UART slave device support
>> +
>> +A remote device connected to a RS232 interface is usually power con=
trolled by the DTR line.
>> +The DTR line is managed automatically by the UART driver for open()=
 and close() syscalls
>> +and on demand by tcsetattr().
>> +
>> +With embedded devices, the serial peripheral might be directly and =
always connected to the UART
>> +and there might be no physical DTR line involved. Power control (on=
/off) has to be done by some
>> +chip specific device driver (which we call "UART slave") through so=
me mechanisms (I2C, GPIOs etc.)
>> +not related to the serial interface. Some devices do not explicitly=
 tell their power state except
>> +by sending or not sending data to the UART. In such a case the devi=
ce driver must be able to monitor
>> +data activity. The role of the device driver is to encapsulate such=
 power control in a single place.
>> +
>> +This patch series allows to support such drivers by providing:
>> +* a mechanism that a slave driver can identify the UART instance it=
 is connected to
>> +* a mechanism that UART slave drivers can register to be notified
>> +* notfications for DTR (and other modem control) state changes
>> +* notifications that the UART has received some data from the UART
>> +
>> +A slave device simply adds a phandle reference to the UART it is co=
nnected to, e.g.
>> +
>> +	gps {
>> +		compatible =3D "wi2wi,w2sg0004";
>> +		uart =3D <&uart1>;
>> +	};
>> +
>> +The slave driver calls devm_serial_get_uart_by_phandle() to identif=
y the uart driver.
>> +This API follows the concept of devm_usb_get_phy_by_phandle().
>> +
>> +A slave device driver registers itself with serial_register_slave()=
 to receive notifications.
>> +Notification handler callbacks can be registered by serial_register=
_mctrl_notification() and
>> +serial_register_rx_notification(). If an UART has registered a NULL=
 slave or a NULL handler,
>> +no notifications are sent.
>> +
>> +RX notification handlers can define a ktermios during setup and the=
 handler function can modify
>> +or decide to throw away each character that is passed upwards.
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/s=
erial_core.c
>> index eec067d..ad61441 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -38,6 +38,33 @@
>> #include <asm/irq.h>
>> #include <asm/uaccess.h>
>>=20
>> +static LIST_HEAD(uart_list);
>> +static DEFINE_SPINLOCK(uart_lock);
>> +
>> +/* same concept as __of_usb_find_phy */
>> +static struct uart_port *__of_serial_find_uart(struct device_node *=
node)
>> +{
>> +	struct uart_port  *uart;
>> +
>> +	if (!of_device_is_available(node))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	list_for_each_entry(uart, &uart_list, head) {
>> +		if (node !=3D uart->dev->of_node)
>> +			continue;
>> +
>> +		return uart;
>=20
> We can easily save three lines here :)

Hm. We have copied from here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/usb/phy/phy.c?id=3Drefs/tags/v4.1#n65

So please let us know how you want to save 3 lines.

>=20
>> +	}
>> +
>> +	return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +
>> +static void devm_serial_uart_release(struct device *dev, void *res)
>> +{
>> +	struct uart_port *uart =3D *(struct uart_port **)res;
>> +	/* FIXME:      serial_put_uart(uart);	*/
>> +}
>=20
> Looks unfinished=85

Yes indeed. That is why we submit it as a RFC. Maybe someone can give u=
s a comment
how memory management of uart nodes works.

>=20
>> +
>> /*
>>  * This is used to lock changes in serial line configuration.
>>  */
>> @@ -64,6 +91,78 @@ static int uart_dcd_enabled(struct uart_port *upo=
rt)
>> 	return !!(uport->status & UPSTAT_DCD_ENABLE);
>> }
>>=20
>> +/**
>> + * devm_serial_get_uart_by_phandle - find the uart by phandle
>> + * @dev - device that requests this uart
>> + * @phandle - name of the property holding the uart phandle value
>> + * @index - the index of the uart
>> + *
>> + * Returns the uart_port associated with the given phandle value,
>> + * after getting a refcount to it, -ENODEV if there is no such uart=
 or
>> + * -EPROBE_DEFER if there is a phandle to the uart, but the device =
is
>> + * not yet loaded. While at that, it also associates the device wit=
h
>> + * the uart using devres. On driver detach, release function is inv=
oked
>> + * on the devres data, then, devres data is freed.
>=20
> Add -ENOMEM and -EINVAL, remove -EPROBE_DEFER?

Well, if the device is not loaded it means the caller must return -EPRO=
BE_DEFER
anyways since it can=92t complete it=92s probe function.

>=20
>> + *
>> + * For use by tty host and peripheral drivers.
>> + */
>> +
>> +/* same concept as devm_usb_get_phy_by_phandle() */
>> +
>> +struct uart_port *devm_serial_get_uart_by_phandle(struct device *de=
v,
>> +		const char *phandle, u8 index)
>> +{
>> +	struct uart_port  *uart =3D ERR_PTR(-ENOMEM), **ptr;
>> +	unsigned long flags;
>> +	struct device_node *node;
>> +
>> +	if (!dev->of_node) {
>> +		dev_err(dev, "device does not have a device node entry\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	node =3D of_parse_phandle(dev->of_node, phandle, index);
>> +	if (!node) {
>> +		dev_err(dev, "failed to get %s phandle in %s node\n", phandle,
>> +			dev->of_node->full_name);
>> +	return ERR_PTR(-ENODEV);
>=20
> Indentation issue.

Thanks!

>=20
>> +	}
>> +
>> +	ptr =3D devres_alloc(devm_serial_uart_release, sizeof(*ptr), GFP_K=
ERNEL);
>> +	if (!ptr) {
>> +		dev_err(dev, "failed to allocate memory for devres\n");
>> +		goto err0;
>> +	}
>> +
>> +	spin_lock_irqsave(&uart_lock, flags);
>> +
>> +	uart =3D __of_serial_find_uart(node);
>> +	if (IS_ERR(uart)) {
>> +		devres_free(ptr);
>=20
> I would rather create another goto label, say `out_devres_free' and
> checked uart for error there to stay similar across the function, but
> that's under question...
>=20
>> +		goto err1;
>> +	}
>> +
>> +	if (!try_module_get(uart->dev->driver->owner)) {
>> +		uart =3D ERR_PTR(-ENODEV);
>> +		devres_free(ptr);
>> +		goto err1;
>> +	}
>> +
>> +	*ptr =3D uart;
>> +	devres_add(dev, ptr);
>=20
> What is the point of assigning value to *ptr?

Good question. I think it is necessary to store a copy of the found uar=
t/phy instead of a reference.
Therefore the assignment to *ptr copies into the new memory area alloca=
ted above by=20

ptr =3D devres_alloc(devm_serial_uart_release, sizeof(*ptr), GFP_KERNEL=
);

This makes the dev the owner of the data - instead of unknown ownership=
 before.

It is the same as here (but it might be wrong/unnecessary there as well=
):

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/usb/phy/phy.c?id=3Drefs/tags/v4.1#n209

Maybe it has something to do with the unfinished devm_serial_uart_relea=
se().
=20
>=20
>> +
>> +	get_device(uart->dev);
>> +
>> +err1:
>=20
> Naming of labels is against CodingStyle.

Same as:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/usb/phy/phy.c?id=3Drefs/tags/v4.1#n214

but that can easily improved.

>=20
>> +	spin_unlock_irqrestore(&uart_lock, flags);
>> +
>> +err0:
>> +	of_node_put(node);
>> +
>> +	return uart;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_serial_get_uart_by_phandle);
>> +
>> /*
>>  * This routine is used by the interrupt handler to schedule process=
ing in
>>  * the software interrupt portion of the driver.
>> @@ -2727,6 +2826,8 @@ int uart_add_one_port(struct uart_driver *drv,=
 struct uart_port *uport)
>> 	 */
>> 	uport->flags &=3D ~UPF_DEAD;
>>=20
>> +	list_add_tail(&uport->head, &uart_list);
>> +
>>  out:
>> 	mutex_unlock(&port->mutex);
>> 	mutex_unlock(&port_mutex);
>> @@ -2758,6 +2859,8 @@ int uart_remove_one_port(struct uart_driver *d=
rv, struct uart_port *uport)
>>=20
>> 	mutex_lock(&port_mutex);
>>=20
>> +	list_del(&uport->head);
>> +
>> 	/*
>> 	 * Mark the port "dead" - this prevents any opens from
>> 	 * succeeding while we shut down the port.
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core=
=2Eh
>> index 297d4fa..ba23718 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -247,6 +247,7 @@ struct uart_port {
>> 	const struct attribute_group **tty_groups;	/* all attributes (seria=
l core use only) */
>> 	struct serial_rs485     rs485;
>> 	void			*private_data;		/* generic platform data pointer */
>> +	struct list_head	head;			/* list of uarts e.g. to look up by phand=
le */
>> };
>>=20
>> static inline int serial_port_in(struct uart_port *up, int offset)
>> @@ -475,4 +476,13 @@ static inline int uart_handle_break(struct uart=
_port *port)
>> 					 (cflag) & CRTSCTS || \
>> 					 !((cflag) & CLOCAL))
>>=20
>> +/*
>> + * Helper functions for UART slave drivers
>> + */
>> +
>> +/* find UART by phandle (e.g. with 'uart =3D <&uart2>;' then call a=
s
>> + * devm_serial_get_uart_by_phandle(dev, "uart", 0);
>> + */
>> +extern struct uart_port *devm_serial_get_uart_by_phandle(struct dev=
ice *dev,
>> +		const char *phandle, u8 index);
>> #endif /* LINUX_SERIAL_CORE_H */
>> --=20
>> 1.9.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
