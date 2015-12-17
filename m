From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] use callbacks to access UART_DLL/UART_DLM
Date: Thu, 17 Dec 2015 18:09:07 +0000
Message-ID: <yw1xbn9pc5h8.fsf@unicorn.mansr.com>
References: <5672D89A.4090307@laposte.net>
	<yw1xoadpcbbn.fsf@unicorn.mansr.com> <5672F9C9.1010601@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672F9C9.1010601@laposte.net> (Sebastian Frias's message of
	"Thu, 17 Dec 2015 19:07:05 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm@opensource.se>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
List-Id: linux-serial@vger.kernel.org

Sebastian Frias <sf84@laposte.net> writes:

>>>        old_lcr =3D serial_in(p, UART_LCR);
>>> -    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>>> -
>>> -    old_dll =3D serial_in(p, UART_DLL);
>>> -    old_dlm =3D serial_in(p, UART_DLM);
>>>
>>> -    serial_out(p, UART_DLL, 0);
>>> -    serial_out(p, UART_DLM, 0);
>>> +    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>>>
>>> -    id =3D serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
>>> +    old_dl =3D serial_dl_read(p);
>>> +    serial_dl_write(p, 0);
>>> +    id =3D serial_dl_read(p);
>>> +    serial_dl_write(p, old_dl);
>>>
>>> -    serial_out(p, UART_DLL, old_dll);
>>> -    serial_out(p, UART_DLM, old_dlm);
>>>        serial_out(p, UART_LCR, old_lcr);
>>>
>>>        return id;
>>> --
>>
>> If you left the blank lines alone, the patch would end up much easie=
r to
>> understand.  In this diff, some of the lines listed as added or remo=
ved
>> have actually not changed, and that's not immediately obvious.
>>
>
> The old code had some blank lines, which I suppose were there for cla=
rity.
> I attempted to follow the same idea.
> But I don't mind changing the code as you wish.

It could well be that your patch results in a clearer final version, bu=
t
the diff is harder to parse when unchanged lines have moved around.

--=20
M=E5ns Rullg=E5rd
