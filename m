From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC v2 06/11] tty: xuartps: Change driver name to
 'cdns-uart'
Date: Fri, 7 Mar 2014 21:29:44 +0000
Message-ID: <20140307212944.4007c6f1@alan.etchedpixels.co.uk>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
	<1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55979 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaCGVaS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 16:30:18 -0500
In-Reply-To: <1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Fri,  7 Mar 2014 11:13:29 -0800
Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> I'm not sure about this change. Is this acceptable or already too much?
> I think the name is used for some sysfs entries.

Its probably not a good idea. You might be ok depending whether anything
ever used the sysfs nodes.

Alan
