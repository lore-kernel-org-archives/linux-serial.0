From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Mon, 5 Feb 2018 15:53:01 -0800
Message-ID: <20180205235301.GI9465@builder>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
 <20180117062002.GA6620@minitux>
 <29ed5b45-dd70-fb70-3aa4-4e1a0006d57e@codeaurora.org>
 <20180118165745.GE6620@minitux>
 <20180119225708.4mo6fiy5zyd6kscj@rob-hp-laptop>
 <1abb0679-1997-9b70-30bd-d3472cea7053@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1abb0679-1997-9b70-30bd-d3472cea7053-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, corbet-T1hC0tSOHrs@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed 31 Jan 11:02 PST 2018, Karthik Ramasubramanian wrote:
> On 1/19/2018 3:57 PM, Rob Herring wrote:
> > On Thu, Jan 18, 2018 at 08:57:45AM -0800, Bjorn Andersson wrote:
> > > On Thu 18 Jan 01:13 PST 2018, Rajendra Nayak wrote:
[..]
> > > > > 
> > > > > Please use SPDX style license header, i.e. this file should start with:
> > > > > 
> > > > > // SPDX-License-Identifier: GPL-2.0
> > > > > /*
> > > > >   * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> > > > >   */
> > > > 
> > > > Looks like Mark Brown commented elsewhere [1] that we should use the C++
> > > > commenting style even for the Linux Foundation copyright?
> > > > 
> > > > [1] https://marc.info/?l=linux-clk&m=151497978626135&w=2
> > > > 
> > > 
> > > While I can agree with Mark on the ugliness of the mixed commenting
> > > style, this is the style that I found communicated and is what you find
> > > in other files.
> > 
> > Well, that's pretty new guidance. Moving target...
> > 
> > Given that Linus said '//' comments are the only thing C++ got right, I
> > expect to see more of them.
> I believe that in the source file I have to use C++ style comments(as per
> this discussion) and in the header file I have to use C-style comments (as
> per https://lwn.net/Articles/739183/ for reasons related to tooling). Please
> correct me otherwise.

I had missed that detail, you're right.

Thanks,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
