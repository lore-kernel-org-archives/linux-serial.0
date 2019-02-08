From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Date: Fri, 8 Feb 2019 10:09:26 +0530
Message-ID: <76b656dd-e8b2-0982-23a7-398235630d54@codeaurora.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <7af27aa5-3ff6-d4ee-1dc0-bac797c2bdbc@codeaurora.org>
 <154956885472.115909.8681514480591552850@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154956885472.115909.8681514480591552850@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-serial@vger.kernel.org



On 2/8/2019 1:17 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-02-06 22:57:12)
>>
>>> 3) How do we handle devices that already have power-domains specified in
>>> DT? The opp binding for required-opps doesn't let us specify the power
>>> domain to target, instead it assumes that whatever power domain is
>>> attached to a device is the one that OPP needs to use to change the
>>> genpd performance state. Do we need a
>>> dev_pm_opp_set_required_opps_name() or something to be explicit about
>>> this? Can we have some way for the power domain that required-opps
>>> correspond to be expressed in the OPP tables themselves?
>>
>> I was converting a few more drivers to use the proposed approach in this
>> RFC, in order to identify all outstanding issues we need to deal with,
>> and specifically for UFS, I end up with this exact scenario where UFS already
>> has an existing power domain (gdsc) and I need to add another one (rpmhpd) for
>> setting the performance state.
>>
>> If I use dev_pm_opp_of_add_table() to add the opp table from DT, the opp
>> layer assumes its the same device on which it can do a dev_pm_genpd_set_performance_state()
>> with, however the device that's actually associated with the pm_domain when we
>> have multiple power domains is infact the one (dummy) that we create when
>> the driver makes a call to dev_pm_domain_attach_by_name/id().
>>
>> Any thoughts on whats a good way to handle this?
>>
> 
> Ulf mentioned that we can use dev_pm_opp_set_genpd_virt_dev() for this.
> Does that API work here?

Ah, yes, that should work, I hadn't noticed this API existed.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
