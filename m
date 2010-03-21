From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH 3/3] max3100: adds console support for MAX3100
Date: Sun, 21 Mar 2010 08:47:22 +0100
Message-ID: <cabda6421003210047i1d4545aasf8969bb70d48ceb9@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	 <1268987997-22746-1-git-send-email-chripell@fsfe.org>
	 <fa686aa41003191231w54d7489ds917c3cd2de0bea52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:49939 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0CUHrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Mar 2010 03:47:24 -0400
Received: by fxm27 with SMTP id 27so3781745fxm.28
        for <linux-serial@vger.kernel.org>; Sun, 21 Mar 2010 00:47:22 -0700 (PDT)
In-Reply-To: <fa686aa41003191231w54d7489ds917c3cd2de0bea52@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org

On Fri, Mar 19, 2010 at 8:31 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:

>> +config SERIAL_MAX3100_CONSOLE_N
>> + =A0 =A0 =A0 int "Number of MAX3100 chips to wait before registerin=
g console"
>> + =A0 =A0 =A0 depends on SERIAL_MAX3100_CONSOLE=3Dy
>> + =A0 =A0 =A0 default "1"
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Unfortunately due to the async nature of Linux boo=
t we must
>> + =A0 =A0 =A0 =A0 know in advance when to register the console. If w=
e do it
>> + =A0 =A0 =A0 =A0 too early not all the MAX3100 chips are known to t=
he system
>> + =A0 =A0 =A0 =A0 yet. And we just cannot know how many MAX3100 will=
 be in the
>> + =A0 =A0 =A0 =A0 system so it's impossible to wait for the last one=
=2E =A0If you
>> + =A0 =A0 =A0 =A0 just want to have the console on the first MAX3100=
 chip
>> + =A0 =A0 =A0 =A0 probed (ttyMAX0) it's safe to leave this to 1.
>
> This seems wrong and fragile. =A0It certainly isn't multiplatform saf=
e
> to have it as a CONFIG setting because every board will have a
> different number of devices that it needs to wait for. =A0I don't kno=
w
> the console code very well though, but it seems to me that there
> should be a way to register the console regardless and then be able t=
o
> hold off output until the actual backing device shows up.
>
> Anybody know the right thing to do here?

I'll try to dig in the console code, any suggestion from others if
more than welcome.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tx, rx;
>
> inconsistent braces. =A0If you use {} on the else side, then please u=
se
> {} on the if side too.

ack, strange checkpatch.pl didin't catch these.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
=46_TRIGGER_FALLING, "max3100", s) < 0) {
>
> try to avoid unrelated whitespace changes, it adds noise when reviewi=
ng.
>

ack

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity |=3D MAX3100_PARITY_ON;
>
> s->parity?
>

huh, well spotted. ack

>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx &=3D ~MAX3100_PE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity &=3D ~MAX3100_PARITY_ON;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (parity =3D=3D 'o')
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity |=3D MAX3100_PARITY_ODD;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity &=3D ~MAX3100_PARITY_ODD;
>
> ditto?

ack

>
>
> Also, these blocks are really verbose; maybe do this:

ack, I'll reorganize this chunk of code.

>
>> +
>> + =A0 =A0 =A0 msleep(50);
>
> Why the sleep? =A0Shouldn't the console driver be able to handle the =
SPI
> device not being ready yet?

it's for the max3100 to settle. I'll double check the needed time and
add a comment.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(max3100s[i]=
, tx, &rx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Same comment on braces as for above.
>

ack

Thanks again for the review.

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
