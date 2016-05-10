From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 2/2] dmaengine: rename cmd_pause to cmd_suspend
Date: Tue, 10 May 2016 21:41:52 +0530
Message-ID: <20160510161151.GI2274@localhost>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1462390180-82368-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160510155928.GH2274@localhost>
 <1462896023.17131.305.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462896023.17131.305.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 10, 2016 at 07:00:23PM +0300, Andy Shevchenko wrote:
> On Tue, 2016-05-10 at 21:29 +0530, Vinod Koul wrote:
> > On Wed, May 04, 2016 at 10:29:40PM +0300, Andy Shevchenko wrote:
> > > 
> > > Rename cmd_pause to cmd_suspend to be clear that latter capability
> > > reflects
> > > pause AND resume.
> > How does cmd_suspend be any clearer to reflect that channel is paused
> > and
> > not. One can argue this might be related to power management suspend 
> 
> Okay, I'm open to suggestions. My main point that name should not
> represent only pause or resume, rather both.

I am actually okay with this name, but while getting the capablities, we
should rather tell user if both are supported or not. Perhaps make it a
bit mask?

-- 
~Vinod
