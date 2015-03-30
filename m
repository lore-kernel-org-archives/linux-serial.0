From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/5] dmaengine: hsu: Fix memory leak when stopping a
 running transfer
Date: Mon, 30 Mar 2015 23:07:32 +0530
Message-ID: <20150330173732.GK7192@intel.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-5-git-send-email-peter.ujfalusi@ti.com>
 <1427457718.14897.428.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427457718.14897.428.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux@arm.linux.org.uk, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 27, 2015 at 02:01:58PM +0200, Andy Shevchenko wrote:
> On Fri, 2015-03-27 at 13:35 +0200, Peter Ujfalusi wrote:
> > The vd->node is removed from the lists when the transfer started so the
> > vchan_get_all_descriptors() will not find it. This results memory leak.
> > 
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

Greg,

Please apply this in your queue for next

-- 
Vinod

> 
> Though this one would go via Greg's tty tree (Cc'ed) I think.
> It becomes to regular work flow after 4.1-rc1.
> 
> 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > ---
> >  drivers/dma/hsu/hsu.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
> > index 683ba9b62795..d1864bda008f 100644
> > --- a/drivers/dma/hsu/hsu.c
> > +++ b/drivers/dma/hsu/hsu.c
> > @@ -387,7 +387,10 @@ static int hsu_dma_terminate_all(struct dma_chan *chan)
> >  	spin_lock_irqsave(&hsuc->vchan.lock, flags);
> >  
> >  	hsu_dma_stop_channel(hsuc);
> > -	hsuc->desc = NULL;
> > +	if (hsuc->desc) {
> > +		hsu_dma_desc_free(&hsuc->desc->vchan);
> > +		hsuc->desc = NULL;
> > +	}
> >  
> >  	vchan_get_all_descriptors(&hsuc->vchan, &head);
> >  	spin_unlock_irqrestore(&hsuc->vchan.lock, flags);
> 
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy
> 

-- 
