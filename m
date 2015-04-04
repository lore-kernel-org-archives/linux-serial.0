From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 3 Apr 2015 20:09:04 -0700
Message-ID: <CAE9FiQV_TC1Xd6+7e2mHNCEZG8PDTQtZfUoWsWmLhmLnu2CeSQ@mail.gmail.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 3, 2015 at 7:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Apr 3, 2015 at 5:04 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> Restore undocumented behavior of kernel command line parameters of
>> the forms:
>>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>>     console=uart[8250],<addr>[,options]
>> where 'options' have not been specified; in this case, the hardware
>> is assumed to be initialized.
>
>
> This patch fix regression for the hand over.  Thanks.

Just now noticed, this patch only fix partial problem. Kernel console is ok.

But later initrd/init scripts revert back to 9600 again.

So the patch does not fix the regression from

commit c7cef0a84912cab3c9df8949b034e4aa62982ec9
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Mon Mar 9 16:27:12 2015 -0400

    console: Add extensible console matching
