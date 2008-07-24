From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 12:57:06 +0100
Message-ID: <20080724125706.19844a96@lxorguk.ukuu.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45944 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752508AbYGXMOj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:14:39 -0400
In-Reply-To: <200807241347.33261.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org, rmk@arm.linux.org.uk

On Thu, 24 Jul 2008 13:47:29 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

> This patch adds support for the automatic RS485 direction control feature
> present in 16850 UARTs.
> 
> A new termios c_cflag, CARTS, is introduced to configure automatic direction
> control from userspace.
> 
> This is a first proposal. I'm open to suggestions regarding the CARTS name.
> I assume the CARTS flag will have to be added to all asm/termbits.h headers.
> Why are the termios bits definitions platform specific ?

Because many of them are made to match up with the existing previous
OS on those systems (eg to match with Alpha OSF).

I've no fundamental objection to this but I do wonder whether this
feature belongs in setserial rather than termios as it is so chip
specific ?

Alan
