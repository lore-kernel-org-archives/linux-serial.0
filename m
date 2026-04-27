Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152E37C112;
	Mon, 27 Apr 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275282; cv=none; b=WcN3F8xmyHN6HVq/bDSYpNcDvrBoOGiJpEh1XR+qCmsv63wYlgrmlEYkqMCcB5YvfNYFY9U9jDh5sumgYDnafeM1fjBoiK05REb01UaUDKhfFMzaVzkOZwWP68HNvHE5HtwNMkv9c1tELokaDuY/wHsc552C65PtWbsi+qL2/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275282; c=relaxed/simple;
	bh=QAvhRvLzQHH69MBDbCVJ9pxPR7o4fCwYz7Zw68Wk37w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OXP62cnBbXdtxYmXifJRjMvMZ47+ZFWVJiMbs5p41Ks3l2JbUvh4aGVK+kkWjf6a0RRKcVcmH664HIe/quhqdGCmHR4VaBAq3qQ4qgr+tgpAahAehE8l2IUyF+BEO7+VCnLpM/D33Ok9a/HXk63st7gR89WlaV3sk7eOyri6GLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=QSGDGYYa; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="QSGDGYYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=EvtGSF4+wsB8KaQy8UyMm/3mcw9fJX9JJ
	8pi18BcI7E=; b=QSGDGYYaRiHmCN8zw1WSsbVZsnaS0KY7MtGrPnBcFKsaoX7tf
	v9snGXsubST88eb7Nv+JrS/1N1j8MMcAVaROVLlPX1/whY27t8zrAWiQtu4YFuUS
	cUosZ/MJOwA+4xQY7UWr428HaWLHnd0txEI0TRdDru9u+QGj2/RoMjurl4=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEKtEe9pyQEDAA--.1555S2;
	Mon, 27 Apr 2026 15:35:09 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/4] serial: 8250_dw: Add support for UltraRISC
 DP1000 UART
From: Jia Wang <wangjia@ultrarisc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <aes-qdaT_9wMbTsm@ashevche-desk.local>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
 <aes-qdaT_9wMbTsm@ashevche-desk.local>
Date: Mon, 27 Apr 2026 15:34:25 +0800
Message-Id: <177727526561.1796253.1521989195994870860.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777275265; l=913;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=QAvhRvLzQHH69MBDbCVJ9pxPR7o4fCwYz7Zw68Wk37w=;
 b=YBzyVlQUsNsDsDyB4p35jeCaLPKWRKxVOw8/EEhQ80bDajJ2pecorsuLUqnIlXggxui0r0XUr
 I4LKHkQ8rXCBdMT67ezw9mJ/Kj0y+kY/TiTUq7YIseDmQDrE2dg+vAt
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEEKtEe9pyQEDAA--.1555S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw43XF4xtw1DXryxGFWfZrb_yoWfGFb_ur
	yrCr9a9FWkAFs8Za98JrW5CFsIka1UXw1UJryDWrsFkr13A3Z5WayjkwnIv340yayrGF1j
	kFy5Xw48CrZI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAKsr

On 2026-04-24 12:58 +0300, Andy Shevchenko wrote:
> On Fri, Apr 24, 2026 at 01:39:27PM +0800, Jia Wang wrote:
> > This patch series adds support for the UltraRISC DP1000 UART controller.
> > 
> > The series includes four patches. The first two are preparatory cleanups;
> > the last two add the DP1000 compatible and fixed CPR handling.
> > 
> > The patches have been tested on an UltraRISC DP1000 development board with
> > Linux v7.0-rc7, verifying basic UART functionality.
> 
> Now it looks good to me, thanks!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> (except DT bindings, not an expert, no tag)
>

Thanks for the review, Andy. I need to rework patches 1, 2 and 4, so
I won't add your Reviewed-by tag yet. Could you please have another
look at the updated patches in v5?
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
>

Best Regards,
Jia Wang
 


