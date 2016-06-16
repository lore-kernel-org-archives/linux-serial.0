From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC PATCH] tty: serial: msm_serial: Don't reset uart on
 set_termios
Date: Wed, 15 Jun 2016 18:11:33 -0700
Message-ID: <5761FCC5.3010709@codeaurora.org>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 06/13/2016 12:02 PM, Bjorn Andersson wrote:
> Upon opening the tty, uart_open() ends up calling msm_set_baud_rate()
> which resets the uart block. If this happens as we're coming out of
> msm_console_write() a full fifo worth of console output will be
> discarded.
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> As reported here:
> https://bugs.96boards.org/show_bug.cgi?id=378

Urgh. As mentioned in commit a12f1b406f2d (tty: serial: msm: Reset
uartdm after baud rate change, 2014-10-29) we actually need to reset the
hardware sometimes. Perhaps as discussed over IRC we need to take a
different approach here and only reset the hardware if the baud actually
changes? One way to test this would be to try running a getty on the
console and see if input still works.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
