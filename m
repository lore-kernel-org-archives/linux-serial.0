From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Thu, 18 Oct 2018 10:51:18 +0530
Message-ID: <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
 <20181016125721.236ada82@gandalf.local.home>
 <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
 <20181016134803.1b9260c1@gandalf.local.home>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017223334.29ca2837@vmware.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 10/18/2018 8:03 AM, Steven Rostedt wrote:
> On Wed, 17 Oct 2018 00:36:05 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> On 10/17/2018 12:33 AM, Steven Rostedt wrote:
>>> On Wed, 17 Oct 2018 00:31:03 +0530
>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>    
>>>> Haa seems like you are right! With "ftrace=function
>>>> ftrace_filter=msm_read" , I can trigger the crash, but
>>>> sadly "ftrace_notrace=msm_read" also crashes.
>>>
>>> So there's more than one problem area.
>>>
>>> What about ftrace_notrace=m*
>>>
>>> ?
>>>    
>>
>> That too crashes.
>>
> 
> So something else is causing an issue besides just msm_read.
> 
> Can you do an objdump -dr of the entire vmlinux binary and gzip it and
> post it somewhere. Not sure if it would be too big to email. You could
> try sending it to me privately. I'd like to see the binary that you are
> using.
> 

I have sent the objdump and dot config to you privately.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
