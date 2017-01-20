From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v10 2/3] serial: exar: split out the exar code from 8250_pci
Date: Fri, 20 Jan 2017 23:55:53 +0000
Message-ID: <5882A389.1070701@gmail.com>
References: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com> <1484864602-5266-2-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75VeQOHdKd7C_yO-ts9W_Gv5BYJSUp+JdpkhvaJFSYnFpzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeQOHdKd7C_yO-ts9W_Gv5BYJSUp+JdpkhvaJFSYnFpzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Friday 20 January 2017 10:25 PM, Andy Shevchenko wrote:
> On Fri, Jan 20, 2017 at 12:23 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>
>> Add the serial driver for the Exar chips. And also register the
>> platform device for the GPIO provided by the Exar chips.
>
> Thanks, this is indeed much cleaner that v6 I saw couple of weeks before!
>
>> Andy,
>> Having 3 setup hooks and assigning everything there was becoming too
>> complicated for me to follow, so i left it as it is. Though some more
>> parts from the board setup has been removed. uart_offset has been
>> completely removed.
>
> Yes, what about baudrate?
> I will check later, but for me it seems other way, i.e. simpler to
> have just 3 setup functions in a row than one is lurking somewhere
> with allocation et al.
>
<snip>
>> +       CONNECT_DEVICE(XR17C154, UART_4_485),
>> +       CONNECT_DEVICE(XR17C158, UART_8_485),
>
> Perhaps it takes few LOC more, but having same defined struct here
> with dedicated ->setup() looks cleaner to me.
>

I think now I understand the 3 different setup functions. Let me try v11 
(hopefully the last one).

Regards
Sudip
