Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052E472792;
	Wed, 29 Jul 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323987; cv=none; b=VDRTURvPH9khoNh8zJycY58Oa+VKbo+HDIAkKjOek4EwV3uKIfOdzPBFR61zy+0ymUW5dvvYzBQnli0MxeAlzXWm+udJ1RaE6S1njFJ6RfwSWXyHOigNp+ZkIME49VfBNycaH+CySUq7K7U8QnVZcT2R0HV7woOEVuJo7L7gLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323987; c=relaxed/simple;
	bh=oiQOe9UjS38rhyr/aN98o0RG7WzHyhcVenzrn2x3ars=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfnKuMZkYO7kLdcGxSLj2FuKJSSZ5j9ju4QVCDUbur4l8wUyrbxi/tCPNwOikKvU8eVg+toV4vufEyF0Qh1jb8EvCrgPxDsbtxGxUeBvvtcXFj7c+vPJ89cHmPX2C6zjdz6/Qv2I/+Y9YFMG0kLex7iG/0/ex1p4pyuc1mhI9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=fgityIQ1 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="fgityIQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=oiQOe9UjS38rhyr/aN98o0RG7WzHyhcVen
	zrn2x3ars=; b=fgityIQ1idt4kr1bhtJHafN4P5CesJlT0vgAg24WGs17cs9YKp
	q1iiVCHsQz1QL/O6vTovg2dOG9EttGunBjAlwjemkdP4nbHZnnXeFUJ+tma2nf9G
	NNkd2liWBBPXLnNg/MZCieJOiobnmwFqbCfOFYa51Vcrg7IYFJA/DvIdA=
Received: from localhost (unknown [120.221.12.135])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkAmSA7B4WlqFQybAQ--.10490S2;
	Wed, 29 Jul 2026 19:19:30 +0800 (CST)
From: Xincheng Wang <22009200607@stu.xidian.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xincheng Wang <22009200607@stu.xidian.edu.cn>
Subject: Re: [PATCH] tty: limit TCSBRKP break duration
Date: Wed, 29 Jul 2026 19:19:27 +0800
Message-Id: <20260729111927.41154-1-22009200607@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026072700-causal-remarry-6edf@gregkh>
References: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn> <2026072700-causal-remarry-6edf@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkAmSA7B4WlqFQybAQ--.10490S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxAqzx
	v26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0mhFDUUU
	U
X-CM-SenderInfo: qssqimasqqliux6v33wo0lvxldqovvfxof0/

Hi Greg,

Thanks for the review.

You are right. The RCU stall I observed does not by itself justify
clamping long break intervals in the tty core, so I will drop that
patch.

While looking at this path, I noticed that tty_ioctl() multiplies the
TCSBRKP argument by 100 and passes the result to send_break(), whose
duration argument is unsigned int. Values whose product exceeds UINT_MAX
are silently truncated to an unintended duration.

Do you think it is worth fixing that separately by rejecting TCSBRKP
values that cannot fit in the unsigned-int millisecond duration used by
send_break()?

Thanks,
Xincheng

