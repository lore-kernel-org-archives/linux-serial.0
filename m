Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AAA34D390
	for <linux-serial@vger.kernel.org>; Fri, 13 Feb 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975258; cv=none; b=MxxBzkkW0C7fVVt6tXD8s71eIpvox9s/t+FEvOIpwXPSPXoYrsMhfw0X+3J6hXmatQTOAoAaSMS06v78MWymMn/jEw+XAEYboY9r7aRx69I/qNSOhxjo7HEVotp9Y2S7cV4paAJZokCJfX7vSJEAI3L55kewuMx74LcSQDtfrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975258; c=relaxed/simple;
	bh=AjAQ9hB4nplAGoRec2x8+NEuCRJzfSCskPyqkluv504=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTtY6X60h6MkoFLm17/msPzaOMnypuE3yfEOc7Dddt3rqoAr6Vx2BF7JTqrMNg1ngaS8UVmYhKHGh8huxnrCbj+B7LPpSV1lxupHv2jXxxJ3CzX6RHNoCicrJCZyx8xYr573fpiaJpu5eVwPndi2W2FIERh8yi86ZnP/KxWFVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=LK2+2daR; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="LK2+2daR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=J82kEampmF
	AU+kFZ/mmlp5kiMLjyQngXCQNJMfZm9mY=; b=LK2+2daRUBgzIfPi7tIPcUMP5j
	pD44mIv9iGad9FIfd8qK0uPUnk213qaYnekp0JjJeLyyoct5LNGLV4Mjire3SwYo
	sgB+n1x4KU+H7ybMRHyVDhKd8CzmnXWXZPWYE6P5qy+J/wQhEaAQ7QtVyVb7rHwR
	XhFH6qnYh68qXrl38=
Received: from mail.ustc.edu.cn (unknown [116.130.208.26])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHssL2745p89E8AA--.917S2;
	Fri, 13 Feb 2026 17:33:45 +0800 (CST)
From: LiuQingtao <qtliu@mail.ustc.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	bjorn.andersson@oss.qualcomm.com,
	marex@nabladev.com,
	dev@kael-k.io,
	mani@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	hu.yuye@zte.com.cn,
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	jia.yunxiang@zte.com.cn,
	bai.lu5@zte.com.cn,
	yang.susheng@zte.com.cn,
	shen.lin1@zte.com.cn,
	tan.hu@zte.com.cn,
	zuo.jiang@zte.com.cn
Subject: [PATCH v1 0/2] LRW UART: Patch series for LRW UART driver
Date: Fri, 13 Feb 2026 17:33:32 +0800
Message-ID: <20260213093334.9217-1-qtliu@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHssL2745p89E8AA--.917S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrykAFy8KFW5Gr45XFy8Grg_yoWxZrX_Cw
	s7Wa9rZr18ZF1rKa92yr1FkrWYvr4UZFyrW3Z8tas5ZFZxArZ5Ga4qqwnFvan7Ga1UCFn5
	Ar1xWr1Ivrs8WjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8uwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jP8n5UUUUU=
X-CM-SenderInfo: 5twox3o6pdxzwoxv3uoohg3hdfq/1tbiARERAGmN67Eo2QAIsG

From: Wenhong Liu <liu.wenhong35@zte.com.cn>

This patch series introduce the driver for LRW UART
  dt-bindings: serial: Add binding for LRW UART
  tty: serial: add driver for the LRW UART

 .../bindings/serial/lrw,lrw-uart.yaml         |   49 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |   10 +
 drivers/tty/serial/Kconfig                    |   33 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/lrw_uart.c                 | 2822 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 7 files changed, 2920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
 create mode 100644 drivers/tty/serial/lrw_uart.c

-- 
2.27.0

