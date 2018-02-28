From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] serial: stm32: update interrupt initialization
Date: Wed, 28 Feb 2018 17:41:14 +0200
Message-ID: <CAHp75VeX_L_B2e648LiBrbHNBEg-C3NBw-PUTmQdhHhEb=2N-A@mail.gmail.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com> <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 28, 2018 at 5:40 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 12:51 PM, Bich HEMON <bich.hemon@st.com> wrote:

>> -       port->irq       = platform_get_irq(pdev, 0);
>> -       stm32port->wakeirq = platform_get_irq(pdev, 1);

>> +       stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");
>
> But this one is redundant since Tony's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=da997b22c40473b7db60bde6ea188d35565d10c8

Oh, it'a bout getting a resource by name...

Sorry, discard my previous comment.


-- 
With Best Regards,
Andy Shevchenko
