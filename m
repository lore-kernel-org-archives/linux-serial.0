From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH 05/11] serial: support for 16550 serial ports on LP-8x4x
Date: Mon, 02 Dec 2013 15:39:26 +0400
Message-ID: <1385984366.12531.24.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
	 <1385879185-22455-6-git-send-email-ynvich@gmail.com>
	 <20131202113052.GG16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:58679 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab3LBLja (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 06:39:30 -0500
In-Reply-To: <20131202113052.GG16735@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

On Mon, 2013-12-02 at 11:30 +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 01, 2013 at 10:26:18AM +0400, Sergei Ianovich wrote:
> > +static struct platform_device lp8x4x_device = {
> > +	.name			= "serial8250",
> > +	.id			= PLAT8250_DEV_ACCENT,
> 
> You should not re-use the enum value here.  The enum is designed as a
> method to provide the platform devices with a unique id, not as a means
> to identify the manufacturer or anything else like that.

Should I add a new enum?

Or should I use zero?

