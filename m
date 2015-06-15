From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support operational
 speed during setup'
Date: Mon, 15 Jun 2015 07:25:09 -0700
Message-ID: <557EE045.2090503@roeck-us.net>
References: <557ED81D.7090908@roeck-us.net> <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7CF3D545-DAE4-4510-9726-5D40740DDC5D-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 06/15/2015 06:58 AM, Marcel Holtmann wrote:
> Hi Guenter,
>
>> alpha:allmodconfig fails to build in -next with
>>
>> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_set_baudrate':
>> drivers/bluetooth/hci_ldisc.c:276:22: error: 'BOTHER' undeclared
>>
>> BOTHER is not defined for all architectures and otherwise only
>> used with '#ifdef BOTHER'.
>
> thanks for the report. Is this something that should be #ifdef at the using side or maybe just fixed for the other architectures.
>

So far it has been fixed with #ifdef, and this is the first code which
uses it outside drivers/tty. So my first tendency would be to fix it
on the user side.

However, looking into it, I think only alpha and avr32 are affected.
Let me submit patches against those and see where it goes.

Guenter
