From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Wed, 06 Feb 2019 23:58:17 -0800
Message-ID: <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
References: <20190129015547.213276-1-swboyd@chromium.org> <20190131092349.fksfqemm23qddkhw@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131092349.fksfqemm23qddkhw@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, grahamr@codeaurora.org, mturquette@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, vincent.guittot@linaro.org
List-Id: linux-serial@vger.kernel.org

Quoting Viresh Kumar (2019-01-31 01:23:49)
> Adding few folks to the thread who might be interested in this stuff.
>=20
> On 28-01-19, 17:55, Stephen Boyd wrote:
> > This patch series is an RFC around how we can implement DVFS for devices
> > that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
> > strict set of frequencies that they have been tested at to derive some
> > operating performance point. Instead they have a coarser set of
> > frequency max or 'fmax' OPPs that describe the maiximum frequency the
> > device can operate at with a given voltage.
> >=20
> > The approach we take is to let the devm_pm_opp_set_rate() API accept 0
> > as a valid frequency indicating the frequency isn't required anymore and
> > to make the same API use the clk framework to round the frequency passed
> > in instead of relying on the OPP table to specify each frequency that
> > can be used. Once we have these two patches in place, we can use the OPP
> > API to change clk rates instead of clk_set_rate() and use all the recent
> > OPP enhancements that have been made around required-opps and genpd
> > performance states to do DVFS for all devices.
>=20
> Generally speaking I am fine with such an approach but I am not sure
> about what others would say on this as they had objections to using
> OPP core for setting the rate itself.
>=20
> FWIW, I suggested exactly this solution sometime back [1]
>=20
> - Drivers need to use two API sets to change clock rate (OPP helpers)
>   and enable/disable them (CLK framework helpers) and this leads us to
>   exactly that combination. Is that acceptable ? It doesn't look great
>   to me as well..

Agreed. I don't think anyone thinks this looks great, but I'll argue
that it's improving OPP for devices that already use it so that we can
remove voltage requirements when their clk is off. Think about CPUs that
are in their own clk domain where we want to remove the voltage
requirement when those CPUs are offline, or a GPU that wants to remove
its voltage requirement when it turns off clks. The combination is
already out there, just OPP hasn't solved this problem.

The only other plan I had was to implement another API like
dev_pm_set_state() or something like that and have that do something
like what the OPP rate API does right now. The main difference being
that the argument to the function would be some opaque u64 that's
converted by the bus/class/genpd attached to the device into whatever
frequency/voltage/performance state is desired (and sequenced in the
right order too). And then I was thinking that runtime PM or explicit
dev_pm_set_state() calls would be used to tell this new layer that the
device was going to a lower power mode with some other number (sub-kHz
integer?) and have that be translated again into some
frequency/voltage/performance state.

Either way, each driver will have to change from using the clk APIs to
changes rates to something else like one of these APIs, so I don't see a
huge difference. Drivers will have to change.

>=20
> - Do we expect the callers will disable clk before calling
>   opp-set-rate with 0 ? We should remove the regulator requirements as
>   well along with perf-state.

Yes, that's the plan. Problems come along with this though, like shared
resource constraints and actually knowing the clk on/off state,
frequency, voltage, etc. at boot time and making sure to keep those
constraints satisfied during normal operation.

>=20
> - What about enabling/disabling clock as well from OPP framework. We
>   can enable it on the very first call to opp-set-rate and disable
>   when freq is 0. That will simplify the drivers as well.

It works when those drivers aren't calling clk_disable() directly from
some irq handler. I don't think that's very common, but in those cases
we would probably want to allow drivers to quickly gate and ungate their
clks but then defer the sleeping stuff (voltages and off chip clks) to
the schedulable contexts. We'll still be left with a small number of
drivers that want to only call clk_prepare() and clk_unprepare() from
within OPP and keep calling clk_enable() and clk_disable() from their
driver. So introduce different APIs for those drivers to indicate this
to OPP? And only do that when it becomes a requirement?

Otherwise I don't really see a problem with the OPP call handling the
enable state of the clk as well.

>=20
> > One nice feature of this approach is that we don't need to change the
> > OPP binding to support this. We can specify only the max frequencies and
> > the voltage requirements in DT with the existing binding and slightly
> > tweak the OPP code to achieve these results.=20
> >=20
> > This series includes a conversion of the uart and spi drivers on
> > qcom sdm845 where these patches are being developed. It shows how a
> > driver is converted from the clk APIs to the OPP APIs and how
> > enable/disable state of the clk is communicated to the OPP layer.
> >=20
> > Some open topics and initial points for discussion are:
> >=20
> > 1) The dev_pm_opp_set_rate() API changes may break something that's=20
> > relying on the rate rounding that OPP provides. If those exist,
> > we may need to implement another API that is more explicit about using
> > the clk API instead of the OPP tables.
> >=20
> > 2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
> > dropping the rate requirement. Is there anything better than this?
> >=20
> > 3) How do we handle devices that already have power-domains specified in
> > DT? The opp binding for required-opps doesn't let us specify the power
> > domain to target, instead it assumes that whatever power domain is
> > attached to a device is the one that OPP needs to use to change the
> > genpd performance state. Do we need a
> > dev_pm_opp_set_required_opps_name() or something to be explicit about
> > this? Can we have some way for the power domain that required-opps
> > correspond to be expressed in the OPP tables themselves?
> >=20
> > 4) How do we achieve the "full constraint" state? i.e. what do we do
> > about some devices being active and others being inactive during boot
> > and making sure that the voltage for the shared power domains doesn't
> > drop until all devices requiring it have informed OPP about their
> > power requirements?
> >=20

Any comments on these topics?
