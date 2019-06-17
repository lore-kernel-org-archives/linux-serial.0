From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 3/3 v6] tty/serial/8250: use mctrl_gpio helpers
Date: Mon, 17 Jun 2019 14:42:00 +0200
Message-ID: <d62c1a2b-3e24-c109-a7fb-57190388d75f@denx.de>
References: <20190613154542.32438-1-sr@denx.de>
 <20190613154542.32438-3-sr@denx.de>
 <CAGm1_kuyt5ue_3CuvryXw8L0=z0Bti5BeQMA50yRYhFmffcJuQ@mail.gmail.com>
 <CAGm1_ksdQ5CNLGGNzHKBNKeLE3ByHvPyOkjYNoWWM+rw0q214Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGm1_ksdQ5CNLGGNzHKBNKeLE3ByHvPyOkjYNoWWM+rw0q214Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: linux-serial@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 17.06.19 11:51, Yegor Yefremov wrote:

<snip>

>>> @@ -1944,11 +1948,15 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>>>   {
>>>          struct uart_8250_port *up = up_to_u8250p(port);
>>>          unsigned int status;
>>> +       unsigned int val = 0;
>>>
>>>          serial8250_rpm_get(up);
>>>          status = serial8250_modem_status(up);
>>>          serial8250_rpm_put(up);
>>>
>>> +       if (up->gpios)
>>> +               return mctrl_gpio_get(up->gpios, &val);
>>> +
>>
>> What happens when you have a mixed setup i.e. CTS controlled by UART
>> but other status pins controlled by GPIO? In this case CTS status
>> won't be returned. Do I see it right?

Yes, your analysis does seem to be correct. Please note that I did
not intentionally did change it this way. I was not thinking about
such a "mixed design".
  
> What about something like this:
> 
> unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>    {
>            struct uart_8250_port *up = up_to_u8250p(port);
>            unsigned int status;
>            unsigned int val;
> 
>            serial8250_rpm_get(up);
>            status = serial8250_modem_status(up);
>            serial8250_rpm_put(up);
> 
>            val = serial8250_MSR_to_TIOCM(status);
>            if (up->gpios)
>                    mctrl_gpio_get(up->gpios, &val);
> 
>            return val;
>    }

Looks good to me, thanks. Do you have such a setup with some modem
control signal handled via GPIO and some via the UART? Could you
test such a change?

Thanks,
Stefan
