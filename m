From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [RESEND PATCH v2] ARM: debug: add support for Palmchip BK-310x
 UART
Date: Wed, 27 Jan 2016 00:44:44 +0000
Message-ID: <yw1x1t93lukj.fsf@unicorn.mansr.com>
References: <569CA203.6050001@sigmadesigns.com> <7h60yfn9c6.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7h60yfn9c6.fsf@baylibre.com> (Kevin Hilman's message of "Tue, 26
 Jan 2016 16:40:25 -0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, arm-soc <arm@kernel.org>, linux-serial <linux-serial@vger.kernel.org>, Sebastian Frias <sebastian_frias@sigmadesigns.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
List-Id: linux-serial@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>
>> From: Mans Rullgard <mans@mansr.com>
>>
>> Some SoCs use a Palmchip BK-310x UART which is mostly 16550 compatible
>> but with a different register layout.
>
> ... because UART register layout is where we really need innovation. ;)
>
>> While this UART has previously
>> only been supported in MIPS based chips (Alchemy, Ralink), the ARM based
>> SMP87xx series from Sigma Designs also uses it.
>>
>> This patch allows the debug console to work with this type of UART.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> It appears this was previously acked by Arnd also?
> https://lkml.org/lkml/2015/11/9/116
>
>> ---
>> Peter, this is the patch I've been using on Tango for earlyprintk suppor=
t.
>> arm-soc, this is just the Nov 8 patch with my Signed-off-by tag.
>> ---
>>  arch/arm/Kconfig.debug            |  9 +++++++++
>>  arch/arm/include/debug/palmchip.S | 11 +++++++++++
>>  2 files changed, 20 insertions(+)
>>  create mode 100644 arch/arm/include/debug/palmchip.S
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 259c0ca9c99a..708aa9150c00 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1304,6 +1304,7 @@ config DEBUG_SIRFSOC_UART
>>  config DEBUG_LL_INCLUDE
>>  	string
>>  	default "debug/sa1100.S" if DEBUG_SA1100
>> +	default "debug/palmchip.S" if DEBUG_UART_8250_PALMCHIP
>
> minor nit: We're trying (not always with great success) to keep various
> parts of this file sorted alphanumerically.  Can you please insert the
> new entries accordingly?

It has to precede the regular 8250 entry so as to take precedence over
that.

> Otherwise looks good to me,
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> Kevin

-- =

M=E5ns Rullg=E5rd
