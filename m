From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Fri, 13 Nov 2015 23:03:26 +0300
Message-ID: <CAJs94EZeLPo-8aeFB69MgZEgtAP5a6zf-jdM9JOf+K6yL0hiWQ@mail.gmail.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru> <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, Peter Hurley <peter@hurleysoftware.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2015-11-12 22:57 GMT+03:00 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
> On Thu, 12 Nov 2015 17:33:53 +0300
> "Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:
>
>> This flag is supposed to be used by uart drivers using software rs485 direction control.
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  include/uapi/linux/serial.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
>> index 25331f9..95b15ca 100644
>> --- a/include/uapi/linux/serial.h
>> +++ b/include/uapi/linux/serial.h
>> @@ -121,6 +121,9 @@ struct serial_rs485 {
>>  #define SER_RS485_RTS_AFTER_SEND     (1 << 2)        /* Logical level for
>>                                                          RTS pin after sent*/
>>  #define SER_RS485_RX_DURING_TX               (1 << 4)
>> +#define SER_RS485_SOFTWARE           (1 << 5)        /* Software
>> +                                                        implementation is
>> +                                                        being used */
>
> I've only got one question here - why do we need this flag. Why does the
> application care whether the timer is in the kernel or in the chip. In
> particular think about cases where some combinations of features require
> software fallback and others don't. What would the flag indicate then.
>

Peter asked for it, I respect his experience.
Only two lines are required to implement this, so it is easy to add,
easy to drop.

> The patches look nice but I'd strongly favour not having a software flag.
> It should never matter as the kernel API is the same in all cases and we
> should therefore discourage application code from trying to know things
> it doesn't need to worry about.
>
> Alan
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
