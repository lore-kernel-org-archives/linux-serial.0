From: jiwang <jiada_wang@mentor.com>
Subject: Re: Mainline commit "serial: Test for no tx data on tx restart" not
 correct for i.MX6?
Date: Thu, 24 Jul 2014 17:12:33 +0900
Message-ID: <53D0BFF1.30204@mentor.com>
References: <53CF3599.6040509@gmail.com> <53CFE38E.6070302@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:53155 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934120AbaGXIMl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2014 04:12:41 -0400
In-Reply-To: <53CFE38E.6070302@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Huang Shijie <b32955@freescale.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dirk Behme <dirk.behme@de.bosch.com>

Hi Peter

On 07/24/2014 01:32 AM, Peter Hurley wrote:
> Hi Dirk,
>
> On 07/23/2014 12:10 AM, Dirk Behme wrote:
>> Hi,
>>
>> this is a question regarding the i.MX6 part (drivers/tty/serial/imx.c) of the commit
>>
>> serial: Test for no tx data on tx restart
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c557d392fbf5badd693ea1946a4317c87a26a716
>>
>> Talking with some i.MX6 experts about this, I've got the comment
>>
>> -- cut --
>> The imx serial driver part of this commit isn't correct
>> as imx.c sends x_char in irq handler, not in imx_start_tx(),
>> -- cut --
>>
>> What do you think?
> Thanks for the comment.
>
> Yeah, I missed that the imx driver handled x_char _at all_,
> because how the imx driver is handling x_char looks broken.
>
> For example, if data is already in the tx ring buffer,
> imx_start_tx() will send that data before the x_char, and if
> all the tx ring buffer data is sent successfully, the tx
> interrupt is switched back off, so the x_char won't be sent.
imx_start_tx() doesn't do any actual data transfer, it only
switches tx interrupt on, and tx interrupt does the actual data
transfer, so if x_char is pending, it will always be sent before
the data in ring buffer.
> Also, the imx driver doesn't send x_char in dma mode?
Yes, I think so.

Thanks,
Jiada
> Regards,
> Peter Hurley
>

