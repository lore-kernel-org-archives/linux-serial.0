From: Guillaume Juan <guillaume.juan@sagemcom.com>
Subject: [PATCH] n_gsm: prevent crash due to dereferencing NULL gsm->tty
Date: Fri, 26 Oct 2012 10:11:45 +0200
Message-ID: <26026_1351239109_508A45C4_26026_63_1_508A45C1.3010407@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.smmp-rueil.gmessaging.net ([81.80.3.134]:42447 "EHLO
	smtp1.smmp-rueil.gmessaging.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757043Ab2JZIWI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Oct 2012 04:22:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org

=46rom: Guillaume Juan <guillaume.juan@sagemcom.com>

If gsm->tty happens to be NULL in gsmld_output, avoid crashing the kern=
el (the crash is replaced by a warning dump).
Prevent at earlier level such situation:
- gsmtty_hangup does no longer call gsm_dlci_begin_close when called sy=
nchronously from gsm_cleanup_mux, because this would arm a timer that w=
ill asynchronously lead to use gms->tty, potentially after it is nullif=
ied.
- in gsm_cleanup_mux, release DLCIs (other than DLCI#0 which is the con=
trol one) before closing mux. Else, it can happen that the T2 timer is =
rearmed by another thread scheduled between del_timer_sync and gsm_dlci=
 release
(for example by the following call-stack: fput =3D> tty_release =3D> tt=
y_port_close_start =3D> tty_port_lower_dtr_rts =3D> gsm_dtr_rts =3D> gs=
mtty_modem_update)

Signed-off-by: Guillaume Juan <guillaume.juan@sagemcom.com>
---
 drivers/tty/n_gsm.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1e8e8ce..fe3c6ad 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1510,8 +1510,8 @@ static void gsm_dlci_begin_open(struct gsm_dlci *=
dlci)
 }
=20
 /**
- *	gsm_dlci_begin_close	-	start channel open procedure
- *	@dlci: DLCI to open
+ *	gsm_dlci_begin_close	-	start channel close procedure
+ *	@dlci: DLCI to close
  *
  *	Commence closing a DLCI from the Linux side. We issue DISC messages
  *	to the modem which should then reply with a UA, at which point we
@@ -2031,6 +2031,13 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 	spin_unlock(&gsm_mux_lock);
 	WARN_ON(i =3D=3D MAX_MUX);
=20
+	/* Free up any link layer users */
+	if (dlci)
+		dlci->dead =3D 1;
+	for (i =3D 1; i < NUM_DLCI; i++)
+		if (gsm->dlci[i])
+			gsm_dlci_release(gsm->dlci[i]);
+
 	/* In theory disconnecting DLCI 0 is sufficient but for some
 	   modems this is apparently not the case. */
 	if (dlci) {
@@ -2041,15 +2048,11 @@ void gsm_cleanup_mux(struct gsm_mux *gsm)
 	del_timer_sync(&gsm->t2_timer);
 	/* Now we are sure T2 has stopped */
 	if (dlci) {
-		dlci->dead =3D 1;
 		gsm_dlci_begin_close(dlci);
 		wait_event_interruptible(gsm->event,
 					dlci->state =3D=3D DLCI_CLOSED);
+		gsm_dlci_release(dlci);
 	}
-	/* Free up any link layer users */
-	for (i =3D 0; i < NUM_DLCI; i++)
-		if (gsm->dlci[i])
-			gsm_dlci_release(gsm->dlci[i]);
 	/* Now wipe the queues */
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
 		kfree(txq);
@@ -2192,6 +2195,10 @@ EXPORT_SYMBOL_GPL(gsm_alloc_mux);
=20
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 {
+	if (gsm->tty =3D=3D NULL) {
+		WARN(1, "NULL gsm->tty pointer in gsmld_output\n");
+		return -EINVAL;
+	}
 	if (tty_write_room(gsm->tty) < len) {
 		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
 		return -ENOSPC;
@@ -2323,7 +2330,7 @@ static void gsmld_flush_buffer(struct tty_struct =
*tty)
  *	@tty: device
  *
  *	Called from the terminal layer when this line discipline is
- *	being shut down, either because of a close or becsuse of a
+ *	being shut down, either because of a close or because of a
  *	discipline change. The function will not be called while other
  *	ldisc methods are in progress.
  */
@@ -2954,6 +2961,15 @@ static void gsmtty_close(struct tty_struct *tty,=
 struct file *filp)
 	gsm =3D dlci->gsm;
 	if (tty_port_close_start(&dlci->port, tty, filp) =3D=3D 0)
 		goto out;
+	/* Should not happen because the DLCI ttys are hung up (which causes
+	   tty_port_close_start to return 0) by gsm_dlci_release before setti=
ng
+	   gsm->tty to NULL */
+	if (gsm->tty =3D=3D NULL) {
+		WARN(1, "NULL gsm->tty pointer in gsmtty_close for %s\n",
+			tty->name);
+		goto out;
+	}
+
 	gsm_dlci_begin_close(dlci);
 	tty_port_close_end(&dlci->port, tty);
 	tty_port_tty_set(&dlci->port, NULL);
@@ -2967,7 +2983,8 @@ static void gsmtty_hangup(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci =3D tty->driver_data;
 	tty_port_hangup(&dlci->port);
-	gsm_dlci_begin_close(dlci);
+	if (!dlci->gsm->dead)
+		gsm_dlci_begin_close(dlci);
 }
=20
 static int gsmtty_write(struct tty_struct *tty, const unsigned char *b=
uf,
--=20
1.7.0.4



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
