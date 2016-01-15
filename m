From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 21:35:22 +0100
Message-ID: <2F29C78B-8895-4065-A7D9-19F40BA3BF16@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com> <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115194022.GA8371@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115194022.GA8371@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Rutland <mark.rutland@arm.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org


Am 15.01.2016 um 20:40 schrieb Pavel Machek <pavel@ucw.cz>:

> On Fri 2016-01-15 10:34:51, H. Nikolaus Schaller wrote:
>> Hi Mark,
>> 
>> Am 13.01.2016 um 20:15 schrieb Mark Rutland <mark.rutland@arm.com>:
>> 
>>> On Tue, Jan 12, 2016 at 02:28:00PM +0100, H. Nikolaus Schaller wrote:
>>>> Hi Tomeu,
>>>> 
>>>> Am 12.01.2016 um 14:06 schrieb Tomeu Vizoso <tomeu@tomeuvizoso.net>:
>>>> 
>>>>> On 11 May 2015 at 03:56, NeilBrown <neil@brown.name> wrote:
>>>>>> Hi all,
>>>>>> here is version 4 of my "UART slave device" patch set, previously
>>>>>> known as "tty slave devices".
>>>>> 
>>>>> Hi Neil,
>>>>> 
>>>>> do you (or someone else) have plans to continue this work in the short
>>>>> or medium term?
>>>> 
>>>> yes, there is something in our upstreaming pipeline. This one works for us on top of 4.4.0:
>>>> 
>>>> <http://git.goldelico.com/?p=gta04-kernel.git;a=shortlog;h=refs/heads/work/hns/misc/w2sg-tty-slave2-v4>
>>>> 
>>>> There is one point still to be solved: the exact style of the DT bindings.
>>>> 
>>>> We have an idea how a driver can implement two different styles (child node AND phandle)
>>>> so that it is up to the DTS developer to use the one that best fits into the existing DTS.
>>> 
>>> From my perspective as a binding maintainer, and as I stated before, the
>>> child node approach made the most sense and was most consistent with the
>> 
>>> way we handle other devices.
>> 
>> I simply don't see that this is the most common way other devices
>> are handled.
> 
> You promised to shut up once maintainers speak, that happened, and you
> did not shut up. Just do it now.

Nobody has asked for your unqualified and not helpful comments.

So please shut up yourself and stop to disturb Free Software projects.
