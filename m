From: Guillaume JUAN <guillaume.juan@sagemcom.com>
Subject: n_gsm issues
Date: Wed, 1 Aug 2012 17:36:40 +0200
Message-ID: <440_1343835403_50194D0B_440_1588_1_OF108ABE84.7A08D19F-ONC1257A4D.00556998-C1257A4D.0055C11D@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.smmp-rueil.gmessaging.net ([81.80.3.134]:36212 "EHLO
	smtp1.smmp-rueil.gmessaging.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582Ab2HAPpm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Aug 2012 11:45:42 -0400
Received: from smtp1.smmp-rueil.gmessaging.net (localhost.localdomain [127.0.0.1])
	by localhost.smmp-rueil.gmessaging.net (Postfix) with SMTP id EA70C33402A
	for <linux-serial@vger.kernel.org>; Wed,  1 Aug 2012 17:36:43 +0200 (CEST)
Received: from chels01sc.ads.local (unknown [194.51.18.80])
	by smtp1.smmp-rueil.gmessaging.net (Postfix) with ESMTP id 9FA613345F9
	for <linux-serial@vger.kernel.org>; Wed,  1 Aug 2012 17:36:43 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi,

=46or an embedded project with Linux inside, I am using the kernel N_GS=
M line
discipline (linux/drivers/tty/n_gsm.c)

It is great to have the 3GPP 27.010 multiplexing protocol integrated as=
 a
kernel driver (previous project used user-space gsmMuxd instead),
and I am thankful for that.

However it happened I struck on some problems with n_gsm.

Who can I contact to discuss issues / submit fixes ?


Examples of problems I spotted:

- gsmld_output can cause a kernel panic dereferencing null pointer
gsm->tty.
This happens especially because gsm_ttty_hangup() calls
gsm_dlci_begin_close() even in the gsm->dead case, leading to asynchron=
ous
send (from timer T1) after gsm->tty was set null.
gsm_tty_hangup() is called synchronously from gsm_cleanup_mux() via
gsm_dlci_release(), a few insstructions before gsmld_detach_gsm() sets
gsmt->tty null.

- When a virtual tty is closed from user-space, the operation is not fu=
lly
synchronous: DISC requests can be sent on the DLCI after the system cal=
l
has returned.
This is because gsmtty_close does not wait for event DLCI_CLOSED after
calling gsm_dlci_begin_close.

- On line discipline attach, n_gsm use default settings that have no ch=
ance
to match what I set in the modem
and when I do the TIOCSETCONF ioctl to configure it correctly, this
previous settings cause it to call gsm_cleanup_mux(), leading to delays=
 and
useless commands to the modem (that won't be answered).

- The CLD command encoding is not strictly compliant with 3GPP 27.010
The TLV built does not have any L byte, whereas it should have one
indicating a zero length for the value field.
The modem I use accept this variant but some may not.

- The understanding of n_gsm as regards line discipline removal seems t=
o
conflict with the logic in the upper tty layer.
In its line discipline removal callback, n_gsm tries to send commands t=
o
the modem to close the mux and wait for the confirmation, but this is b=
ound
to fail at least partially
because the tty layer does not seem to contemplate that the line discip=
line
makes a final use of the tty at this step:
* When gsmld_close is called because the last field descriptor was clos=
ed:
The commands it tries to send will not even reach the modem because
uart_shutdown has already been closed.
As a result the modem will stay in multiplexing mode and next time we s=
end
it a (non-multiplexed) AT command it will not understand it.
* When gsmld_close is called because of a line discipline change (i.e. =
an
ioctl resets the tty discipline to something different from N_GSM):
The commands can reach the modem, but the line discipline will never ge=
ts
the modem answer
because tty_set_ldisc() intentionally sets tty->receive_room to 0 and c=
alls
tty_ldisc_halt() just before calling tty_ldisc_close().
As a result n_gsm uselessly retries the commands with T1 timer because =
it
does not see the answer.

This issue is the most disturbing for me, as I consequently can see no =
way
to end mux session in a fully satisfying way.


Thanks in advance for your feedback.

Best regards,

Guillaume Juan


#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=E8re priv=E9. S'ils ne =
vous sont
pas destin=E9s, nous vous signalons qu'il est strictement interdit de l=
es
divulguer, de les reproduire ou d'en utiliser de quelque mani=E8re que =
ce
soit le contenu. Si ce message vous a =E9t=E9 transmis par erreur, merc=
i d'en
informer l'exp=E9diteur et de supprimer imm=E9diatement de votre syst=E8=
me
informatique ce courriel ainsi que tous les documents qui y sont attach=
=E9s."


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachm=
ents
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise th=
e
sender immediately and delete this e-mail and all attached documents
from your computer system."
#

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
