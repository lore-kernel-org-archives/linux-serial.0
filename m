From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] serial 8250: fixes for Alchemy uarts.
Date: Sun, 1 Nov 2009 08:09:00 +0100
Message-ID: <20091101070900.GB4551@linux-mips.org>
References: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:60565 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbZKAHHq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Nov 2009 02:07:46 -0500
Content-Disposition: inline
In-Reply-To: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>

On Wed, Oct 28, 2009 at 09:37:28PM +0100, Manuel Lauss wrote:

> Limit the amount of address space claimed for Alchemy serial ports
> to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
> registers only extend to 0x110 at most on all supported alchemy models.
> 
> On the Au1300 the autodetect logic no longer works and this makes
> it necessary to specify the port type through platform data.  Because
> of this the MSR quirk needs to be moved outside the autoconfig()
> function which will no longer be called when UPF_FIXED_TYPE is
> specified.

Andrew,

looks sane to me.  Since this is a MIPS patch I'd like to funnel it through
the MIPS tree.  Ok?

  Ralf
