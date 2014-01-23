From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Thu, 23 Jan 2014 19:47:56 +0100
Message-ID: <52E163DC.1090002@samsung.com>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
 <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
 <20140120100530.GY15937@n2100.arm.linux.org.uk>
 <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
 <20140123180423.1a62611a@www.etchedpixels.co.uk>
 <20140123184022.GC11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140123184022.GC11727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On 23.01.2014 19:40, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 06:04:23PM +0000, Alan Cox wrote:
>
>> We can then enable that config option for ARM (and in time for any other
>> architecture that turns out to need/want it). Eventually it can go away
>> (not that its exactly doing any harm if it doesnt).
>
> We'd need to leave it user selectable rather than enabling it for ARM,
> the whole reason this got noticed is that people are trying to build
> kernels that support a wider range of devices for ARM.

What about making it depend on !MULTIPLATFORM and enabled by default?

Best regards,
Tomasz
