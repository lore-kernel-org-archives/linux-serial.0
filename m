From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
Date: Mon, 14 May 2018 01:20:07 +0300
Message-ID: <CAHp75VeJcqaiWUVr=oXEH5YurY3yCDdE1eeoWumo6jCa_4PWEQ@mail.gmail.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com> <20180508114403.14499-7-mperttunen@nvidia.com>
 <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com> <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com, devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-tegra@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, May 13, 2018 at 9:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> On 05/13/2018 05:16 PM, Andy Shevchenko wrote:
>>
>> On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com>
>> wrote:
>>>
>>> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
>>> multiplexing multiple "virtual UARTs" into a single hardware serial
>>> port. The TCU is the primary serial port on Tegra194 devices.
>>>
>>> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
>>> are part of Tegra HSP blocks that are already controlled by the Tegra
>>> HSP mailbox driver.

>>> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned
>>> int mctrl)
>>> +{
>>
>>
>>> +       (void)port;
>>> +       (void)mctrl;
>>
>>
>> Huh?
>
>
> The serial core calls these callbacks without checking if they are set. They
> don't make sense for this driver so they are stubbed out.

My question why do you need these ugly lines? I'm pretty sure no other
driver with stubs using such style.

>>> +}

>>> +               if (written == 3) {
>>> +                       value |= 3 << 24;
>>> +                       value |= BIT(26);
>>> +                       mbox_send_message(tcu->tx, &value);
>>
>>
>>> +               }
>>
>>
>> (1)
>>
>>> +       }
>>> +
>>> +       if (written) {
>>> +               value |= written << 24;
>>> +               value |= BIT(26);
>>> +               mbox_send_message(tcu->tx, &value);
>>> +       }
>>
>>
>> (2)
>>
>> These are code duplications.
>
>
> Indeed - the length of the duplicated code is so short, and the instances
> are so close to each other, that I don't find it necessary (or clearer) to
> have an extra function.

It makes sense. Consider to refactor other way w/o duplication then.

>>> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
>>> +                                      struct ktermios *new,
>>> +                                      struct ktermios *old)
>>> +{
>>> +       (void)port;
>>> +       (void)new;
>>> +       (void)old;
>>> +}
>>
>>
>> Remove those unused stub contents.
>
>
> Sure. I had these here so that we don't get unused parameter warnings, but I
> can just as well remove the parameter names.

What warnings? How did you get them? We have them disabled as far as I
know even with W=1.

>
>>
>>> +       return uart_set_options(&tegra_tcu_uart_port, cons,
>>> +                               115200, 'n', 8, 'n');
>>
>>
>> Can't it be one line?
>
>
> It would be a total of 81 characters in length on one line, so no.

So, yes. 1 character doesn't prevent us make the readability better.
Please, put to one line.

-- 
With Best Regards,
Andy Shevchenko
