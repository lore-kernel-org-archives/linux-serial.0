From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Date: Thu, 3 Oct 2013 11:30:42 +0900
Message-ID: <20131003023042.GB27371@verge.net.au>
References: <4895580.Leadr2OAf1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4895580.Leadr2OAf1@avalon>
 <20130924134113.GA7246-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 06:41:13AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Sep 24, 2013 at 01:44:32PM +0900, Simon Horman wrote:
> > [ CCed Greg Kroah-Hartman, the serial maintainer for his review ]
> > 
> > On Tue, Sep 24, 2013 at 01:10:39PM +0900, takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:
> > > From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > > migrate to the common clock framework.
> > > 
> > > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > > [takashi.yoshii.ze-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org: edited for conflicts]
> > > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> 

On Mon, Sep 30, 2013 at 05:25:40PM +0200, Laurent Pinchart wrote:
> Hi Yoshii-san,
> 
> Thank you for the patch.
> 
> On Tuesday 24 September 2013 13:10:39 takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:
> > From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > 
> > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > migrate to the common clock framework.
> > 
> > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > [takashi.yoshii.ze-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org: edited for conflicts]
> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Thanks, I have queued this up in the serial branch of the renesas tree.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
