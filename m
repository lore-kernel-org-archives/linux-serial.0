From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH v2] serial/8250: Add support for Exar's XR17V35x family of
 multi-port PCIe UARTs
Date: Wed, 14 Nov 2012 17:05:54 -0600
Message-ID: <CAJp1Oe71SsuWR4qxNhuEJouj2jddYPYUOdQMSAsZ6nLR-MZRpw@mail.gmail.com>
References: <CAJp1Oe7tdGRzBAfXq67kzehgfUnw2FeeJRUEiX7RGya4NWkw7g@mail.gmail.com>
 <20121114230036.2504063c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49693 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab2KNXGP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 18:06:15 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1075004vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 14 Nov 2012 15:06:14 -0800 (PST)
In-Reply-To: <20121114230036.2504063c@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

On Wed, Nov 14, 2012 at 5:00 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> +     /* Fixme: needs tidying up */
>> +     check = serial_in(up, UART_EXAR_DVID);
>> +     if ((check == 0x82) || (check == 0x84) || (check == 0x88))
>> +             p->handle_irq = exar_handle_irq;
>
> Can't you check the port type here rather than re-probing stuff ?
>
>
> Otherwise looks good

I tried that but in my tests port.type == 0 at this point.

Matt
