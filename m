From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] 8250 driver interrupt sharing
Date: Thu, 28 Oct 2004 13:17:41 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200410281317.41817.thomas.koeller@baslerweb.com>
References: <200410281301.59584.thomas.koeller@baslerweb.com> <20041028120026.B3327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.baslerweb.com ([145.253.187.130]:10278 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S262968AbUJ1LN6
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2004 07:13:58 -0400
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id i9SBDlsf016147
	for <linux-serial@vger.kernel.org>; Thu, 28 Oct 2004 13:13:47 +0200
In-Reply-To: <20041028120026.B3327@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On Thursday 28 October 2004 13:00, Russell King wrote:
> On Thu, Oct 28, 2004 at 01:01:58PM +0200, Thomas Koeller wrote:
> > here is a little patch that causes the driver to no longer pretend having
> > handled an interrupt if none of the ports actually interrupted. I am
> > currently doing a port to a platform where I want (actually, have) to
> > share a single interrupt between serial ports and other devices. The
> > patch is against kernel version 2.6.9.
>
> You can only share serial port interrupts with other devices if the
> interrupt controller input is level sensitive rather than edge
> sensitive.  If it is edge sensitive, then you'll run into problems.

On my target platform, interrupts are indeed level sensitive, so this
should not be a problem (for me).

Does this problem somehow invalidate my patch? Even if interrupts were
edge sensitive, returning IRQ_NONE should ok, or not?

tk

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

