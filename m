From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 27/75] And here's a patch (to be applied on top of the last)
	which prevents
Date: Fri, 02 Jan 2009 13:44:27 +0000
Message-ID: <20090102134425.13472.32303.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60344 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757326AbZABNoN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:44:13 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>

this happening again by making use of 'const'.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/8250_pci.c |   37 +++++++++++++++++++++----------------
 include/linux/8250_pci.h  |    2 +-
 2 files changed, 22 insertions(+), 17 deletions(-)


diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 057b532..0b79413 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -42,7 +42,8 @@ struct pci_serial_quirk {
 	u32	subvendor;
 	u32	subdevice;
 	int	(*init)(struct pci_dev *dev);
-	int	(*setup)(struct serial_private *, struct pciserial_board *,
+	int	(*setup)(struct serial_private *,
+			 const struct pciserial_board *,
 			 struct uart_port *, int);
 	void	(*exit)(struct pci_dev *dev);
 };
@@ -107,7 +108,7 @@ setup_port(struct serial_private *priv, struct uart_port *port,
  * ADDI-DATA GmbH communication cards <info@addi-data.com>
  */
 static int addidata_apci7800_setup(struct serial_private *priv,
-				struct pciserial_board *board,
+				const struct pciserial_board *board,
 				struct uart_port *port, int idx)
 {
 	unsigned int bar = 0, offset = board->first_offset;
@@ -134,7 +135,7 @@ static int addidata_apci7800_setup(struct serial_private *priv,
  * Not that ugly ;) -- HW
  */
 static int
-afavlab_setup(struct serial_private *priv, struct pciserial_board *board,
+afavlab_setup(struct serial_private *priv, const struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -188,8 +189,9 @@ static int pci_hp_diva_init(struct pci_dev *dev)
  * some serial ports are supposed to be hidden on certain models.
  */
 static int
-pci_hp_diva_setup(struct serial_private *priv, struct pciserial_board *board,
-	      struct uart_port *port, int idx)
+pci_hp_diva_setup(struct serial_private *priv,
+		const struct pciserial_board *board,
+		struct uart_port *port, int idx)
 {
 	unsigned int offset = board->first_offset;
 	unsigned int bar = FL_GET_BASE(board->flags);
@@ -306,7 +308,7 @@ static void __devexit pci_plx9050_exit(struct pci_dev *dev)
 
 /* SBS Technologies Inc. PMC-OCTPRO and P-OCTAL cards */
 static int
-sbs_setup(struct serial_private *priv, struct pciserial_board *board,
+sbs_setup(struct serial_private *priv, const struct pciserial_board *board,
 		struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -463,7 +465,7 @@ static int pci_siig_init(struct pci_dev *dev)
 }
 
 static int pci_siig_setup(struct serial_private *priv,
-			  struct pciserial_board *board,
+			  const struct pciserial_board *board,
 			  struct uart_port *port, int idx)
 {
 	unsigned int bar = FL_GET_BASE(board->flags) + idx, offset = 0;
@@ -534,7 +536,8 @@ static int pci_timedia_init(struct pci_dev *dev)
  * Ugh, this is ugly as all hell --- TYT
  */
 static int
-pci_timedia_setup(struct serial_private *priv, struct pciserial_board *board,
+pci_timedia_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar = 0, offset = board->first_offset;
@@ -568,7 +571,7 @@ pci_timedia_setup(struct serial_private *priv, struct pciserial_board *board,
  */
 static int
 titan_400l_800l_setup(struct serial_private *priv,
-		      struct pciserial_board *board,
+		      const struct pciserial_board *board,
 		      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
@@ -770,7 +773,8 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 }
 
 static int
-pci_default_setup(struct serial_private *priv, struct pciserial_board *board,
+pci_default_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
 		  struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset, maxnr;
@@ -1099,7 +1103,7 @@ static struct pci_serial_quirk *find_quirk(struct pci_dev *dev)
 }
 
 static inline int get_pci_irq(struct pci_dev *dev,
-				struct pciserial_board *board)
+				const struct pciserial_board *board)
 {
 	if (board->flags & FL_NOIRQ)
 		return 0;
@@ -1894,8 +1898,8 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 }
 
 static inline int
-serial_pci_matches(struct pciserial_board *board,
-		   struct pciserial_board *guessed)
+serial_pci_matches(const struct pciserial_board *board,
+		   const struct pciserial_board *guessed)
 {
 	return
 	    board->num_ports == guessed->num_ports &&
@@ -1906,7 +1910,7 @@ serial_pci_matches(struct pciserial_board *board,
 }
 
 struct serial_private *
-pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board)
+pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 {
 	struct uart_port serial_port;
 	struct serial_private *priv;
@@ -2039,7 +2043,8 @@ static int __devinit
 pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	struct serial_private *priv;
-	struct pciserial_board *board, tmp;
+	const struct pciserial_board *board;
+	struct pciserial_board tmp;
 	int rc;
 
 	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
@@ -2066,7 +2071,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 		 * We matched one of our class entries.  Try to
 		 * determine the parameters of this board.
 		 */
-		rc = serial_pci_guess_board(dev, board);
+		rc = serial_pci_guess_board(dev, &tmp);
 		if (rc)
 			goto disable;
 	} else {
diff --git a/include/linux/8250_pci.h b/include/linux/8250_pci.h
index 3209dd4..b24ff08 100644
--- a/include/linux/8250_pci.h
+++ b/include/linux/8250_pci.h
@@ -31,7 +31,7 @@ struct pciserial_board {
 struct serial_private;
 
 struct serial_private *
-pciserial_init_ports(struct pci_dev *dev, struct pciserial_board *board);
+pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board);
 void pciserial_remove_ports(struct serial_private *priv);
 void pciserial_suspend_ports(struct serial_private *priv);
 void pciserial_resume_ports(struct serial_private *priv);

