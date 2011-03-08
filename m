From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH v2 2/2] n_gsm: fix UIH control byte : P bit should be 0
Date: Tue,  8 Mar 2011 22:15:54 +0100
Message-ID: <1299618954-4742-2-git-send-email-eric@eukrea.com>
References: <20110308130145.3bacbe1b@lxorguk.ukuu.org.uk>
 <1299618954-4742-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 9.26.mail-out.ovh.net ([46.105.56.220]:51815 "HELO
	26.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756846Ab1CHVmw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 16:42:52 -0500
In-Reply-To: <1299618954-4742-1-git-send-email-eric@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, mirq@rere.qmqm.pl, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

* the GSM 07.10 specification says in 5.4.3.1 that
'both stations shall set the P bit to 0'
  thanks to Alan Cox for finding this explanation in the spec

* without this fix, on Telit & Sim.com modems, opening a new DLC
randomly fails. Not setting PF bit of the control byte gives a
reliable behaviour on these modems.

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
v2 : updated patch and comment following Alan's review

 drivers/tty/n_gsm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index aa2e5d3..6613918 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1250,8 +1250,7 @@ static void gsm_control_response(struct gsm_mux *=
gsm, unsigned int command,
=20
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_contr=
ol *ctrl)
 {
-	struct gsm_msg *msg =3D gsm_data_alloc(gsm, 0, ctrl->len + 1,
-							gsm->ftype|PF);
+	struct gsm_msg *msg =3D gsm_data_alloc(gsm, 0, ctrl->len + 1, gsm->ft=
ype);
 	if (msg =3D=3D NULL)
 		return;
 	msg->data[0] =3D (ctrl->cmd << 1) | 2 | EA;	/* command */
--=20
1.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
