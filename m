From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 0/5] Document msm_serial bindings and support newer
 uartdms
Date: Tue, 27 Aug 2013 16:48:44 -0700
Message-ID: <521D3ADC.6050703@codeaurora.org>
References: <1377067686-31957-1-git-send-email-sboyd@codeaurora.org> <20130827232351.GA27119@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:52653 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3H0Xsp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Aug 2013 19:48:45 -0400
In-Reply-To: <20130827232351.GA27119@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

On 08/27/13 16:23, Greg Kroah-Hartman wrote:
> On Tue, Aug 20, 2013 at 11:48:01PM -0700, Stephen Boyd wrote:
>> This patchset aligns the msm_serial driver more with downstream usage and
>> also documents the msm_serial driver's DT binding. Along the way we
>> update the clock names and add support for newer UARTDM hardware that
>> isn't part of a GSBI and make the console layer use the extra registers in
>> UARTDM.
>>
>> Changes since v1:
>>  * Dropped _clk postfix from {core,iface}_clk
>>  * Split DT binding into two files
>>  * Renamed DT binding files to match compatible strings
>>  * Fixed up DT review comments
>>  * Added new patch 5/5 (more than 1 char for UARTDM)
> I took patches 1, 3, and 5 from this series, as it seems that the dt
> bindings are still being discussed.

Thanks Greg. I'll resend the patches right now. I got sidetracked on
other things.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

