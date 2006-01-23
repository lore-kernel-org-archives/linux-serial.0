From: Stephen Hemminger <shemminger@osdl.org>
Subject: JSM driver build problem
Date: Mon, 23 Jan 2006 12:29:15 -0800
Message-ID: <20060123122915.3e8d2166@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:58070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932383AbWAWU3T (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Jan 2006 15:29:19 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.or.uk>
Cc: linux-serial@vger.kernel.org

Build failure in current linux-2.6 git tree.
I am not using it, it was in my .config by accident...


  CC [M]  drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function =E2=80=98jsm_input=E2=80=99:
drivers/serial/jsm/jsm_tty.c:592: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:619: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:620: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:623: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:624: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:667: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:668: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:669: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:670: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:671: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:672: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:674: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:677: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:677: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:677: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:677: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:680: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:681: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:682: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:691: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:692: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:693: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:694: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:695: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:696: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:698: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:701: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:701: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:701: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:701: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:742: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
drivers/serial/jsm/jsm_tty.c:742: error: =E2=80=98struct tty_struct=E2=80=
=99 has no member named =E2=80=98flip=E2=80=99
make[3]: *** [drivers/serial/jsm/jsm_tty.o] Error 1
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
