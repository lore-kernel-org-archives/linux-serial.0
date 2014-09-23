From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: serial console broken in v3.17-rc6 ?
Date: Tue, 23 Sep 2014 17:08:54 -0400
Message-ID: <5421E166.7060206@hurleysoftware.com>
References: <5421D3E3.6080805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:56279 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756935AbaIWVI4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Sep 2014 17:08:56 -0400
In-Reply-To: <5421D3E3.6080805@gmx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-parisc <linux-parisc@vger.kernel.org>

Hi Helge,

On 09/23/2014 04:11 PM, Helge Deller wrote:
> During the release cycle of v3.17 I've seen sometimes a broken serial console output
> on the parisc platform. Interestingly all kernel messages printed by the kernel via printk() show
> up correctly, but output from userspace (e.g. by the init process during boot) show
> up as random bytes.
> Since the printk() output is correct the serial port itself and setup is probably correct.
> Is parisc the only arch which has this problem, or are other architectures affected as well?
> Maybe someone has an idea what could be wrong?
> I did not try to bisect it yet.
> 
> Thanks,
> Helge
> 
> Here is a sample output during bootup:
> 
> <lots of standard kernel printk output>...
> usb 1-2: Manufacturer: SILITEK
> rs
>      og
>  ]f"
> s l
> random: nonblocking pool is initialized
> net eth0: Setting full-duplex based on MII#1 link partner capability of 45e1
> tpdsystemd-udevd[744]: starting version 215
> .
>  eg..
>      vp..
>          ..Adding 1350652k swap on /dev/sdb6.  Priority:-1 extents:1 across:1350652k
> .
>  EXT4-fs (sdb5): re-mounted. Opts: (null)

Thanks for the bug report.

1. What serial driver is this?
2. Regression since when?
3. Full dmesg please
4. Output of setserial -a [serial device]
5. Output of stty -a [serial device]

Regards,
Peter Hurley

