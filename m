From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/5] serial: arc: Remove __init marking from early
 write
Date: Tue, 18 Jul 2017 07:08:38 +0200
Message-ID: <20170718050838.GA7529@kroah.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
 <1500352203-21513-2-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500352203-21513-2-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 12:29:59PM +0800, Jeffy Chen wrote:
> The earlycon would be alive outside the init code in these cases:
> 1/ we have keep_bootcon in cmdline.
> 2/ we don't have a real console to switch to.
> 
> So remove the __init marking to avoid invalid memory access.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 

I can't apply "RFC" patches.  If you have tested and found this series
to be correct, can you resend it without that on the patch?

thanks,

greg k-h
