From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 8/9] serdev: add a tty port controller driver
Date: Wed, 18 Jan 2017 09:03:20 -0600
Message-ID: <CAL_JsqKhmMa3Vs7fnfqzVYJbz-0=AwT6DckxSuf5ykDvCmNqBQ@mail.gmail.com>
References: <20170116225436.17505-1-robh@kernel.org> <20170116225436.17505-9-robh@kernel.org>
 <1484743377.2133.204.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484743377.2133.204.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 18, 2017 at 6:42 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-01-16 at 16:54 -0600, Rob Herring wrote:
>> Add a serdev controller driver for tty ports.
>>
>> The controller is registered with serdev when tty ports are registered
>> with the TTY core. As the TTY core is built-in only, this has the side
>> effect of making serdev built-in as well.
>>
>
>>
>> +if SERIAL_DEV_BUS
>> +
>> +config SERIAL_DEV_CTRL_TTYPORT
>> +     bool "Serial device TTY port controller"
>> +     depends on TTY
>
>
>> +     depends on SERIAL_DEV_BUS != m
>
> Since you have this line the
>  if SERIAL_DEV_BUS
> is redundant for it.

It is not. It is the standard pattern of

menuconfig BLAH

if BLAH
...
endif
<EOF>

If I remove the "if", then SERIAL_DEV_CTRL_TTYPORT can be enabled when
SERIAL_DEV_BUS=n which breaks the build


> So, leave either one or another (as an example you can look at
> DMADEVICES).
>
>> +
>> +#define SERPORT_BUSY 1
>> +#define SERPORT_ACTIVE       2
>> +#define SERPORT_DEAD 3
>> +
>> +struct serport {
>> +     struct tty_port *port;
>> +     struct tty_struct *tty;
>
>> +     struct tty_driver *tty_drv;
>> +     int tty_idx;
>
> Do you need tty_ prefix for them?

It's just to be clear it's the tty driver and index rather than this
driver's driver or index.


>> +static int ttyport_open(struct serdev_controller *ctrl)
>> +{
>> +     struct serport *serport =
>> serdev_controller_get_drvdata(ctrl);
>> +     struct tty_struct *tty;
>> +     struct ktermios ktermios;
>> +
>> +     tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
>> +     serport->tty = tty;
>> +
>> +     serport->port->client_ops = &client_ops;
>> +     serport->port->client_data = ctrl;
>> +
>>
>
>> +     tty->receive_room = 65536;
>
> Magic?

Probably. It's just what every ldisc uses. I suppose we could need
clients to set this, but we can add that as needed.

>> +     if (tty->ops->open)
>> +             tty->ops->open(serport->tty, NULL);
>> +     else
>> +             tty_port_open(serport->port, tty, NULL);
>> +
>> +     /* Bring the UART into a known 8 bits no parity hw fc state
>> */
>> +     ktermios = tty->termios;
>> +     ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
>> +                           INLCR | IGNCR | ICRNL | IXON);
>> +     ktermios.c_oflag &= ~OPOST;
>> +     ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG |
>> IEXTEN);
>> +     ktermios.c_cflag &= ~(CSIZE | PARENB);
>> +     ktermios.c_cflag |= CS8;
>> +     ktermios.c_cflag |= CRTSCTS;
>> +     tty_set_termios(tty, &ktermios);
>> +
>> +     set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>> +
>>
>
>> +     mutex_lock(&serport->lock);
>> +     set_bit(SERPORT_ACTIVE, &serport->flags);
>> +     mutex_unlock(&serport->lock);
>
> So, some clarification would be good to have to understand why you need
> mutex _and_ atomic operation together.
>
> What does mutex protect?

Paranoia. Actually, looking at this closer, we can get rid of the
mutex altogether.


>> +void serdev_tty_port_unregister(struct tty_port *port)
>> +{
>> +     struct serdev_controller *ctrl = port->client_data;
>> +     struct serport *serport =
>> serdev_controller_get_drvdata(ctrl);
>> +
>
>> +     if (!serport)
>> +             return;
>
> What this check prevents from?

Didn't you ask this last time? See patch #9. tty_port_destructor()
calls this unconditionally as it doesn't know whether there's a serdev
or not. ctrl may be NULL, and then serport may be NULL.

Rob
