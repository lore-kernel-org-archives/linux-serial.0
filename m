From: Kang Yin Su <cantona@cantona.net>
Subject: Re: [PATCH v2] serial: max310x: Fix out of bounds access
Date: Wed, 12 Aug 2015 19:50:25 +0800
Message-ID: <CABJLtPG7gfR8VSVfzRgF8XgON7F-mhfMu7C2an0sfQYLBNiLpg@mail.gmail.com>
References: <1439364125-19422-1-git-send-email-cantona@cantona.net>
	<CABJLtPHPCw7VN+wG4ApDxB-ZM7wRz_1xHfpNLL4o4_80JYyKaQ@mail.gmail.com>
	<1439372765.705411926@f362.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439372765.705411926@f362.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 12 August 2015 at 17:46, Alexander Shiyan <shc_work@mail.ru> wrote:
>> =D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 12 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=
=82=D0=B0 2015, 15:36 +08:00 =D0=BE=D1=82 cantona <cantona@cantona.net>=
:
>>
>>
>> added Alexander Shiyan < shc_work@mail.ru >.
>>
>> On 12 August 2015 at 15:22, Su Kang Yin  < cantona@cantona.net > wro=
te:
>> >Max310x driver supports up to 4 UART devices but array size of
>> >"struct max310x_one" is set to 1. That leads to out of bounds
>> >access on UART port registration.
>> >
>> >This patch fixed it by increase the array size to 4 which is
>> >maximum supported UART.
>> >
>> >Signed-off-by: Su Kang Yin < cantona@cantona.net >
>> >---
> ...
>
> This seems incorrect. The number of ports is allocated dynamically by=
:
> ...
> /* Alloc port structure */
> s =3D devm_kzalloc(dev, sizeof(*s) + sizeof(struct max310x_one) * dev=
type->nr, GFP_KERNEL);
> ...
>
> Thanks.
>
> ---
>


Oh, my bad.  But it looks confusing. So we must ensure "struct
max310x_one p[0]"  must the last element of "struct max310x_port".

Thanks.
