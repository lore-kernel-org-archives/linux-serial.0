From: "Pramod Gurav" <gpramod@codeaurora.org>
Subject: Re: [PATCH v3 2/3] tty: serial: msm: Remove duplicate operations on
 clocks in startup/shutdown
Date: Wed, 29 Apr 2015 21:15:56 +0530
Message-ID: <f656bf979fb566091a3b8c6cc06712c2.squirrel@www.codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
    <1428668396-6955-2-git-send-email-gpramod@codeaurora.org>
    <55281068.3000309@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55281068.3000309@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, bryanh@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

Thanks Stephen for review.

On Fri, April 10, 2015 11:33 pm, Stephen Boyd wrote:
> On 04/10/15 05:19, Pramod Gurav wrote:
>> @@ -683,8 +679,7 @@ static void msm_power(struct uart_port *port,
>> unsigned int state,
>>
>>  	switch (state) {
>>  	case 0:
>> -		clk_prepare_enable(msm_port->clk);
>> -		clk_prepare_enable(msm_port->pclk);
>> +		msm_init_clock(port);
>
> Hm... now we would call msm_serial_set_mnd_regs() whenever we power on
> the port? Presumably we only need to do that once when we probe (or when
> we resume from a sleep state that resets the registers, i.e.
> hibernation) but I guess we're getting saved by the fact that the
> if/else if pair in msm_serial_set_mnd_regs_from_uartclk would never be
> true after the first time we call it?

I tried replacing msm_init_clock() call with msm_serial_set_mnd_regs() in
msm_startup() as msm_startup gets called just after msm_power() so that
clk_prepare_enable() is followed by mnd settings. But it does not get the
kernel booted for some reason.

So, can I get a acked-by for this patch or you still think it can be done
in a better way?
>
>>  		break;
>>  	case 3:
>>  		clk_disable_unprepare(msm_port->clk);
>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
