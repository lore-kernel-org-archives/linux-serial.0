From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 13:12:17 +0100
Message-ID: <20060830121216.GA25699@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50445 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750882AbWH3MM3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Aug 2006 08:12:29 -0400
Content-Disposition: inline
In-Reply-To: <200608300100.32836.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas K?ller <thomas@koeller.dyndns.org>

On Wed, Aug 30, 2006 at 01:00:32AM +0200, Thomas Koeller wrote:
> I would like to return to the port type vs. iotype  stuff once again.
> From what you wrote I seem to understand that the iotype is not just
> a method of accessing device registers, but also the primary means of
> discrimination between different h/w implementations, and hence every
> code to support a nonstandard device must define an iotype of its own,
> even though one of the existing iotypes would work just fine?

iotype is all about the access method used to access the registers of
the device, be it by byte or word, and it also takes account of any
variance in the addressing of the registers.

It does not refer to features or bugs in any particular implementation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
