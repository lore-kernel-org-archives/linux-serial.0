From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] tty/synclink: remove ISA support
Date: Mon, 11 Feb 2019 14:25:34 +0100
Message-ID: <20190211132534.29407-2-hch@lst.de>
References: <20190211132534.29407-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211132534.29407-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ISA support in this driver is horribly outdated and the last
driver that passes a NULL dev argument to the DMA mapping routines.

Drop the support, if someone wants to go through the work of converting
it to a proper isa_driver we can resurrect it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/synclink.c | 54 ------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index d55c858d6058..84f26e43b229 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -4325,41 +4325,6 @@ static int mgsl_init_tty(void)
 	return 0;
 }
 
-/* enumerate user specified ISA adapters
- */
-static void mgsl_enum_isa_devices(void)
-{
-	struct mgsl_struct *info;
-	int i;
-		
-	/* Check for user specified ISA devices */
-	
-	for (i=0 ;(i < MAX_ISA_DEVICES) && io[i] && irq[i]; i++){
-		if ( debug_level >= DEBUG_LEVEL_INFO )
-			printk("ISA device specified io=%04X,irq=%d,dma=%d\n",
-				io[i], irq[i], dma[i] );
-		
-		info = mgsl_allocate_device();
-		if ( !info ) {
-			/* error allocating device instance data */
-			if ( debug_level >= DEBUG_LEVEL_ERROR )
-				printk( "can't allocate device instance data.\n");
-			continue;
-		}
-		
-		/* Copy user configuration info to device instance data */
-		info->io_base = (unsigned int)io[i];
-		info->irq_level = (unsigned int)irq[i];
-		info->irq_level = irq_canonicalize(info->irq_level);
-		info->dma_level = (unsigned int)dma[i];
-		info->bus_type = MGSL_BUS_TYPE_ISA;
-		info->io_addr_size = 16;
-		info->irq_flags = 0;
-		
-		mgsl_add_device( info );
-	}
-}
-
 static void synclink_cleanup(void)
 {
 	int rc;
@@ -4403,7 +4368,6 @@ static int __init synclink_init(void)
 
  	printk("%s %s\n", driver_name, driver_version);
 
-	mgsl_enum_isa_devices();
 	if ((rc = pci_register_driver(&synclink_pci_driver)) < 0)
 		printk("%s:failed to register PCI driver, error=%d\n",__FILE__,rc);
 	else
@@ -5025,12 +4989,6 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	info->mbre_bit = BIT8;
 	outw( BIT8, info->io_base );			/* set Master Bus Enable (DCAR) */
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable DMAEN (Port 7, Bit 14) */
-		/* This connects the DMA request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT15) & ~BIT14));
-	}
-
 	/* DMA Control Register (DCR)
 	 *
 	 * <15..14>	10	Priority mode = Alternating Tx/Rx
@@ -6007,12 +5965,6 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 
 	usc_EnableMasterIrqBit( info );
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable INTEN (Port 6, Bit12) */
-		/* This connects the IRQ request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
-	}
-
 	if (info->params.loopback) {
 		info->loopback_bits = 0x300;
 		outw(0x0300, info->io_base + CCAR);
@@ -6107,12 +6059,6 @@ static void usc_set_sync_mode( struct mgsl_struct *info )
 	usc_loopback_frame( info );
 	usc_set_sdlc_mode( info );
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable INTEN (Port 6, Bit12) */
-		/* This connects the IRQ request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
-	}
-
 	usc_enable_aux_clock(info, info->params.clock_speed);
 
 	if (info->params.loopback)
-- 
2.20.1
