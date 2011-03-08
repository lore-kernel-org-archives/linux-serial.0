From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH 1/2] n_gsm: improve behaviour with encoding 0
Date: Tue,  8 Mar 2011 01:24:31 +0100
Message-ID: <1299543872-14580-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 6.27.mail-out.ovh.net ([46.105.50.195]:36336 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751344Ab1CHAvb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Mar 2011 19:51:31 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

* on Telit & Sim.com modems, using encoding 0, opening a new DLC
randomly fails. Not setting PF bit of the control byte gives a
reliable behaviour on these modems.

* note that the detailed documentation of CMUX for both these
modems doesn't set this bit when sending the UIH frame with the
MSC command :
http://www.telit.com/module/infopool/download.php?id=3D616
http://wm.sim.com/sim/News/photo/2010721161442.pdf

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/tty/n_gsm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9a71b57..38efedb 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1251,7 +1251,7 @@ static void gsm_control_response(struct gsm_mux *=
gsm, unsigned int command,
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_contr=
ol *ctrl)
 {
 	struct gsm_msg *msg =3D gsm_data_alloc(gsm, 0, ctrl->len + 1,
-							gsm->ftype|PF);
+					gsm->ftype|(gsm->encoding ? PF : 0));
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
