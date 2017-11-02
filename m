From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Is 115200 still the maximum baudrate?
Date: Thu, 2 Nov 2017 18:44:11 +0000
Message-ID: <20171102184411.4f760de0@alans-desktop>
References: <d712888f-3b91-76c5-b949-407b0c072bcf@molgen.mpg.de>
        <20171102171355.onz27qoczedq7jpv@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102171355.onz27qoczedq7jpv@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2 Nov 2017 13:13:55 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Thu, Nov 02, 2017 at 04:42:56PM +0100, Paul Menzel wrote:
> > 
> > The Linux serial console documentation [1] says that 115200 is the maximum
> > supported baudrate.
> >   
> > > The maximum baudrate is 115200.  
> > 
> > Is that still accurate? If yes, where should I look to support higher
> > values?  
> 
> See the setserial man page and the spd_* options:

Those have been obsolete for over a decade and doesn't work on all
devices.

The core Linux code supports arbitrary baud rate setting. Although it was
designed with the glibc maintainers at the time it seems they never
adopted it so you have do the following Linux specific:


	struct termios t;

	iotl(tty, TCGETS2, &t);
	t.c_flag &= ~CBAUD;
	t.c_flag |= BOTHER;
	t.c_ispeed = input baud;
	t.c_ospeed = output baud;
	ioctl(tty, TCSETS2, &t);


and it'll let you ask for any speed you want including things like midi
baud rates. 76Kbit for ESP8266 devices and so on.

After the calls check the c_ispeed/c_ospeed to see what you got.

Alan
