From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] serial: uartps: Change uart ID port allocation
Date: Thu, 20 Sep 2018 13:32:25 +0200
Message-ID: <20180920113225.GA19956@kroah.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
 <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 18, 2018 at 04:57:59PM +0200, Michal Simek wrote:
> For IPs which have alias algorightm all the time using that alias and
> minor number. It means serial20 alias ends up as ttyPS20.
> 
> If alias is not setup for probed IP instance the first unused position is
> used but that needs to be checked if it is really empty because another
> instance doesn't need to be probed at that time. of_alias_get_alias_list()
> fills alias bitmap which exactly shows which ID is free.
> If alias pointing to different not compatible IP, it is free to use.
> 
> cdns_get_id() call is placed below structure allocation to simplify
> error path.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add handle of return value from of_alias_get_alias_list
> 
> Needs to be applied on the top of
> https://lkml.org/lkml/2018/9/3/404
> https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)
> 
> Greg: Please apply it with
> "of: base: Introduce of_alias_get_alias_list() to check alias IDs
> Rob is ok with that.

I don't have that patch, can you resend the whole series?

thanks,

greg k-h
