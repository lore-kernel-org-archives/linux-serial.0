Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D4283C9D;
	Fri, 31 Jul 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508253; cv=none; b=sNS4Wan66JUD8xg+knMECKuttePHlr/ePo4SmwDOE3a919q6Ttk9xeucpZIqf3gslGMi3W7TN3PUtESmpYeG4OvIhMnabORxMN88639GQXSWpggw2lNZKcThm/95F5+O2/jT+j17mqeWICkP7rzDuf7dhtmcEWzNBo2XEi/Q8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508253; c=relaxed/simple;
	bh=7yzwy4sbjY8sQCQarNwdB/DmD1o6JsPOO9utRCvoWds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSk++7ZsBUqtzrBEpLunaaAADHd7EesMubMvAcW2lkdO/cNGEex1qrdBx5nC0KxeZSPjrwXFi8/JGc+W4RNzpWdWaS7xSghdHfcS9fgCG88yrSInRA+ro6QpEEjD3yjkk4dIuqAcsWdZwWZ+HlLMeOcZiNBInpE70m4NCK5/dqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=7WAynChz reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="7WAynChz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7yzwy4sbjY8sQCQarNwdB/DmD1o6JsPOO9
	utRCvoWds=; b=7WAynChzW/3EzvDSFfqi8uOhl/FFt1KBoF/4T065zFEjOotTmB
	gmhw1vWyvbc9sKPyI/Jb3ocx44QsjdjcFWne6E5bxiZ5zYFN2NNzC5//bApkEPQN
	psSe3hp0yzvpffa3UR5bzyb9H2nI1pu6zb9UZyIplqIGag//TrxLjIjmw=
Received: from localhost (unknown [120.221.100.92])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkA2fjOTsWxqwCmxAQ--.8975S2;
	Fri, 31 Jul 2026 22:30:43 +0800 (CST)
From: Xincheng Wang <22009200607@stu.xidian.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xincheng Wang <22009200607@stu.xidian.edu.cn>
Subject: Re: [PATCH] tty: limit TCSBRKP break duration
Date: Fri, 31 Jul 2026 22:30:41 +0800
Message-Id: <20260731143041.6400-1-22009200607@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026072921-curled-moonlike-1207@gregkh>
References: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn> <2026072700-causal-remarry-6edf@gregkh> <20260729111927.41154-1-22009200607@stu.xidian.edu.cn> <2026072921-curled-moonlike-1207@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkA2fjOTsWxqwCmxAQ--.8975S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxAqzx
	v26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUe6pBDUUU
	U
X-CM-SenderInfo: qssqimasqqliux6v33wo0lvxldqovvfxof0/

Hi Greg,

Yes, it would still be user-visible.

My concern is that tty_ioctl() first multiplies the TCSBRKP argument by
100 before passing it to send_break(), whose duration argument is
unsigned int. For values above UINT_MAX / 100, the current behavior uses
the low 32 bits of the multiplied product, which can be a duration very
different from the requested interval.

But I agree that rejecting or saturating that value would also change
current behavior. Would you be open to a fix for this, or would you
rather leave the path as-is?

Thanks,
Xincheng

