From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with
 small transfers"
Date: Fri, 09 Oct 2015 17:48:37 +0300
Message-ID: <1444402117.8361.549.camel@linux.intel.com>
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
	 <20151006135503.GA13250@kroah.com> <5613D968.7000505@linux.intel.com>
	 <5617D2FA.1020108@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5617D2FA.1020108-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2015-10-09 at 16:45 +0200, Frederic Danis wrote:
> Hello Greg,
> 
> On 06/10/2015 16:23, Frederic Danis wrote:
> > > 
> > > Andy, any objections?
> > > 
> > > Frederic, don't you want to see this backported to 4.0 and newer?
> > 
> > Yes, you're right, unless Andy has any objection this should be 
> > good
> 
> This is first time for me that patch may be applied to previous 
> kernel.
> 
> Is there something specific I should do to allow this patch to be 
> applied and backported to 4.0 and newer ?

Earlier we use to Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
(I don't know if it's still a case)

Now the tag Fixes: is in use, like you may add the following line to th
e commit message:

Fixes: 9119fba0cfed (serial: 8250_dma: don't bother DMA with small
transfers)

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
