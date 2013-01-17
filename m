From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] serial: tegra: Switch to using struct tty_port
Date: Thu, 17 Jan 2013 10:07:51 -0700
Message-ID: <50F82FE7.9090403@wwwdotorg.org>
References: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44970 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab3AQRHz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jan 2013 12:07:55 -0500
In-Reply-To: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/17/2013 06:31 AM, Thierry Reding wrote:
> Many of the tty functions were converted to use a struct tty_port
> instead of a struct tty_struct. Update the Tegra driver accordingly to
> avoid build breakage.

I tested that this does indeed fix the build warnings. I didn't test the
resultant driver.

