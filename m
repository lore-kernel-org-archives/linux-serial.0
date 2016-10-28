From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: 8250_dw: Add support for IrDA SIR mode
Date: Fri, 28 Oct 2016 11:20:40 +0300
Message-ID: <20161028082040.GA31275@kuha.fi.intel.com>
References: <1477586286-15748-1-git-send-email-ed.blake@imgtec.com>
 <1477587370.5295.37.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477587370.5295.37.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ed Blake <ed.blake@imgtec.com>, gregkh@linuxfoundation.org, jslaby@suse.com, wangkefeng.wang@huawei.com, noamc@ezchip.com, annie.wang@amd.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, james.hartley@imgtec.com
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Thu, Oct 27, 2016 at 07:56:10PM +0300, Andy Shevchenko wrote:
> On Thu, 2016-10-27 at 17:38 +0100, Ed Blake wrote:
> > Add a set_ldisc function to enable/disable IrDA SIR mode according to
> > the new line discipline.
> 
> Thanks for the patch.
> 
> Consider that not all implementations based on 8250_dw support IRDA
> feature. I suppose you need to read capability register bits 6 and 7,
> set flag and then based on the value accept or reject IRDA mode.
> 
> P.S. Use -n when prepare patches to link them if you consider them
> dependent.

These are numbered? Or do you mean that please prefer sending
series of patches as threads?

        % git send-email --thread...

Or something like that? I guess coverletter would be nice too.


Thanks,

-- 
heikki
