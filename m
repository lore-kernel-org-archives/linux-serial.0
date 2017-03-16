From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 2/2] serdev: Add minimal bus locking API
Date: Thu, 16 Mar 2017 07:37:59 -0700
Message-ID: <CAHQ1cqGkWaZYkopXign9dxaAUv4Jbe5Kee8j-5Fkh6LX4r1i0A@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com>
 <20170314134819.19476-3-andrew.smirnov@gmail.com> <CAHp75VdtSCyr+8WeB_dHuo-P3LddA8sRDeFJh0FS92E_Rhijcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdtSCyr+8WeB_dHuo-P3LddA8sRDeFJh0FS92E_Rhijcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 4:20 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 3:48 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> Add minimal bus locking API which is useful for serial devices that
>> implement request-reply protocol
>
> Can you put an example here?
>
> I'm not sure mutex is needed at all.

My use case is a "supervisory" microcontroller connected to SoC via
UART various aspects of which are exposed via MFD. I saw this kind of
"device design pattern" a number of times in my career, so I thought
and abstraction to help dealing with cases like that might be useful.

However, since Rob mentioned that API's expectation is that any such
locking is driver's responsibility, I'll drop this patch.

Thanks,
Andrey Smirnov
