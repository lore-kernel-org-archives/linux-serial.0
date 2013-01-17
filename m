From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] serial: tegra: Switch to using struct tty_port
Date: Thu, 17 Jan 2013 23:04:41 +0530
Message-ID: <50F83631.9080208@nvidia.com>
References: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de> <50F82FE7.9090403@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:19127 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3AQRfN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jan 2013 12:35:13 -0500
In-Reply-To: <50F82FE7.9090403@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@nvidia.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 17 January 2013 10:37 PM, Stephen Warren wrote:
> On 01/17/2013 06:31 AM, Thierry Reding wrote:
>> Many of the tty functions were converted to use a struct tty_port
>> instead of a struct tty_struct. Update the Tegra driver accordingly to
>> avoid build breakage.
> I tested that this does indeed fix the build warnings. I didn't test the
> resultant driver.
>
The api prototype changes and driver development went in parallel and 
hence the driver uses the older api. Both got merged on similar time and 
so out of sync.
I think this change is proper. I have not tested this change but 
reviewing code, it looks good to me.

Acked-By: Laxman Dewangan<ldewangan@nvidia.com>
