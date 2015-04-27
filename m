From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 8250-based SoC serial ports and features
Date: Mon, 27 Apr 2015 09:07:43 -0500
Message-ID: <CAL_JsqLqtmOogeizn2cNFzPe=dwm-f+ZDu2n2TsA82kv85YBoA@mail.gmail.com>
References: <CAGhQ9Vw5hJKX+wrhV91mGmB00eUJKaR8Astns8rpk465BQnv1Q@mail.gmail.com>
 <9563845.vZY1xECvNe@wuerfel> <CAGhQ9VyrnPrgzqtkTN5V7zpSQQ6QhmQdpQi5Sc1eTkcQnxKZXw@mail.gmail.com>
 <6085099.eeiYtUGZgl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6085099.eeiYtUGZgl@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 25, 2015 at 3:08 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Saturday 25 April 2015 16:33:18 Joachim Eastwood wrote:
>>
>> One other question: What is the preferred way of describing different
>> UART SoC features in DT?
>> 16550a is used as base on most NXP Cortex-M devices, but each UART can
>> have different features like; IRDA, Smart card, RS485, sync mode
>> (USART), DMA, hardware RTS/CTS pins and full modem pins.
>> Features also differ between UARTs on the same device.
>>
>> I am thinking about either using different comp strings or some kind
>> of feature flags in DT. (Freescale UART already uses feature flags
>> like: "fsl,irda-mode" and "fsl,uart-has-rtscts")
>
> I would probably specify both then, to give more flexibility to the
> driver in implementing it one way or the other.
>
>> All UARTs on LPC1850 have RS485 and DMA support. In additional you have:
>> UART0,2,3: sync mode and smart card.
>> UART3: IRDA
>> UART1: full modem control pin set.
>>
>> Comp strings could be something like:
>> "nxp,lpc1850-usart" <- sync+smart card
>> "nxp,lpc1850-usart-irda" <- sync+smart card+irda
>> "nxp,lpc1850-uart-modem" <- modem-pins

I'd only consider going this route if the UARTs are hard wired in the
chip for these functions. But use of full modem signals is almost
always optional.

>> or feature flags like:
>> nxp,sync-mode;
>> nxp,rs485-mode;
>> nxp,smart-card;
>> nxp,irda-mode;
>> nxp,full-modem;
>
> For cases where a single chip has uarts with different features,
> using feature flags makes most sense, you can probably skip
> assigning different compatible strings there.

Agreed. I would add that if you find vendor specific flags like this
that you also need, drop the vendor prefix and create something
generic.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
