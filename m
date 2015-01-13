From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] tty: serial_mctrl_gpio: Add irqs helpers for
 input lines
Date: Tue, 13 Jan 2015 15:30:06 +0100
Message-ID: <CACQ1gAipk7mfGdg7fjoGvFaN+1hc8iOhW65i5bkr-avXmtB+8g@mail.gmail.com>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
 <CACQ1gAibCAwWavjhT8VW8WkjEq0qGobQ9qF=pNtHRu1WUaRigA@mail.gmail.com> <54B52304.1030008@elproma.com.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b3a8ec0cb2f23050c89768c
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <54B52304.1030008@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

--047d7b3a8ec0cb2f23050c89768c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015-01-13 14:52 GMT+01:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.pl>:
>
> W dniu 2015-01-13 o 14:04, Richard Genoud pisze:
>
>> 2015-01-10 15:32 GMT+01:00 Janusz Uzycki <j.uzycki@elproma.com.pl>:

>>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
>>> b/drivers/tty/serial/serial_mctrl_gpio.h
>>> index 400ba04..13ba3f4 100644
>>> --- a/drivers/tty/serial/serial_mctrl_gpio.h
>>> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
>>> @@ -21,6 +21,7 @@
>>>   #include <linux/err.h>
>>>   #include <linux/device.h>
>>>   #include <linux/gpio/consumer.h>
>>> +#include <linux/serial_core.h>
>>>
>>>   enum mctrl_gpio_idx {
>>>          UART_GPIO_CTS,
>>> @@ -40,6 +41,13 @@ enum mctrl_gpio_idx {
>>>    */
>>>   struct mctrl_gpios;
>>>
>>> +/*
>>> + * Return true if gidx is GPIO line, otherwise false.
>>> + * It assumes that gpios is allocated and not NULL.
>>> + */
>>> +inline
>>> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_idx
>>> gidx);
>>> +
>>
>> This leads to a compile error :
>>    CC      drivers/tty/serial/atmel_serial.o
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/atmel_serial.c: In function 'atmel_disable_ms.part.22=
':
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:536:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:539:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:542:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:545:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/atmel_serial.c: In function 'atmel_enable_ms':
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:503:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:506:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:509:25: error: called from here
>> In file included from drivers/tty/serial/atmel_serial.c:64:0:
>> drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
>> call to always_inline 'mctrl_gpio_is_gpio': function body not
>> available
>> drivers/tty/serial/atmel_serial.c:512:25: error: called from here
>> make[3]: *** [drivers/tty/serial/atmel_serial.o] Error 1
>> make[2]: *** [drivers/tty/serial] Error 2
>> make[1]: *** [drivers/tty] Error 2
>> make: *** [drivers] Error 2
>
>
> Do you compile atmel_serial as module? I compiled built-in and it was fin=
e
> for me.
> So the function should be exported like mctrl_gpio_to_gpiod() I guess.
> An other reason can be you have CONFIG_GPIOLIB=3Dn ?
> In fact, mctrl_gpio_is_gpio() should depend on CONFIG_GPIOLIB for empty
> body.
>
well, I'm also compiling it built-in (I even have config_module=3DN)
kernel is 3.19-rc3 with your patches ontop.
I attached my .config (saved as a defconfig)

arm-linux-gcc (GCC) 4.7.3

--047d7b3a8ec0cb2f23050c89768c
Content-Type: application/octet-stream; name=defconfig
Content-Disposition: attachment; filename=defconfig
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i4vdjkc50

IyBDT05GSUdfQVJNX1BBVENIX1BIWVNfVklSVCBpcyBub3Qgc2V0CkNPTkZJR19QSFlTX09GRlNF
VD0weDIwMDAwMDAwCkNPTkZJR19LRVJORUxfTFpPPXkKQ09ORklHX0RFRkFVTFRfSE9TVE5BTUU9
ImxucyIKIyBDT05GSUdfU1dBUCBpcyBub3Qgc2V0CkNPTkZJR19TWVNWSVBDPXkKIyBDT05GSUdf
Q1JPU1NfTUVNT1JZX0FUVEFDSCBpcyBub3Qgc2V0CkNPTkZJR19JS0NPTkZJRz15CkNPTkZJR19J
S0NPTkZJR19QUk9DPXkKQ09ORklHX1JFTEFZPXkKQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpF
PXkKQ09ORklHX0tBTExTWU1TX0FMTD15CkNPTkZJR19FTUJFRERFRD15CkNPTkZJR19TTEFCPXkK
Q09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0VGSV9QQVJUSVRJT04gaXMgbm90
IHNldAojIENPTkZJR19JT1NDSEVEX0RFQURMSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9TQ0hF
RF9DRlEgaXMgbm90IHNldApDT05GSUdfQVJDSF9BVDkxPXkKQ09ORklHX1NPQ19BVDkxU0FNOVg1
PXkKQ09ORklHX0FUOTFfVElNRVJfSFo9MTI4CkNPTkZJR19BRUFCST15CiMgQ09ORklHX0NPTVBB
Q1RJT04gaXMgbm90IHNldApDT05GSUdfVUFDQ0VTU19XSVRIX01FTUNQWT15CiMgQ09ORklHX0FU
QUdTIGlzIG5vdCBzZXQKQ09ORklHX1pCT09UX1JPTV9URVhUPTB4MApDT05GSUdfWkJPT1RfUk9N
X0JTUz0weDAKQ09ORklHX0FVVE9fWlJFTEFERFI9eQojIENPTkZJR19DT1JFRFVNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NVU1BFTkQgaXMgbm90IHNldApDT05GSUdfTkVUPXkKQ09ORklHX1BBQ0tF
VD15CkNPTkZJR19QQUNLRVRfRElBRz15CkNPTkZJR19VTklYPXkKQ09ORklHX1VOSVhfRElBRz15
CkNPTkZJR19YRlJNX1VTRVI9eQpDT05GSUdfTkVUX0tFWT15CkNPTkZJR19JTkVUPXkKQ09ORklH
X0lQX1BOUD15CkNPTkZJR19JUF9QTlBfREhDUD15CkNPTkZJR19JTkVUX0FIPXkKQ09ORklHX0lO
RVRfRVNQPXkKQ09ORklHX0lORVRfSVBDT01QPXkKQ09ORklHX0lORVRfVURQX0RJQUc9eQpDT05G
SUdfSU5FVDZfQUg9eQpDT05GSUdfSU5FVDZfRVNQPXkKQ09ORklHX0lORVQ2X0lQQ09NUD15CkNP
TkZJR19ORVRGSUxURVI9eQojIENPTkZJR19ORVRGSUxURVJfQURWQU5DRUQgaXMgbm90IHNldApD
T05GSUdfQlJJREdFPXkKIyBDT05GSUdfQlJJREdFX0lHTVBfU05PT1BJTkcgaXMgbm90IHNldApD
T05GSUdfRE5TX1JFU09MVkVSPXkKQ09ORklHX05FVExJTktfTU1BUD15CkNPTkZJR19ORVRMSU5L
X0RJQUc9eQojIENPTkZJR19XSVJFTEVTUyBpcyBub3Qgc2V0CkNPTkZJR19VRVZFTlRfSEVMUEVS
X1BBVEg9Ii9zYmluL2hvdHBsdWciCkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19N
T1VOVD15CiMgQ09ORklHX1NUQU5EQUxPTkUgaXMgbm90IHNldAojIENPTkZJR19QUkVWRU5UX0ZJ
Uk1XQVJFX0JVSUxEIGlzIG5vdCBzZXQKIyBDT05GSUdfRklSTVdBUkVfSU5fS0VSTkVMIGlzIG5v
dCBzZXQKQ09ORklHX01URD15CkNPTkZJR19NVERfQ01ETElORV9QQVJUUz15CkNPTkZJR19NVERf
TkFORD15CkNPTkZJR19NVERfTkFORF9BVE1FTD15CkNPTkZJR19NVERfVUJJPXkKQ09ORklHX01U
RF9VQklfRkFTVE1BUD15CkNPTkZJR19CTEtfREVWX0xPT1A9eQpDT05GSUdfQkxLX0RFVl9SQU09
eQpDT05GSUdfQkxLX0RFVl9SQU1fQ09VTlQ9NApDT05GSUdfQkxLX0RFVl9SQU1fU0laRT04MTky
CkNPTkZJR19BVE1FTF9UQ0xJQj15CkNPTkZJR19FRVBST01fQVQyND15CkNPTkZJR19FRVBST01f
OTNDWDY9eQpDT05GSUdfU0NTST15CkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfU0NTSV9M
T1dMRVZFTCBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX1RVTj15CiMgQ09O
RklHX05FVF9WRU5ET1JfQVJDIGlzIG5vdCBzZXQKQ09ORklHX01BQ0I9eQojIENPTkZJR19ORVRf
VkVORE9SX0JST0FEQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DSVJSVVMgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0ZBUkFEQVkgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NQVJWRUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkFUU0VN
SSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU0VFUSBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfU01TQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU1RNSUNSTyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1ZFTkRPUl9XSVpORVQgaXMgbm90IHNldApDT05GSUdfREFWSUNPTV9QSFk9eQpDT05GSUdfUFBQ
PXkKQ09ORklHX1BQUF9ERUZMQVRFPXkKQ09ORklHX1BQUF9BU1lOQz15CiMgQ09ORklHX1VTQl9O
RVRfRFJJVkVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU4gaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9NT1VTRURFViBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9FVkRFVj15CiMgQ09ORklHX0lO
UFVUX0tFWUJPQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTU9VU0UgaXMgbm90IHNldApD
T05GSUdfSU5QVVRfTUlTQz15CkNPTkZJR19JTlBVVF9VSU5QVVQ9eQojIENPTkZJR19TRVJJTyBp
cyBub3Qgc2V0CkNPTkZJR19WVF9IV19DT05TT0xFX0JJTkRJTkc9eQojIENPTkZJR19MRUdBQ1lf
UFRZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFVktNRU0gaXMgbm90IHNldApDT05GSUdfU0VSSUFM
X0FUTUVMPXkKQ09ORklHX1NFUklBTF9BVE1FTF9DT05TT0xFPXkKQ09ORklHX0kyQz15CiMgQ09O
RklHX0kyQ19DT01QQVQgaXMgbm90IHNldApDT05GSUdfSTJDX0NIQVJERVY9eQpDT05GSUdfSTJD
X01VWD15CkNPTkZJR19JMkNfQVQ5MT15CkNPTkZJR19JMkNfR1BJTz15CkNPTkZJR19TUEk9eQpD
T05GSUdfU1BJX0FUTUVMPXkKQ09ORklHX1NQSV9TUElERVY9eQpDT05GSUdfR1BJT19TWVNGUz15
CiMgQ09ORklHX0hXTU9OIGlzIG5vdCBzZXQKQ09ORklHX1dBVENIRE9HPXkKQ09ORklHX0FUOTFT
QU05WF9XQVRDSERPRz15CkNPTkZJR19TU0I9eQpDT05GSUdfQkNNQT15CkNPTkZJR19ISURSQVc9
eQpDT05GSUdfVUhJRD15CkNPTkZJR19VU0JfSElEREVWPXkKQ09ORklHX1VTQj15CkNPTkZJR19V
U0JfQU5OT1VOQ0VfTkVXX0RFVklDRVM9eQpDT05GSUdfVVNCX0VIQ0lfSENEPXkKQ09ORklHX1VT
Ql9FSENJX1JPT1RfSFVCX1RUPXkKQ09ORklHX1VTQl9HQURHRVQ9eQpDT05GSUdfVVNCX0FUOTE9
eQpDT05GSUdfVVNCX0FUTUVMX1VTQkE9eQpDT05GSUdfVVNCX0VUSD15CkNPTkZJR19ORVdfTEVE
Uz15CkNPTkZJR19MRURTX0NMQVNTPXkKQ09ORklHX0xFRFNfR1BJTz15CkNPTkZJR19MRURTX1RS
SUdHRVJTPXkKQ09ORklHX0xFRFNfVFJJR0dFUl9USU1FUj15CkNPTkZJR19MRURTX1RSSUdHRVJf
T05FU0hPVD15CkNPTkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUPXkKQ09ORklHX0xFRFNfVFJJ
R0dFUl9HUElPPXkKQ09ORklHX0xFRFNfVFJJR0dFUl9ERUZBVUxUX09OPXkKQ09ORklHX0RNQURF
VklDRVM9eQpDT05GSUdfQVRfSERNQUM9eQojIENPTkZJR19JT01NVV9TVVBQT1JUIGlzIG5vdCBz
ZXQKQ09ORklHX0VYVDRfRlM9eQpDT05GSUdfRkFOT1RJRlk9eQpDT05GSUdfVE1QRlM9eQpDT05G
SUdfVUJJRlNfRlM9eQpDT05GSUdfVUJJRlNfRlNfQURWQU5DRURfQ09NUFI9eQpDT05GSUdfTkZT
X0ZTPXkKIyBDT05GSUdfTkZTX1YyIGlzIG5vdCBzZXQKQ09ORklHX1JPT1RfTkZTPXkKQ09ORklH
X05MU19ERUZBVUxUPSJ1dGY4IgpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz15CkNPTkZJR19OTFNf
Q09ERVBBR0VfODUwPXkKQ09ORklHX05MU19JU084ODU5XzE9eQpDT05GSUdfTkxTX1VURjg9eQpD
T05GSUdfUFJJTlRLX1RJTUU9eQpDT05GSUdfU1RSSVBfQVNNX1NZTVM9eQpDT05GSUdfREVCVUdf
RlM9eQpDT05GSUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSD15CkNPTkZJR19NQUdJQ19TWVNSUT15
CiMgQ09ORklHX1NDSEVEX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQlVHVkVSQk9T
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUkFDRSBpcyBub3Qgc2V0CkNPTkZJR19LRVlTPXkKQ09O
RklHX0NSWVBUT19DQ009eQpDT05GSUdfQ1JZUFRPX0VDQj15CkNPTkZJR19DUllQVE9fTUlDSEFF
TF9NSUM9eQpDT05GSUdfQ1JZUFRPX0FSQzQ9eQojIENPTkZJR19DUllQVE9fQU5TSV9DUFJORyBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fVVNFUl9BUElfSEFTSD15CkNPTkZJR19DUllQVE9fVVNF
Ul9BUElfU0tDSVBIRVI9eQojIENPTkZJR19DUllQVE9fSFcgaXMgbm90IHNldApDT05GSUdfQ1JD
X0lUVV9UPXkKQ09ORklHX0NSQzc9eQpDT05GSUdfQVZFUkFHRT15Cg==
--047d7b3a8ec0cb2f23050c89768c--
