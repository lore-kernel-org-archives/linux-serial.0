From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [1/1] stallion.c: "fix" initialisation path.
Date: Mon, 13 Jun 2005 21:17:50 +0100
Message-ID: <20050613211749.A32077@flint.arm.linux.org.uk>
References: <20050613225833.08afa8ff@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20241 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261279AbVFMUR5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Jun 2005 16:17:57 -0400
Content-Disposition: inline
In-Reply-To: <20050613225833.08afa8ff@zanzibar.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Mon, Jun 13, 2005 at 10:58:33PM +0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-serial@vger.kernel.org

On Mon, Jun 13, 2005 at 10:58:33PM +0400, Evgeniy Polyakov wrote:
> Driver with such IRQ hacks inside looks really scary.
> I do not have neither hardware nor deep knowledge about it,
> just found a bug report from kerneltrap maillist.
> That code really requires some changes.

Removing such things isn't a fix though - it changes something which
fails/warns into a build-time silent run-time failure which are harder
to find.

(Also I don't process patches for non-drivers/serial based stuff, sorry.
That should go via linux-kernel, thanks.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
