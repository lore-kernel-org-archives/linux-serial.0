From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] tty: serial: bcm63xx_uart: do not depend on MIPS
Date: Sun, 8 Dec 2013 17:13:56 -0800
Message-ID: <20131209011356.GB7671@kroah.com>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47976 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569Ab3LIIWg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 03:22:36 -0500
Content-Disposition: inline
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org, mbizon@freebox.fr, cernekee@gmail.com, linux-serial@vger.kernel.org

On Thu, Dec 05, 2013 at 06:26:03PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patchset reduces the dependency of the bcm63xx_uart on the MIPS BCM63XX
> SoC support code in preparation for being used on different architectures
> such as ARM.
> 
> Due to the MIPS patch which breaks down the register defines, this series
> should ideally go via the MIPS tree.

That's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
