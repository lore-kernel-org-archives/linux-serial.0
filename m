From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 3 Apr 2015 20:37:54 -0700
Message-ID: <CAE9FiQU2MDuiWKKJo1k3RvkWNAkFTq6_y_fQ220ydt0v9-haWQ@mail.gmail.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
	<CAE9FiQV_TC1Xd6+7e2mHNCEZG8PDTQtZfUoWsWmLhmLnu2CeSQ@mail.gmail.com>
	<551F5742.70508@hurleysoftware.com>
	<CAE9FiQV+8sjq6DSqojQ9vyziPiriqtMVJonW7uevPFHBsjKOWA@mail.gmail.com>
	<551F5B45.6030806@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <551F5B45.6030806@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 3, 2015 at 8:32 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>
>>>> Just now noticed, this patch only fix partial problem. Kernel console is ok.
>>>>
>>>> But later initrd/init scripts revert back to 9600 again.
>>>
>>> Please share the init scripts.
>>
>> I am using opensuse 13.1 rescue disk as ramdisk.
>
> NVM, I know what the problem is.
>

What is NVM here?
