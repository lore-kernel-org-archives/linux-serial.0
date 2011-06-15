From: Greg KH <gregkh@suse.de>
Subject: Re: PROBLEM:  BUG and system dies if cat /proc/tty/driver/serial
 while console on ttyS0
Date: Wed, 15 Jun 2011 08:28:08 -0700
Message-ID: <20110615152808.GA9928@suse.de>
References: <COL116-W65B54193A5784AAE0E1505A36B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40376 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755787Ab1FOP33 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 11:29:29 -0400
Content-Disposition: inline
In-Reply-To: <COL116-W65B54193A5784AAE0E1505A36B0@phx.gbl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Lumby <johnlumby@hotmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, Jun 15, 2011 at 11:08:51AM -0400, John Lumby wrote:
>=20
> If I direct kernel console output to the serial port ttyS0
> =A0by grub kernel command line like so
> =A0 =A0 =A0 =A0 =A0 kernel /vmlinuz-2.6.39-FLG ro root=3D/dev/sdb3 ro=
otfstype=3Dext3 selinux=3D0 console=3DttyS0,19200n8r console=3Dtty0
> then console output appears at the other end of the ttyS0 as expected=
,  but then if I log in (on local tty1) and
>=20
> cat /proc/tty/driver/serial
>=20
> I get this=A0 (on 2.6.39)
>=20
> BUG:   sleeping function called from invalid context at arch/x86/mm/f=
ault.c:1087
> and the system is dead.

This should be resolved in the next 2.6.39.y release, and should also b=
e
fixed in the 3.0-rc3 kernel.  Can you verify that?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
