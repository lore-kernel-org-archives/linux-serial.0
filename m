From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH v2 7/9] arm: twr-k70f120m: use Freescale eDMA driver with
 Kinetis SoC
Date: Wed, 1 Jul 2015 08:54:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507010849390.8255@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl> <1435667250-28299-8-git-send-email-pawelo@king.net.pl> <1650263.FfdEQKm1Bu@wuerfel>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="98048-2106302197-1435733717=:8255"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1650263.FfdEQKm1Bu@wuerfel>
Sender: linux-gpio-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Paul Osmialowski <pawelo@king.net.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--98048-2106302197-1435733717=:8255
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Arnd,

Thanks for pointing this - dma-ranges seem to work properly. This makes 
the patch much simpler. To be included to the next iteration.

I also removed DMA_OF from Kconfig and CONFIG_DMA_OF from my defconfig and 
it was automatically added during preparation of .cofing for build.

On Tue, 30 Jun 2015, Arnd Bergmann wrote:

> On Tuesday 30 June 2015 14:27:28 Paul Osmialowski wrote:
>> Note that <mach/memory.h> is needed (which is denoted by
>> CONFIG_NEED_MACH_MEMORY_H) as it provides macros required for proper
>> operation of DMA allocation functions.
>
> You can't do this, it breaks compilation when multiple platforms
> are enabled.
>
>> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
>> ---
>>  arch/arm/Kconfig                            |  4 ++
>>  arch/arm/boot/dts/kinetis.dtsi              | 34 ++++++++++++++++
>>  arch/arm/mach-kinetis/include/mach/memory.h | 61 +++++++++++++++++++++++++++++
>>  3 files changed, 99 insertions(+)
>>  create mode 100644 arch/arm/mach-kinetis/include/mach/memory.h
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index b21592b..8ccffee 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -971,6 +971,10 @@ config ARCH_KINETIS
>>  	select CLKSRC_KINETIS
>>  	select PINCTRL
>>  	select PINCTRL_KINETIS
>> +	select DMADEVICES
>> +	select FSL_EDMA
>> +	select DMA_OF
>> +	select NEED_MACH_MEMORY_H
>
> I think DMA_OF is implied by dmaengine support in combination with CONFIG_OF
>
>> +
>> +#ifndef _MACH_KINETIS_MEMORY_H
>> +#define _MACH_KINETIS_MEMORY_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +/*
>> + * On Kinetis K70, consistent DMA memory resides in a special
>> + * DDRAM alias region (non-cacheable DDRAM at 0x80000000).
>> + *
>> + */
>> +#define KINETIS_PHYS_DMA_OFFSET UL(0x80000000)
>> +
>> +/*
>> + * Mask of the field used to distinguish DDRAM aliases
>> + */
>> +#define KINETIS_DRAM_ALIAS_MASK UL(0xf8000000)
>
> This should be expressed using the 'dma-ranges' properties in the
> bus nodes above any DMA master, the normal DMA mapping code will
> then do the right thing.
>
> 	Arnd
>
--98048-2106302197-1435733717=:8255
Content-Type: TEXT/x-diff; name=0007-arm-twr-k70f120m-use-Freescale-eDMA-driver-with-Kine.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.2.00.1507010854560.8255@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=0007-arm-twr-k70f120m-use-Freescale-eDMA-driver-with-Kine.patch

RnJvbSBlMGI1NDkxNTFiM2VlOGQ0NDE5MzQ0YTJiNWVmNDYxYmFkMTliMmFm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogUGF1bCBPc21pYWxv
d3NraSA8cGF3ZWxvQGtpbmcubmV0LnBsPg0KRGF0ZTogTW9uLCAyOSBKdW4g
MjAxNSAyMzozNzoyMCArMDIwMA0KU3ViamVjdDogW1BBVENIIDcvOV0gYXJt
OiB0d3ItazcwZjEyMG06IHVzZSBGcmVlc2NhbGUgZURNQSBkcml2ZXIgd2l0
aCBLaW5ldGlzDQogU29DDQoNClNpZ25lZC1vZmYtYnk6IFBhdWwgT3NtaWFs
b3dza2kgPHBhd2Vsb0BraW5nLm5ldC5wbD4NCi0tLQ0KIGFyY2gvYXJtL0tj
b25maWcgICAgICAgICAgICAgICB8ICAyICsrDQogYXJjaC9hcm0vYm9vdC9k
dHMva2luZXRpcy5kdHNpIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9LY29uZmlnIGIvYXJjaC9h
cm0vS2NvbmZpZw0KaW5kZXggYjIxNTkyYi4uODFhNjMyOCAxMDA2NDQNCi0t
LSBhL2FyY2gvYXJtL0tjb25maWcNCisrKyBiL2FyY2gvYXJtL0tjb25maWcN
CkBAIC05NzEsNiArOTcxLDggQEAgY29uZmlnIEFSQ0hfS0lORVRJUw0KIAlz
ZWxlY3QgQ0xLU1JDX0tJTkVUSVMNCiAJc2VsZWN0IFBJTkNUUkwNCiAJc2Vs
ZWN0IFBJTkNUUkxfS0lORVRJUw0KKwlzZWxlY3QgRE1BREVWSUNFUw0KKwlz
ZWxlY3QgRlNMX0VETUENCiAJaGVscA0KIAkgIFRoaXMgZW5hYmxlcyBzdXBw
b3J0IGZvciB0aGUgRnJlZXNjYWxlIEtpbmV0aXMgTUNVcw0KIA0KZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2tpbmV0aXMuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2tpbmV0aXMuZHRzaQ0KaW5kZXggNWZmMWQzYi4uNzVm
YzZkNCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2tpbmV0aXMu
ZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMva2luZXRpcy5kdHNpDQpA
QCAtMTksNiArMTksNDIgQEANCiAJfTsNCiANCiAJc29jIHsNCisJCWRtYS1y
YW5nZXMgPSA8MHg4MDAwMDAwMCAweDAwMDAwMDAwIDB4MDgwMDAwMDA+Ow0K
Kw0KKwkJZWRtYTogZG1hLWNvbnRyb2xsZXJANDAwMDgwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAiZnNsLGtpbmV0aXMtZWRtYSI7DQorCQkJcmVnID0gPDB4
NDAwMDgwMDAgMHgyMDAwPiwgLyogRE1BQyAqLw0KKwkJCQk8MHg0MDAyMTAw
MCAweDEwMDA+LCAvKiBETUFNVVgwICovDQorCQkJCTwweDQwMDIyMDAwIDB4
MTAwMD47IC8qIERNQU1VWDEgKi8NCisJCQkjZG1hLWNlbGxzID0gPDI+Ow0K
KwkJCWRtYS1jaGFubmVscyA9IDwzMj47DQorCQkJaW50ZXJydXB0cyA9CSA8
MD4sICA8MT4sICA8Mj4sICA8Mz4sDQorCQkJCQkgPDQ+LCAgPDU+LCAgPDY+
LCAgPDc+LA0KKwkJCQkJIDw4PiwgIDw5PiwgPDEwPiwgPDExPiwNCisJCQkJ
CTwxMj4sIDwxMz4sIDwxND4sIDwxNT4sDQorCQkJCQk8MTY+Ow0KKwkJCWlu
dGVycnVwdC1uYW1lcyA9ICJlZG1hLXR4LTAsMTYiLA0KKwkJCQkJICAiZWRt
YS10eC0xLDE3IiwNCisJCQkJCSAgImVkbWEtdHgtMiwxOCIsDQorCQkJCQkg
ICJlZG1hLXR4LTMsMTkiLA0KKwkJCQkJICAiZWRtYS10eC00LDIwIiwNCisJ
CQkJCSAgImVkbWEtdHgtNSwyMSIsDQorCQkJCQkgICJlZG1hLXR4LTYsMjIi
LA0KKwkJCQkJICAiZWRtYS10eC03LDIzIiwNCisJCQkJCSAgImVkbWEtdHgt
OCwyNCIsDQorCQkJCQkgICJlZG1hLXR4LTksMjUiLA0KKwkJCQkJICAiZWRt
YS10eC0xMCwyNiIsDQorCQkJCQkgICJlZG1hLXR4LTExLDI3IiwNCisJCQkJ
CSAgImVkbWEtdHgtMTIsMjgiLA0KKwkJCQkJICAiZWRtYS10eC0xMywyOSIs
DQorCQkJCQkgICJlZG1hLXR4LTE0LDMwIiwNCisJCQkJCSAgImVkbWEtdHgt
MTUsMzEiLA0KKwkJCQkJICAiZWRtYS1lcnIiOw0KKwkJCWNsb2NrcyA9IDwm
bWNnX2NjbGtfZ2F0ZSA2IDE+LA0KKwkJCQkgPCZtY2dfcGNsa19nYXRlIDUg
MT4sIDwmbWNnX3BjbGtfZ2F0ZSA1IDI+Ow0KKwkJCWNsb2NrLW5hbWVzID0g
ImVkbWEiLCAiZG1hbXV4MCIsICJkbWFtdXgxIjsNCisJCX07DQorDQogCQlw
b3J0QTogcGlubXV4QDQwMDQ5MDAwIHsNCiAJCQljb21wYXRpYmxlID0gImZz
bCxraW5ldGlzLXBhZGNvbmYiOw0KIAkJCXJlZyA9IDwweDQwMDQ5MDAwIDB4
MTAwMD47DQotLSANCjIuMy42DQoNCg==

--98048-2106302197-1435733717=:8255--
