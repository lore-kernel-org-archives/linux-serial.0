Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648711;
	b=urdmg3rVGjyeR+vJWG383Dyk3YqQnvmELtMeKmmrGommMfr0l5liKXlTAKbFQeyYvswy
	 jbJN68XeznuivQ5HMTsU/MJMzLY+PuIxDHNTswQV1NEW07/K6IdvA31wvoXDdDiNkBzj9
	 o2ZU7e4YjqDOBJZph7TNcnjvlMUikevXojBQ/GxBuy/l78fIX0tkBFdhhyxsyV5cSn3Lh
	 yDaEczV3fLlKRnrenYpOkIdHRhOd21shUZkPr4dWTshfJHM/cFNfuLfAuu5w12KWiW7r2
	 LkDd/w4EgOkgZrluS3rRSGzthgFviNAkaAWlAw7cKqrTG1GqfGvK6Ooifs1aYmoPvAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648711;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=e3wyVq9vmesK47PV94Sx8ujXeiZquP7DA2efEV/rlqQ=;
	b=ln7mPrshfjCpLrzFNzEW9RG+iRAWovSBL9MiV5YtwZF2pXmc5u5orRIiaGgfchRlbqv8
	 VbXe+lz4YbFu1dbXdp0wPRqZEHD9tIVT7Lz1xS10x0BXvY7rwp4ae/T4YIl+/oqFLPl12
	 dNrsD22bDLGnjrD6AfhGCayUDe3+ue5UnzBfppX4cO8aj8exXKeKnPQ15Cwy6o7Q0v400
	 8dJdhTdXORTjEFts4W/RoA0KzvUldN7YcMa6guci9IG3aKEtavdpO2SFtWBR3o7z30WaT
	 wIRYF/B65N+c3Q2iHNKUL8GPD5ZVXWwxFJPLp6/XzYSl0yNqz3+w8ZG7BNH0+cRxKsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fJW/ky92";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00721606A332;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJW/ky92
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648710;
	b=W5mye46dV6eVilcTStENA6pBQHSNwYHfEzlSK7ruTASkeuG8NLDyV/p4TWYaMQpjkFyz
	 Y9zSfGgqB0NPbW6pVfeErLmmr2kgA5s/E7Xnh+2PyHN1PhOidOLvv44QobU5k6nR/LUXw
	 fCFy9CWfZhqa+/btl1zSE3tLRGekdKrlsxtRVW44pVD2EsxIAGTh0J7K7zufghjLNMCpR
	 roUZu197IPHwUZpjtd+lu93PwhXRLrcFFoRjNOyNNBJGW4fz7rMTiAWOTt1aEc4LAjau0
	 pBvkaDJfusdUb4VcTZAKgREpgZdiD9fRswiWNWCMGTk9HyT3SMFOeKOGB8rLp6hEh2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648710;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=e3wyVq9vmesK47PV94Sx8ujXeiZquP7DA2efEV/rlqQ=;
	b=GJ+X+WedL/wGi8GgVKiE2bnGAvRPVfzQjYNEM9XnLshhubN0ewsIkHkiKEpMQoZiNf2t
	 d4HgLWNNzVkJXLHnoTUBKNbeq1N2bgAIJ/DjV9/PdMY+56XJ6kud9v4zX9/ky7B4kZ/8W
	 MquPDLNSLNHlsLrivJrQI6pLeOqamzFWUpQUlgrQH3ImmyN6Z9SEY4UqqJ96MqoiygrmX
	 pd3VmJR4zSmeXItMBHm0kEtLNbPlUv5wMM96wu9K0HcUSA/vT81I+sFcwYFvQabrcS4c4
	 jH5xxv/TcjwAsOqDgw2AV6UtoLOcMFWJAPE2dJVi7OSXwYEwujmviNPlnmbSiOvN7rg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52CB21F00A17;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648710;
	bh=e3wyVq9vmesK47PV94Sx8ujXeiZquP7DA2efEV/rlqQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=fJW/ky92fxwpwbc7VuH44QuN9FXCIeLK7v3Gsw6fwtFCu+mgVJoM0qN3Fhdtc0Iud
	 fWWD9xv2XzIyLQSIt+Xy2K6QTk8BdrUO/2jhR/MntL/LwytF8msyx6bJrC25P/gANY
	 yLBwqcWCdy018mCljxld3eK5OZVOJA1hLQmHkXD3RfNSKdVcQTTOzoeIbYAjLfrfSl
	 IIt484omUMXAltU2VQdJOxl7jntYNM5ftWmhJlqi02Fei5GMfR0JH9K8yShLkFLrtd
	 LoNoCXDZ2l2cYzk4XuHtvk4c+vEiDM+uMWaSj3IoF4GctB5PeG9+XZ7mZeI7x4FI0k
	 hBnNXCCNVZqKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9DC7D46606;
	Mon,  2 Nov 2026 19:45:08 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Subject: [PATCH RFC v3 00/17] riscv: add initial Zhihe A210 support using
 SCMI clocks and resets
Date: Tue, 03 Nov 2026 03:45:03 +0800
Message-Id: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQqCQBRGX0XuupGZ8ZdWQdADtA0X451r3kCNu
 SaF+O6pbVuej8P5ZhAKTALHaIZAEwsP/QrJIQJsXX8nxX5lsNrmRttCOWu0EuxYESa28WjT3OW
 w+s9ADb/31g2ulzNUv1Fe9YNw3Cqb1rKMQ/jsj5PZ5T/xySititRnJVKZ1b48saCT2GGMPVTLs
 nwBTHa3R7sAAAA=
X-Change-ID: 20261027-a210-scmi-ec32fdc246a6
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=6929;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=qJnpOKYgSY+CxvvdscVQfHlmE8/VuKqhLVuhLq3Ax30=;
 b=oL9F7FE3HXj7HVFebcOJhByBbwziul9m3Bk09rFP/ffuYVyXoih5Jxi7YcqKrY0E3qoTot39e
 ZTGO3GEKrk8CCZE/ASC6Xv2b4p2uCZT4RlEQtgwqQr/6cSlcukdh3QL
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

This adds initial support for the Zhihe A210 SoC and the Melon Pi V1
and V2 boards.

The A210 has four C908V and four C920V2 cores, plus an E902 management
core. The E902 firmware handles clocks, resets, power, the PMIC and
CPU DVFS, so Linux uses SCMI for clocks and resets. The only new SCMI
piece is the mailbox to the E902. [2] explains why I picked SCMI over
RPMI.

The series adds the mailbox, the pin controller, the UARTs and their
bindings and DTs. On v7.4-rc1 with the riscv defconfig, a Melon Pi V2
boots to a shell on the serial console with all eight CPUs online.

The numbering follows [1], as Bartosz asked, so the RFC [2] is v2 and
this is v3.

Conor asked about vendor firmware. We are talking to Zhihe about SCMI
support in their firmware. Until that is settled, mainline needs the
firmware below, so this is still an RFC.

The E902 runs a Zephyr based SCMI server [3]. The rest of the boot
chain is coreboot [4], OpenSBI [5] and EDK2 [6][7]. The full Linux tree
with the other peripherals is at [8].

[1] https://lore.kernel.org/r/20261022-a210-init-v1-0-5e438f972d24@iscas.ac.cn
[2] https://lore.kernel.org/r/20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn
[3] https://github.com/RevySR/zephyr/tree/xuantie/scmi-v3
[4] https://github.com/revyos/coreboot/tree/a210/scmi-v3
[5] https://github.com/revyos/opensbi/tree/a210/scmi-v3
[6] https://github.com/revyos/edk2/tree/a210/scmi-v3
[7] https://github.com/revyos/ruyiedk2/tree/a210/scmi-v3
[8] https://github.com/RevySR/linux/tree/a210/scmi-v3

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
Changes in v3:
- Rebase on v7.4-rc1, and add zhihe,a210-uart to the list of DW APB
  UARTs with two resets.
- arm_scmi: drop the ARM dependency instead of adding RISCV (Michal).
  Build tested on x86_64 without OF, i386, loongarch64, ppc64le and
  riscv64 (Sudeep).
- Move the SCMI clock and reset IDs from dt-bindings to headers next
  to the DTS, as the firmware assigns them (Conor).
- mailbox binding: use fixed "local" and "remote" regions and add blank
  lines between properties (Conor). Drop the clocks, as the firmware
  keeps the mailboxes running, and call it a mailbox, not a doorbell.
- mailbox driver: don't request a shared interrupt.
- pinctrl: rename to pinctrl-zhihe-a210.c and PINCTRL_ZHIHE_A210, drop
  the 64BIT dependency and a forward declaration, comment the register
  layout and the ____ placeholder, and round drive strength up (Linus).
  Don't include mod_devicetable.h (Uwe).
- pinctrl: drop PERI3. It comes back with the SDIO controller, as pins
  and function, with the shared mux handled in the driver (Conor).
- pinctrl: use one function name per kind, like gpio, spi or pwm, and
  number them only where a pad can pick an instance, as for the UARTs
  (Conor).
- pinctrl: use pm_sleep_ptr() instead of #ifdef CONFIG_PM_SLEEP, and
  don't use dev_err_probe() in resume.
- defconfig: drop SRAM, the SCMI mailbox transport and the SCMI reset
  driver. SCMI maps its shared memory itself, and the other two are
  enabled by default with SCMI. Shorten the NR_UARTS explanation.
- dts: use 0x1000 regions for uart0 and uart4, like the other UARTs.
- dts: describe the PLIC M-mode contexts with 11 instead of -1.
- Spell the vendor name Zhihe everywhere.
- Add Conor's acks.
- Link to v2 (sent as RFC): https://patch.msgid.link/20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn

Changes in v2 (sent as RFC):
- Replace the native clock and reset drivers with SCMI. Conor pointed
  out that the clock blocks were not modelled right, and the E902
  firmware uses those registers too.
- Add the AP to E902 mailbox driver as the SCMI transport, and allow
  arm_scmi transports on RISC-V.
- Add dt-bindings headers for the SCMI clock and reset IDs.
- Add zhihe,a210-uart with separate APB and serial resets (Philipp).
- pinctrl: take the pad resets from SCMI, explain the SDIO pad names
  and the shared SDIO mux bit, and order pin nodes as pins, function,
  then config (Conor).
- defconfig: explain why SERIAL_8250_NR_UARTS is 10 (Conor).
- Link to v1: https://patch.msgid.link/20261022-a210-init-v1-0-5e438f972d24@iscas.ac.cn

---
Han Gao (9):
      firmware: arm_scmi: Drop the ARM architecture dependency
      dt-bindings: mailbox: add Zhihe A210 AP to E902 mailbox
      mailbox: add Zhihe A210 AP to E902 mailbox driver
      dt-bindings: timer: add Zhihe A210 CLINT
      dt-bindings: serial: snps-dw-apb-uart: add Zhihe A210 UART
      riscv: dts: zhihe: add A210 module memory
      riscv: dts: zhihe: add Melon Pi V1 and V2
      riscv: defconfig: enable A210 support
      MAINTAINERS: add Zhihe A210

Zhiguo Zhu (8):
      dt-bindings: vendor-prefixes: add Zhihe
      riscv: add Zhihe A210 support
      dt-bindings: pinctrl: add Zhihe A210 pin controller
      pinctrl: zhihe: add A210 support
      dt-bindings: interrupt-controller: add Zhihe A210 PLIC
      dt-bindings: riscv: add Melon Pi V1 and V2
      riscv: dts: zhihe: add A210 core support
      riscv: dts: zhihe: add A210 UARTs

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 .../bindings/mailbox/zhihe,a210-ap-mailbox.yaml    |  67 ++
 .../bindings/pinctrl/zhihe,a210-pinctrl.yaml       | 146 +++
 Documentation/devicetree/bindings/riscv/zhihe.yaml |  27 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |   6 +-
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  12 +
 arch/riscv/Kconfig.socs                            |  10 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/zhihe/Makefile                 |   2 +
 arch/riscv/boot/dts/zhihe/a210-clock.h             |  15 +
 arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi |  55 ++
 arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts      |   9 +
 arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts      |   9 +
 arch/riscv/boot/dts/zhihe/a210-reset.h             |  13 +
 arch/riscv/boot/dts/zhihe/a210-som.dtsi            |  11 +
 arch/riscv/boot/dts/zhihe/a210.dtsi                | 593 ++++++++++++
 arch/riscv/configs/defconfig                       |   7 +
 drivers/firmware/arm_scmi/Kconfig                  |   1 -
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-a210.c                     | 176 ++++
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-zhihe-a210.c               | 996 +++++++++++++++++++++
 26 files changed, 2183 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261027-a210-scmi-ec32fdc246a6

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>


