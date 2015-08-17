From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under
 IGNPAR option
Date: Mon, 17 Aug 2015 12:19:30 -0400
Message-ID: <55D20992.60302@hurleysoftware.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com> <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com> <55D20297.6010500@hurleysoftware.com> <59506B47DEDD3943ABF9AC60020F4E2978D6E7FF@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59506B47DEDD3943ABF9AC60020F4E2978D6E7FF@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anirudha Sarangi <anirudha.sarangi@xilinx.com>, Michal Simek <michals@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, Soren Brinkmann <sorenb@xilinx.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 08/17/2015 11:58 AM, Anirudha Sarangi wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Peter Hurley [mailto:peter@hurleysoftware.com]
>> Sent: Monday, August 17, 2015 9:20 PM
>> To: Michal Simek
>> Cc: linux-kernel@vger.kernel.org; monstr@monstr.eu; Anirudha Sarangi=
; Soren
>> Brinkmann; Jiri Slaby; linux-serial@vger.kernel.org; Greg Kroah-Hart=
man; linux-
>> arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 2/4] serial: xuartps: Do not handle overrun erro=
rs under
>> IGNPAR option
>>
>> On 08/17/2015 03:22 AM, Michal Simek wrote:
>>> From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
>>>
>>> The existing implementation includes overrun errors under IGNPAR
>>> option. This patch fixes it by including only parity and framing er=
ror
>>> under IGNPAR option.
>>
>> The convention adopted by Linux serial drivers is to ignore overrun =
errors if both
>> IGNPAR and IGNBRK are set.
>>
> I just followed the set_termios documentation, which says that IGNPAR=
 is for parity and framing.
> The current controller does not support break detection reliably.
> That is probably why we don=E2=80=99t have IGNBRK.

My point is about how a user-space process tells the serial driver to i=
gnore
overrun errors, as well, and not specifically about break handling.

>=20
> Regards
> Anirudha
>=20
>> Regards,
>> Peter Hurley
>>
>>> Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/xilinx_uartps.c
>>> b/drivers/tty/serial/xilinx_uartps.c
>>> index a3020344ac9d..c4437e8929ff 100644
>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>> @@ -691,7 +691,7 @@ static void cdns_uart_set_termios(struct uart_p=
ort
>>> *port,
>>>
>>>     if (termios->c_iflag & IGNPAR)
>>>             port->ignore_status_mask |=3D CDNS_UART_IXR_PARITY |
>>> -                   CDNS_UART_IXR_FRAMING |
>> CDNS_UART_IXR_OVERRUN;
>>> +                                       CDNS_UART_IXR_FRAMING;
>>>
>>>     /* ignore all characters if CREAD is not set */
>>>     if ((termios->c_cflag & CREAD) =3D=3D 0)
>>>
>=20
>=20
>=20
> This email and any attachments are intended for the sole use of the n=
amed recipient(s) and contain(s) confidential information that may be p=
roprietary, privileged or copyrighted under applicable law. If you are =
not the intended recipient, do not read, copy, or forward this email me=
ssage or any attachments. Delete this email message and any attachments=
 immediately.
>=20
