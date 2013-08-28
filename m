From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v3 2/2] ARM: dts: msm: Update uartdm compatible strings
Date: Wed, 28 Aug 2013 13:09:30 -0500
Message-ID: <73376D74-0D5C-4739-A81A-1A1EC7B3463F@codeaurora.org>
References: <1377648764-23453-1-git-send-email-sboyd@codeaurora.org> <1377648764-23453-3-git-send-email-sboyd@codeaurora.org> <0092782E-9E89-4350-B3B5-EB1275F2F8E3@codeaurora.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <0092782E-9E89-4350-B3B5-EB1275F2F8E3@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, David Brown <davidb@codeaurora.org>
List-Id: linux-serial@vger.kernel.org


On Aug 28, 2013, at 1:04 PM, Kumar Gala wrote:

> 
> On Aug 27, 2013, at 7:12 PM, Stephen Boyd wrote:
> 
>> Let's follow the ratified DT binding and use uartdm instead of
>> hsuart. This does break backwards compatibility but this
>> shouldn't be a problem because the uart driver isn't probing on
>> these devices without adding clock support (which isn't merged so
>> far).
> 
> I'm not seeing any driver upstream even using the compatibles so might be worth adding that we aren't even breaking anything upstream.
> 
> Otherwise you can add:

Ignore me, not sure what tree I was looking at.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
