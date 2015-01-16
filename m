From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] serial: Fintek F81232 driver improvement
Date: Fri, 16 Jan 2015 07:21:53 -0800
Message-ID: <20150116152153.GC11240@kroah.com>
References: <1421390481-2871-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421390481-2871-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 16, 2015 at 02:41:21PM +0800, Peter Hung wrote:
> From: Peter Hong <hpeter@gmail.com>
> 
> The original driver completed with TX function, but RX/MSR/MCR/LSR is not
> workable with this driver. So we rewrite it to make this device workable.
> 
> This patch is tested with PassMark BurnInTest with Cycle-to-115200 +
> MCR/MSR check for 15mins & checked with Suspend-To-RAM/DISK
> 
> Signed-off-by: Peter Hong <hpeter@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 528 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 440 insertions(+), 88 deletions(-)

Please use get_maintainer.pl to determine who to send this to (hint,
it's not me...)

thanks,

greg k-h
