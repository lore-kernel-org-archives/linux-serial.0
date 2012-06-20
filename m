From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: samsung: Fixed wrong comparison for
 baudclk_rate
Date: Wed, 20 Jun 2012 16:50:36 -0700
Message-ID: <20120620235036.GB8293@kroah.com>
References: <000101cd3665$7943b690$6bcb23b0$%kim@samsung.com>
 <028f01cd4e9d$2b344410$819ccc30$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <028f01cd4e9d$2b344410$819ccc30$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Kyoungil Kim' <ki0351.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 'Alan Cox' <alan@linux.intel.com>, 'Yoon' <junho78.yoon@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 20, 2012 at 01:28:40PM +0900, Kukjin Kim wrote:
> Kyoungil Kim wrote:
> > 
> > port->baudclk_rate should be compared to the rate of port->baudclk,
> > because port->baudclk_rate was assigned as the rate of port->baudclk
> > previously.
> > So to check that the current baudclk rate is same as previous rate,
> > the target of comparison sholud be the rate of port->baudclk.
> > 
> > Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> 
> (Cc'ed Greg)
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Greg, this is needed to fix the wrong comparison for baudclk_rate for
> Samsung Serial.
> Could you please pick this up in your fix tree?

Already there, thanks.

greg k-h
