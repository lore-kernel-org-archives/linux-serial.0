From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Fri, 29 Apr 2016 10:32:02 -0700
Message-ID: <20160429173202.GA9134@kroah.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
 <1461881913-23967-2-git-send-email-rjones@redhat.com>
 <20160428225633.GA9134@kroah.com>
 <20160429081006.GD3826@redhat.com>
 <20160429151635.GB16895@kroah.com>
 <20160429153757.GE3826@redhat.com>
 <20160429155413.GA23477@kroah.com>
 <20160429160256.GE28599@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429160256.GE28599@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jslaby@suse.com, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 29, 2016 at 05:02:57PM +0100, Richard W.M. Jones wrote:
> On Fri, Apr 29, 2016 at 08:54:13AM -0700, Greg KH wrote:
> > You are trying to take a generalized kernel and somehow "know" about the
> > hardware ahead of time it is going to run on.  That seems like two
> > conflicting requirements, don't you agree?
> 
> We would have the 8250 serial port in any kernel.  Even if Fedora
> kernel maintainers allowed us to have specialized kernels for each
> purpose, I would use the simple ISA serial port here because it allows
> us to capture debug messages very early in the boot.  Alternatives
> like virtio-console don't allow that.
> 
> The kernel does know what hardware it's running on - via the CPUID
> hypervisor leaf.  It's also possible for us to tell the kernel about
> the hardware using the command line, ACPI[*], DT, etc.  I'd really
> like to tell the kernel this is a 16550A, not broken, you don't need
> to spend time testing that.

Then properly describe the device to the kernel in a way that you know
you don't have to do the 20ms sleep from your system configuration file
(acpi, dt, etc.)

good luck,

greg k-h
