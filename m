From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 1 Feb 2007 09:45:22 +0000
Message-ID: <20070201094522.GA24608@flint.arm.linux.org.uk>
References: <6d6a94c50701310249o2b2c8024i4d3f28ec1601246a@mail.gmail.com> <20070131162123.67e22e23@localhost.localdomain> <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422715AbXBAJpk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 01, 2007 at 10:33:40AM +0800, Aubrey Li wrote:
> On 2/1/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> >What code is running on that console at the time. Most likely that user
> >code is also saving/restoring terminal settings so overwrite yours
> >
> 
> I implemented the serial driver by myself, :). See the attachment.
> I didn't save/restore terminal setting in the my_set_termios().
> 
> I trace this back till tty_tioctl(..., unsigned long arg), everytime I
> type "ENTER" key,
> the argument "arg" passed into tty_ioctl() is the address of a termios
> structure, which include wrong c_cflag.

If userspace is issuing an ioctl to re-enable crtscts, and the kernel
is obliging, how can this be a kernel bug?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
