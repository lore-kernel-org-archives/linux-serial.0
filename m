Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5339183C;
	Wed, 13 May 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668510; cv=none; b=ogscnofpBkBd99OderXq4MeseabeJBcxJXoOTiCZLq+CexAAsew4wakegGM4WyvAyrvMKpu2ou7Xw6AX/ED78ChaosIvWIQUhJZNCgvB9uPH5DZnepInTfdBktagAUFUJ6G6ex55JVmj79oX9Qe0b8RSn7TqsYGZuWL4eTyR8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668510; c=relaxed/simple;
	bh=sF+Pm4mfrfXND7lL5Z6QpI4cx9tugUfK4jX6T+Nq230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgCpjDALcpUZ1eFeCP8YPdqiTMw0RtPm/6cjTNaGNg7h6Tw1aJ19tDEZEeWJojPJfhq+AfTThc5nPSMdXfcOw9Dr8mvk+1584N8yib2jnV5v1INa9c1+Cr7SDEeQMBFD2zTfU0kOq9r9YEZyltZJ/imHcclC+6hc3eEIrpaiQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqlU/05d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqlU/05d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE963C2BCB7;
	Wed, 13 May 2026 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778668510;
	bh=sF+Pm4mfrfXND7lL5Z6QpI4cx9tugUfK4jX6T+Nq230=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqlU/05d+cufJULX5BEPfPMM2CUDbVBGecI6BkX5uxwnB/5dFoLkL8RB9bL2pwg8L
	 Iv4jruKLTFHbBo14xJEhqiJYfaTkKbr9plMyXCXXSHWwhAVc8Wbn1VKTB0DUJdzYTn
	 Bhetk4n7LD7/RuV5UNqZdwlGVA7xHyIska8Ov8AA=
Date: Wed, 13 May 2026 10:59:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liu.qingtao2@zte.com.cn
Cc: krzk@kernel.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marex@nabladev.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, rdunlap@infradead.org, geert+renesas@glider.be,
	quic_zongjian@quicinc.com, arturs.artamonovs@analog.com,
	robert.marko@sartura.hr, hvilleneuve@dimonoff.com,
	thierry.bultel.yh@bp.renesas.com, julianbraha@gmail.com,
	flavra@baylibre.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn, liu.fei16@zte.com.cn,
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn,
	jia.yunxiang@zte.com.cn, he.yilin@zte.com.cn, bai.lu5@zte.com.cn,
	yang.susheng@zte.com.cn, shen.lin1@zte.com.cn, zuo.jiang@zte.com.cn,
	hu.shengming@zte.com.cn, gao.rui@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: [PATCH v2 1/2] Add ZTE LRX UART driver
Message-ID: <2026051332-footsie-ogle-4eba@gregkh>
References: <202605130851.64D8prqc083672@mse-fl1.zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605130851.64D8prqc083672@mse-fl1.zte.com.cn>

On Wed, May 13, 2026 at 04:46:51PM +0800, liu.qingtao2@zte.com.cn wrote:
> >From 08610be731b6fc3919d5eebfd2ff9d67f38a094c Mon Sep 17 00:00:00 2001
> From: Wenhong Liu <liu.wenhong35@zte.com.cn>
> Date: Tue, 28 Apr 2026 22:30:31 +0800
> Subject: [PATCH v2 1/2] dt-bindings: serial: Add zte,lrx-uart

Um, something went wrong with your email client, this should not be in
the body of the email :(

thanks,

greg k-h
