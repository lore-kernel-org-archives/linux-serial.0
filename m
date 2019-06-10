From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
Date: Mon, 10 Jun 2019 16:44:25 +0200
Message-ID: <20190610144425.GC31086@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org, Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 10:44:55AM +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch fixes the below warning
> 
>         -->Symbolic permissions 'S_IRUGO' are not preferred.
>            Consider using octal permissions '0444'.
>         -->macros should not use a trailing semicolon.
>         -->line over 80 characters.
>         -->void function return statements are not generally useful.
>         -->Prefer 'unsigned int' to bare use of 'unsigned'.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Happy to split it if needed.

Please split.  Do not do more than one "logical thing" per patch.

And the subject is not correct, there are no general "warnings", these
are all checkpatch warnings, not a build issue.

thanks,

greg k-h
