From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Fri, 8 Feb 2019 12:47:26 +0530
Message-ID: <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Graham Roff <grahamr@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Doug Anderson <dianders@chromium.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 07-02-19, 14:37, Ulf Hansson wrote:
> I think we also need to consider cross SoC drivers. One SoC may have
> both clocks and OPPs to manage, while another may have only clocks.

We already have that case with CPUs as well and dev_pm_opp_set_rate()
takes care of it.

> Even it this may be fairly uncommon, we should consider it, before we
> decide to fold in additional clock management, like
> clk_prepare|unprepare() for example, behind the dev_pm_opp_set_rate()
> API.
> 
> The point is, the driver may need to call clk_prepare|enable()
> anyways, unless we make that conditional depending on a DT compatible
> string, for example. Of course, because the clock prepare/enable is
> reference counted, there may not be a problem in practice to have both
> the OPP and driver to deal with it.

-- 
viresh
