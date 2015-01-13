From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] tty: serial: msm_serial: code cleanup in msm_console_setup
Date: Mon, 12 Jan 2015 16:24:16 -0800
Message-ID: <54B465B0.6080206@codeaurora.org>
References: <1421070332-24420-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1421070332-24420-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/12/2015 05:45 AM, Pramod Gurav wrote:
> The change does following:
>  - baud, flow, bits, parity were being overwritten as they were
>    being reinitialized after parsing.  Initialize them when they are
>    declared so that user provided setting are not overwritten.
>  - msm_set_baud_rate() is anyway called in uart_set_options when it calls
>    msm_set_termios(). msm_reset() is called when we change the baud rate.
>    Hence doing away with both of these calls.
>  - CR_CMD_PROTECTION_EN and CR_TX_ENABLE settings are done in msm_set_baud_rate.
>    So do away with this here.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
