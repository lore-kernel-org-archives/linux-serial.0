Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671EB67E;
	Sun,  4 Aug 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753435; cv=none; b=m+uB+I5YBbEiWv8MhyJxtmLXhmXSwfgXAIoUGYhi08ZNk7v8W0T3qxGD0PrIKM0/cZY8kxLFLR/kAXB826bRtZRVrNovcnjzE6+bliRUg8bej9cG6M3twqMOV2RWS3tMrL41mw0OOqEbelNoG+Aq2gMEdryLcj6FnM+GUYP35wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753435; c=relaxed/simple;
	bh=cJIdwziKQqmSeY72vNUrkuCmXVbZJvQADfQ9ksYZzLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI0BncPFxmIo7pDCX/XNwN0P+ILK1lCl+WOs45apP4lRKNFzhHcvMls5nxeY3mNTU6NqRKAfz5/zOJGas8VPGiuEcdsctEi2EMbBwLa+fdl7RxPejTi9lkvhNl+/9TvP8kz7S7T0ifSl1727areH2E0acwlkShPLujV+QCOOFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8AxmOmPIa9mr2sHAA--.24156S3;
	Sun, 04 Aug 2024 14:37:03 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMAxouGOIa9m3qYCAA--.15253S2;
	Sun, 04 Aug 2024 14:37:02 +0800 (CST)
From: zhenghaowei@loongson.cn
To: zhenghaowei@loongson.cn,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v2 0/3] uart: Introduce uart driver for the Loongson family chips
Date: Sun,  4 Aug 2024 14:36:07 +0800
Message-ID: <20240804063610.69873-1-zhenghaowei@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxouGOIa9m3qYCAA--.15253S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQETBGauHPMDgQABsz
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr4xGF1xuFW8ArWktr18WFX_yoWkKwbEka
	s2kas7Gw1xGF13ta4UXr47Cry3ZF4UZ3Zaka40q34rZ39Iv3y5JFWqv34DGF17WrWUWFn5
	JrWxGr10yrnFqosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb6AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8J3kJUUUUU==

From: Haowei Zheng <zhenghaowei@loongson.cn>

Hi all:

This patchset introduce a generic UART framework driver for Loongson family.
It can be found on Loongson3 series cpus, Loongson-2K series cpus and Loongson 
LS7A bridge chips.

Thanks.

Haowei Zheng (3):
  dt-bindings: serial: Add Loongson UART controller
  tty: serial: 8250: Add loongson uart driver support
  LoongArch: dts: Update UART driver to Loongson-2K0500, Loongson-2K1000
    and Loongson-2K2000.

 .../bindings/serial/loongson,ls7a-uart.yaml   |  74 +++++++
 MAINTAINERS                                   |   7 +
 arch/loongarch/boot/dts/loongson-2k0500.dtsi  |   6 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi  |   6 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi  |   5 +-
 drivers/tty/serial/8250/8250_loongson.c       | 208 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |   8 +
 drivers/tty/serial/8250/Kconfig               |   9 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/uapi/linux/serial_core.h              |   1 +
 10 files changed, 322 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c

-- 
2.43.0

