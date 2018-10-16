From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Wed, 17 Oct 2018 00:31:03 +0530
Message-ID: <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016144123.24c47b38@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 10/17/2018 12:11 AM, Steven Rostedt wrote:
> On Tue, 16 Oct 2018 23:55:14 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> On 10/16/2018 11:46 PM, Steven Rostedt wrote:
>>>
>>> [ Removed ivan.ivanov@linaro.org due to getting mail delivery errors ]
>>>
>>> On Tue, 16 Oct 2018 23:35:00 +0530
>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>    
>>>> Ok got it, this sounds fun. I'll give it a try.
>>>
>>> Awesome, I'm looking forward to seeing what you come up with.
>>>    
>>
>> Now, I can trigger this crash reboot with "ftrace=function
>> ftrace_filter=f*,g*,h*,i*,j*,k*,l*,m*,n*,o*,p*,q*"
> 
> Does it crash with just "f*" or "g*" or any singularity of the above?
> 
> Hmm, I wonder if it is from tracing msm_read?
> 

Haa seems like you are right! With "ftrace=function 
ftrace_filter=msm_read" , I can trigger the crash, but
sadly "ftrace_notrace=msm_read" also crashes.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
