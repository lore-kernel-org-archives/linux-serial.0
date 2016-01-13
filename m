From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Wed, 13 Jan 2016 15:59:30 +0530
Message-ID: <20160113102930.GA26117@sudip-pc>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
 <20160109182908.GB29967@kroah.com>
 <20160111083536.GB8070@sudip-pc>
 <20160111111101.GA18945@roeck-us.net>
 <5693C553.7050400@windriver.com>
 <5695E207.9080309@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5695E207.9080309@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 12, 2016 at 09:35:03PM -0800, Guenter Roeck wrote:
> On 01/11/2016 07:08 AM, Paul Gortmaker wrote:
> >On 2016-01-11 06:11 AM, Guenter Roeck wrote:
> >>On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
> >>>On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wrote:
> >>>>On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
<snip>
> >>>
> >>>Hi Guenter,
> >>>Just a thought. It has happended many times that we both have sent
> >>>patches to fix the same build fail. Maybe your patch got applied and
> >>>mine came late or maybe mine was applied and you came late. But I think
> >>>if we have a separate mailing list where people interested to fix and
> >>>monitor build failures will be members and we Cc that list whenever we
> >>>send patch for build fail and then in that case we will know that
> >>>someone else has already sent a patch for this failure and we can invest
> >>>the time in some other problem.
> >>>
> >>
> >>Hi Sudip,
> >>
> >>I agree, it would make sense to have a build(/runtime?)-fixes-only mailing
> >>list. Question though is how to limit noise on such a list and, of course,
> >>where and how to set it up. Any thoughts ?
> >
> >Since most (all?) of these kind of fails are on linux-next, why not
> 
> Most or many, but not all.
> 
> >do what everyone else does, and report the fail there and/or ensure
> >the fix is cc'd there?   Before I waste time trying to fix sth on
> >linux-next, I always google for the error msg and many times that
> >leads me to a lkml or linux-next post where it was reported and
> >fixed already.
> 
> Many times, Sudip and I end up fixing problems literally in parallel,
> and it happened quite often lately that we do send patches in parallel.

sometimes it was a difference of few minutes.

> Even if I do a Google search for an error message, it happens quite
> often that I get no results, yet the fix is already out there on
> some list.

google will take some time to index it.

> 
> Sudip, one option would be to set up a semi-private mailing list.
> My build tests now have a dedicated virtual host (kerneltests.org).
> I could set up a managed list there.

yes, fine with me. As long as we can share the information that one of
us has already sent the fix.

regards
sudip
