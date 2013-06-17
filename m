From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v2 06/10] clk: exynos5420: register clocks using common
 clock framework
Date: Mon, 17 Jun 2013 14:16:02 +0530
Message-ID: <CANuQgHFwdyGdpBAD8bnQmyyGDK2=3qa7yGQsK=54n6fvocrNkA@mail.gmail.com>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
	<1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
	<1371218572-8993-7-git-send-email-chander.kashyap@linaro.org>
	<CAL1qeaFS=MMHJj8TP4vX8-KeXNo0W_EjvhrLsb5=YNsnaqOVXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63386 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab3FQIqD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 04:46:03 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so3019068oah.25
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 01:46:02 -0700 (PDT)
In-Reply-To: <CAL1qeaFS=MMHJj8TP4vX8-KeXNo0W_EjvhrLsb5=YNsnaqOVXw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Bresticker <abrestic@google.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, Mark Rutland <mark.rutland@arm.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>

On 14 June 2013 22:56, Andrew Bresticker <abrestic@google.com> wrote:
> Hi Chander,
>
>> +       [Core Clocks]
>> +
>> +  Clock                        ID
>> +  ----------------------------
>> +
>> +  oscclk               1
>
> I know the UM refers to this as 'oscclk', but could we instead call
> this 'fin_pll' to be consistent with Exynos 4 and Exynos 5250?
I will rename it to make consistent.
Thanks.
>
> Thanks,
> Andrew



--
with warm regards,
Chander Kashyap
