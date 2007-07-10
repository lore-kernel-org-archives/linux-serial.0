From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
Subject: a few tiny patches suggested
Date: Tue, 10 Jul 2007 23:23:07 +0200
Message-ID: <469414DB.2513.1275391A@Frantisek.Rysanek.post.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary=Message-Boundary-20171
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([212.80.76.43]:37630 "HELO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757399AbXGJVXI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Jul 2007 17:23:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--Message-Boundary-20171
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Dear everyone,

maybe I'd like to suggest one or two slight changes to the serial subsytem.

1.) make struct uart_8250_port public, i.e. move it to some header file,
such as drivers/serial/8250.h or include/linux/serial_8250.h .
I need to access its "acr" member from my own translation unit
(for the purposes of 16C950 TEMT-based RS485 RX/TX steering).

2.) consider removing some unnecessary init stuff related to the 16C950
from 8250.c. It harms my 16C950 RX/TX steering setup, by resetting the
acr register and the acr member within the struct uart_8250_port.
See the attached small patch.
It also turns "struct uart_8250_port serial8250_ports[]" into a public symbol, 
to make the structs accessible from other translation units.

If you've read this far, thanks for your kind attention...

Frank Rysanek

--Message-Boundary-20171
Content-type: text/plain; charset=US-ASCII
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any other MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  8250.c.patch
     Date:  10 Jul 2007, 23:15
     Size:  931 bytes.
     Type:  Unknown

--Message-Boundary-20171
Content-type: Application/Octet-stream; name="8250.c.patch"; type=Unknown
Content-disposition: attachment; filename="8250.c.patch"
Content-transfer-encoding: BASE64

LS0tIGRyaXZlcnMvc2VyaWFsLzgyNTAuYy5vbGQJMjAwNi0wOC0yOCAxNTo1NToxMC4wMDAw
MDAwMDAgKzAyMDANCisrKyBkcml2ZXJzL3NlcmlhbC84MjUwLmMJMjAwNi0wOC0yOCAxNjow
MzozNi4wMDAwMDAwMDAgKzAyMDANCkBAIC0xNTA3LDE1ICsxNTA3LDE3IEBADQogDQogCWlm
ICh1cC0+cG9ydC50eXBlID09IFBPUlRfMTZDOTUwKSB7DQogCQkvKiBXYWtlIHVwIGFuZCBp
bml0aWFsaXplIFVBUlQgKi8NCi0JCXVwLT5hY3IgPSAwOw0KKwkJLy91cC0+YWNyID0gMDsN
CiAJCXNlcmlhbF9vdXRwKHVwLCBVQVJUX0xDUiwgMHhCRik7DQogCQlzZXJpYWxfb3V0cCh1
cCwgVUFSVF9FRlIsIFVBUlRfRUZSX0VDQik7DQogCQlzZXJpYWxfb3V0cCh1cCwgVUFSVF9J
RVIsIDApOw0KIAkJc2VyaWFsX291dHAodXAsIFVBUlRfTENSLCAwKTsNCisjaWYgMA0KIAkJ
c2VyaWFsX2ljcl93cml0ZSh1cCwgVUFSVF9DU1IsIDApOyAvKiBSZXNldCB0aGUgVUFSVCAq
Lw0KIAkJc2VyaWFsX291dHAodXAsIFVBUlRfTENSLCAweEJGKTsNCiAJCXNlcmlhbF9vdXRw
KHVwLCBVQVJUX0VGUiwgVUFSVF9FRlJfRUNCKTsNCiAJCXNlcmlhbF9vdXRwKHVwLCBVQVJU
X0xDUiwgMCk7DQorI2VuZGlmDQogCX0NCiANCiAjaWZkZWYgQ09ORklHX1NFUklBTF84MjUw
X1JTQQ0KQEAgLTIwODksNyArMjA5MSw4IEBADQogCS52ZXJpZnlfcG9ydAk9IHNlcmlhbDgy
NTBfdmVyaWZ5X3BvcnQsDQogfTsNCiANCi1zdGF0aWMgc3RydWN0IHVhcnRfODI1MF9wb3J0
IHNlcmlhbDgyNTBfcG9ydHNbVUFSVF9OUl07DQorc3RydWN0IHVhcnRfODI1MF9wb3J0IHNl
cmlhbDgyNTBfcG9ydHNbVUFSVF9OUl07DQorRVhQT1JUX1NZTUJPTChzZXJpYWw4MjUwX3Bv
cnRzKTsNCiANCiBzdGF0aWMgdm9pZCBfX2luaXQgc2VyaWFsODI1MF9pc2FfaW5pdF9wb3J0
cyh2b2lkKQ0KIHsNCg==

--Message-Boundary-20171--
