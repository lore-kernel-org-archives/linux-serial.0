From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Mon, 30 Aug 2010 00:17:37 +0200
Message-ID: <1283120257.17967.24.camel@utx.lan>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
	 <1282593975.3526.9.camel@utx.lan>
	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>
	 <1282733489.5085.35.camel@utx.lan> <1282766435.5085.178.camel@utx.lan>
	 <4C762ADC.8080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42915 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335Ab0H2WRj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 29 Aug 2010 18:17:39 -0400
In-Reply-To: <4C762ADC.8080309@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Jason Wang wrote:

> Hah, :), i guess the ops->set_termios() resume your uart in the end.
> Why lost some logs, i will try to reproduce your test.

I'll try and ask you to test verify that my new patch does not break
your platform.

Anyway, now I know, what I did bad. Your patch makes things better on
some platforms and does not break others.

Acked-by: Stanislav Brabec <sbrabec@suse.cz>

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
