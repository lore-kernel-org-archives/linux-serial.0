From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC v2 08/11] tty: xuartps: Rename Kconfig symbols
Date: Fri, 7 Mar 2014 21:30:58 +0000
Message-ID: <20140307213058.702ff194@alan.etchedpixels.co.uk>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
	<1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55988 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaCGVbb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 16:31:31 -0500
In-Reply-To: <1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Fri,  7 Mar 2014 11:13:31 -0800
Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> Rename the config symbols for the Cadence UART to reflect the driver
> rebranding:
>   SERIAL_XILINX_PS_UART(_CONSOLE) -> SERIAL_CADENCE_UART(_CONSOLE)

This breaks all those setups people have with pre-packed .config files
that have worked for a long time and now randomly need changing for this
kernel.

