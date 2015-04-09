From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 2/2] tty: serial: msm: Disable pclk when port is closed
Date: Thu, 9 Apr 2015 07:04:20 -0700
Message-ID: <20150409140420.GA9663@codeaurora.org>
References: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org>
 <1428499733-21963-2-git-send-email-gpramod@codeaurora.org>
 <5525BF1D.3050408@codeaurora.org>
 <28dae70b3f6435d2e0178c31154af9f5.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28dae70b3f6435d2e0178c31154af9f5.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/09, Pramod Gurav wrote:
> 
> On Thu, April 9, 2015 5:21 am, Stephen Boyd wrote:
> >
> > It's not clear to me at all when this clock is enabled and when it's
> > disabled during the lifetime of this driver. For example, why do we have
> > a .pm op to turn clocks on and off? Shouldn't they already be on? Can
> > you please explain when the clocks are turned on and off and what
> > userspace actions cause that to happen? Looking at drivers like
> > amba-pl010.c I don't see any .pm op, just a
> > clk_prepare_enable/clk_disable_unprepare pair in the startup and
> > shutdown ops.
> 
> 
> When a userspce opens a serial port the uart_startup (in serial_core)
> function is executed which changes the uart_pm state to UART_PM_STATE_ON.
> So when this port is release/closed by the application
> uart_close(serial_core) changes the uart_pm state to UART_PM_STATE_OFF if
> its not console. But it is not done in uart_shutdown function.
> 
> So ideally clk_prepare_enable/clk_disable_unprepare must be called in .pm
> only. So, we can get rid of these operations from msm_startup function as
> these will be called anyway using .pm ops.
> 
> About .pm in uart_ops, there are few drivers which have it for an example,
> atmel_serial, sh-sci etc. That is where they do
> clk_prepare_enable/clk_disable_unprepare. And moreover when there is
> suspend across system these function will handled through .pm.

Ok. If the .pm op is called at the right time then it seems to be
possible to drop the clock operations from startup/shutdown. Do
other drivers hook the .pm op to do runtime PM as well? Because
it would be nice to move this driver to use runtime PM sometime
in the future as well. 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
