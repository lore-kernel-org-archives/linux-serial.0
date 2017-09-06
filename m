From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier
 console
Date: Wed, 6 Sep 2017 14:43:40 +0200
Message-ID: <72a8ba54-69fb-5a69-35b3-8c9e277621fb@xilinx.com>
References: <1503487221-17950-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <20170823232424.GA9546@kroah.com>
 <62daa70c-0c6f-7628-efa4-308cfe93709c@xilinx.com>
 <CACRpkdZ2kNxM_MLFTXUy6bVxh5q2a_cFd+kwVWMHmOSDzG-cOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ2kNxM_MLFTXUy6bVxh5q2a_cFd+kwVWMHmOSDzG-cOQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shubhrajyoti.datta@gmail.com
List-Id: linux-serial@vger.kernel.org

On 31.8.2017 14:59, Linus Walleij wrote:
> On Thu, Aug 24, 2017 at 11:32 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 24.8.2017 01:24, Greg KH wrote:
>>> On Wed, Aug 23, 2017 at 04:50:21PM +0530, Shubhrajyoti Datta wrote:
>>>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>>
>>> I can't take patches without any changelog text at all :(
>>
>> ok. I see you have also commented this.
>>
>> Anyway this is kind of old discussion about moving serial drivers to
>> arch_initcall from module_init.
>>
>> There is one patch in the tree.
>>
>> commit 4dd9e742df98f8f600b4302d3adbb087a68237f7
>> Author:     Alessandro Rubini <rubini@gnudd.com>
>> AuthorDate: Tue May 5 05:54:13 2009 +0100
>> Commit:     Russell King <rmk+kernel@arm.linux.org.uk>
>> CommitDate: Sun May 31 14:58:11 2009 +0100
>>
>>     [ARM] 5505/1: serial amba-pl011: move to arch_initcall for earlier
>> console
>>
>>     Signed-off-by: Alessandro Rubini <rubini@unipv.it>"
>>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>>
>> and then there was one patch (also sent to linux-serial but don't have link)
>> https://patches.linaro.org/patch/14633/
>>
>> where that discussion wasn't finished.
> 
> Yeah Alessandro never came back on that.
> 
> I *guess* it is to get the console up really early, simply becaus it is
> quite helpful for spotting early boot problems.


ok. It means no concern about the move to arch_initcall.
Shubhrajyoti: Please send v2 with changelog.

Thanks,
Michal
