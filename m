From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Thu, 3 Dec 2015 20:29:54 +0300
Message-ID: <CAJs94EZiyZAsNd3A+=J9VWKzBgkoZKLn-aK+vq=zO4Lpbdnz+A@mail.gmail.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru> <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
 <5644F4F2.2080408@hurleysoftware.com> <20151114152536.693d964c@lxorguk.ukuu.org.uk>
 <564A2BF5.8030305@hurleysoftware.com> <CAJs94EZ816QpSeCrXRgjmg4mn7zbOX1V3BMr7+63QVF0p4As-A@mail.gmail.com>
 <564CC472.8010505@hurleysoftware.com> <CAJs94EacZ8d636suzFYZPBsoyAiF0-pqdAyKPXZPSJ=qrXayvw@mail.gmail.com>
 <CAJs94EY=qAhn6dzH9JbREruoXrvZoJh6a4jZEFHrK_KGGAre8g@mail.gmail.com>
 <565F7CA2.5030505@hurleysoftware.com> <CAJs94EY+QnYkgRPz=QNBqVYo7iC3EHvPjGZvOCA3Z3WJhLxJOg@mail.gmail.com>
 <56605491.1070206@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56605491.1070206@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2015-12-03 17:41 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Matwey,
>
> On 12/03/2015 12:50 AM, Matwey V. Kornilov wrote:
>> I am working on v4, where I completely redesigned implementation. And
>> now I think that it is considerably better than v3.
>> It looks like the following:
>> https://github.com/matwey/linux/commits/8520_rs485_v4
>> But it is not ready yet, there is a bug somewhere.
>>
>> In the v4, each subdriver decides separately if it needs rs485
>> emulation support. Then it enables it like the following:
>> https://github.com/matwey/linux/commit/4455e425fc045713fb921ccec695fe183f1558f0
>> Before calling serial8250_rs485_emul_enabled, the driver enables
>> interrupt on empty shift register (they are always there for omap_).
>
> Looks good.
>
> Are you testing with CONFIG_SERIAL_8250_DMA=n first to simplify the
> debug effort? DMA adds a completely different tx path.

Many thanks for the advice. I've just found that the bug is not in my code =)
Even with pure 4.3.0 I cannot open /dev/ttyS5 more than once. It just
hangs on open() and the process is in S+ state.

>
> Also, before submission, please shorten the identifiers. And Greg hates
> functions returning bool so just expanded serial8250_rs485_emul_enabled()
> inline.

Am I allowed to use `re' instead of rs485_emul in names?

>
> Regards,
> Peter Hurley
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
