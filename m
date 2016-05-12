From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm: Remove duplicate handling of clocks
Date: Wed, 11 May 2016 17:18:37 -0700
Message-ID: <20160512001837.GJ3492@codeaurora.org>
References: <1462957229-17567-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462957229-17567-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: andy.gross@linaro.org, gregkh@linuxfoundation.org, davidb@codeaurora.org, jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/11, Pramod Gurav wrote:
> msm_serial driver provides a .pm callback to the serial core to enable
> and disable clock resource in suspend/resume path. This function is
> also called before msm_startup. msm_startup also enables the clocks which
> is not needed. Hence remove the duplcate clock operation from msm_startup
> and msm_shutdown. Same is done in console setup to get rid of duplicate
> clock operation.

I had to check and I see that for the console case we call the
.pm callback and don't turn it off until suspend/resume paths
(would be nice to add suspend/resume to this driver too). I
guess that's what you meant by this last sentence?

> 
> Tested on DB410C console.
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
