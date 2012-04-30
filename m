From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question:  How to power-manage UART-attached devices.
Date: Tue, 1 May 2012 00:34:20 +0100
Message-ID: <20120501003420.028b57ec@pyramind.ukuu.org.uk>
References: <20120501082209.0b560708@notabene.brown>
	<4F9F178F.3030408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9F178F.3030408@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: NeilBrown <neilb@suse.de>, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 30 Apr 2012 15:51:59 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 04/30/2012 03:22 PM, NeilBrown wrote:
> > 
> > What I would really like is to integrate it closely with the state
> > of the UART.  i.e. if the /dev/ttyO1 device is open, then the GPS
> > is "on".  If not then it is "off".  Similarly if /dev/tty/O0 is
> > open, bluetooth is "on", else "off". However I cannot find any way
> > to "plug in" to the tty or serial drivers to perform an arbitrary
> > action on first-open or last-close.  Is something like that
> > possible? If not, is it a reasonable thing to ask? Any suggests
> > about where to put such a hook?
> > 
> 
> I don't think that's the right interface.  Just because the port is
> currently open doesn't mean the device is active, nor vice versa.  ALL
> it means is that someone currently has an access handle to it.
> 
> Since a serial port models, well, a *port*, it is logical to think of
> a (hypothetical) socket containing an RS-232 connector as well as a
> power outlet.  Given that, it would be logical to drive the "power
> connector" using the same type of interface used for the other parts
> of an RS-232 control, meaning either with termios flags or via a
> dedicated control ioctl (TIOCPOWER?).

Actually several of our virtual tty interfaces treat open as meaning
powered up. It's a fairly logical power management model. A lot of our
real tty ports do the same as well and kill power on the last close.

At the tty layer the tty_port helper callbacks port->activate() and
port->shutdown() provide the needed functionality.

You don't however want to be "hooking" this - your platform needs to
provide its own versions of the relevant operations in the OMAP serial
driver.

Alan
