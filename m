From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 31/39] pcmcia: deprecate CS_NO_MORE_ITEMS
Date: Mon, 18 Aug 2008 20:53:22 +0200
Message-ID: <1219085610-12289-31-git-send-email-linux@dominikbrodowski.net>
References: <20080818185025.GA11647@comet.dominikbrodowski.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:35881 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760839AbYHRSyB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2008 14:54:01 -0400
In-Reply-To: <20080818185025.GA11647@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-serial@vger.kernel.org, Michael Buesch <mb@bu3sch.de>

CS_NO_MORE_ITEMS is returned by the CIS tuple reading and parsing code if
the end of a tuple chain is reached. As at least one PCMCIA driver relies
on matching this return value, replace it with -ENOSPC which is now
uniquely used for this purpose within the in-kernel pcmcia subsystem.

CC: Russell King <rmk+kernel@arm.linux.org.uk>
CC: linux-serial@vger.kernel.org
CC: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/cistpl.c          |   10 +++++-----
 drivers/pcmcia/ds.c              |    2 +-
 drivers/pcmcia/pcmcia_ioctl.c    |    2 +-
 drivers/pcmcia/pcmcia_resource.c |    2 +-
 drivers/serial/serial_cs.c       |    2 +-
 drivers/ssb/pcmcia.c             |    2 +-
 include/pcmcia/cs.h              |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index 7454d82..858cca6 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -450,7 +450,7 @@ int pccard_get_first_tuple(struct pcmcia_socket *s, unsigned int function, tuple
 	if (pccard_get_next_tuple(s, function, tuple) == 0) {
 	    tuple->DesiredTuple = CISTPL_LINKTARGET;
 	    if (pccard_get_next_tuple(s, function, tuple) != 0)
-		return CS_NO_MORE_ITEMS;
+		return -ENOSPC;
 	} else
 	    tuple->CISOffset = tuple->TupleLink = 0;
 	tuple->DesiredTuple = req;
@@ -526,7 +526,7 @@ int pccard_get_next_tuple(struct pcmcia_socket *s, unsigned int function, tuple_
 	/* End of chain?  Follow long link if possible */
 	if (link[0] == CISTPL_END) {
 	    if ((ofs = follow_link(s, tuple)) < 0)
-		return CS_NO_MORE_ITEMS;
+		return -ENOSPC;
 	    attr = SPACE(tuple->Flags);
 	    read_cis_cache(s, attr, ofs, 2, link);
 	}
@@ -584,7 +584,7 @@ int pccard_get_next_tuple(struct pcmcia_socket *s, unsigned int function, tuple_
     }
     if (i == MAX_TUPLES) {
 	cs_dbg(s, 1, "cs: overrun in pcmcia_get_next_tuple\n");
-	return CS_NO_MORE_ITEMS;
+	return -ENOSPC;
     }
     
     tuple->TupleCode = link[0];
@@ -606,7 +606,7 @@ int pccard_get_tuple_data(struct pcmcia_socket *s, tuple_t *tuple)
 	return -EINVAL;
 
     if (tuple->TupleLink < tuple->TupleOffset)
-	return CS_NO_MORE_ITEMS;
+	return -ENOSPC;
     len = tuple->TupleLink - tuple->TupleOffset;
     tuple->TupleDataLen = tuple->TupleLink;
     if (len == 0)
@@ -1488,7 +1488,7 @@ int pccard_validate_cis(struct pcmcia_socket *s, unsigned int function, unsigned
        cards have only a broken VERS_2 tuple; hence the bogus test. */
     if ((pccard_read_tuple(s, function, CISTPL_MANFID, p) == 0) ||
 	(pccard_read_tuple(s, function, CISTPL_VERS_1, p) == 0) ||
-	(pccard_read_tuple(s, function, CISTPL_VERS_2, p) != CS_NO_MORE_ITEMS))
+	(pccard_read_tuple(s, function, CISTPL_VERS_2, p) != -ENOSPC))
 	ident_ok++;
 
     if (!dev_ok && !ident_ok)
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index cb8e241..edbd85b 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -88,7 +88,7 @@ static const lookup_t error_table[] = {
     { CS_BAD_ARGS,		"Bad arguments" },
     { -EACCES,			"Configuration locked" },
     { CS_IN_USE,		"Resource in use" },
-    { CS_NO_MORE_ITEMS,		"No more items" },
+    { -ENOSPC,			"No more items" },
     { CS_OUT_OF_RESOURCE,	"Out of resource" },
     { CS_BAD_TUPLE,		"Bad CIS tuple" }
 };
diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
index 6df9058..5367634 100644
--- a/drivers/pcmcia/pcmcia_ioctl.c
+++ b/drivers/pcmcia/pcmcia_ioctl.c
@@ -972,7 +972,7 @@ static int ds_ioctl(struct inode * inode, struct file * file,
 	    err = -EBUSY; break;
 	case CS_OUT_OF_RESOURCE:
 	    err = -ENOSPC; break;
-	case CS_NO_MORE_ITEMS:
+	case -ENOSPC:
 	    err = -ENODATA; break;
 	case -ENOSYS:
 	    err = -ENOSYS; break;
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 049e29f..0c99536 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -211,7 +211,7 @@ int pcmcia_get_window(struct pcmcia_socket *s, window_handle_t *handle,
 		if (s->state & SOCKET_WIN_REQ(w))
 			break;
 	if (w == MAX_WIN)
-		return CS_NO_MORE_ITEMS;
+		return -EINVAL;
 	win = &s->win[w];
 	req->Base = win->ctl.res->start;
 	req->Size = win->ctl.res->end - win->ctl.res->start + 1;
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 17fbff5..be2be45 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -432,7 +432,7 @@ first_tuple(struct pcmcia_device *handle, tuple_t * tuple, cisparse_t * parse)
 	int i;
 	i = pcmcia_get_first_tuple(handle, tuple);
 	if (i != 0)
-		return CS_NO_MORE_ITEMS;
+		return i;
 	i = pcmcia_get_tuple_data(handle, tuple);
 	if (i != 0)
 		return i;
diff --git a/drivers/ssb/pcmcia.c b/drivers/ssb/pcmcia.c
index 9699308..fbfadba 100644
--- a/drivers/ssb/pcmcia.c
+++ b/drivers/ssb/pcmcia.c
@@ -733,7 +733,7 @@ int ssb_pcmcia_get_invariants(struct ssb_bus *bus,
 			break;
 		}
 		res = pcmcia_get_next_tuple(bus->host_pcmcia, &tuple);
-		if (res == CS_NO_MORE_ITEMS)
+		if (res == -ENOSPC)
 			break;
 		GOTO_ERROR_ON(res != 0, "VEN next tpl");
 		res = pcmcia_get_tuple_data(bus->host_pcmcia, &tuple);
diff --git a/include/pcmcia/cs.h b/include/pcmcia/cs.h
index 2dc1411..20440de 100644
--- a/include/pcmcia/cs.h
+++ b/include/pcmcia/cs.h
@@ -315,7 +315,7 @@ typedef struct error_info_t {
 #define CS_BAD_ARGS		0x1c
 #define CS_CONFIGURATION_LOCKED	-EACCES
 #define CS_IN_USE		-EBUSY
-#define CS_NO_MORE_ITEMS	0x1f
+#define CS_NO_MORE_ITEMS	-ENOSPC
 #define CS_OUT_OF_RESOURCE	-ENOMEM
 #define CS_BAD_HANDLE		-EINVAL
 
-- 
1.5.4.3

