From: "Shankarmurthy, Akshay" <akshay.s@ti.com>
Subject: RE: [PATCH v2] serial: 8250: Add cpufreq support
Date: Mon, 14 May 2012 12:20:03 +0000
Message-ID: <6F6B80BD2E18844D97BB4B51FE3705C83E935014@DBDE01.ent.ti.com>
References: <1335353194-2621-1-git-send-email-akshay.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2ENMUm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 May 2012 08:20:42 -0400
In-Reply-To: <1335353194-2621-1-git-send-email-akshay.s@ti.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "jamie@jamieiles.com" <jamie@jamieiles.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "dianders@chromium.org" <dianders@chromium.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hi Alan,

On Wed, Apr 25, 2012 at 16:56:33, Shankarmurthy, Akshay wrote:
> This patch adds cpufreq support for 8250 serial driver. A clk structure member has been added to the platform and port data structures. This member is used by the cpufreq notifier callback to get the updated clock rate. Also adds a member 'cpufreq_flag' to the plat_serial8250_port and uart_port structures which decides the requirement of cpufreq registration for each individual ports. If the port requires registration then 'cpufreq_flag'
> should be passed as TRUE from the board file.
> 
> Tested on TI DA850/OMAP-L138 EVM.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> Signed-off-by: Shankarmurthy, Akshay <akshay.s@ti.com>
> ---
> v2 includes following changes :
> 
> 1. Used "tty_port_tty_get" API to get the tty struct instead of accesing it directly from the uart_port structure.
> 2. Added a boolean member "enable_cpufreq" to the uart_port and serial8250_port structures. This indicates the requirement of cpu freq registration for each individual ports.
> 3. Renamed the function from "serial8250_cpufreq_deregister" to "serial8250_cpufreq_unregister".
> 
> Changes are as per these discussions
> http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg22841.html
> 

Please let me know if there are any comments on this patch?

Regards,
Akshay
