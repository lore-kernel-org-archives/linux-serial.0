From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Thu, 3 May 2012 21:34:56 +0100
Message-ID: <20120503213456.77c55c51@pyramind.ukuu.org.uk>
References: <1335817637-2862-1-git-send-email-preston.fick@silabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335817637-2862-1-git-send-email-preston.fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preston Fick <pffick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, preston.fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org, "linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


Ok this is my suggestion based on GregKH comments and a couple of others
plus some other driver and ldisc stuff that is pending

- register the gpio lines with the gpio layer dynamically
- put them in the right place in the device tree (I'll let Greg advise on
  the best way to do that bit), plus make them visible via the ioctls for
  convenience and as they will be needed anyway in kernel

That provides the user space API

After that I'll add the hooks to the core tty layer code which allow an
ldisc to adjust the gpio lines.

For that we'll need

struct tty_gpio {
	u32 base;
	u16 num;
	u16 reserved;
#define NR_TTY_GPIOMAP 8
	u16 map[NR_TTY_GPIOMAP];
	u32 reserved2[4];
};

and

tty->gpiomap

which will be NULL for most users.


Plus

struct tty_gpio d;
ioctl(tty, TIOCGPIO, &d)

and

ioctl(tty, TIOCSGPIO, &d)

where the only bits that can be updated will be the map.



So the normal use case from user space would be

struct tty_gpio d;
int fd = open("/dev/ttyUSB0", O_RDWR);
ioctl(tty, TIOCSGPIO, &d);

stuff using the gpio driver interfaces

close(fd);


And setting up for a kernel ldisc something like


/* Set a GPIO to LDISC signal mapping for ISO7816 */
ioctl(tty, TIOCGPIO, &d);
d.map[TTY_GPIO_ISO7816_RESET] = d.base;
d.map]TTY_GPIO_ISO7816_VCC] = d.base + 1;
ioctl(tty, TIOCSGPIO, &d);

/* Switch to the ldisc */
ld = N_ISO7816;
ioctl(tty, TCSETD, &ld);


and we can then abstract all the wiring details away to keep the ldisc
portable.


Thoughts ?

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
