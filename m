From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Fri, 28 Oct 2011 15:35:23 +0800
Message-ID: <CAGsJ_4z=VtU+RJ4c0Y2ruttWU6mTVtHMxzvCYWGz=5w6i7QJMQ@mail.gmail.com>
References: <1319772453-1275-1-git-send-email-Barry.Song@csr.com> <20111028071129.GA2362@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65471 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab1J1Hfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Oct 2011 03:35:46 -0400
In-Reply-To: <20111028071129.GA2362@tarshish>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: torvalds@linux-foundation.org, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

2011/10/28 Baruch Siach <baruch@tkos.co.il>:
> Hi Barry,
>
> On Thu, Oct 27, 2011 at 08:27:33PM -0700, Barry Song wrote:
>> From: Rong Wang <Rong.Wang@csr.com>
>>
>> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainlin=
e
>> 3.0.
>>
>> There are three dedicated UARTs in system. This patch adds basic dri=
ver
>> support for them.
>>
>> It has used the newest pinmux subsystem from Linus Walleij.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> ---
>
> [snip]
>
>> +config SERIAL_SIRFSOC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "SiRF SoC Platform Serial port=
 support"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARM && ARCH_PRIMA2
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL_CORE
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Support for the on-chip UART on =
the CSR SiRFprimaII series,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0providing /dev/ttyS0, 1 and 2 (n=
ote, some machines may not
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provide all of these ports, depe=
nding on how the serial port
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pins are configured.
>
> Unbalanced parentheses.

Hi Baruch,
Thanks for reviewing! I sent this mail for Torvalds to pick seperately
since it depends on pinctl tree, and it was not gone through tty tree
since tty has no pinctrl before linus merges it.
This patch has been reviewed and acked in linux-serial, unfortunately,
missed this error.
i am not sure whether i will make Linus confused if i send a new
version at this moment. how about i send a seperate patch to fix this
after the driver is applied?

>
> baruch
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~. .~ =C2=A0 Tk Open Systems
> =3D}------------------------------------------------ooO--U--Ooo------=
------{=3D
> =C2=A0 - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co=
=2Eil -

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
