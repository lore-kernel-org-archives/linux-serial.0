From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: RCU stall in 8250 serial driver Linux 4.15-rc1
Date: Wed, 24 Jan 2018 18:40:32 +0200
Message-ID: <CAHp75Vejt2h_nnLwS+_hy1WYSgo_U7ry1vRAYksaCA4e002k4A@mail.gmail.com>
References: <CAASgV=tHtf88=h-wtUrnoC74M6BEnNXcCg8d3DyWJfx21dnLYg@mail.gmail.com>
 <20180117170520.GA12606@kroah.com> <CAASgV=tRY1ioh4vZi3ZyugDJzCiADwo+Mg+HNoEwCzAaV_G=jQ@mail.gmail.com>
 <20180123155229.2035e674@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123155229.2035e674@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Shankara Pailoor <sp3485@columbia.edu>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 23, 2018 at 5:52 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 17 Jan 2018 09:24:32 -0800
> Shankara Pailoor <sp3485@columbia.edu> wrote:
>
>> Hi Greg,
>>
>> Sorry for that. Here is the stack trace. C Program below
>
>
>
>>  serial_in drivers/tty/serial/8250/8250.h:111 [inline]
>>  wait_for_xmitr+0x8a/0x1d0 drivers/tty/serial/8250/8250_port.c:2033
>>  serial8250_console_putchar+0x19/0x50 drivers/tty/serial/8250/8250_port.c:3170
>>  uart_console_write+0x98/0xc0 drivers/tty/serial/serial_core.c:1858
>
> The console is spinning in polled mode trying to write data to the
> console port, which it seems has gotten a bit stuck. Could be the
> hypervisor hits some kind of buffering limit, could be hypervisor
> interface broke.
>
> Either way the console interface is supposed to stall the machine to
> ensure the bytes always get out and if your serial port jams or gets
> massively behind then this will happen.

+1
https://lkml.org/lkml/2017/12/21/480

-- 
With Best Regards,
Andy Shevchenko
