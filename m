From: Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Fri, 07 Dec 2012 15:24:25 +0800
Message-ID: <1354865065.7216.52.camel@yhuang-dev>
References: <cover.1354505471.git.lv.zheng@intel.com>
	 <6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
	 <20121204185404.GQ3117@intel.com>
		<20121204195030.238d1b71@bob.linux.org.uk>
	 <20121205062015.GR3117@intel.com>
	 <20121205094343.09d653c5@pyramind.ukuu.org.uk>
	 <1AE640813FDE7649BE1B193DEA596E88BD6C94@SHSMSX101.ccr.corp.intel.com>
	 <20121206135341.148b325e@pyramind.ukuu.org.uk>
	 <1AE640813FDE7649BE1B193DEA596E88BD756A@SHSMSX101.ccr.corp.intel.com>
	 <1AE640813FDE7649BE1B193DEA596E88BD75D2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD75D2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi, Alan and Lv,

On Thu, 2012-12-06 at 22:41 -0700, Zheng, Lv wrote:
[snip]
> > > > Shall we change the uart_bus to the tty_bus, then introduce tty_host
> > > > /
> > > tty_target for the bus?
> > >
> > > We have a tty class - is that not sufficient ?
> > 
> > As I mentioned in the previous mail, I'll keep the current naming rule until I see
> > some objections strong enough.
> 
> This statement is confusing in English, let me clarify this.
> If the reasons for the uart_bus in the previous email are not correct, I'll change everything named as uart_xxx to tty_xxx, then the tty_bus is probably not needed, and I can use tty class after the decision.

If my understanding were correct, the point is not about name it as
uart_bus or tty_bus, but why do we need a bus instead of just use tty
class for that.

If we use tty class to export tty target device information, it can be
something as follow:

$ cd /sys/devices/platform/serial8250/tty/ttyS0
$ ls
slave_type
slave_id
slave_compat_ids
slave_attr
modem_lines

If we use uart or tty bus to export tty target device information, it
can be something as follow:

$ cd /sys/devices/platform/serial8250/bluetooth:00
$ ls
type
id
compt_ids
attr
modem_lines
...
$ cd /sys/bus/(uart|tty)/devices
$ ls
bluetooth:00

Both works.  But IMHO, the second one appears more natural and
consistent, just like other hardware devices in system.  And create
struct device for each target devices make it easier to do power
management etc, for example, user can enable/disable runtime power
management via bluetooth:00/power/control, just like other hardware
devices.

Best Regards,
Huang Ying


