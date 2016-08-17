From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] Revert "tty/serial/8250: use mctrl_gpio helpers"
Date: Wed, 17 Aug 2016 12:21:42 +0300
Message-ID: <20160817092142.GO30827@lahna.fi.intel.com>
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

Works for me. This solves the issue I've seen on Broxton machines.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
