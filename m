Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6956303A07;
	Wed, 26 Nov 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168450; cv=none; b=jnVix4VoQ7e/0FKUCCAe/QuuCqVJwc3n3fmahHBmV+do4bAaNxitFhBdsRCw9P9ZbqtJ0xHde3svF/x/iBBPrs0yS/XhOZlt20DiBa1Rw8lvnMhQts/4pRL3gcVey5o4bunlCqTgx0MUfHis5smifiBHegM9Nt7mHK55ZimNUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168450; c=relaxed/simple;
	bh=nNZuDjUUX40k181EdfgWM9nRuLEqXqEcWcFFtpNuwqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlnLsheRvby6IMQ/8Kk3xJEz7TH0AOO5Fg75tDpr5zOrYPHGbv5HfwvgbPX36pIperksJ4wbjMdSTj7TURs9japS4+Qk8YDT8xyuR4Azu1T9BwzlqgnJ+HE6I2ssCM7lsP75cOAgtn5tzGRpJ0/ndT9XhFFUppVT4Qe7zzwU5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gWLCc6GZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gWLCc6GZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Or
	LJ5RnzxdcuSxO6QWxutyrR3uTW9B83ZnMQjPKjHUs=; b=gWLCc6GZ1g++l6rOR8
	EsE9GI/fVwmBqpRNu6ojYiH/pzJUeOdmEWua+NBtxD/eHP8vnR4oMdnvRcPLYt2Z
	IaFJ+8uqHCDZoexPuZ6761mnOpuJ2fsivopkbb16EV/5/0Y0ghsYHi0MIjtaIZZQ
	aVxoEtD4lzOhHBD/TLeX3a5wM=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCHb1vaEidpn+nTCQ--.3197S2;
	Wed, 26 Nov 2025 22:46:51 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Date: Wed, 26 Nov 2025 22:46:50 +0800
Message-Id: <20251126144650.2799567-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025112654-shaping-undoing-afe4@gregkh>
References: <2025112654-shaping-undoing-afe4@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHb1vaEidpn+nTCQ--.3197S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRQSdvUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxzf6WknEtwWPAAA3-

On Wed, 26 Nov 2025 13:10:49 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> I don't know, what have you found in your testing?  Will multiple
> workqueues cause too much overhead for large multi-port systems (i.e.
> modem banks?)
> 
> Perhaps start with just a single workqueue and then increase it if there
> is contention later if people notice?

OK. I will allocate single workqueue of one tty_driver in v4, simplifying
the logic for creating and releasing the workqueue.

--
Xin Zhao

