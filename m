From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Allow hardware flow control to
 be used
Date: Wed, 11 Jan 2017 09:00:55 +0100
Message-ID: <20170111080055.GA8548@kroah.com>
References: <1481063643-11951-1-git-send-email-jason.uy@broadcom.com>
 <1481063643-11951-2-git-send-email-jason.uy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481063643-11951-2-git-send-email-jason.uy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Uy <jason.uy@broadcom.com>
Cc: Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 06, 2016 at 02:34:03PM -0800, Jason Uy wrote:
> In the most common use case, the Synopsys DW UART driver does not
> set the set_termios callback function.  This prevents UPSTAT_AUTOCTS
> from being set when the UART flag CRTSCTS is set.  As a result, the
> driver will use software flow control as opposed to hardware flow
> control.
> 
> To fix the problem, the set_termios callback function is set to the
> DW specific function.  The logic to set UPSTAT_AUTOCTS is moved so
> that any clock error will not affect setting the hardware flow
> control.
> 
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Jason Uy <jason.uy@broadcom.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

This patch doesn't apply at all to the latest kernel tree.  Can you
please refresh it and resend?

thanks,

greg k-h
