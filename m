From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Wed, 17 Oct 2018 20:19:41 +0530
Message-ID: <69d2f43d-dc96-9348-7f70-5db88e8f5c39@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
 <20181017101355.GA230639@joelaf.mtv.corp.google.com>
 <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel@joelfernandes.org>, Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 10/17/2018 5:08 PM, Sai Prakash Ranjan wrote:
>>
>> What do you think about the (untested) patch below? It seems to me 
>> that it
>> should solve the issue of missing early crash dumps, but I have not 
>> tested it
>> yet. Sai, would you mind trying it out and let me know if you can see the
>> early crash dumps properly now?
>>
>> ----8<---
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> Subject: [RFC] pstore: allocate compression during late_initcall
>>
>> ramoop's pstore registration (using pstore_register) has to run during
>> late_initcall because crypto backend may not be ready during
>> postcore_initcall. This causes missing of dmesg crash dumps which could
>> have been caught by pstore.
>>
>> Instead, lets allow ramoops pstore registration earlier, and once crypto
>> is ready we can initialize the compression.
>>
>> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>   fs/pstore/platform.c | 13 +++++++++++++
>>   fs/pstore/ram.c      |  2 +-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index 15e99d5a681d..f09066db2d4d 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
>>       }
>>   }
>> +static int __init pstore_compression_late_init(void)
>> +{
>> +    /*
>> +     * Check if any pstore backends registered earlier but did not 
>> allocate
>> +     * for compression because crypto was not ready, if so then 
>> initialize
>> +     * compression.
>> +     */
>> +    if (psinfo && !tfm)
>> +        allocate_buf_for_compression();
>> +    return 0;
>> +}
>> +late_initcall(pstore_compression_late_init);
>> +
>>   module_param(compress, charp, 0444);
>>   MODULE_PARM_DESC(compress, "Pstore compression to use");
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index bbd1e357c23d..98e48d1a9776 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -940,7 +940,7 @@ static int __init ramoops_init(void)
>>       ramoops_register_dummy();
>>       return platform_driver_register(&ramoops_driver);
>>   }
>> -late_initcall(ramoops_init);
>> +postcore_initcall(ramoops_init);
>>   static void __exit ramoops_exit(void)
>>   {
>>
> 
> Yes I could see the early crash dump. Also I tested with different 
> compression (LZO) instead of deflate just to be sure and it works fine, 
> thanks :)
> 
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 

I just noticed that allocate_buf_for_compression() is also called from 
pstore_register(). Shouldn't that call be removed now that ramoops_init 
is moved to postcore_initcall and allocate_buf_for_compression() will 
just return doing nothing when called from pstore_register()?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
