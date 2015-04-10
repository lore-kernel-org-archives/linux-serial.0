From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 2/3] tty: serial: msm: Remove duplicate operations
 on clocks in startup/shutdown
Date: Fri, 10 Apr 2015 11:03:20 -0700
Message-ID: <55281068.3000309@codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org> <1428668396-6955-2-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-2-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/10/15 05:19, Pramod Gurav wrote:
> @@ -683,8 +679,7 @@ static void msm_power(struct uart_port *port, unsigned int state,
>  
>  	switch (state) {
>  	case 0:
> -		clk_prepare_enable(msm_port->clk);
> -		clk_prepare_enable(msm_port->pclk);
> +		msm_init_clock(port);

Hm... now we would call msm_serial_set_mnd_regs() whenever we power on
the port? Presumably we only need to do that once when we probe (or when
we resume from a sleep state that resets the registers, i.e.
hibernation) but I guess we're getting saved by the fact that the
if/else if pair in msm_serial_set_mnd_regs_from_uartclk would never be
true after the first time we call it?

>  		break;
>  	case 3:
>  		clk_disable_unprepare(msm_port->clk);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
