From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control
 modem lines and implement atmel_serial.c
Date: Fri, 25 Apr 2014 08:58:47 -0700
Message-ID: <20140425155847.GC22879@kroah.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47503 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbaDYPzx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 11:55:53 -0400
Content-Disposition: inline
In-Reply-To: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 25, 2014 at 04:52:36PM +0200, Richard Genoud wrote:
> This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
> that missed 3.15 because it caused merge conflicts.
> 
> The 1st patch may be applied as a fix for 3.15-rc, since it correct a
> device tree binding documentation example.
> 
> Greg, for you to decide if it's worth it or not !

Why am I the one tho decides if it is worth it?  If it's up to me, I'll
just say "no", as I sure don't need this for any of my machines...

See, that was easy :)

greg k-h
