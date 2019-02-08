From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Fri, 8 Feb 2019 16:03:50 +0530
Message-ID: <20190208103350.jnmpsd3hkehzwbo3@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
 <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
 <CAPDyKFrXWAzDChd3d2acQnF6GZw57+g6XeNtHo29q3i1qjidnQ@mail.gmail.com>
 <20190208100529.l2y75ua3bfa6nnyx@vireshk-i7>
 <CAPDyKFpmZNW7KgsgagD_6tKTQ07AJS7Kc=AGCQmMpNASuOG-Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpmZNW7KgsgagD_6tKTQ07AJS7Kc=AGCQmMpNASuOG-Dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Graham Roff <grahamr@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Doug Anderson <dianders@chromium.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 08-02-19, 11:31, Ulf Hansson wrote:
> On Fri, 8 Feb 2019 at 11:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-02-19, 10:45, Ulf Hansson wrote:
> > > On Fri, 8 Feb 2019 at 08:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 07-02-19, 14:37, Ulf Hansson wrote:
> > > > > I think we also need to consider cross SoC drivers. One SoC may have
> > > > > both clocks and OPPs to manage, while another may have only clocks.
> > > >
> > > > We already have that case with CPUs as well and dev_pm_opp_set_rate()
> > > > takes care of it.
> > >
> > > I think you may have misunderstood my point. Or maybe I don't get yours. :-)
> >
> > It was me. I thought you are talking about regulators and that is what
> > is already managed, i.e. to work with or without regulators.
> >
> > > What if there is no OPP at all to use, then dev_pm_opp_set_rate() is
> > > just a noop, right? In this scenario the driver still need to call
> > > clk_set_rate().
> > >
> > > How do we cope with these cases?
> >
> > Yeah, that would be a problem and hacking the OPP core may not be the
> > right solution :(
> 
> I guess one simple way forward could just be to check if there is an
> OPP handle/table available, then use dev_pm_opp_set_rate(). When no
> OPP handle/table, use clk_set_rate() *instead*, not both.
> 
> That could work, don't you think?

Yeah, just that it adds more conditional code in drivers, while we
wanted to make them light-weight :)

-- 
viresh
