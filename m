From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] Revert "tty/serial/8250: use mctrl_gpio helpers"
Date: Mon, 29 Aug 2016 10:07:26 +0300
Message-ID: <20160829070726.GW1812@lahna.fi.intel.com>
References: <1471349214-69793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471349214-69793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Yegor Yefremov <yegorslists@googlemail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 16, 2016 at 03:06:54PM +0300, Andy Shevchenko wrote:
> Serial console is broken in v4.8-rcX. Mika and I independently bisected down to
> commit 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers").
> 
> Since neither author nor anyone else didn't propose a solution we better revert
> it for now.
> 
> This reverts commit 4ef03d328769eddbfeca1f1c958fdb181a69c341.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://lkml.kernel.org/r/20160809130229.GN1729@lahna.fi.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We are already in -rc4 and the issue still hasn't been fixed. Currently
commit 4ef03d328769eddbfeca1f1c958fdb181a69c341 breaks serial console on
many Intel systems so it would be nice to get this fixed before final
v4.8 is released.
