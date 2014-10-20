From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] tty: serial: 8250_mtk: Fix quot calculation
Date: Mon, 20 Oct 2014 13:30:38 +0200
Message-ID: <CABuKBeKUdzZ0oxiHyo8q82qTg+fGbnJuPz1uhWQaZbou=LQg0Q@mail.gmail.com>
References: <1412871811-5986-1-git-send-email-matthias.bgg@gmail.com>
	<20141009215228.GA23507@kroah.com>
	<CABuKBeL1v=E4ZSM2iq+zC2G=a1g4RT3DmJ16ra_RwQ_9ARZkZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBeL1v=E4ZSM2iq+zC2G=a1g4RT3DmJ16ra_RwQ_9ARZkZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jslaby@suse.cz, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Yingjoe Chen <yingjoe.chen@gmail.com>, Howard Chen <ibanezchen@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

2014-10-10 10:10 GMT+02:00 Matthias Brugger <matthias.bgg@gmail.com>:
> 2014-10-09 23:52 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:
>> On Thu, Oct 09, 2014 at 06:23:31PM +0200, Matthias Brugger wrote:
>>> The calculation of value quot for highspeed register set to three
>>> was wrong. This patch fixes the calculation so that the serial port
>>> for baudrates bigger then 576000 baud is working correctly.
>>>
>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>> ---
>>>  drivers/tty/serial/8250/8250_mtk.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
>>> index 1c4b4bf..4376c48 100644
>>> --- a/drivers/tty/serial/8250/8250_mtk.c
>>> +++ b/drivers/tty/serial/8250/8250_mtk.c
>>> @@ -81,7 +81,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>>>               /* Set to highest baudrate supported */
>>>               if (baud >= 1152000)
>>>                       baud = 921600;
>>> -             quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
>>> +             quot = (port->uartclk / (256 * baud)) + 1;
>>>       }
>>>
>>>       /*
>>
>> Has this always been incorrect, or was it caused by a specific patch?
>
> It has always been incorrect :o
>
>> Should it go to the stable kernels?  If so, how far back?
>
> No need to go to the stable kernels. The driver is only in linux-next.

Any comments on that?

Thanks,
Matthias

>
> Cheers,
> Matthias Brugger
>
>>
>> thanks,
>>
>> greg k-h
>
>
>
> --
> motzblog.wordpress.com



-- 
motzblog.wordpress.com
