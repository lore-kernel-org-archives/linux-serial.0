From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Thu, 15 Nov 2018 16:03:29 +0530
Message-ID: <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
 <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
 <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org>
 <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 11/13/2018 3:14 PM, Srinivas Kandagatla wrote:
> Hi Sai,
> 
> 
> 
> On 25/10/18 15:36, saiprakash.ranjan@codeaurora.org wrote:
>> "If I disable dma node and LS-UART0, then I don't see any crash and
>> ftrace also works fine"
>>
>> And one more observation is that even without ftrace cmdline, if I use
>> earlycon and disable dma, I face the same crash.
>>
>> So basically this seems to be some kind of earlycon and dma issue and
>> not ftrace(I can be wrong).
>>
>> So adding Srinivas for more info on this dma node.
> 
> Its Interesting that my old email conversations with SBoyd show that I 
> have investigated this issue in early 2016!
> 
> My analysis so far:
> 
> This reason for such behavior is due the common iface clock
> (GCC_BLSP1_AHB_CLK) across multiple drivers(serial ports, bam dma
> and other low speed devices).
> The code flow in DB410C is bit different, as the uart0 is first
> attempted to set as console and then uart1, this ordering triggers
> pm state change uart_change_pm(state, UART_PM_STATE_OFF) from serial
> core while setting up uart0, this would go and disable all the
> clocks for uart0.
> As uart1 is not setup Yet, and earlycon is still active, any
> attempts by earlycon to write to registers would trigger a system
> reboot as the clock was just disabled by uart0 change_pm code.
> 
> This can even be triggered with any drivers like spi which uses same
> clock I guess.
> 
> Hope it helps,
> 
> Either earlycon needs to reference the clocks or those clocks needs to
> be marked always-on (but only with earlycon).
> 
>>
>> Also just for a note: apq8096-db820c.dtsi shows UART0 is disabled because
>> bootloader does not allow access to it. Could this also be the case 
>> for db410c?
> No, this is not the case with DB410c. DB820c has added restrictions in 
> TZ, I think new booloaders should have solved this issue.
> 
> 

Hi Srinivas,

Thanks a lot for pointing out the cause of crash.
I just tried setting GCC_BLSP1_AHB_CLK with flag CLK_IS_CRITICAL and the
crash disappears.

But I suppose setting CLK_IS_CRITICAL is not the solution?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
