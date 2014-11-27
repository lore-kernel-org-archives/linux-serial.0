From: Guoqing Liu <lgqgood@gmail.com>
Subject: Re: Uart2 can't work well after the system goto standby and then
 resume at csr primaII platform
Date: Thu, 27 Nov 2014 10:42:58 +0800
Message-ID: <CAMLw+SGsys1pn4bSVr+Z1Vk7-Y4OquLxFZk_ZsAbeDrQA4+zYw@mail.gmail.com>
References: <CAMLw+SEMavUKc1-9mZA+-UJ=UJiBhBp=7=srNNqg-W74C=BLSQ@mail.gmail.com>
	<20141126184348.GA6958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:41050 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaK0Cm6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 21:42:58 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so2897110qgf.38
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2014 18:42:58 -0800 (PST)
In-Reply-To: <20141126184348.GA6958@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 27, 2014 at 2:43 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Wed, Nov 26, 2014 at 02:17:06PM +0800, Guoqing Liu wrote:
>> Daer Sir,
>>=E3=80=80=E3=80=80  I'm very sorry to trouble you.
>>      Recently I found the uart2 at csr primaII platform can't work
>> well after the system  goto standby and then resume.
>>
>> My test environment is as follows=EF=BC=9A
>>      kernel:   3.10.16
>
> That is a very old and obsolete kernel version.  If a vendor is forci=
ng
> you to stick to that version, please ask them for support as there's
> nothing that we can to do help here, sorry.
>
> Now if you can duplicate this on the 3.17 kernel release, that's a
> different story...
>
> good luck,
>
> greg k-h


Dear Greg
    Thank you very much for your reply.
        I am a newbie to lkml. So I hope you do not mind. :)
=E3=80=80=E3=80=80=E3=80=80=EF=BC=A9 will try it and feedback as soon a=
s possible.


--=20
good life
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
