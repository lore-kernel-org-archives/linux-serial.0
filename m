From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/7] soc: qcom: Add GENI based QUP Wrapper driver
Date: Fri, 19 Jan 2018 16:57:08 -0600
Message-ID: <20180119225708.4mo6fiy5zyd6kscj@rob-hp-laptop>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-4-git-send-email-kramasub@codeaurora.org>
 <20180117062002.GA6620@minitux>
 <29ed5b45-dd70-fb70-3aa4-4e1a0006d57e@codeaurora.org>
 <20180118165745.GE6620@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118165745.GE6620@minitux>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 18, 2018 at 08:57:45AM -0800, Bjorn Andersson wrote:
> On Thu 18 Jan 01:13 PST 2018, Rajendra Nayak wrote:
> 
> > []..
> > 
> > >> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> > >> new file mode 100644
> > >> index 0000000..3f43582
> > >> --- /dev/null
> > >> +++ b/drivers/soc/qcom/qcom-geni-se.c
> > >> @@ -0,0 +1,1016 @@
> > >> +/*
> > >> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> > >> + *
> > >> + * This program is free software; you can redistribute it and/or modify
> > >> + * it under the terms of the GNU General Public License version 2 and
> > >> + * only version 2 as published by the Free Software Foundation.
> > >> + *
> > >> + * This program is distributed in the hope that it will be useful,
> > >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > >> + * GNU General Public License for more details.
> > >> + *
> > >> + */
> > > 
> > > Please use SPDX style license header, i.e. this file should start with:
> > > 
> > > // SPDX-License-Identifier: GPL-2.0
> > > /*
> > >  * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> > >  */
> > 
> > Looks like Mark Brown commented elsewhere [1] that we should use the C++
> > commenting style even for the Linux Foundation copyright?
> > 
> > [1] https://marc.info/?l=linux-clk&m=151497978626135&w=2 
> > 
> 
> While I can agree with Mark on the ugliness of the mixed commenting
> style, this is the style that I found communicated and is what you find
> in other files.

Well, that's pretty new guidance. Moving target...

Given that Linus said '//' comments are the only thing C++ got right, I 
expect to see more of them.

Rob
