From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register support
Date: Wed, 17 May 2017 12:53:32 +0300
Message-ID: <CAHp75VfN6=EZ6zBsVojfrXf5kdhBXUjS_HNBkb0gHhVQRPc=OQ@mail.gmail.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com> <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, fugang.duan@nxp.com, dongas86@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yangbo.lu@nxp.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Mingkai.Hu@nxp.com, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 16, 2017 at 2:15 PM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
>>  static u32 lpuart32_read(void __iomem *addr)
>>  {
>> -     return ioread32be(addr);
>> +     return lpuart_is_be ? ioread32be(addr) : readl(addr);
>>  }
>>
>>  static void lpuart32_write(u32 val, void __iomem *addr)
>>  {
>> -     iowrite32be(val, addr);
>> +     if (lpuart_is_be)
>> +             iowrite32be(val, addr);
>> +     else
>> +             writel(val, addr);
>>  }
>
> What if this is ever executed on big endian system?

Above is apparently about bus side of communication and it looks like
it needs to be CPU side. Is this what you are trying to discuss?


-- 
With Best Regards,
Andy Shevchenko
