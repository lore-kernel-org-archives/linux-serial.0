From: Glynn Clements <glynn-yNl2PdEqlWR9KcvjrzN2WNBPR1lH4CV8@public.gmane.org>
Subject: Re: Accessing USB thermometer sensor
Date: Sat, 21 Jun 2008 10:02:35 +0100
Message-ID: <18524.50091.552123.924329@cerise.gclements.plus.com>
References: <8b08c39f01286180748bbc0eeddc56cb.squirrel@webmail.vp44.net>
	<18523.56941.116797.23150@cerise.gclements.plus.com>
	<1f60185ec2ee200f67d7a12ee6cbf2fb.squirrel@webmail.vp44.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1f60185ec2ee200f67d7a12ee6cbf2fb.squirrel-2RFepEojUI3piBo0p4lDPw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jhammond-qGaTmy9+pjn8wb0/L2CcF0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-c-programming-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


Josh Hammond wrote:

> >> usb 1-2.2: pl2303 converter now attached to ttyUSB0
> >
> > Does "cat /dev/ttyUSB0" work?
> 
> Nope. I get only blank

Thinking about it some more, if the device is outputting binary, the
line buffering performed by the TTY driver and stdio will get in the
way. How about:

	stty raw < /dev/ttyUSB0
	dd if=/dev/ttyUSB0 bs=1 | od -t x1 -w1

Or, in C:

	int fd;
	struct termios t;

	fd = open("/dev/ttyUSB0", O_RDONLY|O_NOCTTY);

	tcgetattr(fd, &t);
	cfmakeraw(&t);
	tcsetattr(fd, TCSANOW, &t);

	for (;;) {
		unsigned char buf[1];
		if (read(fd, buf, 1) <= 0)
			break;
		printf("%02x\n", *buf);
	}

	close(fd);

-- 
Glynn Clements <glynn-yNl2PdEqlWR9KcvjrzN2WNBPR1lH4CV8@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
