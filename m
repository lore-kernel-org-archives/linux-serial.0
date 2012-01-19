From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] power: Add function to init wakeup capability without enabling
Date: Thu, 19 Jan 2012 01:10:18 +0100
Message-ID: <201201190110.18846.rjw@sisk.pl>
References: <1326826563-32215-3-git-send-email-sjg@chromium.org> <1326928027-20610-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40967 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab2ASAGt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jan 2012 19:06:49 -0500
In-Reply-To: <1326928027-20610-1-git-send-email-sjg@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Thursday, January 19, 2012, Simon Glass wrote:
> device_init_wakeup() offers two options:
> 
> 1. Wakeup capable and wakeup enabled
> 2  Not wakeup capable and not wakeup enabled
> 
> serial_core wants a third option:
> 
> 3. Wakeup capable but not wakeup enabled (yet)

Which is device_set_wakeup_capable(dev, true).

Thanks,
Rafael
