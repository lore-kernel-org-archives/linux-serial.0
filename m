From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/8] Replace kernel-defined ASYNC_ bits
Date: Thu, 28 Apr 2016 13:36:43 -0700
Message-ID: <20160428203643.GA13542@kroah.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 09, 2016 at 05:53:19PM -0700, Peter Hurley wrote:
> As outlined in my January email ("RFC: out-of-tree tty driver breakage"),
> the tty/serial core uses 5 bits in the tty_port.flags field to manage
> state. They are:
> 
> ASYNCB_INITIALIZED
> ASYNCB_SUSPENDED
> ASYNCB_NORMAL_ACTIVE
> ASYNCB_CTS_FLOW
> ASYNCB_CHECK_CD
> 
> (NB: ASYNC_CLOSING was recently removed)
> 
> However, updates to this field (tty_port.flags) can be and often are
> non-atomic. Additionally, the field is visible to/modifiable by userspace
> (the state bits above are not modifiable by userspace though).
> 
> This series moves these state bits into a different tty_port field
> (iflags) and abstracts state tests and changes with trivial helpers.
> 
> The last patch of the series purposefully breaks out-of-tree driver
> builds to ensure they update state test/change methods to the helpers
> instead.
> 
> REQUIRES: "tty: Replace TTY_IO_ERROR bit tests with tty_io_error()"
>           "tty: Replace TTY_THROTTLED bit tests with tty_throttled()"

Wonderful, thanks for doing this work.

greg k-h
