From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] TTY: serial: convert drivers/tty/serial/* to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 11:46:49 +0000
Message-ID: <20111128114649.4ce362c7@bob.linux.org.uk>
References: <1322479335.1939.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28202 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab1K1LfY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Nov 2011 06:35:24 -0500
In-Reply-To: <1322479335.1939.6.camel@phoenix>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Jamie Iles <jamie@jamieiles.com>, Yoichi Yuasa <yuasa@linux-mips.org>, linux-serial@vger.kernel.org

On Mon, 28 Nov 2011 19:22:15 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> This patch converts the drivers in drivers/tty/serial/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

Acked-by: Alan Cox <alan@linux.intel.com>
