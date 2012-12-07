From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Fri, 7 Dec 2012 10:27:41 +0000
Message-ID: <20121207102741.451c1627@pyramind.ukuu.org.uk>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BD75D2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-serial@vger.kernel.org

> Ying has suggested me to include all of the HID/CIDs as a list into board_info.

if HID/CID values are also provided by ACPI then that makes sense

> If OF need this feature, I'll split type into a type and an "ID" list.

That would be good. Code that wants generic answers can check the type,
code that wants identifiers or needs detail can check the ids

Alan
