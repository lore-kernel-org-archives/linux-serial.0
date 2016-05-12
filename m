From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Remove duplicate handling of clocks
Date: Thu, 12 May 2016 10:08:59 +0530
Message-ID: <CANYu_0tdzLEn8PumAPhtMR8hR0uAmjLskpPVV6_RKCKDw7zGJg@mail.gmail.com>
References: <1462957229-17567-1-git-send-email-pramod.gurav@linaro.org>
	<20160512001837.GJ3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160512001837.GJ3492@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, gregkh@linuxfoundation.org, David Brown <davidb@codeaurora.org>, jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12 May 2016 at 05:48, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/11, Pramod Gurav wrote:
>> msm_serial driver provides a .pm callback to the serial core to enable
>> and disable clock resource in suspend/resume path. This function is
>> also called before msm_startup. msm_startup also enables the clocks which
>> is not needed. Hence remove the duplcate clock operation from msm_startup
>> and msm_shutdown. Same is done in console setup to get rid of duplicate
>> clock operation.
>
> I had to check and I see that for the console case we call the
> .pm callback and don't turn it off until suspend/resume paths
> (would be nice to add suspend/resume to this driver too). I
> guess that's what you meant by this last sentence?
>
Yes the clocks would be kept ON if its console.
I am working to add suspend/resume and runtime pm as it will not
happen by default through core.
>>
>> Tested on DB410C console.
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
