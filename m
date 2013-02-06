From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] ACPI / serial: Add UART change_pm support with ACPI power domain
Date: Wed, 06 Feb 2013 22:39:09 +0100
Message-ID: <14333377.SHpFl2uDhh@vostro.rjw.lan>
References: <cover.1354505471.git.lv.zheng@intel.com> <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com> <20130206190728.GA32275@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130206190728.GA32275@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Krogerus Heikki <heikki.krogerus@intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday, February 06, 2013 11:07:28 AM Greg Kroah-Hartman wrote:
> On Wed, Feb 06, 2013 at 02:26:26PM +0800, Lv Zheng wrote:
> > This patch enables ACPI power domain on UART user devices. With this
> > patch, Linux can achieve open/close based ACPI power manageability for
> > UART tty ports.
> 
> So you are going to be sticking acpi_* calls into common core places all
> over the kernel for stuff like this?
> 
> What's wrong with using the existing pm callbacks that are there for all
> platforms to use?

I think that this just hasn't been thought through sufficiently (again).

Sorry about this noise,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
