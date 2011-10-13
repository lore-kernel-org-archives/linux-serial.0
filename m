From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Thu, 13 Oct 2011 22:49:41 +0800
Message-ID: <CAGsJ_4z2nss7fEH2mKWEtzdSbDD6n+MnjrLVnFmxyXJQvZuaWg@mail.gmail.com>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com>
 <20111013105556.09d64d4d@bob.linux.org.uk> <CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
 <20111013152721.6abcbbdc@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38065 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab1JMOuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Oct 2011 10:50:02 -0400
Received: by bkbzt4 with SMTP id zt4so1544074bkb.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Oct 2011 07:50:01 -0700 (PDT)
In-Reply-To: <20111013152721.6abcbbdc@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Barry Song <Barry.Song@csr.com>, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, workgroup.linux@csr.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/10/13 Alan Cox <alan@linux.intel.com>:
>> >> +static struct console sirfsoc_uart_console =3D {
>> >> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "tty=
S",
>> >
>> > ttyS is 8250 devces. Pick a new name for your own.
>>
>> ok. most devices have names like ttySQ, ttySA, ttySG... since our So=
C
>> is named SiRFprimaII, i'd like to have ttySI?
>
> If nobody else is using it for anything mainstream sure. Or ttySiRF0 =
=2E.
> etc might be more definitively unique
well. the later  in v2.

>
>
> Alan
>
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
