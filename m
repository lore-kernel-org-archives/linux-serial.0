From: Anup Patel <anup@brainfault.org>
Subject: [PATCH 2/3] RISC-V: defconfig: Enable RISC-V SBI earlycon support
Date: Tue,  4 Dec 2018 19:25:06 +0530
Message-ID: <20181204135507.3706-3-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@infradead.org>, Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Anup Patel <anup@brainfault.org>
List-Id: linux-serial@vger.kernel.org

This patch enables RISC-V SBI earlycon support in default defconfig
so that we can use "earlycon=sbi" in kernel parameters for early
debug prints.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ef4f15df9adf..f399659d3b8d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
-- 
2.17.1
