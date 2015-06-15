From: Ilya Faenson <ifaenson-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: Build error -in -next due to 'Bluetooth: hci_uart: Support
 operational speed during setup'
Date: Mon, 15 Jun 2015 16:51:12 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9426232D@IRVEXCHMB15.corp.ad.broadcom.com>
References: <557ED81D.7090908@roeck-us.net>
 <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
 <557EE045.2090503@roeck-us.net>
 <E0D3336E15B58B4294723AC879BA5E94262266@IRVEXCHMB15.corp.ad.broadcom.com>
 <7F15059F-B180-4722-8167-864C4A24CE9B@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7F15059F-B180-4722-8167-864C4A24CE9B-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org] 
Sent: Monday, June 15, 2015 10:43 AM
To: Ilya Faenson
Cc: Guenter Roeck; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frederic Danis; BlueZ development; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support operational speed during setup'

Hi Ilya,

>>> alpha:allmodconfig fails to build in -next with
>>> 
>>> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_set_baudrate':
>>> drivers/bluetooth/hci_ldisc.c:276:22: error: 'BOTHER' undeclared
>>> 
>>> BOTHER is not defined for all architectures and otherwise only
>>> used with '#ifdef BOTHER'.
>> 
>> thanks for the report. Is this something that should be #ifdef at the using side or maybe just fixed for the other architectures.
>> 
> 
> So far it has been fixed with #ifdef, and this is the first code which
> uses it outside drivers/tty. So my first tendency would be to fix it
> on the user side.
> 
> However, looking into it, I think only alpha and avr32 are affected.
> Let me submit patches against those and see where it goes.
> 
> IF: The BOTHER flag should not be involved in setting the baud rate at all. I've published a patch last week that implements the hci_uart_set_baudrate properly (in my opinion).

can you extract this and just submit that version. We might just take that into hci_ldisc.c right away.

IF: I've published my version now, thanks.

However fixing the #ifdef around BOTHER is useful as well since they look unneeded. At least I can not see a reason why a platform would not define them.

Regards

Marcel
