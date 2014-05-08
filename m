From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: Re: Re: Re: [PATCH V6] serial/uart/8250: Add tunable RX interrupt
 trigger I/F of FIFO buffers
Date: Thu, 08 May 2014 11:15:10 +0900
Message-ID: <536AE8AE.2070402@hitachi.com>
References: <20140417060644.27329.31663.stgit@yunodevel> <20140424231158.GA32250@kroah.com> <535A226E.7000608@hitachi.com> <20140425160150.GD22879@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [133.145.228.44] ([133.145.228.44]:52567 "EHLO
	mail9.hitachi.co.jp" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaEHCPf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 May 2014 22:15:35 -0400
In-Reply-To: <20140425160150.GD22879@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Alan <gnomes@lxorguk.ukuu.org.uk>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, linux-serial@vger.kernel.org, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Aaron Sierra <asierra@xes-inc.com>, Jiri Slaby <jslaby@suse.cz>

Hi Greg,

Sorry for the late reply.

(2014/04/26 1:01), Greg Kroah-Hartman wrote:
> On Fri, Apr 25, 2014 at 05:53:02PM +0900, Yoshihiro YUNOMAE wrote:
>> Hi Greg,
>>
>> Thank you for your review.
>>
>> (2014/04/25 8:11), Greg Kroah-Hartman wrote:
>>> On Thu, Apr 17, 2014 at 03:06:44PM +0900, Yoshihiro YUNOMAE wrote:
>> [snip]
>>>> +static DEVICE_ATTR(rx_int_trig, S_IRUSR | S_IWUSR | S_IRGRP,
>>>> +		   serial8250_get_attr_rx_int_trig,
>>>> +		   serial8250_set_attr_rx_int_trig);
>>>> +
>>>
>>> As you are adding a new sysfs attribute, you have to add a
>>> Documentation/ABI/ entry as well.
>>
>> I added this attribute to /sys/dev/char/*
>
> What?  No.  That's not ok, why would it be?
>
> See, Documentation would have pointed that problem out very obviously=
 :)
>
>> , so the documentation may be sysfs-dev. However, any other attribut=
es
>> are not written at all. Should I add this description to it or is
>> there another file?
>
> It shouldn't be on a char device, that's not acceptable.

My reply that I added this attribute to /sys/dev/char/* was
inappropriate. Actually, I added it to a serial device(ttyS0) in
/sys/devices/ tree. /sys/dev/char/* stores symlinks of devices
in /sys/devices/ tree.

I think the documentation where I should add the description is
Documentation/ABI/testing/sysfs-tty. (/sys/class/* also stores
symlinks of devices in /sys/devices/ tree.)

>>>> +static struct attribute *serial8250_dev_attrs[] =3D {
>>>> +	&dev_attr_rx_int_trig.attr,
>>>> +	NULL,
>>>> +	};
>>>> +
>>>> +static struct attribute_group serial8250_dev_attr_group =3D {
>>>> +	.attrs =3D serial8250_dev_attrs,
>>>> +	};
>>>
>>> What's wrong with the macro to create a group?
>>
>> I'll explain about this below.
>>
>>>> +
>>>> +static void register_dev_spec_attr_grp(struct uart_8250_port *up)
>>>> +{
>>>> +	const struct serial8250_config *conf_type =3D &uart_config[up->p=
ort.type];
>>>> +
>>>> +	if (conf_type->rxtrig_bytes[0])
>>>> +		up->port.dev_spec_attr_group =3D &serial8250_dev_attr_group;
>>>> +}
>>>> +
>>>>   static void serial8250_config_port(struct uart_port *port, int f=
lags)
>>>>   {
>>>>   	struct uart_8250_port *up =3D
>>>> @@ -2708,6 +2848,9 @@ static void serial8250_config_port(struct ua=
rt_port *port, int flags)
>>>>   	if ((port->type =3D=3D PORT_XR17V35X) ||
>>>>   	   (port->type =3D=3D PORT_XR17D15X))
>>>>   		port->handle_irq =3D exar_handle_irq;
>>>> +
>>>> +	register_dev_spec_attr_grp(up);
>>>> +	up->fcr =3D uart_config[up->port.type].fcr;
>>>>   }
>>>>
>>>>   static int
>>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial=
/serial_core.c
>>>> index 2cf5649..41ac44b 100644
>>>> --- a/drivers/tty/serial/serial_core.c
>>>> +++ b/drivers/tty/serial/serial_core.c
>>>> @@ -2548,15 +2548,16 @@ static struct attribute *tty_dev_attrs[] =3D=
 {
>>>>   	NULL,
>>>>   	};
>>>>
>>>> -static const struct attribute_group tty_dev_attr_group =3D {
>>>> +static struct attribute_group tty_dev_attr_group =3D {
>>>>   	.attrs =3D tty_dev_attrs,
>>>>   	};
>>>>
>>>> -static const struct attribute_group *tty_dev_attr_groups[] =3D {
>>>> -	&tty_dev_attr_group,
>>>> -	NULL
>>>> -	};
>>>> -
>>>> +static void make_uport_attr_grps(struct uart_port *uport)
>>>> +{
>>>> +	uport->attr_grps[0] =3D &tty_dev_attr_group;
>>>> +	if (uport->dev_spec_attr_group)
>>>> +		uport->attr_grps[1] =3D uport->dev_spec_attr_group;
>>>> +}
>>>>
>>>>   /**
>>>>    *	uart_add_one_port - attach a driver-defined port structure
>>>> @@ -2607,12 +2608,15 @@ int uart_add_one_port(struct uart_driver *=
drv, struct uart_port *uport)
>>>>
>>>>   	uart_configure_port(drv, state, uport);
>>>>
>>>> +	make_uport_attr_grps(uport);
>>>> +
>>>>   	/*
>>>>   	 * Register the port whether it's detected or not.  This allows
>>>>   	 * setserial to be used to alter this port's parameters.
>>>>   	 */
>>>>   	tty_dev =3D tty_port_register_device_attr(port, drv->tty_driver=
,
>>>> -			uport->line, uport->dev, port, tty_dev_attr_groups);
>>>> +			uport->line, uport->dev, port,
>>>> +			(const struct attribute_group **)uport->attr_grps);
>>>
>>> If you have to cast that hard, something is wrong here, why are you
>>> doing that?
>>
>> The attribute group in serial layer was defined as constant
>> because serial layer has only common sysfs I/F. However, I want to
>> change sysfs I/F for specific devices. So, I deleted 'const' from th=
e
>> definition of the attribute group in serial layer in order to make t=
he
>> attribute group be changeable. On the other hand, to pass the attrib=
ute
>> group to tty layer, the group must be const because the 5th variable=
 of
>> tty_port_register_device_attr() is an attribute group with 'const', =
so
>> I implemented like this. Although I investigated again,
>> tty_port_register_device_attr() is used only here, and
>> tty_register_device_attr() called by the function is called from 2
>> locations (the one of them passes NULL in the 5th variable).
>> Therefore, we can delete 'const' for those functions, I think.
>> How do you think about this?
>
> I think you need to not be messing with the devices in /sys/dev/char/=
 at
> all...
>
> And why do you feel you need a sysfs attribute at all?  What is it go=
ing
> to be used for?  Who needs it?  Without knowing that, I can't really
> answer your questions...

In the 1st and 2nd patches, I realized this feature by using ioctl(2),
but that was not easy to use because the RX trigger was only changeable
after opening serial fd=E3=80=80(i.e. setting termios). Alan suggested =
using
sysfs I/F. I think this is better approach because
we can solve the problem easily by using existing platform of serial
devices and users can easily change the RX trigger. So, I added the
device specific sysfs attribute.

Thanks,
Yoshihiro YUNOMAE

--=20
Yoshihiro YUNOMAE
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: yoshihiro.yunomae.ez@hitachi.com


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
