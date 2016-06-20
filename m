From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] tty: serial: msm: Don't reconfigure same baud rate
Date: Mon, 20 Jun 2016 16:54:25 -0700
Message-ID: <20160620235425.GA1521@codeaurora.org>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
 <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/16, Bjorn Andersson wrote:
> msm_set_termios() is called whenever the tty is opened. Setting the baud
> rate requires a full reset of the msm serial block, even when the rate
> is unchanged. In the case when the same uart is used as console this
> reset will discard any console output data still being clocked out of
> the TX fifo.
> 
> By skipping the rate-change in the case where the baud rate is unchanged
> since last request we can avoid the reset and the discarding of the
> data.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
