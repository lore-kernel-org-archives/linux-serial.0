From: Greg KH <greg@kroah.com>
Subject: Re: serial: start_tx & buffer handling
Date: Thu, 3 May 2018 11:34:08 -0700
Message-ID: <20180503183408.GA12152@kroah.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> I’m trying to understand how user mode buffer is written to low level
> serial hardware registers.
> 
> For this I read the kernel code and I came to know that from user mode
> write() API lands into kernel’s tty_write() ("drivers/tty/tty_io.c")
> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
> 
> In uart_write(), the buffer is copied to circ_buf and then it calls
> low level serial hardware driver’s start_tx() (struct uart_ops
> .start_tx). But here I could not find how the buffer kept in circ_buf
> is copied to serial port’s TX_FIFO registers?
> 
> Can someone take a moment to explain me on this?

It all depends on which specific UART driver you are looking at, they
all do it a bit different depending on the hardware.

Which one are you looking at?  Look at what the start_tx callback does
for that specific driver, that should give you a hint as to how data
starts flowing.  Usually an interrupt is enabled that is used to flush
the buffer out to the hardware.

thanks,

greg k-h
