From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier
 console
Date: Thu, 24 Aug 2017 11:32:25 +0200
Message-ID: <62daa70c-0c6f-7628-efa4-308cfe93709c@xilinx.com>
References: <1503487221-17950-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <20170823232424.GA9546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823232424.GA9546@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi, +Linus

On 24.8.2017 01:24, Greg KH wrote:
> On Wed, Aug 23, 2017 at 04:50:21PM +0530, Shubhrajyoti Datta wrote:
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> I can't take patches without any changelog text at all :(

ok. I see you have also commented this.

Anyway this is kind of old discussion about moving serial drivers to
arch_initcall from module_init.

There is one patch in the tree.

commit 4dd9e742df98f8f600b4302d3adbb087a68237f7
Author:     Alessandro Rubini <rubini@gnudd.com>
AuthorDate: Tue May 5 05:54:13 2009 +0100
Commit:     Russell King <rmk+kernel@arm.linux.org.uk>
CommitDate: Sun May 31 14:58:11 2009 +0100

    [ARM] 5505/1: serial amba-pl011: move to arch_initcall for earlier
console

    Signed-off-by: Alessandro Rubini <rubini@unipv.it>"
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


and then there was one patch (also sent to linux-serial but don't have link)
https://patches.linaro.org/patch/14633/

where that discussion wasn't finished.


There is one more patch which does that without real description for
this change.
commit ce87122911f8db59d3c2bc355c694c7a38940804
Author:     Vladimir Murzin <vladimir.murzin@arm.com>
AuthorDate: Tue Jun 7 16:02:37 2016 +0100
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Sat Jun 25 14:01:57 2016 -0700

    serial: mps2-uart: make driver explicitly non-modular


Most of drivers are using module_init and only some of them arch_initcall.

Thanks,
Michal
