From: Hao Lee <haolee.swjtu@gmail.com>
Subject: Re: [PATCH] tty: serial: 8250: Fix type field in format string
Date: Sat, 27 Apr 2019 16:41:44 +0800
Message-ID: <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
References: <20190427080013.GA3624@haolee.io> <20190427080942.GA8218@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427080942.GA8218@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 27 Apr 2019 at 16:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Apr 27, 2019 at 04:00:15PM +0800, Hao Lee wrote:
> > The variable type and the type field is inconsistent.
>
> In what way?  Please be very specific when you resend this.

The main problem is the dev_dbg statement should print the value of
uart.port.mapbase instead of its address. Besides that, uart.port.irq
and uart.port.iotype are all unsigned types, so using %u is more
appropriate.

Regards,
Hao Lee
