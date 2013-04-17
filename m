From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH 0/4] ARM: davinci: fix UART clock enabling
Date: Wed, 17 Apr 2013 06:32:46 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4DCC9@DBDE01.ent.ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41245 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965761Ab3DQGdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Apr 2013 02:33:17 -0400
In-Reply-To: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hs@denx.de" <hs@denx.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>

Hi Sekhar,

On Tue, Apr 09, 2013 at 17:57:57, Manjunathappa, Prakash wrote:
> Patch series addresses below issues:
> 1) Do clk_get on dev_id when there is single clock for a module
> 2) Fix garbled UART log with DT kernel on da850-evm.
> 

Could you please accept this series if you do not have review comments?

Thanks,
Prakash

> Applies on top of v3.9-rc9 of Linus's.
> Tested on da850-evm. Able to see proper bootup log and console on UART2.
> 
> Manjunathappa, Prakash (4):
>   ARM: davinci: uart: move to devid based clk_get
>   ARM: davinci: da850: override device name of UART in DT kernel
>   ARM: davinci: da850: do not specify clock_frequency for UART DT node
>   ARM: davinci: da8xx: remove da8xx_uart_clk_enable
> 
>  arch/arm/boot/dts/da850.dtsi                   |    3 -
>  arch/arm/mach-davinci/da830.c                  |    8 ++--
>  arch/arm/mach-davinci/da850.c                  |    8 ++--
>  arch/arm/mach-davinci/da8xx-dt.c               |   11 +----
>  arch/arm/mach-davinci/devices-da8xx.c          |   40 ++++++++++++++++---
>  arch/arm/mach-davinci/devices-tnetv107x.c      |   35 ++++++++++++++---
>  arch/arm/mach-davinci/dm355.c                  |   48 ++++++++++++++++++-----
>  arch/arm/mach-davinci/dm365.c                  |   35 ++++++++++++----
>  arch/arm/mach-davinci/dm644x.c                 |   48 ++++++++++++++++++-----
>  arch/arm/mach-davinci/dm646x.c                 |   49 +++++++++++++++++++-----
>  arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +-
>  arch/arm/mach-davinci/serial.c                 |   19 ++++++---
>  arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
>  14 files changed, 233 insertions(+), 83 deletions(-)
> 
> --
> 1.7.4.1
> 
> 

