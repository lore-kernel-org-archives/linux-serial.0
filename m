From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Thu, 31 Jan 2019 16:11:53 +0530
Message-ID: <20190131104153.ojyp3razjbzm6pnc@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <CAJZ5v0jY5Zjg0R7uC6ewJT5Pi-15Mohotj=im9k8w4THJSM0Dw@mail.gmail.com>
 <20190131100628.6ex6ic3kspuxxxt7@vireshk-i7>
 <CAJZ5v0jA0U1Z=AeRrEGXH2j+AenzNaiD+tV-yKwKanKwiNVW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jA0U1Z=AeRrEGXH2j+AenzNaiD+tV-yKwKanKwiNVW7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Michael Turquette <mturquette@baylibre.com>, grahamr@codeaurora.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 31-01-19, 11:36, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-01-19, 10:58, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > Adding few folks to the thread who might be interested in this stuff.
> > > >
> > > > On 28-01-19, 17:55, Stephen Boyd wrote:
> > > > > This patch series is an RFC around how we can implement DVFS for devices
> > > > > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > > > > strict set of frequencies that they have been tested at to derive some
> > > > > operating performance point. Instead they have a coarser set of
> > > > > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > > > > device can operate at with a given voltage.
> > > > >
> > > > > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > > > > as a valid frequency indicating the frequency isn't required anymore and
> > > > > to make the same API use the clk framework to round the frequency passed
> > > > > in instead of relying on the OPP table to specify each frequency that
> > > > > can be used. Once we have these two patches in place, we can use the OPP
> > > > > API to change clk rates instead of clk_set_rate() and use all the recent
> > > > > OPP enhancements that have been made around required-opps and genpd
> > > > > performance states to do DVFS for all devices.
> > > >
> > > > Generally speaking I am fine with such an approach but I am not sure
> > > > about what others would say on this as they had objections to using
> > > > OPP core for setting the rate itself.
> > > >
> > > > FWIW, I suggested exactly this solution sometime back [1]
> > > >
> > > > - Drivers need to use two API sets to change clock rate (OPP helpers)
> > > >   and enable/disable them (CLK framework helpers) and this leads us to
> > > >   exactly that combination. Is that acceptable ? It doesn't look great
> > > >   to me as well..
> > >
> > > I agree here.
> > >
> > > > - Do we expect the callers will disable clk before calling
> > > >   opp-set-rate with 0 ? We should remove the regulator requirements as
> > > >   well along with perf-state.
> > >
> > > Well, disabling clk affects HW in general, doesn't it?
> >
> > Yeah, but the regulator may be shared and is running at higher
> > voltages just because of the clock requirement of the device getting
> > disabled here. Or did I misunderstood what you wanted to say ?
> 
> What I wanted to say is that if the caller is required to disable clk
> beforehand, that may be as good as setting its rate to zero already.

Right, but that doesn't mean that the requirements put on the
regulator and genpd are gone as well and that is why I favor the OPP
core to handle all the parts otherwise write the rules explicitly. If
the OPP core doesn't disable the clock and the caller also hasn't done
the same, then disabling the genpd/regulator may break things up.

-- 
viresh
