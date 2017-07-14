From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Fri, 14 Jul 2017 14:58:08 +0100
Message-ID: <73a13c55-367f-12c2-94c1-5e0101e74068@imgtec.com>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
 <20170707044537.GB7478@jagdpanzerIV.localdomain>
 <0212d098-e307-2ea1-cb41-1e81d545da56@imgtec.com>
 <20170711124308.GA3393@pathway.suse.cz>
 <86ff1193-8485-4b14-492f-627720c1d868@imgtec.com>
 <20170712111117.GD3393@pathway.suse.cz>
 <20170714124026.GA32632@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170714124026.GA32632@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 14/07/17 13:40, Petr Mladek wrote:
> On Wed 2017-07-12 13:11:17, Petr Mladek wrote:
>> On Tue 2017-07-11 15:41:50, Matt Redfearn wrote:
>>> On 11/07/17 13:43, Petr Mladek wrote:
>>>> IMHO, the reasonable solution is to move early console code and data
>>>> out of the init sections. We should do this for the early consoles
>>>> where the corresponding real console is registered using a deferred
>>>> probe. Others should be already replaced by the real console when
>>>> printk_late_init() is called. At least this is how I understand it.
>>> This seems like the most reasonable way forward to me as well,
>>> though sadly will lead to some post-init kernel bloat.
>>>
>>> I still think, however, that this patch is a reasonable change to
>>> make.
>> The thing is that this patch "silently" makes the keep_bootcon
>> option almost unusable.
> I was wrong here. I thought that most early consoles used the init
> section. It was mentioned somewhere and I looked a wrong way.
> But this is not true. In fact, it seems that there are
> only few of them. Most early consoles have struct console
> and the write() callback in the normal section that is preserved.
>
> Matt's patch and the keep_bootcon option makes sense to me
> after all. Let me to resend Matt's patch with some small
> improvements and one more patch that improves the check
> of early consoles that use init section. I'll keep Matt
> as the author of the first patch.

Thanks for looking into this and your fix Petr!

Matt

>
> Best Regards,
> Petr
>   
