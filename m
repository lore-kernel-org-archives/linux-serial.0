From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4 v2] ARM: mach-shmobile: add SCIFA and SCIFB DMA slave
 definitions for sh7372
Date: Sun, 23 May 2010 18:39:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231836090.3571@axis700.grange>
References: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

SH7372 can use DMA with the SCI serial driver. Add required slave IDs and slave
descriptors.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

No need to move DMA platform devices to the top, they are placed correctly 
by the new version of the

[PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable DMA for SDHI

patch

 arch/arm/mach-shmobile/include/mach/sh7372.h |   14 +++++
 arch/arm/mach-shmobile/setup-sh7372.c        |   70 ++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 57e033a..c2d2d81 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -433,6 +433,20 @@ enum {
 
 /* DMA slave IDs */
 enum {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SCIF6_TX,
+	SHDMA_SLAVE_SCIF6_RX,
 	SHDMA_SLAVE_SDHI0_RX,
 	SHDMA_SLAVE_SDHI0_TX,
 	SHDMA_SLAVE_SDHI1_RX,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index cc040a8..ce50184 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -62,6 +62,76 @@ enum {
 
 static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
 	{
+		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
+		.addr		= 0xe6c40020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
+		.addr		= 0xe6c40024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
+		.addr		= 0xe6c50020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x25,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
+		.addr		= 0xe6c50024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x26,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0xe6c60020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0xe6c60024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
+		.addr		= 0xe6c70020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
+		.addr		= 0xe6c70024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
+		.addr		= 0xe6c80020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x39,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
+		.addr		= 0xe6c80024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_TX,
+		.addr		= 0xe6cb0020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x35,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_RX,
+		.addr		= 0xe6cb0024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x36,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_TX,
+		.addr		= 0xe6c30040,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_RX,
+		.addr		= 0xe6c30060,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3e,
+	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
 		.addr		= 0xe6850030,
 		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
-- 
1.6.2.4

