From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Fri, 25 Jan 2013 16:21:47 -0800
Message-ID: <20130126002147.GA5132@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214121.GA30924@kroah.com>
 <20130126003216.1f16a705@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130126003216.1f16a705@bob.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 26, 2013 at 12:32:16AM +0000, Alan Cox wrote:
> > Or am I missing something big and major here?  How have people been
> > seeing and configuring their tty devices for the last 8+ years or so
> > since the 2.6.0 kernel was released with uevent support for tty
> > devices?
> 
> Minor more than major. The newer ACPI tries to begin to describe what
> is on the other end of serial busses being used for internal purposes.
> 
> Now there are several good reasons we want to know what is on the end
> of a port already that are not currently handled, and I have suggested
> a port "type" attribute would be useful (eg  unknown, modem, bluetooth,
> ax25, dcc, etc) so the kernel can help user space enumerate in user
> friendly fashion.

That's fine, just add a single attribute to the existing tty class
device, not a whole new class, which is what this code does.

> Where it gets slightly more tricky is that we are beginning to see
> systems where the firmware is describing
> 
> 	serial port (and power management)
> 	device behind port (and power management)
> 
> so there is a power management hierarchy involved.

Ick, that's going to get messy fast.  There's no hope they would switch
to a USB connection instead for these devices, could they?  That would
fix up most of these issues, and make the devices discoverable.

thanks,

greg k-h
