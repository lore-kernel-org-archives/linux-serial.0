From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Wed, 13 Aug 2008 12:39:08 +0100
Message-ID: <20080813123908.353cc083@lxorguk.ukuu.org.uk>
References: <200808071032.16709.laurentp@cse-semaphore.com>
	<000f01c8f88c$ad29d950$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55492 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751324AbYHML4p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Aug 2008 07:56:45 -0400
In-Reply-To: <000f01c8f88c$ad29d950$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: 'Laurent Pinchart' <laurentp@cse-semaphore.com>, 'Aristeu Rozanski' <arozansk@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> About a RS485 ioctl: could you consider the attached files which are already
> in the Linux kernel (in include/asm-cris).
> They define a TIOCSERSETRS485 (ioctl.h), and the data structure (rs485.h)
> with allows to specify timings. Sounds just like what we want ?

That would make sense for hardware assisted RS485 but we still have to
sort out DTR/DSR as well
