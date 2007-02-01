From: "Aubrey Li" <aubreylee@gmail.com>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 1 Feb 2007 18:09:24 +0800
Message-ID: <6d6a94c50702010209t94964ew1aebfad2677aa315@mail.gmail.com>
References: <6d6a94c50701310249o2b2c8024i4d3f28ec1601246a@mail.gmail.com>
	 <20070131162123.67e22e23@localhost.localdomain>
	 <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
	 <20070201094522.GA24608@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422744AbXBAKJ0@vger.kernel.org>
In-Reply-To: <20070201094522.GA24608@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2/1/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Feb 01, 2007 at 10:33:40AM +0800, Aubrey Li wrote:
> > On 2/1/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > >What code is running on that console at the time. Most likely that user
> > >code is also saving/restoring terminal settings so overwrite yours
> > >
> >
> > I implemented the serial driver by myself, :). See the attachment.
> > I didn't save/restore terminal setting in the my_set_termios().
> >
> > I trace this back till tty_tioctl(..., unsigned long arg), everytime I
> > type "ENTER" key,
> > the argument "arg" passed into tty_ioctl() is the address of a termios
> > structure, which include wrong c_cflag.
>
> If userspace is issuing an ioctl to re-enable crtscts, and the kernel
> is obliging, how can this be a kernel bug?

But the fact is not.
1) kernel boot up and enable crtscts by default
2) issue an ioctl to disable crtscts.
3) not do anything but type "ENTER", kernel re-enable crtscts.

That's wrong. Terminal setting seems not be recorded by the serial core.
Is it clear?

-Aubrey
