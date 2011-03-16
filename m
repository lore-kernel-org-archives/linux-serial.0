From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 74/76] n_gsm: fix UIH control byte : P bit should be 0
Date: Wed, 16 Mar 2011 14:12:44 -0700
Message-ID: <1300309966-5745-74-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32981 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023Ab1CPVPj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:39 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

=46rom: Eric B=C3=A9nard <eric@eukrea.com>

* the GSM 07.10 specification says in 5.4.3.1 that
'both stations shall set the P bit to 0'
  thanks to Alan Cox for finding this explanation in the spec

* without this fix, on Telit & Sim.com modems, opening a new DLC
randomly fails. Not setting PF bit of the control byte gives a
reliable behaviour on these modems.

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0d90be4..176f632 100644
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
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
