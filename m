From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 03 Apr 2015 23:32:21 -0400
Message-ID: <551F5B45.6030806@hurleysoftware.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>	<CAE9FiQV_TC1Xd6+7e2mHNCEZG8PDTQtZfUoWsWmLhmLnu2CeSQ@mail.gmail.com>	<551F5742.70508@hurleysoftware.com> <CAE9FiQV+8sjq6DSqojQ9vyziPiriqtMVJonW7uevPFHBsjKOWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQV+8sjq6DSqojQ9vyziPiriqtMVJonW7uevPFHBsjKOWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/03/2015 11:24 PM, Yinghai Lu wrote:
> On Fri, Apr 3, 2015 at 8:15 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/03/2015 11:09 PM, Yinghai Lu wrote:
>>> On Fri, Apr 3, 2015 at 7:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> On Fri, Apr 3, 2015 at 5:04 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> Restore undocumented behavior of kernel command line parameters of
>>>>> the forms:
>>>>>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>>>>>     console=uart[8250],<addr>[,options]
>>>>> where 'options' have not been specified; in this case, the hardware
>>>>> is assumed to be initialized.
>>>>
>>>>
>>>> This patch fix regression for the hand over.  Thanks.
>>>
>>> Just now noticed, this patch only fix partial problem. Kernel console is ok.
>>>
>>> But later initrd/init scripts revert back to 9600 again.
>>
>> Please share the init scripts.
> 
> I am using opensuse 13.1 rescue disk as ramdisk.

NVM, I know what the problem is.
