From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] tty: serial: OMAP: Fix oops due to NULL pdata in DT boot
Date: Tue, 28 Feb 2012 10:23:45 -0800
Message-ID: <87y5rmyfym.fsf@ti.com>
References: <20120126024903.31613.24730.stgit@dusk>
	<20120126025036.31613.67819.stgit@dusk> <4F4D0D44.3010604@ti.com>
	<20120228172851.GA13653@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:60862 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502Ab2B1SXt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Feb 2012 13:23:49 -0500
Received: by mail-pz0-f48.google.com with SMTP id p13so7023035dad.21
        for <linux-serial@vger.kernel.org>; Tue, 28 Feb 2012 10:23:48 -0800 (PST)
In-Reply-To: <20120228172851.GA13653@kroah.com> (Greg KH's message of "Tue, 28
	Feb 2012 09:28:51 -0800")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 28, 2012 at 06:22:12PM +0100, Cousson, Benoit wrote:
>> The following commit: be4b0281956c5cae4f63f31f11d07625a6988766
>> (tty: serial: OMAP: block idle while the UART is transferring data in PIO mode),
>> is introducing an oops if OMAP is booted using device tree blob because
>> the pdata will not be initialized.
>
> Is that something that happens today on systems?  Does this need to go
> in for 3.3-final, or can it wait for 3.4?

It is needed for 3.3-final.

Thanks,

Kevin
