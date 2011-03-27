From: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Subject: [PATCH] tty/n_gsm: fix bug in CRC calculation for gsm1 mode
Date: Sun, 27 Mar 2011 04:05:00 +0400
Message-ID: <1301184300-9158-1-git-send-email-mikhail.kshevetskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, stable@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Problem description:
  gsm_queue() calculate a CRC for arrived frames. As a last step of
  CRC calculation it call

    gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);

  This work perfectly for the case of GSM0 mode as gsm->received_fcs
  contain the last piece of data required to generate final CRC.

  gsm->received_fcs is not used for GSM1 mode. Thus we put an
  additional byte to CRC calculation. As result we get a wrong CRC
  and reject incoming frame.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
---
 drivers/tty/n_gsm.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 176f632..4806276 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1658,8 +1658,12 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	if ((gsm->control & ~PF) == UI)
 		gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf, gsm->len);
-	/* generate final CRC with received FCS */
-	gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
+	if (gsm->encoding == 0){
+		/* WARNING: gsm->received_fcs is used for gsm->encoding = 0 only.
+		            In this case it contain the last piece of data
+		            required to generate final CRC */
+		gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
+	}
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
 		if (debug & 4)
-- 
1.7.4.1

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
