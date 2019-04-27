From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: 8250: Fix type field in format string
Date: Sat, 27 Apr 2019 10:59:20 +0200
Message-ID: <20190427085920.GA25621@kroah.com>
References: <20190427080013.GA3624@haolee.io>
 <20190427080942.GA8218@kroah.com>
 <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hao Lee <haolee.swjtu@gmail.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 27, 2019 at 04:41:44PM +0800, Hao Lee wrote:
> On Sat, 27 Apr 2019 at 16:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Apr 27, 2019 at 04:00:15PM +0800, Hao Lee wrote:
> > > The variable type and the type field is inconsistent.
> >
> > In what way?  Please be very specific when you resend this.
> 
> The main problem is the dev_dbg statement should print the value of
> uart.port.mapbase instead of its address. Besides that, uart.port.irq
> and uart.port.iotype are all unsigned types, so using %u is more
> appropriate.

Wonderful, put all of that in the changelog text and please resend.
What you submitted is not sufficient.

thanks,

greg k-h
