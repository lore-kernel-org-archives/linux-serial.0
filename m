From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Wed, 12 Apr 2017 09:24:13 +0300
Message-ID: <52661d42-b418-116a-0ee8-70cd0a24c51d@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170410142214.GA3452@pathway.suse.cz>
 <0514db53-4f8b-fa08-f461-902de85777ee@linaro.org>
 <20170411074325.GC3452@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411074325.GC3452@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 04/11/2017 10:43 AM, Petr Mladek wrote:
> On Mon 2017-04-10 21:00:35, Aleksey Makarov wrote:
>>
>>
>> On 04/10/2017 05:22 PM, Petr Mladek wrote:
>>> On Wed 2017-04-05 23:20:00, Aleksey Makarov wrote:

[..]

>> Thank you for review.  Can you (or anybody else) ACK it?
>> I am going to resend the whole series without those empty lines.
>> May I add your Acked-by:?
> 
> Sure. Feel free to use:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> The meaning of the tags is a bit unclear. Acked-by means that
> the maintainer agrees with the idea. But it does not necessarily
> means that she reviewed the code in details. I agree with the idea
> and did the review, so I used the Reviewed-by tag.
> 
> Also you do not need to resend the patchset just because the two
> empty lines. Sergey agrees. I will wait day or two and push
> all three patches into the printk.git if nobody complains
> in the meantime. I could remove the two empty lines when doing so.

Ok, then I will not resend it.

> Thanks a lot for the fix and patience.

Thank you for reviewing and acking it.
Aleksey Makarov
