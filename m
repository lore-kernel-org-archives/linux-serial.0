From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
Date: Fri, 20 Apr 2018 10:22:41 +0200
Message-ID: <c53b19818748ec4c179970c5d53a89d3@agner.ch>
References: <20180416153502.11814-1-stefan@agner.ch>
 <581f0f26d7191aa3355a6c63b531f876@agner.ch>
 <20180420060315.ob6eygfcibwq7f24@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420060315.ob6eygfcibwq7f24@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 20.04.2018 08:03, Uwe Kleine-König wrote:
> Hello Stefan,
> 
> On Thu, Apr 19, 2018 at 11:37:23PM +0200, Stefan Agner wrote:
>> On 16.04.2018 17:35, Stefan Agner wrote:
>> > To reset the UART the SRST needs be cleared (low active). According
>> > to the documentation the bit will remain active for 4 module clocks
>> > until it is cleared (set to 1).
>> >
>> > Hence the real register need to be read in case the cached register
>> > indcates that the SRST bit is zero.
>> >
>> > This bug lead to wrong baudrate because the baud rate register got
>> > restored before reset completed in imx_flush_buffer.
>>
>> Given that you reviewed my other patch rather quickly, you might have
>> overlooked this one?
> 
> no I didn't, still the ping was justified. I didn't look into it at once
> because I didn't feel like opening the refman.
>  
>> Since it is a regression, this should go into v4.17 still...
> 
> That's right,
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I wonder what is different on your side that made it break. I didn't see
> any breakage and tested that on a handful of different machines.

I observed it on a i.MX 6DualLite, UART in DTE mode...

It did work on a i.MX 7Dual just fine for me too. Probably bus clock
etc. dependent...

--
Stefan

> 
> Best regards
> Uwe
