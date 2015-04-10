From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/3] tty: serial: msm: Add mask value for UART_DM registers
Date: Fri, 10 Apr 2015 10:57:08 -0700
Message-ID: <55280EF4.9000100@codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/10/15 05:19, Pramod Gurav wrote:
> The bit masks for RFR_LEVEL1 and STALE_TIMEOUT_MSB values in MR1 and
> IPR registers respectively are different for UART and UART_DM hardware
> cores. We have been using UART core mask values for these. Add the same
> for UART_DM core.
>
> There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
> it only for UART core.
>
> Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
