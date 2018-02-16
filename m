From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Feb 2018 19:44:06 +0100
Message-ID: <20180216184406.GA9286@kroah.com>
References: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org, yoshihiro.shimoda.uh@renesas.com
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 15, 2018 at 01:02:27PM +0100, Ulrich Hecht wrote:
> When the TTY buffers fill up to the configured maximum, a system lockup
> occurs:
> 
> [  598.820128] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  598.825796]  0-...!: (1 GPs behind) idle=5a6/2/0 softirq=1974/1974 fqs=1
> [  598.832577]  (detected by 3, t=62517 jiffies, g=296, c=295, q=126)
> [  598.838755] Task dump for CPU 0:
> [  598.841977] swapper/0       R  running task        0     0      0 0x00000022
> [  598.849023] Call trace:
> [  598.851476]  __switch_to+0x98/0xb0
> [  598.854870]            (null)
> 
> This can be prevented by doing a dummy read of the RX data register.
> 
> This issue affects both HSCIF and SCIF ports. Reported for R-Car H3 ES2.0;
> reproduced and fixed on H3 ES1.1. Probably affects other R-Car platforms
> as well.
> 
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Should this go to older kernel versions as well?
If so, how far back?

thanks,

greg k-h
