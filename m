From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] PNPACPI: support shareable interrupts
Date: Fri, 30 Jun 2006 21:50:59 -0600 (MDT)
Message-ID: <3410.24.9.204.52.1151725859.squirrel@mail.atl.hp.com>
References: <CFF307C98FEABE47A452B27C06B85BB6E16DA1@hdsmsx411.amr.corp.intel.com>
    <20060630181431.6245202c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060630181431.6245202c.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, bjorn.helgaas@hp.com, ambx1@neo.rr.com, castet.matthieu@free.fr, shaohua.li@intel.com, linux-acpi@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> OK.  But that still didn't give me a how-to-get-this-to-mainline graph.

I can't answer this, other than the obvious: it'd be good to get
acks from Adam and/or Shaohua and Russell.

> Bjorn, are these patches considered for-2.6.18 material?  (They look like
> it).

Yes, please.  I should have been more clear about that.

I'm pretty sure this problem will prevent all distro kernels from
booting on HP ia64 boxes with large I/O configs.  So I'll be
pushing it into distro updates soon.

I do wish we had more soak time, because a BIOS that incorrectly
reports a COM port interrupt as shareable could come back to
bite us.

