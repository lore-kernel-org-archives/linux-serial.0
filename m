From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Thu, 3 Dec 2015 14:45:00 -0500
Message-ID: <56609BBC.8010806@hurleysoftware.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
 <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
 <5644F4F2.2080408@hurleysoftware.com>
 <20151114152536.693d964c@lxorguk.ukuu.org.uk>
 <564A2BF5.8030305@hurleysoftware.com>
 <CAJs94EZ816QpSeCrXRgjmg4mn7zbOX1V3BMr7+63QVF0p4As-A@mail.gmail.com>
 <564CC472.8010505@hurleysoftware.com>
 <CAJs94EacZ8d636suzFYZPBsoyAiF0-pqdAyKPXZPSJ=qrXayvw@mail.gmail.com>
 <CAJs94EY=qAhn6dzH9JbREruoXrvZoJh6a4jZEFHrK_KGGAre8g@mail.gmail.com>
 <565F7CA2.5030505@hurleysoftware.com>
 <CAJs94EY+QnYkgRPz=QNBqVYo7iC3EHvPjGZvOCA3Z3WJhLxJOg@mail.gmail.com>
 <56605491.1070206@hurleysoftware.com>
 <CAJs94EZiyZAsNd3A+=J9VWKzBgkoZKLn-aK+vq=zO4Lpbdnz+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZiyZAsNd3A+=J9VWKzBgkoZKLn-aK+vq=zO4Lpbdnz+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12/03/2015 12:29 PM, Matwey V. Kornilov wrote:
> 2015-12-03 17:41 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>> Hi Matwey,
>>
>> On 12/03/2015 12:50 AM, Matwey V. Kornilov wrote:
>>> I am working on v4, where I completely redesigned implementation. A=
nd
>>> now I think that it is considerably better than v3.
>>> It looks like the following:
>>> https://github.com/matwey/linux/commits/8520_rs485_v4
>>> But it is not ready yet, there is a bug somewhere.
>>>
>>> In the v4, each subdriver decides separately if it needs rs485
>>> emulation support. Then it enables it like the following:
>>> https://github.com/matwey/linux/commit/4455e425fc045713fb921ccec695=
fe183f1558f0
>>> Before calling serial8250_rs485_emul_enabled, the driver enables
>>> interrupt on empty shift register (they are always there for omap_)=
=2E
>>
>> Looks good.
>>
>> Are you testing with CONFIG_SERIAL_8250_DMA=3Dn first to simplify th=
e
>> debug effort? DMA adds a completely different tx path.
>=20
> Many thanks for the advice. I've just found that the bug is not in my=
 code =3D)
> Even with pure 4.3.0 I cannot open /dev/ttyS5 more than once. It just
> hangs on open() and the process is in S+ state.

Hmm, that's odd. So

$ stty -a < /dev/ttyS5

hangs if something like below is running?

$ cat > /dev/ttyS5


>> Also, before submission, please shorten the identifiers. And Greg ha=
tes
>> functions returning bool so just expanded serial8250_rs485_emul_enab=
led()
>> inline.
>=20
> Am I allowed to use `re' instead of rs485_emul in names?

Long names and constructs tend to obscure the execution flow.
Some of the names could be reduced where the meaning is obvious:

  serial8250_rts_on_send
  serial8250_rts_after_send
  serial8250_handle_start_timer
  serial8250_handle_stop_timer

These two I would inline into their lone call site:

  serial8250_rs485_emul_startup()
  serial8250_rs485_emul_shutdown()

serial8250_rs485_emul_start_tx  =3D> __start_tx_rs485

rs485_emul =3D> sw485/em485/emul485/soft485 ?

Or just rs485 (except for the field name and structs so as not to confu=
se
it with the port->rs485)

Just my 2=C2=A2

Regards,
Peter Hurley
