From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/9] tty: drop broken alt-speed handling
Date: Tue, 13 Jun 2017 11:55:11 +0200
Message-ID: <20170613095511.GA15192@kroah.com>
References: <20170606105441.689-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 06, 2017 at 12:54:32PM +0200, Johan Hovold wrote:
> Setting an alt-speed using TIOCSSERIAL and SPD flags has been deprecated
> since v2.1.69 and has been broken for all tty drivers but serial-core
> since v3.10 and commit 6865ff222cca ("TTY: do not warn about setting
> speed via SPD_*") without anyone noticing (for four years).
> 
> Instead of reverting the offending commit, lets get rid of this legacy
> code while adding back a warning about the SPD flags being deprecated to
> the drivers that once implemented it. Note that drivers implementing
> SPD_CUST will continue to support using a custom divisor.
> 
> Also note that serial-core did not rely on the TTY layer for SPD
> handling and continues to support it while warning about deprecation
> (since 2003 at least).
> 
> Greg, I suggest you take it all trough the TTY tree even if merging
> through multiple trees and applying the final patch once everything is
> upstream would be an option. Also the irda clean up does not depend on
> the rest of series as the code implementing SPD handling was ifdefed
> out.

I've taken these all through my tty tree, nice work, thanks for the
cleanups.

greg k-h
