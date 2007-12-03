From: Thiemo Seufer <ths@networkno.de>
Subject: Re: Rename Sibyte duart devices?
Date: Mon, 3 Dec 2007 14:14:26 +0000
Message-ID: <20071203141426.GI617@networkno.de>
References: <20071203130818.GA6466@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20071203130818.GA6466@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Ralf Baechle wrote:
> Devices created by udev have been named duart? instead of the common
> ttyS?.  This is a nuisance because it requires changes to all sorts of
> config files such as /etc/inittab, /etc/securetty etc. to work.  I
> suggest to kill the problem by the root by something like the below
> patch.  Comments?

Debian uses such a patch since forever to avoid all the trouble.


Thiemo
