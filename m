From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] serial: sh-sci: use of_property_read_bool()
Date: Sun, 13 Aug 2017 22:07:39 +0300
Message-ID: <20170813190811.352748420@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline; filename=serial-sh-sci-use-of_property_read_bool.patch
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "\"open list:SERIAL DRIVERS\"" <linux-serial@vger.kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

Use more compact of_property_read_bool() call for a boolean property
instead  of of_find_property() call in sci_parse_dt().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.

 drivers/tty/serial/sh-sci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: tty/drivers/tty/serial/sh-sci.c
===================================================================
--- tty.orig/drivers/tty/serial/sh-sci.c
+++ tty/drivers/tty/serial/sh-sci.c
@@ -3073,8 +3073,7 @@ static struct plat_sci_port *sci_parse_d
 	p->type = SCI_OF_TYPE(match->data);
 	p->regtype = SCI_OF_REGTYPE(match->data);
 
-	if (of_find_property(np, "uart-has-rtscts", NULL))
-		sp->has_rtscts = true;
+	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
 	return p;
 }
