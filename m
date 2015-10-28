From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v13 2/5] uart: pl011: Introduce register accessor
Date: Wed, 28 Oct 2015 11:08:49 -0400
Message-ID: <5630E501.7070506@hurleysoftware.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-3-git-send-email-jun.nie@linaro.org>
 <55FBECCD.2080906@arm.com>
 <CAOZdJXUZDTzEn4f4FGhmKfq7HeEFKPKp4BAbR6_=wXGVw5_0GQ@mail.gmail.com>
 <5630DA2A.4050803@hurleysoftware.com> <5630E0F7.9080705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5630E0F7.9080705@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 10/28/2015 10:51 AM, Timur Tabi wrote:
> On 10/28/2015 09:22 AM, Peter Hurley wrote:
>> EARLYCON_DECLARE(zte, zte_early_console_setup);
>> OF_EARLYCON_DECLARE(zte, ".......", zte_early_console_setup);
>> EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);
>> OF_EARLYCON_DECLARE(sbsa32, "arm,sbsa-uart", sbsa32_early_console_setup);
>>
>> The above assumes that the sbsa32 maintains the equivalence of
>> earlycon and console; ie., that
>>
>> / {
>>     chosen {
>>         stdout-path = &uart0;
>>     };
>>
>>     soc {
>>         uart0: serial@xxxxxx {
>>             compatible = "arm,sbsa-uart";
>>         };
>>     };
>> };
>>
>>
>> will start a sbsa32 earlycon and later replace that with
>> sbsa console.
> 
> I never really understood the device tree support for SBSA. The "S" stands for Server, and ARM Server systems are supposed to use ACPI. It's easy to add special cases via device tree, because of its flexibility.

Agreed.

> ACPI is much more difficult, and that's why I used the command-line approach.

Understood.

> Anyway, I found this alternate patch from Lief Lindholm that implements this idea better, although it needs work:
> 
> https://patches.linaro.org/53265/

Yeah, I saw those, but I'm waiting for v2 to review.

Regards,
Peter Hurley
