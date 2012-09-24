From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] Powerpc 8xx CPM_UART desynchronisation
Date: Mon, 24 Sep 2012 08:17:08 +0200
Message-ID: <201209240617.q8O6H8ED029430@localhost.localdomain>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

This patch fixes a desynchronisation problem with CPM UART driver on
Powerpc MPC8xx. The problem happens if data is received before the device
is open by the user application.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

--- linux-3.5-vanilla/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-08-09 17:38:37.000000000 +0200
@@ -417,6 +417,7 @@
 			clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR);
 			clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_RX);
 		}
+		cpm_uart_initbd(pinfo);
 		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 	}
 	/* Install interrupt handler. */
