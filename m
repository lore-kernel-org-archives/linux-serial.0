From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Sun, 7 Dec 2003 00:31:38 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312062314440.4454-100000@maggie.lkpg.cendio.se>
References: <3FD0A958.4020302@columbia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:9972 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S265264AbTLFXbn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Dec 2003 18:31:43 -0500
In-Reply-To: <3FD0A958.4020302@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>
Cc: Corey Minyard <minyard@acm.org>, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

> >Actually, we are using telnet+RFC2217 over an SSH TCP tunnel. I thin=
k this=20
> >is a pretty clean solution. How could a "better" solution look like?
> > =20
> >
> Two better solutions:
>=20
>  * TELNET START_TLS + AUTH {SRP, KRB5} + RFC2217

But the START_TLS and auth stuff has nothing to do with RFC2217. It's j=
ust=20
a matter of using several Telnet options at the same time.=20


>  * SSH + a Remote Serial Port subsystem (yet to be built)

SSH subsystems are nothing magic: The subsystem process communicates wi=
th
sshd via stdin/stdout, just like inetd. For example, the "SSH File
Transfer Protocol" RFC says:

  Even though this protocol is described in the context of the SSH2
  protocol, this protocol is general and independent of the rest of the
  SSH2 protocol suite.

So, the question is, telnet+RFC2217 a "bad" or inappropriate protocol t=
o=20
be used with a SSH subsystem? I think not.=20


Since sredird is a inetd-type service, it can actually work as a=20
subsystem. It works, I've just tested it. Here's what I did:

* Created /tmp/sredir-sshsub:

#!/bin/sh
exec /tmp/sredird 5 /dev/ttyS0 /tmp/LCK..ttyS0


* Added to sshd_config:

Subsystem       sredir  /tmp/sredir-sshsub


* Used ssh and socat to connect:

socat TCP-LISTEN:5555 "EXEC:ssh -s localhost sredir"


* Connected with Kermit:

(/home/peter/) C-Kermit>set host localhost:5555
 DNS Lookup...  Trying 127.0.0.1...  Reverse DNS Lookup... (OK)
 localhost.localdomain connected on port 5555
 Negotiations.. (OK)


So, I think telnet+RFC2217 is a good protocol, even in a SSH environmen=
t.=20
Thus, it would be useful with an updated spec.=20

What remains is perhaps convincing IETF of this. Or, maybe not: We coul=
d=20
just go ahead and update the spec.=20


--=20
Peter =C5strand		www.thinlinc.com
Cendio			www.cendio.se
Teknikringen 3		Phone: +46-13-21 46 00
583 30 Link=F6ping


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
