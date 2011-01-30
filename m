From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RFC] serial-core: reset the console speed on resume
Date: Sun, 30 Jan 2011 01:20:58 +0100
Message-ID: <1296346859.5397.29.camel@utx.lan>
References: <20110125104302.GM3315@kai-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110125104302.GM3315@kai-debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Yin Kangkai <kangkai.yin@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, Greg KH <greg@kroah.com>, Deepak Saxena <dsaxena@laptop.org>, Jason Wang <jason77.wang@gmail.com>, Daniel Drake <dsd@laptop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Yin Kangkai wrote on Tue 25 Jan 2011 at 18:43 +0800:

> On some platforms, we need to restore the console speed on resume eve=
n
> it was not suspended (no_console_suspend), and on others we don't hav=
e
> to do that.
>=20
> So don't care about the "console_suspend_enabled" and unconditionally
> reset the console speed if it is a console.

Well, there is currently another breakage on Zaurus. But it improves th=
e
situation.
(Note: Your patch has bad file path. I'll agree with such change after
this fix.)

Test report on Zaurus
(serial hardware itself is in undefined state after resume):

                                       before  after
login:                                   OK     OK
console:                               broken broken
console + login:                         OK     OK
console + no_console_suspend:          broken broken
login + no_console_suspend:              OK     OK
console + login + no_console_suspend:  broken   OK

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/
