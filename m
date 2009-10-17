From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC] serial_cs: remove noop
Date: Sat, 17 Oct 2009 19:09:50 +0200
Message-ID: <20091017170950.GA23886@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: linux-pcmcia@lists.infradead.org
Cc: rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Sat, 17 Oct 2009 18:19:34 +0200
Subject: [PATCH 4/5] serial_cs: remove noop

In the only case "tuple" is used afterwards, tuple->DesiredTuple is
explicitely set to CISTPL_CFTABLE_ENTRY. Therefore, remove useless
assignments to other values.

CC: linux-serial@vger.kernel.org
CC: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index ff4617e..47162d9 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -715,7 +715,6 @@ static int serial_config(struct pcmcia_device * link)
 	info->multi = (first_tuple(link, tuple, parse) == 0);
 
 	/* Is this a multiport card? */
-	tuple->DesiredTuple = CISTPL_MANFID;
 	info->manfid = link->manf_id;
 	info->prodid = link->card_id;
 
@@ -730,7 +729,6 @@ static int serial_config(struct pcmcia_device * link)
 
 	/* Another check for dual-serial cards: look for either serial or
 	   multifunction cards that ask for appropriate IO port ranges */
-	tuple->DesiredTuple = CISTPL_FUNCID;
 	if ((info->multi == 0) &&
 	    (link->has_func_id) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
-- 
1.6.0.4
