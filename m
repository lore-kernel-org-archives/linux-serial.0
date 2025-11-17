Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95682264C7;
	Mon, 17 Nov 2025 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763352463; cv=none; b=oJZyK/kCsE2aFiDl4Xl1Y1V3Jdh0kiYIoMHCE1C2+N6VFD6/a/MRtdkWhcnTPnOcZWf4L2u4u1EnTgU3YMcnwRTK0YW7HHv/jBzDEHFVZbj/LrBW+yzTklrcviIbX4kIJNUyAF8Hfn9gn2fCILVc+MF97aoGbdUuioZV4vKFok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763352463; c=relaxed/simple;
	bh=WVVzN0VHM4+E51StAHZQ1752xa5evWlBY6UghPSulHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzzRjMnDBcgmkOon1KdZPKoFx8B1etATNFbopdnielc9pzT9SSJlI8rRFVhOhym4THC1ov3x/p/lkUq8lAFwiANLXLKVE2oBBtz6UPTGLsLl0TMjdEiuIFDGpypeIYhDmEEafZ28HCFesQtL9iHoqUHJbdCzh375pGPzSyIw1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAXpdeGnxppyAUIAQ--.20798S2;
	Mon, 17 Nov 2025 12:07:36 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Charles Han <hanchunchao@inspur.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] serial: icom: Convert PCIBIOS_* return codes to errnos
Date: Mon, 17 Nov 2025 12:07:10 +0800
Message-ID: <20251117040710.1544-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXpdeGnxppyAUIAQ--.20798S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw43KFyfXr4fWrW8GF48WFg_yoWDJFc_C3
	ZrGwn7GFyUCFy2grnxCrW5ZrySv3WDZFn5WrnYga4fGr9rJFZrJFyq9rnIvr47Ww4DJFyY
	krnxuryxCrnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoJA2kag5dUkwABsn

icom_probe() uses pci_read_config_dword() that returns PCIBIOS_*
codes. The return code is returned from the probe function as is but
probe functions should return normal errnos. A proper implementation
can be found in drivers/leds/leds-ss4200.c

Convert PCIBIOS_* return codes using pcibios_err_to_errno() into
normal errno before returning them.

Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/tty/serial/icom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 7fb995a8490e..566c05511b0f 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1723,6 +1723,7 @@ static int icom_probe(struct pci_dev *dev,
 	retval = pci_read_config_dword(dev, PCI_COMMAND, &command_reg);
 	if (retval) {
 		dev_err(&dev->dev, "PCI Config read FAILED\n");
+		retval = pcibios_err_to_errno(retval);
 		goto probe_exit0;
 	}
 
-- 
2.50.1.windows.1

