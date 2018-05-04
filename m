From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: serial: start_tx & buffer handling
Date: Fri, 4 May 2018 10:01:21 +0530
Message-ID: <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
 <20180503183408.GA12152@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503183408.GA12152@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 4, 2018 at 12:04 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
>> Hi All,
>>
>> I=E2=80=99m trying to understand how user mode buffer is written to low =
level
>> serial hardware registers.
>>
>> For this I read the kernel code and I came to know that from user mode
>> write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty_io=
.c")
>> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
>>
>> In uart_write(), the buffer is copied to circ_buf and then it calls
>> low level serial hardware driver=E2=80=99s start_tx() (struct uart_ops
>> .start_tx). But here I could not find how the buffer kept in circ_buf
>> is copied to serial port=E2=80=99s TX_FIFO registers?
>>
>> Can someone take a moment to explain me on this?
>
> It all depends on which specific UART driver you are looking at, they
> all do it a bit different depending on the hardware.
>
> Which one are you looking at?  Look at what the start_tx callback does
> for that specific driver, that should give you a hint as to how data
> starts flowing.  Usually an interrupt is enabled that is used to flush
> the buffer out to the hardware.
>

I=E2=80=99m looking for any existing sample code which does DMA transfers o=
f
UART transmitted data. I looked at the bcm63xx_uart.c, it looks it
does not handle DMA transfers. Even copying the Tx buffer (from
circ_buf) to UART_FIFO_REG happening in ISR.


> thanks,
>
> greg k-h



--=20
Thanks,
Sekhar
