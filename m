From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Thu, 5 Dec 2013 17:57:04 +0100
Message-ID: <52A0B060.4040203@atmel.com>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org> <5283A8C7.30904@atmel.com> <529C4936.5060304@atmel.com> <20131204102353.GI29721@pengutronix.de> <20131204170911.GC14859@kroah.com> <20131204191606.GL29721@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:24213 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab3LEQ5R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Dec 2013 11:57:17 -0500
In-Reply-To: <20131204191606.GL29721@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-serial@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, "arm@kernel.org" <arm@kernel.org>

On 04/12/2013 20:16, Uwe Kleine-K=F6nig :
> Hello Greg,
>
> On Wed, Dec 04, 2013 at 09:09:11AM -0800, Greg Kroah-Hartman wrote:
>> On Wed, Dec 04, 2013 at 11:23:53AM +0100, Uwe Kleine-K=F6nig wrote:
>>> Hello Greg, hi Nicolas,
>>>
>>> On Mon, Dec 02, 2013 at 09:47:50AM +0100, Nicolas Ferre wrote:
>>>> On 13/11/2013 17:28, Nicolas Ferre :
>>>>> On 07/11/2013 10:25, Linus Walleij :
>>>>>> This passes the errata fix using a GPIO to control the RTS pin
>>>>>> on one of the AT91 chips to use gpiolib instead of the
>>>>>> AT91-specific interfaces. Also remove the reliance on
>>>>>> compile-time #defines and the cpu_* check and rely on the
>>>>>> platform passing down the proper GPIO pin through platform
>>>>>> data.
>>>>>>
>>>>>> This is a prerequisite for getting rid of the local GPIO
>>>>>> implementation in the AT91 platform and move toward
>>>>>> multiplatform.
>>>>>>
>>>>>> The patch also adds device tree support for getting the
>>>>>> RTS GPIO pin from the device tree on DT boot paths.
>>>>>>
>>>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>>>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.co=
m>
>>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>> You acknowledged a previous version of this patch which was takin=
g a
>>>>> different approach with the subject:
>>>>> "[PATCH 1/4] ARM/serial: at91: move machine quirk into machine"
>>>>>
>>>>> In order to integrate the series build by Linus in our AT91/arm-s=
oc
>>>>> flow, would you mind reviewing this v4 patch and eventually givin=
g your
>>>>> blessing ;-)
>>>>> If it is okay on your side, I'll integrate it in a pull-request t=
o
>>>>> arm-soc for 3.14.
>>>>
>>>> Greg, ping?
>>> I'm depending on that patch for a series that gets rid of ARM's
>>> <mach/timex.h>. So I'm interested to either get a stable commit to
>>> base on or alternatively to get the blessing from both of you to ta=
ke it
>>> (also via arm-soc) as part of my series.
>>>
>>> A preview of my series is available at
>>>
>>> 	git://git.pengutronix.de/git/ukl/linux.git deprecatemachtimexh
>>
>> No objection from me to take it through your tree.
> gregkh: Thanks. I'll interpret this as Acked-by: you if Nicolas also
> agrees that I take it.
>
> nferre: What is your plan with this patch? Do you have patches
> depending on it, too, or is it ok if I take it?

Well, the problem is that your branch generates conflicts with the=20
at91/cleanup one that Olof have just pulled. They are not big conflicts=
,=20
only additions of header files at the same location.
Maybe you can rebase your branch on top of this cleanup branch=20
(arm-soc/next/cleanup: 94c5216ee93b3b4).

But, anyway I feel that it is better if you take the whole series in a =
raw.

Bye,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
