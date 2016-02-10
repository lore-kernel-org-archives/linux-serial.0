From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v8 0/3] tty: Introduce software RS485 direction control support
Date: Wed, 10 Feb 2016 19:24:02 +0300
Message-ID: <CAJs94EYjwViCA7=8ecXj2FOLwBT5C9Lt_pOfc1-ardL0TQ4yDg@mail.gmail.com>
References: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru> <56BB5FE7.30009@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BB5FE7.30009@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2016-02-10 19:05 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Matwey,
>
> On 02/01/2016 10:09 AM, Matwey V. Kornilov wrote:
>> Changes from v7:
>>  - rework comments to follow guidelines
>>  - minor style changes
>> Changes from v6:
>>  - minor style changes
>>  - timers are not IRQSAFE now
>> Changes from v5:
>>  - rs485_emul variable has been renamed to em485 to follow function names convention
>> Changes from v4:
>>  - Add commit message to 1/3
>> Changes from v3:
>>  - Completely redesigned.
>> Changes from v2:
>>  - Introduced SER_RS485_SOFTWARE to show that software implementation is being used
>>  - serial8250_rs485_config is located as required
>>  - Timers are used to implement delay_before and delay_after timeouts
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>
> The holdup here is that I'd like to unit test this, which is 3rd on my todo list.
> Should be done before the end of the week which will be soon enough
> for this series to make linux-next.

Hi Peter,

Is something required from me?

>
> Thanks for your work on this.
>
> Regards,
> Peter Hurley
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
