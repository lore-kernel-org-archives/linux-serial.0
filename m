From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Mon, 29 Mar 2010 08:11:15 +0200
Message-ID: <cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	 <1269340170-6558-1-git-send-email-chripell@fsfe.org>
	 <20100329104838.49c18075@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47825 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0C2GLQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Mar 2010 02:11:16 -0400
In-Reply-To: <20100329104838.49c18075@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 29, 2010 at 4:48 AM, Feng Tang <feng.tang@intel.com> wrote:
> Hi,

Hi,

>
> I modified the code a little and run it on our HW platform, it really=
 show
> some sigh of life: it can boots to console (the print format is not s=
o good),
> I can input command and it execute correctly, but very slow, I type 3
> characters and it takes about 2 seconds to echo back on screen and st=
art the
> execution, and after about 1 minute, the console hang there and input=
 stopped
> to work.

never seen such a behavior. Which platform are you using? Which SPI
driver? Do you have a low level printk (printascii) that puts output
somewhere else so I can send you a patch with some debugging output?
Can you log in some other way (like via network) and see if the CPU
load is at 100% for some reason?

>> This patch adds console support for the MAX3100 UART
>> (console=3DttyMAX0,11500). The SPI subsystem and an
>
> 115200?
>

ack

> Does this imply to have to work with HW flow control? on my platform
> I have to remove the RTS bit to make it work.
>

no, I put RTS on  because it looks like a good default. I can make it
configurable. I just noticed on the data sheet that RTS is actually
inverted so a more sensible default would be to put it off. For
testing you should have flow control set to none on the machine you
are using as a terminal emulator.

>> + =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(s, tx, &rx);
>
> It doesn't handle received characters here? If the console is printin=
g out
> a bulk of message while user input some command, the command may be i=
gnored.
> Myself have met the same problem in our driver.
>

yes but I think it's quite difficult to solve this problem in every
case. Console output is massively used only on boot when the user is
not supposed to type a lot.

>> + =A0 =A0 if (next !=3D s->console_tail) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->console_buf[next] =3D ch;
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->console_head =3D next;
>> + =A0 =A0 }
>
> Also I saw max3100_sr() uses cpu_to_be16() and be16_to_cpu(), is it r=
eally
> necessary, our platform is little-endian(x86), and I have to disable =
them
> to make the code work. Is your test platform big-endian?
>

Have you configured your SPI controller as LSB first somehow, haven't
you? BTW my platform is a quite usual ARM9 S3C2440 which is little
endian.


--=20
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
