From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] Revert "tty/serial/8250: use mctrl_gpio helpers"
Date: Mon, 22 Aug 2016 11:38:38 +0300
Message-ID: <20160822083838.GA9065@kuha.fi.intel.com>
References: <1471349214-69793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471349214-69793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Yegor Yefremov <yegorslists@googlemail.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Aug 16, 2016 at 03:06:54PM +0300, Andy Shevchenko wrote:
> Serial console is broken in v4.8-rcX. Mika and I independently bisected down to
> commit 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers").
> 
> Since neither author nor anyone else didn't propose a solution we better revert
> it for now.
> 
> This reverts commit 4ef03d328769eddbfeca1f1c958fdb181a69c341.

Maybe you should have explained the problem in the commit message.

I just hit the issue, and can confirm that this patch fixes it. So
basically 8250 is broken in v4.8. Shouldn't this have "Cc: stable.."
tag?

> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://lkml.kernel.org/r/20160809130229.GN1729@lahna.fi.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In any case, FWIW:

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
