From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Thu, 7 Aug 2008 10:14:48 +0100
Message-ID: <20080807101448.239fadc6@lxorguk.ukuu.org.uk>
References: <20080806211438.GB20355@redhat.com>
	<200808071032.16709.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53405 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755039AbYHGMYm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Aug 2008 08:24:42 -0400
In-Reply-To: <200808071032.16709.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: Aristeu Rozanski <arozansk@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> Please read the '[PATCH/RFC] 8250: Auto RS485 direction control' thread for background information. In a nutshell we need more than just CTS/RTS and DTR/DSR, and we don't have enough c_cflags bits. We will probably have to create a new ioctl.

Maybe - fortunately the kernel and user termios structure are now
independent so we can extend ktermios easily enough.

