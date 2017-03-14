From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] serdev: Add minimal bus locking API
Date: Wed, 15 Mar 2017 01:20:21 +0200
Message-ID: <CAHp75VdtSCyr+8WeB_dHuo-P3LddA8sRDeFJh0FS92E_Rhijcg@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com> <20170314134819.19476-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134819.19476-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 3:48 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add minimal bus locking API which is useful for serial devices that
> implement request-reply protocol

Can you put an example here?

I'm not sure mutex is needed at all.

-- 
With Best Regards,
Andy Shevchenko
