Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6E379C2F;
	Wed, 13 May 2026 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668518; cv=none; b=Bn8sR14bvBe10CkuBrI5aPN+mk+CjynwTSzWSm5T5PHZuhfDXVSGQSD5AoK8oFr4AdqRMew3OaPoHfQ8Sk/U1o3tOVgxGmu3puNfFfHG4YXZiXPUV/0ekzv6RAipqKQuECD5OBcxqgx24EPNsriUznVInoBtEprQ0DhJ1cobX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668518; c=relaxed/simple;
	bh=8S+r3vi1jr7i6VhYB4ksbZTc+cZK5iU9FX8rEbFmZyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZOUxB6jAYQF40dgxT/pFrlLvN7BkdUSCKeXX8B6D0mgkjxSA02o40FMFnZVI2KsdvolTAi73wYuXHi/k33wvT+8qVB3xIKhNl7q4iQYsu4erW/9S4BytEhoVYbobfpP1mM/S7D0L3t5jrtUsum8lAl9x7ORAMYDReCeZ7Qaljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVvk8vYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVvk8vYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15BFC2BCB7;
	Wed, 13 May 2026 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778668518;
	bh=8S+r3vi1jr7i6VhYB4ksbZTc+cZK5iU9FX8rEbFmZyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVvk8vYzhESNW7SI3UycernAMZQJh4mtp/eJZC26stwL+421inzivWuTQHXnzQrpk
	 eN2lQWrbyfOCdXIMmJIX6aeY5LYmJQ8B4JuB2qzz+ycqDQXT+lrGumNW0qfk7qutQa
	 b4GWRvbnBk+Wfuu/NinjCaFfXc2GnMNMBaTkE4e0=
Date: Wed, 13 May 2026 12:01:11 +0200
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
Subject: Re: [PATCH v2 0/2] Add ZTE LRX UART driver
Message-ID: <2026051341-cattle-multiple-3845@gregkh>
References: <202605130852.64D8qMgL084414@mse-fl1.zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605130852.64D8qMgL084414@mse-fl1.zte.com.cn>

On Wed, May 13, 2026 at 04:46:42PM +0800, liu.qingtao2@zte.com.cn wrote:
> >From 9eba3be2e9b4d5c77956258e3c5db95049c3a895 Mon Sep 17 00:00:00 2001
> From: Wenhong Liu
> Date: Mon, 12 May 2026 10:15:55 +0800
> Subject: [PATCH v2 0/2] Add ZTE LRX UART driver

Again, why is this here?

Just use 'git send-email' to send patches out please.  Your patches here
are not threaded together at all and our tooling can not pick them up
:(

thanks,

greg k-h
