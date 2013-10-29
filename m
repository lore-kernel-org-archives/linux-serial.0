From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] tty: xuartps: Fix "may be used uninitialized" build
 warning
Date: Tue, 29 Oct 2013 09:22:52 -0700
Message-ID: <20131029162252.GA21986@kroah.com>
References: <1382398861-21542-1-git-send-email-soren.brinkmann@xilinx.com>
 <1382398861-21542-2-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382398861-21542-2-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 21, 2013 at 04:40:59PM -0700, Soren Brinkmann wrote:
> Initialize varibles for which a 'may be used uninitalized' warning is
> issued.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> The warning is actually a false positive. The variables are passed to a
> function per reference. That function uses those variables to return
> values, which then are used by the caller. Is there a way to
> avoid the initialization and the build warning alltogether?
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please properly credit the kbuild robot who found these issues the next
time...

thanks,

greg k-h
