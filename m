From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Thu, 13 Oct 2011 15:27:21 +0100
Message-ID: <20111013152721.6abcbbdc@bob.linux.org.uk>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com>
	<20111013105556.09d64d4d@bob.linux.org.uk>
	<CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53483 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab1JMORp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Oct 2011 10:17:45 -0400
In-Reply-To: <CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Barry Song <Barry.Song@csr.com>, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, workgroup.linux@csr.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> >> +static struct console sirfsoc_uart_console =3D {
> >> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "ttyS=
",
> >
> > ttyS is 8250 devces. Pick a new name for your own.
>=20
> ok. most devices have names like ttySQ, ttySA, ttySG... since our SoC
> is named SiRFprimaII, i'd like to have ttySI?

If nobody else is using it for anything mainstream sure. Or ttySiRF0 ..
etc might be more definitively unique


Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
