From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support operational speed during setup'
Date: Mon, 15 Jun 2015 16:43:00 +0200
Message-ID: <7F15059F-B180-4722-8167-864C4A24CE9B@holtmann.org>
References: <557ED81D.7090908@roeck-us.net> <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org> <557EE045.2090503@roeck-us.net> <E0D3336E15B58B4294723AC879BA5E94262266@IRVEXCHMB15.corp.ad.broadcom.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E94262266@IRVEXCHMB15.corp.ad.broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Faenson <ifaenson@broadcom.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic Danis <frederic.danis@linux.intel.com>, BlueZ development <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

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

However fixing the #ifdef around BOTHER is useful as well since they look unneeded. At least I can not see a reason why a platform would not define them.

Regards

Marcel
