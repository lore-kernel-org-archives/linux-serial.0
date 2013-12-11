From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] serial: clps711x: UART driver refactor
Date: Wed, 11 Dec 2013 22:21:21 +0100
Message-ID: <201312112221.22180.arnd@arndb.de>
References: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53756 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3LKVV5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 16:21:57 -0500
In-Reply-To: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, arm@kenrel.org, Olof Johansson <olof@lixom.net>, Jiri Slaby <jslaby@suse.cz>

On Wednesday 11 December 2013, Alexander Shiyan wrote:
> This is a complex patch for refactoring CLPS711X serial driver.
> Major changes:
> - Eliminate <mach/hardware.h> usage.
> - Devicetree support.
> 
> Patch created for adding in tty tree, but this changes need attention
> from ARM and DT maintainers, so "ACK" will be useful here.

Both patches look good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
