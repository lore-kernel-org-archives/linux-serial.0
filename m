From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Fri, 13 Nov 2015 03:26:01 +0200
Message-ID: <CAHp75VcoJh51ai_35vB_V7exyFwRT0NjKcs=a0TAdaU8+FuzwA@mail.gmail.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
	<1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
	<20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
	<5644F4F2.2080408@hurleysoftware.com>
	<CAHp75Vdv-ycJfgA2xkjS2SrvL8N2vvrBMS-2d4ibBg-yvZying@mail.gmail.com>
	<564538B4.20402@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564538B4.20402@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Matwey V. Kornilov" <matwey@sai.msu.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 13, 2015 at 3:11 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/12/2015 07:41 PM, Andy Shevchenko wrote:
>> On Thu, Nov 12, 2015 at 10:22 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 11/12/2015 02:57 PM, One Thousand Gnomes wrote:
>>
>>> An illustrative (kernel-space) example is the mess that is dmaengine_pause().
>>> Some DMA implementations provide the means to stop and restart DMA without
>>> losing data and some DMA implementations do not. Unfortunately, some
>>> advertise they support dmaengine_pause() but only for lossy uses like audio.
>>> Because the api hides this, the query interface for pause support is
>>> useless.
>>
>> The DMA pause() call means only pause with possibility to resume.
>> There is a resume() call as well. Any driver which treats pause() as a
>> complete stop is buggy driver and should be fixed.
>
> How about pause _without_ the possibility to resume?
>
> https://groups.google.com/d/msg/linux.kernel/Abe0hfGcgsw/H0se55wC558J

Briefly what I got from the thread that Russel shows similar view on
the API, so that's why he was objecting to add pause/resume calls for
a specific hardware.

-- 
With Best Regards,
Andy Shevchenko
