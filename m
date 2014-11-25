From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO accesses via DT
Date: Tue, 25 Nov 2014 11:21:03 +0100
Message-ID: <201411251121.04160.arnd@arndb.de>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56363 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKYKVX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 05:21:23 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

On Tuesday 25 November 2014, Kevin Cernekee wrote:
> 
> My last submission attempted to work around serial driver coexistence
> problems on multiplatform kernels.  Since there are still questions
> surrounding the best way to solve that problem, this patch series
> will focus on the narrower topic of big endian MMIO support on serial.
> 
> 
> V2->V3:
> 
>  - Document the new DT properties.
> 
>  - Add libfdt-based wrapper, to complement the "struct device_node" based
>    version.
> 
>  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>    temporary variable, so it is easy to add more of_setup_earlycon()
>    properties later.
> 
>  - Make of_serial and serial8250 honor the new "big-endian" property.

Looks all good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
