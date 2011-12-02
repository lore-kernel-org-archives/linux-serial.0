From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Date: Thu, 1 Dec 2011 20:42:13 -0500
Message-ID: <CAP=VYLqG_+-vksaVLO5kPbj6qRUKK9z6AcEQOFnCgoPGrO2crg@mail.gmail.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
	<1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
	<20111202005752.10ce5eea@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab1LBBmP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Dec 2011 20:42:15 -0500
In-Reply-To: <20111202005752.10ce5eea@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: gregkh@suse.de, galak@kernel.crashing.org, scottwood@freescale.com, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Thu, Dec 1, 2011 at 7:57 PM, Alan Cox <alan@linux.intel.com> wrote:
>
>> @@ -1553,7 +1554,15 @@ static void serial8250_handle_port(struct
>> uart_8250_port *up)
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>>
>> - =A0 =A0 status =3D serial_inp(up, UART_LSR);
>> + =A0 =A0 /* Workaround for IRQ storm errata on break with Freescale
>> 16550 */
>> + =A0 =A0 if (UART_BUG_FSLBK & up->port.bugs && up->lsr_last &
>> UART_LSR_BI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->lsr_last &=3D ~UART_LSR_BI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_inp(up, UART_RX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, fla=
gs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 status =3D up->lsr_last =3D serial_inp(up, UART_LSR);
>
> We've now had a recent pile of IRQ function changes adding more quirk
> bits and special casing. This doesn't scale. We either need to make
> handle_port a method the specific drivers can override or you could
> hide the mess in your serial_inp implementation and not touch any cor=
e
> code.

To be fair, this one is zero cost for !PPC, but I understand your point=
,
and the idea of hiding it somehow in serial_inp was something that
never crossed my mind.  I'll look into seeing if I can abuse that.

>
> I really don't mind which but I suspect dealing with it in your
> serial_inp handler so that when you read UART_LSR you do the fixup
> might be simplest providing you can just do that.
>
> Sorting out a ->handle_port override is probably ultimately the right
> thing to do and then we can push some of the other funnies out furthe=
r.
>
> At this point it's becoming increasingly clear that 8250 UART cloners
> are both very bad at cloning the things accurately, and very busy add=
ing
> extra useful features so we need to start to treat 8250.c as a librar=
y
> you can wrap.

Sad but true.  It is like a time warp back to lib8390.c  --- whee.

P.

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
