From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: fix error handling in of_platform_serial_probe()
Date: Tue, 18 Jul 2017 18:55:42 +0300
Message-ID: <CAHp75VcL_L8hOdqQdY=5VWTRHvO=w9Yd9M6stdTmDOnAs4Sbbw@mail.gmail.com>
References: <032e9a8b-8013-fe60-4a49-11cbf5cc28ed@ispras.ru>
 <1500377531-28358-1-git-send-email-khoroshilov@ispras.ru> <20170718154521.GA7132@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718154521.GA7132@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 6:45 PM, Johan Hovold <johan@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 02:32:11PM +0300, Alexey Khoroshilov wrote:
>> clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
>> while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().

>> +err_register:
>>       irq_dispose_mapping(port8250.port.irq);
>> +     if (info->clk)
>> +             clk_disable_unprepare(info->clk);
>> +err_setup:
>> +     kfree(info);
>
> Please name also these error labels after what they do rather than after
> from where you jump to them (i.e. as you did above in
> of_platform_serial_setup()).

Actually good point!

-- 
With Best Regards,
Andy Shevchenko
