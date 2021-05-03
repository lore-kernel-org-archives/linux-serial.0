Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C2C433ED
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBFA61176
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 09:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhECJwg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 May 2021 05:52:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:10595 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhECJwg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 May 2021 05:52:36 -0400
IronPort-SDR: 7Fo9L2F9CVZUWkEFknWmklGsocFhFIi92HlxLSmmxCq5m/T3XkBfoU8FDJqXgo353gttlhIxMk
 eK/LHLULC8Nw==
X-IronPort-AV: E=McAfee;i="6200,9189,9972"; a="218494911"
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="218494911"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 02:51:43 -0700
IronPort-SDR: rnnC37PlQP7b07uU/5diHiDYx/F+E9bHBhRAjHoEPelVhmRsAqoL9hm6vk8JNoNpNCCZOHcNcB
 OnmVfrgstMUA==
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="405544989"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 02:51:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ldVEo-009Ed1-90; Mon, 03 May 2021 12:51:38 +0300
Date:   Mon, 3 May 2021 12:51:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YI/HqpJN+OvYduMn@smile.fi.intel.com>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
 <20210430114106.GF1981@kadam>
 <YIv92DBnaVotWd9Y@smile.fi.intel.com>
 <20210430133329.GH1981@kadam>
 <YIwSZGE76f2ZJyyf@smile.fi.intel.com>
 <20210503065439.GI1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503065439.GI1981@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 03, 2021 at 09:54:39AM +0300, Dan Carpenter wrote:
> On Fri, Apr 30, 2021 at 05:21:24PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 30, 2021 at 04:33:29PM +0300, Dan Carpenter wrote:
> > > On Fri, Apr 30, 2021 at 03:53:44PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 30, 2021 at 02:41:06PM +0300, Dan Carpenter wrote:
> > > > > On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > > > Why would I make it unsigned?  As a static analysis developer,
> > > > > pointlessly unsigned variables are one of the leading causes for the
> > > > > bugs I see.
> > > > > 
> > > > > There are times where a iterator counter needs to be unsigned long, or
> > > > > u64 but I have never seen a case where changing an iterator from
> > > > > "int i;" to "unsigned int i;" solves a real life kernel bug.  It only
> > > > > introduces bugs.
> > > > 
> > > > See my followup to that, I meant
> > > > 
> > > > unsigned int count;
> > > > 
> > > > do {
> > > > 	...
> > > > } while (--count);
> > > > 
> > > > It doesn't solve bug, but prevents the code be read incorrectly like what you
> > > > are fixing can be avoided with do {} while (); along with unsigned type.
> > > 
> > > Why would you use an unsigned int for this???
> > 
> > Why it should be signed? You clearly show the amount of iterations. Check for
> > null I guess even compact in the assembly in comparison to -1.
> > 
> > I do not see any point why it should be signed. For what purpose?
> > 
> > It's a *down* counter.
> 
> Yeah.  And people regularly test down counters for >= 0.

I don't know that. What I see the test is as simple as
while (--count) which is basically > 0.

> Signed ints
> are safer.

Any research article about it? What about wrong integral promotions which
I consider is a root cause of many bugs? People should learn that, or the
C (standard) should be fixed to make it easier to get.

> Unsigned ints are a *leading* cause of bugs in the kernel.

Again, where this statistics comes from? Maybe it's a simple answer to the
question that review in kernel is not good enough?

> I don't know if they're in the top five but they're definitely in the
> top ten.

Again, I don't see any proofs.

> Also if you need a larger type you should switch to a 64 bit type.  The
> 2-4 million range is very narrow.
> 
> I have never seen a single kernel bug where the for loop counter was
> "int i;" and making it "unsigned int i;" fixed a real life kernel bug.

Your very patch suggests one of the solution to switch to unsigned to fix a
kernel bug (though with lowest severity).

> Of course, there are times when unsigned int is appropriate, like for
> sizes or because it's in the spec.
> 
> It's frustrating to me because GCC encourages people to make loop
> counters unsigned and it introduces bugs.

Any code which was written in unthought manner is a buggy code. So, how
unsigned vs. signed loop counter any different here to any other buggy code?

> I'm looking at the git log right now and I see that someone changed:
> 
>  void dt_to_asm(FILE *f, struct dt_info *dti, int version)
>  {
>         struct version_info *vi = NULL;
> -       int i;
> +       unsigned int i;
>         struct data strbuf = empty_data;
>         struct reserve_info *re;
>         const char *symprefix = "dt";
> 
> There are two loops in that function:
> 
> 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
> 
> This the one that generates the warning.  GCC knows at compile time that
> ARRAY_SIZE() is 5.  ARGH!!!  GCC is so lazy and horrible.  If I did this
> in Smatch people would never accept it.  Even if ARRAY_SIZE() were
> higher than INT_MAX the loop would behave the same regardless of whether
> it was signed or not because of type promotion.
> 
> The other loop is:
> 
> 	for (i = 0; i < reservenum; i++) {
> 
> In this case "reservenum" comes from the command line.  In the original
> code if it were negative that would be a harmless no-op but now because
> i is unsigned it's a crashing bug.  Why did GCC not generate a warning
> for this?  The code was obviously bad before, that's true, but now in a
> very measurable way it has become worse.

See above. I think the root cause that people do not understand C and how to
program in C in bug-less manner.

> This example is not really important.  I only brought it up because it
> is most recent example of people changing "int i;" to "unsigned int i;".
> But there have been other cases like this which have had a security
> impact.

-- 
With Best Regards,
Andy Shevchenko


