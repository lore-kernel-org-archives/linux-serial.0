From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH v2 1/4] MIPS: OCTEON: Set proper UART clock in internal device trees.
Date: Wed, 19 Jun 2013 14:37:26 -0700
Message-ID: <1371677849-23912-2-git-send-email-ddaney.cavm@gmail.com>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

From: David Daney <david.daney@cavium.com>

Following patch to use generic 8250 drivers will need proper clock
information.  So when using the internal device tree, populate the
"clock-frequency" property with the correct value.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 389512e..7b746e7 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -490,8 +490,15 @@ int __init octeon_prune_device_tree(void)
 
 		if (alias_prop) {
 			uart = fdt_path_offset(initial_boot_params, alias_prop);
-			if (uart_mask & (1 << i))
+			if (uart_mask & (1 << i)) {
+				__be32 f;
+
+				f = cpu_to_be32(octeon_get_io_clock_rate());
+				fdt_setprop_inplace(initial_boot_params,
+						    uart, "clock-frequency",
+						    &f, sizeof(f));
 				continue;
+			}
 			pr_debug("Deleting uart%d\n", i);
 			fdt_nop_node(initial_boot_params, uart);
 			fdt_nop_property(initial_boot_params, aliases,
-- 
1.7.11.7
