From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: How to enable output to serial console at run-time?
Date: Thu, 2 Nov 2017 22:29:12 +0000
Message-ID: <20171102222912.3d0bd8ad@alans-desktop>
References: <3c348fe1-1474-6c19-691d-8130d4bd0d32@molgen.mpg.de>
        <20171102165322.GA19434@kroah.com>
        <677939ab-22d3-d220-46fd-0f45be6c9226@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <677939ab-22d3-d220-46fd-0f45be6c9226@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2 Nov 2017 20:01:07 +0100
Paul Menzel <pmenzel+linux-serial@molgen.mpg.de> wrote:

> Dear Greg,
> 
> 
> Am 02.11.2017 um 17:53 schrieb Greg KH:
> > On Thu, Nov 02, 2017 at 04:39:36PM +0100, Paul Menzel wrote:  
> 
> >> If I want to output the Linux kernel messages to the serial console, but the
> >> `console=ttyS…` line is missing on the Linux command line, is there a way to
> >> activate that during run-time by, for example, using the sysfs interface?  
> > 
> > Why not change the command line to enable it properly?  
> 
> Sometimes it’s not possible or very inconvenient to reboot the system.

Try "man 2 ioctl_tty"


Alan
