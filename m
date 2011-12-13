From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 13 Dec 2011 09:35:56 -0800
Message-ID: <87pqfsxtkz.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<874nxd5j0f.fsf@ti.com> <4EE75E1A.7080101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:47749 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab1LMRgF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Dec 2011 12:36:05 -0500
In-Reply-To: <4EE75E1A.7080101@ti.com> (Rajendra Nayak's message of "Tue, 13
	Dec 2011 19:45:54 +0530")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Rajendra Nayak <rnayak@ti.com> writes:

> Hi Kevin,
>
> On Wednesday 07 December 2011 05:51 AM, Kevin Hilman wrote:
>> "Govindraj.R"<govindraj.raja@ti.com>  writes:
>>
>>> Converting uart driver to adapt to pm runtime API's.
>>> Code re-org + cleanup.
>>> Moving some functionality from serial.c to omap-serial.c
>>
>> Alan, can you confirm your Ack's are still valid on the drivers/tty
>> parts of this series?  It has gone through quite a few changes since
>> your original ack.
>>
>> Greg, are you ok with this series merging via the OMAP tree since it is
>> changing arch/arm/mach-omap2/* code as well as the driver, and should go
>> together.  If so, with your ack (on the drivers/tty/* parts), I'll
>> handle this series through the OMAP tree.
>
> I had a series to add DT support for omap-serial, which I did on top
> of the runtime series from Govindraj. Its already acked by Rob Herring
> for the DT parts. Would you be able to pick those up as well if its
> fine with Greg?

Yes, those should go on top of Govindraj's series.

I'm OK with taking them, but I'd like to see them rebased on Govidraj's
latest and see several Tested-by reports from various people since it is
pretty late in the merge cycle.

Kevin
