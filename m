From: David Monniaux <David.Monniaux@ens.fr>
Subject: [PATCH] [BUG] bug in moxa.c driver
Date: Thu, 8 Jul 2004 09:29:53 +0200 (MEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.03.10407080929100.15620-100000@basilic.ens.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nef.ens.fr ([129.199.96.32]:23055 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S265833AbUGHH37 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Jul 2004 03:29:59 -0400
Received: from di.ens.fr (di.ens.fr [129.199.99.1])
          by nef.ens.fr (8.12.11/1.01.28121999) with ESMTP id i687TwO2000372
          for <linux-serial@vger.kernel.org>; Thu, 8 Jul 2004 09:29:58 +0200 (CEST)
Received: from basilic.ens.fr (monniaux@basilic [129.199.99.48]) by di.ens.fr (8.12.9/jb-1.1)
	id i687TuKM023235 for <linux-serial@vger.kernel.org>; Thu, 8 Jul 2004 09:29:56 +0200 (MEST)
Received: from localhost (monniaux@localhost) by basilic.ens.fr (8.11.0/jb-1.1)
	id i687Trw15667 for <linux-serial@vger.kernel.org>; Thu, 8 Jul 2004 09:29:53 +0200 (MEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I know this is not a 8250/16?50, but it's serial anyway.

SYMPTOMS:
The current Moxa Intellio driver (moxa.c) panics when using > 1 board.

BACKGROUND:
The Moxa board needs a firmware download (see
http://www.moxa.com/drivers/C320T/Linux/v5.4/MXDRV.TGZ, command
moxaload -y) prior to usage.

Unfortunately, the current Linux kernel code fails during this download=
 if
more than one board are installed.

EXPLANATION AND FIX:
The MoxaDriverPoll function does:
[...]
        for (card =3D 0; card < MAX_BOARDS; card++) {
                if ((ports =3D moxa_boards[card].numPorts) =3D=3D 0)
                        continue;
                if (readb(moxaIntPend[card]) =3D=3D 0xff) {
[...]

Unfortunately, with multiple boards, there exists a point where
MoxaDriverPoll() will be called when moxa_boards[card].numPorts !=3D 0 =
but
moxaIntPend[card] is still NULL. Result: kernel panic.

=46ix: use instead
                if ((ports =3D moxa_boards[card].numPorts) =3D=3D 0
                    || moxaIntPend[card] =3D=3D 0)
                        continue;

If someone who understands the code better than me proposes a better
patch, I'd be delighted. [For the little story, the above patch was
written after finding the bug in a remote location without internet acc=
ess
using a serial console for getting the panic trace...]

David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'=C9cole Normale Sup=E9rieure,
Paris, France


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
