From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Mon, 23 Aug 2010 22:06:15 +0200
Message-ID: <1282593975.3526.9.camel@utx.lan>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55397 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab0HWUGS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Aug 2010 16:06:18 -0400
In-Reply-To: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Jason Wang wrote:
> Sorry for resending this thread. Last thread is forgot to CC
> Greg Kroah-Hartman.

Well, I experienced no_console_supend breakage on my PXA270 based Zauru=
s
SL-C3200 (terrier/spitz) as well.

But your patches did not fix the behavior, serial port remains dead
after resume with no_console_supend.

> The [1/2] fix this situation:
> we set no_console_supend and console=3DttyS0 to bootargs, then bootup
> the kernel, the boot logs will print out from ttyS0. When we execute
> echo mem > /sys/power/state, the system will suspend, we press a
> key(or other wakeup trigger) to resume the system, but the ttyS0 can'=
t
> work anymore.
>=20
> The [2/2] fix this situation:
> we set console=3DttyS0 to bootargs, then bootup the kernel, the boot
> logs will print out from ttyS0, this time we set ttyS1 as tty and
> login for shell. When we execute echo mem > /sys/power/state, the
> system will suspend, we press a key(or other wakeup trigger) to
> resume the system, but the ttyS0 can't work anymore.

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
