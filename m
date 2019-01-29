From: Stephen Boyd <swboyd@chromium.org>
Subject: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Mon, 28 Jan 2019 17:55:42 -0800
Message-ID: <20190129015547.213276-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-serial@vger.kernel.org

This patch series is an RFC around how we can implement DVFS for devices
that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
strict set of frequencies that they have been tested at to derive some
operating performance point. Instead they have a coarser set of
frequency max or 'fmax' OPPs that describe the maiximum frequency the
device can operate at with a given voltage.

The approach we take is to let the devm_pm_opp_set_rate() API accept 0
as a valid frequency indicating the frequency isn't required anymore and
to make the same API use the clk framework to round the frequency passed
in instead of relying on the OPP table to specify each frequency that
can be used. Once we have these two patches in place, we can use the OPP
API to change clk rates instead of clk_set_rate() and use all the recent
OPP enhancements that have been made around required-opps and genpd
performance states to do DVFS for all devices.

One nice feature of this approach is that we don't need to change the
OPP binding to support this. We can specify only the max frequencies and
the voltage requirements in DT with the existing binding and slightly
tweak the OPP code to achieve these results. 

This series includes a conversion of the uart and spi drivers on
qcom sdm845 where these patches are being developed. It shows how a
driver is converted from the clk APIs to the OPP APIs and how
enable/disable state of the clk is communicated to the OPP layer.

Some open topics and initial points for discussion are:

1) The dev_pm_opp_set_rate() API changes may break something that's 
relying on the rate rounding that OPP provides. If those exist,
we may need to implement another API that is more explicit about using
the clk API instead of the OPP tables.

2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
dropping the rate requirement. Is there anything better than this?

3) How do we handle devices that already have power-domains specified in
DT? The opp binding for required-opps doesn't let us specify the power
domain to target, instead it assumes that whatever power domain is
attached to a device is the one that OPP needs to use to change the
genpd performance state. Do we need a
dev_pm_opp_set_required_opps_name() or something to be explicit about
this? Can we have some way for the power domain that required-opps
correspond to be expressed in the OPP tables themselves?

4) How do we achieve the "full constraint" state? i.e. what do we do
about some devices being active and others being inactive during boot
and making sure that the voltage for the shared power domains doesn't
drop until all devices requiring it have informed OPP about their
power requirements?

Rajendra Nayak (4):
  OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
  tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
  spi: spi-geni-qcom: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add OPP table for all qup devices

Stephen Boyd (1):
  OPP: Don't overwrite rounded clk rate

 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 115 ++++++++++++++++++++++++++
 drivers/opp/core.c                    |  26 ++++--
 drivers/spi/spi-geni-qcom.c           |  12 ++-
 drivers/tty/serial/qcom_geni_serial.c |  15 +++-
 4 files changed, 155 insertions(+), 13 deletions(-)

For the interested, these patches are located here:

   https://github.com/rrnayak/linux/ v5.0-rc3/opp-corners-wip

I've generated these patches by cutting off the top of that tree and
massaging the commit text a bit for the first patch.

base-commit: 49a57857aeea06ca831043acbb0fa5e0f50602fd
prerequisite-patch-id: 9c3ee728603596b8b0ba06ffd66084bdc21b1271
prerequisite-patch-id: f160e050bcd74f5de6fad66329381853869a6a97
prerequisite-patch-id: aa23548d2b486c29489b4304d85799d08762254e
prerequisite-patch-id: 40dd117c45fecb4308298352346546612db94b64
prerequisite-patch-id: cd102fa42bab19897c2295e8b990b2156626054a
prerequisite-patch-id: 3b9e5c8ed65ee96cc0f1c50166cf6bbb597ef582
prerequisite-patch-id: 7e71b957b90ad51d0619944d5ebc859380e8e3e4
prerequisite-patch-id: 5abd2bd6b3ae3e91551e2b8f9295169019ba82c7
prerequisite-patch-id: 68bb3e44cf4e5dbd363a1a1750e4d378971ed393
prerequisite-patch-id: 882b14ef9527b15d22cfddbb5fa2b9d43df1ff04
prerequisite-patch-id: 6fc14ddeb074fb0826f1f40031e9d161f1361666
-- 
Sent by a computer through tubes
