From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
Date: Wed, 4 Dec 2013 10:56:43 -0800
Message-ID: <CAAYSxhrvNRkDjxyeHWFfDux3c8VqoYwDomdVViy-H2ysbXGJwQ@mail.gmail.com>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
	<20131126183559.GA18570@localhost>
	<CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
	<20131127185448.GA21422@localhost>
	<20131128093034.5d61130a@skate>
	<20131128194720.GD13182@localhost>
	<20131128195337.GE13182@localhost>
	<20131204130156.GA2486@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41855 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067Ab3LDS4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Dec 2013 13:56:44 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so17153756oag.35
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2013 10:56:44 -0800 (PST)
In-Reply-To: <20131204130156.GA2486@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Wed, Dec 4, 2013 at 5:01 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Thu, Nov 28, 2013 at 04:53:37PM -0300, Ezequiel Garcia wrote:
>> On Thu, Nov 28, 2013 at 04:47:20PM -0300, Ezequiel Garcia wrote:

>> > Changing the console port by setting "console=3DttyS1,115200" give=
s this:
>> >
>> > [..]
>> > Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> > dw-apb-uart d0012000.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012000.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012000.serial: Couldn't set LCR to 224
>> > dw-apb-uart d0012000.serial: Couldn't set LCR to 224
>> > d0012000.serial: ttyS0 at MMIO 0xd0012000 (irq =3D 17, base_baud =3D=
 15625000) is a 16550A
>> > dw-apb-uart d0012100.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012100.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012100.serial: Couldn't set LCR to 224
>> > dw-apb-uart d0012100.serial: Couldn't set LCR to 224
>> > d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq =3D 18, base_baud =3D=
 15625000) is a 16550A
>> > console [ttyS1] enabled
>> > dw-apb-uart d0012200.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012200.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012200.serial: Couldn't set LCR to 224
>> > dw-apb-uart d0012200.serial: Couldn't set LCR to 224
>> > d0012200.serial: ttyS2 at MMIO 0xd0012200 (irq =3D 31, base_baud =3D=
 15625000) is a 16550A
>> > dw-apb-uart d0012300.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012300.serial: Couldn't set LCR to 191
>> > dw-apb-uart d0012300.serial: Couldn't set LCR to 224
>> > dw-apb-uart d0012300.serial: Couldn't set LCR to 224
>> > d0012300.serial: ttyS3 at MMIO 0xd0012300 (irq =3D 32, base_baud =3D=
 15625000) is a 16550A
>> >
>> > So we get the "Couldn't set" message in all four ports.
>> >
>> > Tim: Any ideas?
>>
>> And another thing: the weird output on the console looks related to =
the
>> early boot console. If I enable 'earlyprintk' on ttyS0 but set the c=
onsole
>> on ttyS1, this is what I get on ttyS0:
>>
>> bootconsole [earlycon0] enabled
>> [..]
>> Kernel command line: earlyprintk console=3DttyS1,115200 root=3D/dev/=
nfs rw nfsroot=3D192.168.0.45:/opt/buildrootfs,v3, ip=3D192.168.0.159:1=
92.168.0.45:192.168.0.1:255.255.255.0:develboard:eth0:on rootwait
>> [..]
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> =EF=BF=BD=C9=8A=EF=BF=BD=EF=BF=BD=C9=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=C9=86=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
>> Welcome to Buildroot
>> buildroot login:
>>
>> Hope this helps you understand what's going on...
>
> Gentle ping?
>
> Any ideas about those weird characters?

If there was just one weird character, I would say it was an
indication that hardware rejected a write to LCR and then software
wrote the lower 8 bits of the baud into DLL which happens to live at
the same address offset as RBR.  However, there are a bunch of them
here so it is less clear.

It would be really helpful to get any extra information that you can
about the Synopsys IP in your SoC.  If it configured with
UART_ADD_ENCODED_PARAMS =3D 1, there should be a UART configuration ID
register at offset 0xF4.  Could you try reading that back?  This
register has information about the FIFO size and a few more things.

Also, I am curious what LCR value the hardware reports when the driver
fails update it.  Perhaps you can amend the error message to include
p->serial_in(p, UART_LCR) too?

-Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
