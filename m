From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Fri, 31 Jan 2014 16:04:36 +0100
Message-ID: <52EBBB84.9050705@gmail.com>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org> <CACRpkdZNe0L+yZnqrY51Oeg+k5NHXebJAiqxi+p5Scy-BQ2+1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZNe0L+yZnqrY51Oeg+k5NHXebJAiqxi+p5Scy-BQ2+1w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 13/01/2014 14:39, Linus Walleij wrote:
> On Thu, Nov 7, 2013 at 10:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> This passes the errata fix using a GPIO to control the RTS pin
>> on one of the AT91 chips to use gpiolib instead of the
>> AT91-specific interfaces. Also remove the reliance on
>> compile-time #defines and the cpu_* check and rely on the
>> platform passing down the proper GPIO pin through platform
>> data.
>>
>> This is a prerequisite for getting rid of the local GPIO
>> implementation in the AT91 platform and move toward
>> multiplatform.
>>
>> The patch also adds device tree support for getting the
>> RTS GPIO pin from the device tree on DT boot paths.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v3->v4:
> 
> ARM SoC folks, if you're not taking this in through the <timex.h> removal
> series then please ACK this patch so I can take it through the GPIO
> tree instead (unless you want to apply this single patch, which would
> be even better, you have Greg's ACK in this thread).
> 
I can't find this patch in linux-next, did I missed something ?


