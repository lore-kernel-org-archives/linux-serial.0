From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] ACPI / serial: Add UART change_pm support with ACPI
 power domain
Date: Wed, 6 Feb 2013 11:07:28 -0800
Message-ID: <20130206190728.GA32275@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Krogerus Heikki <heikki.krogerus@intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 06, 2013 at 02:26:26PM +0800, Lv Zheng wrote:
> This patch enables ACPI power domain on UART user devices. With this
> patch, Linux can achieve open/close based ACPI power manageability for
> UART tty ports.

So you are going to be sticking acpi_* calls into common core places all
over the kernel for stuff like this?

What's wrong with using the existing pm callbacks that are there for all
platforms to use?

greg k-h
