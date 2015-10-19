From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/5] drivers/tty/serial: make msm_serial.c explicitly
 non-modular
Date: Mon, 19 Oct 2015 16:19:16 -0400
Message-ID: <20151019201916.GF26878@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <1445206878-12455-5-git-send-email-paul.gortmaker@windriver.com>
 <56254819.6030809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56254819.6030809@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[Re: [PATCH 4/5] drivers/tty/serial: make msm_serial.c explicitly non-modular] On 19/10/2015 (Mon 12:44) Stephen Boyd wrote:

> On 10/18/2015 03:21 PM, Paul Gortmaker wrote:
> > The Kconfig currently controlling compilation of this code is:
> >
> > drivers/tty/serial/Kconfig:config SERIAL_MSM
> > drivers/tty/serial/Kconfig:     bool "MSM on-chip serial port support"
> >
> > ...meaning that it currently is not being built as a module by anyone.
> >
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> >
> > We explicitly disallow a driver unbind, since that doesn't have a
> > sensible use case anyway, and it allows us to drop the ".remove"
> > code for non-modular drivers.
> >
> > Since module_init translates to device_initcall in the non-modular
> > case, the init ordering remains unchanged with this commit.
> >
> > We don't replace module.h with init.h since the file already has that.
> >
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > is already contained at the top of the file in the comments.
> >
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Andy Gross <agross@codeaurora.org>
> > Cc: David Brown <davidb@codeaurora.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: linux-soc@vger.kernel.org
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> 
> I'd prefer we make the Kconfig a tristate. I'll test out that
> configuration today, but I don't see why it wouldn't work.

Sure, if you want to do that then great; as I've said in other threads,
it simply doesn't scale for me to be expanding functionality in these
kinds of commits, since there are 300+ of them and I can't do much more
than just make the code consistent with the Makefile/Kconfig behaviour
and still get through them all.

When I see a tristate patch for it appear in -next I will drop this.
Or if Greg wants to merge the series w/o this one patch, that is fine
too -- basically whatever works for Greg, since he's got the larger
burden here, maintaining all these different things that he does.

Thanks,
Paul.
--

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
