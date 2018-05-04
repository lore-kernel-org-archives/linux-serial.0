From: =?UTF-8?Q?lo=C3=AFc_tourlonias?= <loic.tourlonias@gmail.com>
Subject: Re: serial: start_tx & buffer handling
Date: Fri, 4 May 2018 14:14:41 +0200
Message-ID: <CA+XxOSETX-3P9vNfOTgHK8cu=65oXpZpuznHE1ThD_nb2QYseA@mail.gmail.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
 <20180503183408.GA12152@kroah.com> <CAHhAz+iub6boqtK7UgFuKW=4t9DYPrnPX6nDu8R4T2J4=v=-DA@mail.gmail.com>
 <CA+XxOSG8UozW9uzmdrtmAOEYsgwxPVEUB8B=3HNnsrnZMuGF2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+XxOSG8UozW9uzmdrtmAOEYsgwxPVEUB8B=3HNnsrnZMuGF2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

 Hi

 On Fri, May 4, 2018 at 6:31 AM, Muni Sekhar <munisekharrms@gmail.com> wrot=
e:
>>
>> On Fri, May 4, 2018 at 12:04 AM, Greg KH <greg@kroah.com> wrote:
>> > On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
>> >> Hi All,
>> >>
>> >> I=E2=80=99m trying to understand how user mode buffer is written to l=
ow level
>> >> serial hardware registers.
>> >>
>> >> For this I read the kernel code and I came to know that from user mod=
e
>> >> write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty=
_io.c")
>> >> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c")=
.
>> >>
>> >> In uart_write(), the buffer is copied to circ_buf and then it calls
>> >> low level serial hardware driver=E2=80=99s start_tx() (struct uart_op=
s
>> >> .start_tx). But here I could not find how the buffer kept in circ_buf
>> >> is copied to serial port=E2=80=99s TX_FIFO registers?
>> >>
>> >> Can someone take a moment to explain me on this?
>> >
>> > It all depends on which specific UART driver you are looking at, they
>> > all do it a bit different depending on the hardware.
>> >
>> > Which one are you looking at?  Look at what the start_tx callback does
>> > for that specific driver, that should give you a hint as to how data
>> > starts flowing.  Usually an interrupt is enabled that is used to flush
>> > the buffer out to the hardware.
>> >
>>
>> I=E2=80=99m looking for any existing sample code which does DMA transfer=
s of
>> UART transmitted data. I looked at the bcm63xx_uart.c, it looks it
>> does not handle DMA transfers. Even copying the Tx buffer (from
>> circ_buf) to UART_FIFO_REG happening in ISR.


 You can have a look at atmel_serial kernel module (built for ARM).
 https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/atmel_se=
rial.c

 The dma buffer is linked to uart circular buffer in prepare_tx() function
 called from uart_startup(). It's released in release_tx() function called
 from uart_shutdown(). DMA buffer is managed in schedule_tx() function call=
ed
 from a tasklet triggered by the ISR.

 HTH

>>
>>
>> > thanks,
>> >
>> > greg k-h
>>
>>
>>
>> --
>> Thanks,
>> Sekhar
>>
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>
