From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH] ACPI / serial: Add UART change_pm support with ACPI
 power domain
Date: Thu, 7 Feb 2013 00:38:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BF7086@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <69483f548e2d5476b8e1ce530e6910bfbf770d3d.1360131884.git.lv.zheng@intel.com>
 <20130206190728.GA32275@kroah.com> <14333377.SHpFl2uDhh@vostro.rjw.lan>
 <20130206213839.GB31339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130206213839.GB31339@kroah.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Krogerus, Heikki" <heikki.krogerus@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > > So you are going to be sticking acpi_* calls into common core places
> > > all over the kernel for stuff like this?
> > >
> > > What's wrong with using the existing pm callbacks that are there for
> > > all platforms to use?
> >
> > I think that this just hasn't been thought through sufficiently (again).
> 
> Ugh.  Ok, I now am going to just quietly drop all intel.com patches to the
> tty/serial layer unless they have at least 2 signed-off-by: lines, one of which is
> by someone who is "well known" to me as being sane.

Sorry for the noise. Please ignore.
It's sent by wrong typing "gitsendemail acpi-uart" instead of "gitsendemail intel-uart" where gitsendemail is my patch sending script.
It should be reviewed internally prior to be sent to the public, collecting advices about where should be the better place to implement an open/close based PM.

Thanks
-Lv
