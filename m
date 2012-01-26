From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: 3.3-rc1 console lag (was: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime
 adaptation + cleanup)
Date: Wed, 25 Jan 2012 18:22:26 -0600
Message-ID: <CAB-zwWg4RS4J1YCcbfMWjLSCcV=oHqk9vaUKKKr0WjnTEuOmxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41564 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab2AZAW2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jan 2012 19:22:28 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Govindraj Raja <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi,

On Fri, Nov 11, 2011 at 3:57 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Converting uart driver to adapt to pm runtime API's.
> Code re-org + cleanup.
> Moving some functionality from serial.c to omap-serial.c
...
>
> Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
> And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
> console might be sluggish.

There is console lag for omap2plus_defconfig given that
CONFIG_CPU_IDLE is not enabled. Is the intention to force CPU_IDLE
into the defconfig or find an alternative for the new pm_qos when cpu
idle is disabled.

Seen on beagle-xm and 3.3-rc1.

Regards,

Omar
