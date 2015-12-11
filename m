From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH] serial: earlycon: Initialize uart_port spinlock
Date: Fri, 11 Dec 2015 08:28:27 -0800
Message-ID: <CAJAp7Ogv-2y2WTewtYK0JwEYvNkh+u8U91MfxpPLoz__bcsT2Q@mail.gmail.com>
References: <1449796126-14906-1-git-send-email-bjorn.andersson@sonymobile.com>
	<CAL_Jsq+Tam+vo46LvPUqJ_o6EueBsYJ4RQx=3MbhD+AZTNHNWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+Tam+vo46LvPUqJ_o6EueBsYJ4RQx=3MbhD+AZTNHNWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 10, 2015 at 6:35 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Dec 10, 2015 at 7:08 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>> Initialize the uart_port spinlock of earlycon to avoid the BUG() when
>> booting with spinlock debug enabled.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Same patch[1] should already be in Greg's queue.
>
> Rob
>
> [1] https://lkml.org/lkml/2015/11/27/165
>

Thanks, missed that one.

Regards,
Bjorn
