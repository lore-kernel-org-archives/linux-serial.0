From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 23:06:24 +0530
Message-ID: <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
 <20181016125721.236ada82@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016125721.236ada82@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 10/16/2018 10:27 PM, Steven Rostedt wrote:
> 
> OK, can you add to the command line:
> 
>   ftrace=function ftrace_filter=*schedule*
> 
> to see if it's a specific function that may be causing the issue (but
> hopefully it's not one of the scheduling functions that caused it).
> 

Target boots fine with this. So its not scheduling functions that is 
causing it. Also I tried with ftrace_filter=*msm* just to be sure if
tracing driver functions is causing any issue but its NOT.


>>> Does it break if the crypto is not initialized? Perhaps add a command
>>> line flag to have it happen earlier:
>>>   
>>
>> I didnt see any breakage, have been using ramoops with postcore_initcall
>> for sometime now.
>>
>>>    ramoops=earlyinit
>>>
>>> and add a postcore_initcall that checks if that flag is set, and if so,
>>> it does the work then, and the late_initcall() will do nothing.
>>>
>>> That way, you can still have unmodified kernels use pstore when it
>>> crashes at boot up.
>>>    
>>
>> Sounds good.
> 
> Great, I guess you can write a patch to do that ;-)
> 

Sure I can :) but as Kees said it would be better if we could
find a way to make it work with a late initialization of compression.
I will try on that.

Thanks,

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
