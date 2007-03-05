From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Mon, 5 Mar 2007 12:09:20 -0500
Message-ID: <8bd0f97a0703050909n18386114kd2c0b2a108591641@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <20070304194632.GC30345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:61320 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXCERJV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2007 12:09:21 -0500
Received: by an-out-0708.google.com with SMTP id b33so1489744ana
        for <linux-serial@vger.kernel.org>; Mon, 05 Mar 2007 09:09:20 -0800 (PST)
In-Reply-To: <20070304194632.GC30345@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

On 3/4/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Mar 01, 2007 at 07:03:02PM -0500, Mike Frysinger wrote:
> > the console= bootcmd allows for controlling of the initial state of
> > flow control by adding/omitting the 'r' suffix ...
>
> The console command *only* sets the state for the kernel's use of one
> serial port.  It does not affect any other serial port, so tying
> random RTS behaviours into that command line option is absolutely
> silly.

true ... so ignoring the original motivation for change i posted, is
it really correct for the serial core to be forcing TIOCM_RTS at uart
startup even though the uart doesnt have CTSRTS flow control enabled ?
 in other words, my change is agnostic of the console, and is done for
all uarts ... it should prob have a similar change in uart_shutdown()
though ...
-mike
