From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Fri, 19 Oct 2018 20:18:19 +0530
Message-ID: <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019095122.0f1c0946@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 10/19/2018 7:21 PM, Steven Rostedt wrote:
> On Fri, 19 Oct 2018 12:24:05 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>>>> Anyone see any problems here?
>>>
>>> This seems sane to me, he says in the other thread that he put 'notrace' to
>>> the msm serial functions (which AIUI should prevent ftrace instrumentation)
>>> and he still sees the issue.
>>>    
>>
>> Yes I did add notrace to all functions in msm serial and checked the
>> objdump to make sure that those were not instrumented, and yet the
>> target crashed. This doesnt seem like an issue with ftrace but rather
>> with msm early con.
> 
> The thing that still bothers me is that it boots fine without ftrace
> running, and that it requires tracing something to cause the problem.
> This tells me that ftrace has something to do with it. Perhaps it's
> just changing the timing.
> 

Yes tracing does cause issue but only if earlycon is present. If I 
disable earlycon, then even tracing wont cause any issue and target 
boots fine.

> You said that if you add 'ftrace_filter=msm_read' to the command line,
> it still crashes?
> 
> So only tracing that function we have an issue, right?
> 

Tracing msm_read does cause the crash, but that is not the only one 
causing the crash because even after "ftrace_notrace=msm_read" the board 
crashes which is why I suspect msm earlycon and not ftrace.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
