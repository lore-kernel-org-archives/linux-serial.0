From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/3] tty: Add software emulated RS485 support for 8250
Date: Sun, 20 Dec 2015 20:13:27 +0200
Message-ID: <CAHp75VeVKscH8k-ehDyiGx3+zF6hToRMXGWMp6YzMSvL+5SOfg@mail.gmail.com>
References: <1449919416-1980-1-git-send-email-matwey@sai.msu.ru>
	<1449919416-1980-3-git-send-email-matwey@sai.msu.ru>
	<CAHp75VcJaJnEMA04Xit4JxzLs+VQtsE0_j-MAf_S=_ERh0AxgQ@mail.gmail.com>
	<CAJs94Ea-gz8GAL6Sx4A4RqBVPKs-Z=gvk+9KiaGLt-TJM3s92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94Ea-gz8GAL6Sx4A4RqBVPKs-Z=gvk+9KiaGLt-TJM3s92Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 8:11 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> 2015-12-20 19:41 GMT+03:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Sat, Dec 12, 2015 at 1:23 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>>> Implementation of software emulation of RS485 direction handling is based
>>> on omap_serial driver.
>>> Before and after transmission RTS is set to the appropriate value.
>>>
>>> Note that before calling serial8250_em485_init the caller has to
>>> ensure that UART will interrupt when shift register empty. Otherwise,
>>> emultaion cannot be used.
>>>
>>> Both serial8250_em485_init and serial8250_em485_destroy are
>>> idempotent functions.
>>
>> Just nitpick suggesting to rename both struct and field:
>>
>> struct uart_8250_rs485em *rs485em;
>
> Why not
>
> struct uart_8250_em485 *em485;
>
> to be consistent with function name suffix?

I'm fine with that as well.

-- 
With Best Regards,
Andy Shevchenko
