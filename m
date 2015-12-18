From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 10/11] tty: serial: 8250: Replace printk by pr_*
Date: Fri, 18 Dec 2015 07:10:52 -0800
Message-ID: <567421FC.7080005@hurleysoftware.com>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
 <1450437723-2978-11-git-send-email-anton.wuerfel@fau.de>
 <1450441926.30729.208.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450441926.30729.208.camel@linux.intel.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffe>
List-Id: linux-serial@vger.kernel.org

Hi Anton,

On 12/18/2015 04:32 AM, Andy Shevchenko wrote:
> On Fri, 2015-12-18 at 12:22 +0100, Anton Wuerfel wrote:
>=20
>=20
>>  This comes with a slight change in behaviour as
>> pr_debug is configurable via CONFIG_DYNAMIC_DEBUG, whereas
>> printk(KERN_DEBUG ...) is not.

Please make this one change and the changes Andy is suggesting
it a separate patch.

That way the commit can describe how the get the equivalent
behavior (ie., with CONFIG_DYNAMIC_DEBUG) rather than with
-DSERIAL_DEBUG_PNP.

Regards,
Peter Hurley

> --- a/drivers/tty/serial/8250/8250_pnp.c
>> +++ b/drivers/tty/serial/8250/8250_pnp.c
>> @@ -465,9 +465,9 @@ serial_pnp_probe(struct pnp_dev *dev, const
>> struct pnp_device_id *dev_id)
>>  		return -ENODEV;
>> =20
>>  #ifdef SERIAL_DEBUG_PNP
>> -	printk(KERN_DEBUG
>=20
> I think it's not okay.
>=20
> The rationale to have printk(KERN_DEBUG =E2=80=A6) here is to allow a
> compilation with support of those messages independently on
> DYNAMIC_DEBUG.
>=20
> If you want to switch to DYNAMIC_DEBUG you have to carefully check wh=
at
> is done under SERIAL_DEBUG_PNP.
>=20
> git grep on current linux-next shows that SERIAL_DEBUG_PNP is an
> orphan.
>=20
> So, I would suggest to remove #ifdef.
>=20
>> -		"Setup PNP port: port %x, mem 0x%lx, irq %d, type
>> %d\n",
>> -		       uart.port.iobase, uart.port.mapbase,
>> uart.port.irq, uart.port.iotype);
>> +	pr_debug("Setup PNP port: port %x, mem 0x%lx, irq %d, type
>> %d\n",
>> +		 uart.port.iobase, uart.port.mapbase,
>> +		 uart.port.irq, uart.port.iotype);
>>  #endif
>>
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
