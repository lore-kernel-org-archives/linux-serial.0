From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] tty: xilinx_uartps: move to arch_initcall for earlier console
Date: Thu, 7 Sep 2017 11:40:26 +0530
Message-ID: <CAKfKVtG2+R3rYODSZ3YwgrB-N=QcnRQVOxqP6JpUvahSO+HB2Q@mail.gmail.com>
References: <1503487221-17950-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <20170823232424.GA9546@kroah.com> <62daa70c-0c6f-7628-efa4-308cfe93709c@xilinx.com>
 <CACRpkdZ2kNxM_MLFTXUy6bVxh5q2a_cFd+kwVWMHmOSDzG-cOQ@mail.gmail.com> <72a8ba54-69fb-5a69-35b3-8c9e277621fb@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <72a8ba54-69fb-5a69-35b3-8c9e277621fb@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

...
>>
>> I *guess* it is to get the console up really early, simply becaus it is
>> quite helpful for spotting early boot problems.
>
>
> ok. It means no concern about the move to arch_initcall.
> Shubhrajyoti: Please send v2 with changelog.

Will do thanks for the review.

>
> Thanks,
> Michal
