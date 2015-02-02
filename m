From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Sun, 01 Feb 2015 22:27:14 -0500
Message-ID: <54CEEE92.70407@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>	 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>	 <54CE53F3.5040709@hurleysoftware.com> <1422845104.5512.18.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422845104.5512.18.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On 02/01/2015 09:45 PM, Eddie Huang wrote:
> Hi Peter,
> 
> On Sun, 2015-02-01 at 11:27 -0500, Peter Hurley wrote:
>> Hi Eddie,
>>
>> On 01/12/2015 08:08 AM, Eddie Huang wrote:
>>> Add earlycon support not only baudrate option, but also add noinit option.
>>> If use noinit option, 8250 earlycon will not init serial hardware and use
>>> loader setting.
>>
>> I see this went into Greg's tty-testing branch.
>>
>> The only point of this is to not program the divisor, right?
> In this case, yes.
> 
>> I ask because early_serial8250_setup() could already handle this without
>> extra options by simply not doing divisor programming if no baud option is
>> present.
> MTK support high speed UART, which means baudrate can be more than
> 115200. You can reference mtk8250_set_termios() function in 8250_mtk.c.
> Unfortunately, the early_serial8250_setup() can not handle high speed
> case. This is why I add noinit parameter.

Thanks, that's what I thought; I just wanted to verify.

> Besides, I think "no baud option" is a little tricky, and maybe someday
> someone not only care about divisor, but also flow. Legacy earlyprintk
> and other uart drivers like msm_serial.c also don't init uart hardware.

My point is the 8250 earlycon should only be doing hardware initialization
if there is an option string (of the form <baud><parity><bits>), because
if there's no baud option, programming the divisor is pointless.

And to specify any other line control option the baud must be specified.
So to program any other setting would require the proper option string.

Regards,
Peter Hurley
