From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Mon, 25 Jul 2016 10:47:12 -0700
Message-ID: <20160725174712.GA5752@kroah.com>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <mstaudt@suse.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 25, 2016 at 07:36:15PM +0200, Max Staudt wrote:
> Some serial ports may not emit IRQs properly, or there may be a defect
> in their routing on the motherboard.
> 
> This patch allows these ports to be used anyway (or until a better
> workaround is known for a specific platform), though with no guarantees.
> 
> If you have such a buggy UART, boot Linux with 8250.force_polling=1 .

Ick, don't add new module parameters if at all possible.

> It is essentially the kernel level version of:
> 
>   setserial /dev/ttySn irq 0

Why can't you just do this instead?

thanks,

greg k-h
