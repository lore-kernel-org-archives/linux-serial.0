From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Wed, 5 Apr 2017 21:26:08 +0300
Message-ID: <7895d9ed-cd39-8f22-bf03-341665e19501@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
 <20170327141432.GH2846@pathway.suse.cz>
 <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
 <20170328020404.GA10573@jagdpanzerIV.localdomain>
 <20170328125657.GJ2846@pathway.suse.cz>
 <20170330055546.GD513@jagdpanzerIV.localdomain>
 <20170404111202.GK29537@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404111202.GK29537@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 04/04/2017 02:12 PM, Petr Mladek wrote:
> On Thu 2017-03-30 14:55:46, Sergey Senozhatsky wrote:
>> On (03/28/17 14:56), Petr Mladek wrote:

[..]

> Alekesey, any chance to use the global variable to count used or point
> to the last element?
>
> I know that you have already spent a lot of time with it. It was great
> work. But the current solution of the cycle looks weird to me.

Sorry for the delay.  I will send next version soon.

Thank you
Aleksey Makarov
