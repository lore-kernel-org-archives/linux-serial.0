From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Data corruption on serial interface under load
Date: Fri, 5 Feb 2016 00:27:19 +0200
Message-ID: <CAHp75VfFQt3ST7DrWSuR2YmfU0xdd1p2TS7RyUD0hN1_dJ-tYA@mail.gmail.com>
References: <CAHp75VehshCyAjKiOyB26zkeu4WUar9-z-XfFNLuchc0swyvSQ@mail.gmail.com>
	<56B3AF54.2050609@hurleysoftware.com>
	<CAHp75VcjxYne9WN1=j+bGHF6FdGL3tHQeq8EXoiKxmj1+fXW-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcjxYne9WN1=j+bGHF6FdGL3tHQeq8EXoiKxmj1+fXW-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 5, 2016 at 12:24 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 4, 2016 at 10:06 PM, Peter Hurley <peter@hurleysoftware.com> wrote:

>>> Original sample:
>>> 00000000: 7f 45 4c 46 01 01 01 00  00 00 00 00 00 00 00 00   .ELF............
>>> 00000010: 02 00 03 00 01 00 00 00  19 8d 04 08 34 00 00 00   ............4...
>>> 00000020: 2c f2 00 00 00 00 00 00  34 00 20 00 04 00 28 00   ,.......4. ...(.
>>>
>>> Received sample:
>>> 00000000: 7f 00 45 00 4c 00 46 00  01 00 01 00 01 00 00 00   ..E.L.F.........
>>> 00000010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ................
>>> 00000020: 02 00 00 00 03 00 00 00  01 00 00 00 00 19 8d 04   ................

>> 2) If you mean the NUL bytes for overruns, I could have some functional mode
>>    mis-branched in the N_TTY line discipline.
>
> Yeah, this one.
>
>> What are the termios settings
>>    on the rx side?
>
> I'm using this [1] tool with small patch applied that enables internal
> loopback (TCIOM_LOOP).

Here are the calls

ret = cfsetspeed(&new_term, opts.baudrate);
cfmakeraw(&new_term);
new_term.c_cflag |= CREAD;
new_term.c_cflag &= ~CRTSCTS;
new_term.c_cc[VMIN] = 64;
new_term.c_cc[VTIME] = 8;
...
ret = tcflush(fd, TCIFLUSH);
ret = fcntl(fd, F_SETFL, 0);

> [1] https://git.breakpoint.cc/cgit/bigeasy/serialcheck.git/

-- 
With Best Regards,
Andy Shevchenko
