From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Wed, 25 Aug 2010 22:00:35 +0200
Message-ID: <1282766435.5085.178.camel@utx.lan>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
	 <1282593975.3526.9.camel@utx.lan>
	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>
	 <1282733489.5085.35.camel@utx.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49508 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab0HYUAj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2010 16:00:39 -0400
In-Reply-To: <1282733489.5085.35.camel@utx.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: wanghui <Hui.Wang@windriver.com>
Cc: jason wang <jason77.wang@gmail.com>, gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Stanislav Brabec wrote:
> wanghui wrote:  =20
> > For this situation, i guess you use a single serial port both as a
> > printk console and as a login tty.
>=20
> Yes, I did exactly that.

Well, I just succeeded with experiments.
Changing
if (console_suspend_enabled || !uart_console(uport)) {
in resume process just above the line
/* Protected by port mutex for now */
to
if (1) {
makes resume working with no_console_suspend again. So one of lines
inside does something important.

Even then, the log is incomplete. dmesg shows more, but even it lacks
printk output from inside of if (1).

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
