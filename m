From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Device to write to all (serial) consoles
Date: Fri, 2 Aug 2019 18:02:43 +0200
Message-ID: <20190802160243.GA15484@kroah.com>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a lot of devices, like servers, you have more than one serial console,
> and you do not always know, how they are numbered. Therefore, we start a
> console on ttyS0 and ttyS1.
> 
> In user space, we also would like to write to both consoles to not worry
> about the numbering. Writing to `/dev/console` only write to the active
> console.

So the same data to multiple console devices with just one userspace
call?  Why?

>     $ more /proc/consoles # I think
>     tty0                 -WU (EC p  )    4:1
>     ttyS0                -W- (E  p a)    4:65
>     ttyS1                -W- (E  p a)    4:65
> 
> Does a device exist, or can a device be configured so you can write to
> all (serial) consoles from user space?

With one syscall, not that I know of, sorry.

greg k-h
